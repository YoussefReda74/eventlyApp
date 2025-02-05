import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eventapp/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'onBoarding/onboarding.dart';

class LetsgoScreen extends StatefulWidget {
  static const String routeName = 'letsgo';
  const LetsgoScreen({super.key});

  @override
  State<LetsgoScreen> createState() => _LetsgoScreenState();
}

class _LetsgoScreenState extends State<LetsgoScreen> {
  String currentLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/inter_img.png',
                width: 160,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 5,
              child: Image.asset(
                provider.thememode == ThemeMode.light
                    ? 'assets/images/being_creative_img.png'
                    : 'assets/images/being_creative_img_dark.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  context.tr("intro_title"),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Text(context.tr("intro_desc"),
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Language".tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
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
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Theme".tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  AnimatedToggleSwitch.rolling(
                    fittingMode: FittingMode.none,
                    current: provider.thememode,
                    height: 40,
                    indicatorSize: const Size(45, 45),
                    values: const [ThemeMode.light, ThemeMode.dark],
                    onChanged: (i) {
                      provider.changetheme(i);
                      setState(() {});
                    },
                    iconBuilder: (value, foreground) {
                      if (value == ThemeMode.dark) {
                        return const Icon(Icons.nightlight );
                      } else {
                        return const Icon(Icons.sunny);
                      }
                    },
                    style: const ToggleStyle(
                      indicatorColor: Color(0xff5669FF),
                      borderColor: Color(0xff5669FF),
                    ), // optional style settings
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, OnboardingScreen.routeName);
                        //OnboardingScreen
                      },
                      child: Text(
                        "lets_go".tr(),
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
