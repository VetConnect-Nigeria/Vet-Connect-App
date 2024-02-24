import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vet_connect/misc/constants.dart';
import 'package:vet_connect/misc/toast.dart';
import 'package:vet_connect/misc/widgets.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:vet_connect/user_auth/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../home/map.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int index = 0;
  bool showPassword = false;
  bool acceptTerms = false;
  bool filledOTP = false;
  bool fromForgot = false;
  bool _isSigning = false;
  bool isSigningUp = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<TextStyle?> otpStyles = [];

  Color accentPurpleColor = const Color(0xFF6A53A1);
  Color primaryColor = const Color(0xFF121212);
  Color accentPinkColor = const Color(0xFFF99BBD);
  Color accentDarkGreenColor = const Color(0xFF115C49);
  Color accentYellowColor = const Color(0xFFFFB612);
  Color accentOrangeColor = const Color(0xFFEA7A3B);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (otpStyles.isEmpty) {
      otpStyles.add(createStyle(accentPurpleColor));
      otpStyles.add(createStyle(accentDarkGreenColor));
      otpStyles.add(createStyle(accentOrangeColor));
      otpStyles.add(createStyle(accentPinkColor));
      otpStyles.add(createStyle(accentPurpleColor));
    }
  }

  TextStyle? createStyle(Color color) {
    ThemeData theme = Theme.of(context);
    return theme.textTheme.bodyLarge?.copyWith(color: color);
  }

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
            "Personalized Animal Profiles",
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: 10.h),
          Text(
            "Create personalized profiles for each of your pets and livestock on VetConnect. "
            "Share their name, breed, and age while connecting with a vibrant veterinary community.",
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 47.h),
          ElevatedButton(
            onPressed: () => setState(() => index = 4),
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
            onTap: () => setState(() => index = 5),
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
            type: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.h),
          SpecialForm(
            controller: passwordController,
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
              onTap: () => setState(() => index = 7),
              child:
                  Text("Forgot Password?", style: context.textTheme.bodySmall),
            ),
          ),
          SizedBox(height: 47.h),
          ElevatedButton(
            onPressed: _signIn,
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
                    ..onTap = () => setState(() => index = 4),
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
            "Create account",
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
            controller: passwordController,
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
          Row(
            children: [
              Checkbox(
                value: acceptTerms,
                onChanged: (val) => setState(() => acceptTerms = !acceptTerms),
                checkColor: weirdGrey2,
                activeColor: appPurple,
              ),
              Text("Accept Terms and Conditions",
                  style: context.textTheme.bodySmall),
            ],
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: _signUp,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  acceptTerms ? appPurple : appPurple.withOpacity(0.5),
              minimumSize: Size(327.w, 50.h),
              maximumSize: Size(327.w, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              "Create account",
              style: context.textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
          ),
          SizedBox(height: 10.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Already have an account?",
                    style: context.textTheme.bodySmall),
                TextSpan(
                  text: " Log in here!",
                  style:
                      context.textTheme.bodySmall!.copyWith(color: appPurple),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => setState(() => index = 5),
                ),
              ],
            ),
          )
        ],
      );

  Widget get validationPage => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Validation Code",
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: 10.h),
          Text(
            "Check your email inbox and enter the validation code here",
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          OtpTextField(
            numberOfFields: 5,
            fieldWidth: 50.r,
            fillColor: Colors.white,
            styles: otpStyles,
            borderColor: accentPurpleColor,
            showFieldAsBox: true,
            onCodeChanged: (code) {
              setState(() => filledOTP = code.length == 5);
            },
            onSubmit: (verificationCode) {
              setState(() => filledOTP = verificationCode.length == 5);
            }, // end onSubmit
          ),
          SizedBox(height: 40.h),
          ElevatedButton(
            onPressed: () {
              if (fromForgot) {
                setState(() {
                  index = 8;
                });
              } else {
                context.router.pushReplacementNamed(Pages.home);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  filledOTP ? appPurple : appPurple.withOpacity(0.5),
              minimumSize: Size(327.w, 50.h),
              maximumSize: Size(327.w, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              "Confirm",
              style: context.textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
          ),
          SizedBox(height: 10.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Did not receive the code?",
                    style: context.textTheme.bodySmall),
                TextSpan(
                  text: " Resend",
                  style:
                      context.textTheme.bodySmall!.copyWith(color: brightBlue),
                ),
              ],
            ),
          )
        ],
      );

  Widget get forgotStage => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Forgot password",
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: 10.h),
          Text(
            "Enter your email address or phone number",
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          SpecialForm(
            controller: emailController,
            width: 375.w,
            height: 50.h,
            hint: "Your email/phone number",
          ),
          SizedBox(height: 47.h),
          ElevatedButton(
            onPressed: () => setState(() {
              index = 6;
              fromForgot = true;
            }),
            style: ElevatedButton.styleFrom(
              backgroundColor: appPurple,
              minimumSize: Size(327.w, 50.h),
              maximumSize: Size(327.w, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              "Continue",
              style: context.textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      );

  Widget get resetStage => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Reset password",
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: 24.h),
          SpecialForm(
            controller: passwordController,
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
          SpecialForm(
            controller: emailController,
            width: 375.w,
            height: 50.h,
            obscure: true,
            hint: "Confirm Password",
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
          SizedBox(height: 47.h),
          ElevatedButton(
            onPressed: () => setState(() => index = 5),
            style: ElevatedButton.styleFrom(
              backgroundColor: appPurple,
              minimumSize: Size(327.w, 50.h),
              maximumSize: Size(327.w, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              "Submit",
              style: context.textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      );

  Widget get stepOne => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          Text(
            "Find a certified veterinarian around you by using the location services",
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: 10.h),
          Text(
            "Just turn on your location and you will locate nearby animal care",
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 45.w,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: index != 1 ? 5.w : 15.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: index == 1 ? appPurple : weirdBlack3,
                        borderRadius: BorderRadius.circular(
                          1.5.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () => setState(() => index = 1),
                backgroundColor: appPurple,
                child: const Icon(Icons.arrow_forward_rounded,
                    color: Colors.white),
              )
            ],
          )
        ],
      );

  Widget get stepTwo => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          Text(
            "Get the best treatment and care for animals",
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: 10.h),
          Text(
            "Get the best treatment for your pets and livestocks with us",
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 45.w,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: index != 2 ? 5.w : 15.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: index == 2 ? appPurple : weirdBlack3,
                        borderRadius: BorderRadius.circular(
                          1.5.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () => setState(() => index = 2),
                backgroundColor: appPurple,
                child: const Icon(Icons.arrow_forward_rounded,
                    color: Colors.white),
              )
            ],
          )
        ],
      );

  Widget get stepThree => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          Text(
            "Book an appointment with a certified veterinarian",
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: 10.h),
          Text(
            "Get the best treatment for your animals with us",
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 45.w,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: index != 3 ? 5.w : 15.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: index == 3 ? appPurple : weirdBlack3,
                        borderRadius: BorderRadius.circular(
                          1.5.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () => setState(() => index = 3),
                backgroundColor: appPurple,
                child: const Icon(Icons.arrow_forward_rounded,
                    color: Colors.white),
              )
            ],
          )
        ],
      );

  Widget get child {
    switch (index) {
      case 0:
        return stepOne;
      case 1:
        return stepTwo;
      case 2:
        return stepThree;
      case 3:
        return welcomeStage;
      case 4:
        return registerStage;
      case 5:
        return loginStage;
      case 6:
        return validationPage;
      case 7:
        return forgotStage;
      case 8:
        return resetStage;

      default:
        return const SizedBox();
    }
  }

  IconData get icon {
    switch (index) {
      case 0:
        return Icons.location_on_rounded;

      case 1:
        return Icons.favorite_rounded;
      case 2:
        return Icons.calendar_month_rounded;

      case 3:
        return Remix.edit_line;

      case 4:
        return Icons.person_2_outlined;
      case 5:
        return Icons.lock_outline_rounded;
      case 6:
        return Remix.qr_scan_fill;
      case 7:
      case 8:
        return Icons.scanner_rounded;
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

  double get height {
    if (index < 3) return 400.h;
    return 500.h;
  }

  bool get shouldPop {
    if (index == 0) return true;
    if (index < 3) {
      setState(() => --index);
      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                  clipper:
                      _OnboardClipper(edgeRadius: 40.r, circleRadius: 40.r),
                  child: Container(
                    width: 375.w,
                    height: height,
                    color: weirdGrey,
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
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      showToast(message: "Your account is successfully created");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapSample()),
      );
    } else {
      showToast(message: "Some error happend");
    }
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });
    if (user != null) {
      showToast(message: "You are successfully signed in");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapSample()),
      );
    } else {
      showToast(message: "Some error happend");
    }
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
