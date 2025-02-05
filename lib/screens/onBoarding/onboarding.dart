import 'package:easy_localization/easy_localization.dart';
import 'package:eventapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = 'onboarding';
  const OnboardingScreen({super.key});

  Widget _buildImage(String assetName, [double width = 361]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    var pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.titleMedium!,
      bodyTextStyle: Theme.of(context).textTheme.headlineMedium!,
      imageFlex: 2,
      pageColor: Theme.of(context).hintColor,
      imagePadding: EdgeInsets.zero,
    );
    return SafeArea(
      top: true,
      child: IntroductionScreen(
        globalBackgroundColor: Theme.of(context).hintColor,
        globalHeader: Padding(
          padding: EdgeInsets.zero,
          child: Image.asset(
            "assets/images/inter_img.png",
            width: 160,
            height: 50,
          ),
        ),
        dotsFlex: 2,
        dotsDecorator: DotsDecorator(
          activeSize: const Size(20.0, 8.0),
          color: Colors.black,
          activeColor: Theme.of(context).primaryColor,
          spacing: const EdgeInsets.all( 3),
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
        ),
        showNextButton: true,
        showBackButton: true,
        back: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child:  Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
        ),
        next: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child:  Icon(
            Icons.arrow_forward,
            color:Theme.of(context).primaryColor,
          ),
        ),
        done: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child:  Icon(
            Icons.arrow_forward,
            color: Theme.of(context).primaryColor,
          ),
        ),
        showDoneButton: true,
        onDone: () {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        },
        pages: [
          PageViewModel(
            title: context.tr("onBoarding1_title"),
            body: context.tr("onBoarding1_body"),
            image: _buildImage(
              'onboarding_img1.png',
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: context.tr("onBoarding2_title"),
            body: context.tr("onBoarding2_body"),
            image: _buildImage('onboarding_img2.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: context.tr("onBoarding3_title"),
            body: context.tr("onBoarding3_body"),
            image: _buildImage('onboarding_img3.png'),
            decoration: pageDecoration,
          ),
        ],
      ),
    );
  }
}
