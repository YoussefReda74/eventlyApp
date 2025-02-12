import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eventapp/firebase/firebase_manager.dart';
import 'package:eventapp/provider/user_provider.dart';
import 'package:eventapp/screens/home_screen.dart';
import 'package:eventapp/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String currentLanguage = 'en';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/images/Logo.png'),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                  
                    FirebaseManager.login(
                      emailController.text,
                      passwordController.text,
                      () {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                              title: Center(child: CircularProgressIndicator()),
                              backgroundColor: Colors.transparent),
                        );
                      },
                      () async{
                        Navigator.pop(context);
                        await userProvider.initUser();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeScreen.routeName,
                          (route) => false,
                        );
                      },
                      (massage) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: const Text('Something Wrong'),
                            content: Text(massage),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('ok'),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text(
                    'login',
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t Have Account ?",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(
                      "Create Account",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      indent: 15,
                      endIndent: 15,
                      color: Color(0xff5669FF),
                    ),
                  ),
                  Text(
                    'Or',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Expanded(
                    child: Divider(
                      indent: 15,
                      endIndent: 15,
                      color: Color(0xff5669FF),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/google_icon.png'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Login With Google',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              AnimatedToggleSwitch.rolling(
                fittingMode: FittingMode.none,
                current: currentLanguage,
                height: 40,
                indicatorSize: const Size(45, 45),
                values: const ['en', 'ar'],
                onChanged: (selectedValue) {
                  setState(
                    () {
                      currentLanguage = selectedValue;
                      context.setLocale(
                        Locale(currentLanguage),
                      );
                    },
                  );
                },
                iconList: [
                  Image.asset('assets/images/am.png'),
                  Image.asset('assets/images/eg.png'),
                ],
                style: const ToggleStyle(
                  indicatorColor: Color(0xff5669FF),
                  borderColor: Color(0xff5669FF),
                ), // optional style settings
              )
            ],
          ),
        ),
      ),
    );
  }
}
