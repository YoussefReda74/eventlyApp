import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eventapp/firebase/firebase_manager.dart';
import 'package:eventapp/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();

  var nameController = TextEditingController();

  String currentLanguage = 'en';

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Register',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'name is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                        .hasMatch(value);
                    if (emailValid == false) {
                      return 'invalid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'password should be 6 character ';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: rePasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' rePassword is required';
                    }
                    if (value.length < 6) {
                      return "password should be 6 character ";
                    }
                    if (passwordController.text != value) {
                      return "password doesn't match ";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'RePassword',
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseManager.createAccount(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          () {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                  title: Center(
                                      child: CircularProgressIndicator()),
                                  backgroundColor: Colors.transparent),
                            );
                          },
                          () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          (massage) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
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
                      }
                    },
                    child: const Text(
                      'Create account',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have Account ?",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: Text(
                        "Login",
                        style:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ],
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
      ),
    );
  }
}
