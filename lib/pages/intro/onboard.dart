import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vet_connect/misc/constants.dart';
import 'package:vet_connect/misc/widgets.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int index = 0;
  bool showPassword = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget get welcomeStage => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  width: 60.w,
                  height: index == 1 ? 6.h : 3.h,
                  decoration: BoxDecoration(
                    color: index == 1 ? weirdYellow : weirdBlack3,
                    borderRadius: BorderRadius.circular(
                      index == 1 ? 3.h : 1.5.h,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "Personalized Pet Profiles",
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: 10.h),
          Text(
            "Create personalized profiles for each of your beloved pets on VetConnect. "
            "Share their name, breed, and age while connecting with a vibrant veterinary community.",
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 47.h),
          ElevatedButton(
            onPressed: () => setState(() => index = 1),
            style: ElevatedButton.styleFrom(
              backgroundColor: appPurple,
              minimumSize: Size(327.w, 50.h),
              maximumSize: Size(327.w, 50.h),
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              "Get Started",
              style: context.textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () => setState(() => index = 2),
            child: Text(
              "Log in",
              style: context.textTheme.bodyMedium,
            ),
          )
        ],
      );

  Widget get loginStage => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Log in",
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: 10.h),
          Text(
            "Welcome! Please enter your information below and get started",
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          SpecialForm(
            controller: emailController,
            width: 375.w,
            height: 50.h,
            hint: "Your email",
          ),
          SizedBox(height: 16.h),
          SpecialForm(
            controller: emailController,
            width: 375.w,
            height: 50.h,
            obscure: true,
            hint: "Password",
            suffix: GestureDetector(
              onTap: () => setState(() => showPassword = !showPassword),
              child: AnimatedSwitcherTranslation.right(
                duration: const Duration(milliseconds: 500),
                child: Icon(
                  showPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  key: ValueKey<bool>(showPassword),
                  size: 18.r,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child:
                  Text("Forgot Password?", style: context.textTheme.bodySmall),
            ),
          ),
          SizedBox(height: 47.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: appPurple,
              minimumSize: Size(327.w, 50.h),
              maximumSize: Size(327.w, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              "Log in",
              style: context.textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
          ),
          SizedBox(height: 10.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Don't have an account?",
                    style: context.textTheme.bodySmall),
                TextSpan(
                  text: " Register here!",
                  style:
                      context.textTheme.bodySmall!.copyWith(color: appPurple),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => setState(() => index = 1),
                ),
              ],
            ),
          )
        ],
      );

  Widget get registerStage => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Log in",
        style: context.textTheme.titleLarge,
      ),
      SizedBox(height: 10.h),
      Text(
        "Welcome! Please enter your information below and get started",
        style: context.textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 24.h),
      SpecialForm(
        controller: emailController,
        width: 375.w,
        height: 50.h,
        hint: "Your email",
      ),
      SizedBox(height: 16.h),
      SpecialForm(
        controller: emailController,
        width: 375.w,
        height: 50.h,
        obscure: true,
        hint: "Password",
        suffix: GestureDetector(
          onTap: () => setState(() => showPassword = !showPassword),
          child: AnimatedSwitcherTranslation.right(
            duration: const Duration(milliseconds: 500),
            child: Icon(
              showPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              key: ValueKey<bool>(showPassword),
              size: 18.r,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      SizedBox(height: 16.h),
      Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {},
          child:
          Text("Forgot Password?", style: context.textTheme.bodySmall),
        ),
      ),
      SizedBox(height: 47.h),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: appPurple,
          minimumSize: Size(327.w, 50.h),
          maximumSize: Size(327.w, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Text(
          "Log in",
          style: context.textTheme.bodySmall!.copyWith(color: Colors.white),
        ),
      ),
      SizedBox(height: 10.h),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: "Don't have an account?",
                style: context.textTheme.bodySmall),
            TextSpan(
              text: " Register here!",
              style:
              context.textTheme.bodySmall!.copyWith(color: appPurple),
              recognizer: TapGestureRecognizer()
                ..onTap = () => setState(() => index = 1),
            ),
          ],
        ),
      )
    ],
  );

  Widget get child {
    switch (index) {
      case 0:
        return welcomeStage;
      case 1:
        return registerStage;
      case 2:
        return loginStage;
      default:
        return const SizedBox();
    }
  }

  IconData get icon {
    switch (index) {
      case 0:
        return Remix.edit_line;
      case 1:
      case 2:
        return Icons.person_2_outlined;
      default:
        return Icons.error_rounded;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPurple,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: 812.h,
              child: Image.asset(
                "assets/dog.jpg",
                width: 375.w,
                height: 500.h,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: ClipPath(
                clipper: _OnboardClipper(edgeRadius: 40.r, circleRadius: 40.r),
                child: Container(
                  width: 375.w,
                  height: index == 0 ? 400.h : 500.h,
                  color: weirdGrey2,
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                        width: 60.r,
                        height: 60.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: appPurple, width: 1.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          color: appPurple,
                          size: 22.r,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardClipper extends CustomClipper<Path> {
  final double edgeRadius;
  final double circleRadius;

  _OnboardClipper({
    required this.edgeRadius,
    required this.circleRadius,
  });

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, circleRadius, size.width, size.height),
        topLeft: Radius.circular(edgeRadius),
        topRight: Radius.circular(edgeRadius),
      ),
    );

    path.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.5, circleRadius),
      radius: circleRadius,
    ));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>
      oldClipper != this;
}
