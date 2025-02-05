import 'package:flutter/material.dart';
import '../screens/letsgo_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
  super.initState();
  Future.delayed(
  const Duration(seconds: 3),
  () => Navigator.pushNamedAndRemoveUntil(
  context,
  LetsgoScreen.routeName,
  (Route<dynamic> route) => false,
  ),
  );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).hintColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/Logo.png',
              width: double.infinity,
            ),
            const Spacer(),
            Image.asset(
              'assets/images/blogo.png',
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
