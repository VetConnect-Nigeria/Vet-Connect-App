import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vet_connect/misc/constants.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () => context.router.pushReplacementNamed(Pages.onboarding));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/dog.jpg",
              fit: BoxFit.cover,
              width: 375.w,
              height: 810.h,
            ),
            Positioned(
              top: 100.h,
              left: 20.w,
              right: 20.w,
              child: SvgPicture.asset("assets/LogoText.svg"),
            ),
          ]
        )
      )
    );
  }
}
