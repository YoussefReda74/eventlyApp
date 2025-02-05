import 'package:easy_localization/easy_localization.dart';
import 'package:eventapp/firebase_options.dart';
import 'package:eventapp/provider/theme_provider.dart';
import 'package:eventapp/screens/create_event/create_event.dart';
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
    ChangeNotifierProvider(
      create: (context) => MyProvider(),
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
    BaseTheme theme = LightTheme();
    BaseTheme darktheme = DarkTheme();
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: theme.themData,
      darkTheme: darktheme.themData,
      themeMode: provider.thememode,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LetsgoScreen.routeName: (context) => const LetsgoScreen(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        CreateEvent.routeName: (context) => CreateEvent(),
      },
    );
  }
}
