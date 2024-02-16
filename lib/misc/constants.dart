import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const Color appPurple = Color(0xFF6729CC);
const Color weirdBlack = Color(0xFF39434F);
const Color weirdBlack2 = Color(0xFF808B9A);
const Color weirdBlack3 = Color(0xFFA0AEC0);
const Color weirdGrey = Color(0xFFD9D9D9);
const Color weirdGrey2 = Color(0xFFD9DFE6);
const Color weirdBlue = Color(0xFFD1E6FF);
const Color weirdYellow = Color(0xFFFFC542);
const Color disabled = Color(0xFFC3CED9);
const Color brightBlue = Color(0xFF1B85F3);



extension PathExtension on String {
  String get path => "/$this";
}

extension OostelExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  GoRouter get router => GoRouter.of(this);
  bool get isDark => MediaQuery.of(this).platformBrightness == Brightness.dark;
}


class Pages
{
  static const String splash = "splash";
  static const String onboarding = 'onboarding';
  static const String home = 'home';
  static const String inbox = 'inbox';
  static const String bookAppointment = 'book-appointment';
  static const String settings = 'settings';
}

const String loremIpsum = "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet. "
    "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, "
    "consectetur. Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum"
    " dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. "
    "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum "
    "dolor sit amet. Lorem ipsum dolor sit amet, consectetur.  Lorem ipsum dolor sit amet, consectetur. "
    "Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, "
    "consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor "
    "sit amet, consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, consectetur. Lorem "
    "ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, consectetur. "
    "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, "
    "consectetur.";
