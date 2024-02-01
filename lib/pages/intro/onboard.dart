import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vet_connect/misc/constants.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int index = 0;

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
                (index) => ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 5.h,
                    minHeight: 3.h,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: index == 1 ? weirdYellow : weirdGrey2,
                      borderRadius: BorderRadius.circular(
                        index == 1 ? 2.5.h : 1.5.h,
                      ),
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
              onPressed: () {},
              child: Text(
                "Get Started",
                style:
                    context.textTheme.bodySmall!.copyWith(color: Colors.white),
              ),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () {}
          )
        ],
      );

  Widget get child {
    switch (index) {
      case 0:
        return welcomeStage;
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/dog.jpg",
              width: 375.w,
              height: 500.h,
              fit: BoxFit.cover,
            ),
            ClipPath(
              clipper: _OnboardClipper(borderRadius: 15.r, circleRadius: 25.r),
              child: Container(
                width: 375.w,
                color: weirdGrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    SizedBox(height: 20.h),
                    child,
                  ],
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
  final double borderRadius;
  final double circleRadius;

  _OnboardClipper({
    required this.borderRadius,
    required this.circleRadius,
  });

  @override
  Path getClip(Size size) {
    double distToCircle =
        (size.width - (2 * borderRadius) - (2 * circleRadius)) * 0.5;

    Path path = Path();
    path.moveTo(borderRadius, 0.0);
    path.lineTo(distToCircle + borderRadius, 0.0);
    path.addArc(
        Rect.fromCircle(
            center: Offset(distToCircle + borderRadius + circleRadius, 0.0),
            radius: circleRadius),
        pi,
        pi);
    path.lineTo((2 * distToCircle) + borderRadius + (2 * circleRadius), 0.0);
    path.arcToPoint(Offset(size.width, borderRadius));
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.width);
    path.lineTo(0, borderRadius);
    path.arcToPoint(Offset(0.0, borderRadius));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
