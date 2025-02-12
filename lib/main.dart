import 'package:easy_localization/easy_localization.dart';
import 'package:eventapp/firebase_options.dart';
import 'package:eventapp/models/task_model.dart';
import 'package:eventapp/provider/theme_provider.dart';
import 'package:eventapp/provider/user_provider.dart';
import 'package:eventapp/screens/create_event/create_event.dart';
import 'package:eventapp/screens/eventDetails_screen.dart';
import 'package:eventapp/screens/home_screen.dart';
import 'package:eventapp/screens/letsgo_screen.dart';
import 'package:eventapp/screens/login_screen.dart';
import 'package:eventapp/screens/onBoarding/onboarding.dart';
import 'package:eventapp/screens/register_screen.dart';
import 'package:eventapp/splash/splash_screen.dart';
import 'package:eventapp/theme/dark_them.dart';
import 'package:eventapp/theme/light_theme.dart';
import 'package:eventapp/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    BaseTheme theme = LightTheme();
    BaseTheme darkTheme = DarkTheme();
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: theme.themData,
      darkTheme: darkTheme.themData,
      themeMode: provider.thememode,
      debugShowCheckedModeBanner: false,
      initialRoute: userProvider.firebaseUser != null
          ? HomeScreen.routeName
          : SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LetsgoScreen.routeName: (context) => const LetsgoScreen(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        CreateEvent.routeName: (context) => CreateEvent(),
        EventDetailsScreen.routeName: (context) => const EventDetailsScreen(),
      },
    );
  }
}
