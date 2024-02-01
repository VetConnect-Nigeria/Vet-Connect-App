import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'pages/intro/splash.dart';
import 'pages/intro/onboard.dart';
import 'misc/constants.dart';

import 'misc/notification_controller.dart';


Future<void> main() async {
  await AwesomeNotifications().initialize(
    'resource://drawable/ic_launcher_foreground',
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color.fromRGBO(6, 73, 151, 1.0),
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group',
      )
    ],
  );
  bool isNotificationAllowed =
  await AwesomeNotifications().isNotificationAllowed();
  if (!isNotificationAllowed) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(const ProviderScope(child: VetConnect()));
}

class VetConnect extends StatefulWidget {
  const VetConnect({super.key});

  @override
  State<VetConnect> createState() => _VetConnectState();
}

class _VetConnectState extends State<VetConnect> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: Pages.splash.path,
      routes: [
        GoRoute(
          path: Pages.splash.path,
          name: Pages.splash,
          builder: (_, __) => const SplashPage(),
        ),
        GoRoute(
          path: Pages.onboarding.path,
          name: Pages.onboarding,
          builder: (_, __) => const OnboardingPage(),
        ),
      ],
    );

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction) =>
          NotificationController.onActionReceivedMethod(
              context, receivedAction),
      onNotificationCreatedMethod:
          (ReceivedNotification receivedNotification) =>
          NotificationController.onNotificationCreatedMethod(
              context, receivedNotification),
      onNotificationDisplayedMethod:
          (ReceivedNotification receivedNotification) =>
          NotificationController.onNotificationDisplayedMethod(
              context, receivedNotification),
      onDismissActionReceivedMethod: (ReceivedAction receivedAction) =>
          NotificationController.onDismissActionReceivedMethod(
              context, receivedAction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, widget) => MaterialApp.router(
        title: 'Fynda',
        theme: FlexThemeData.light(
          fontFamily: "Catamaran",
          useMaterial3: true,
          scheme: FlexScheme.tealM3,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: weirdBlack2,
              fontSize: 18,
              fontFamily: "NotoSans",
              fontWeight: FontWeight.w500,
            ),
            bodyMedium: TextStyle(
              color: weirdBlack2,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: "NotoSans",
            ),
            bodySmall: TextStyle(
              color: weirdBlack2,
              fontSize: 14,
              fontFamily: "NotoSans",
              fontWeight: FontWeight.w500,
            ),
            titleLarge: TextStyle(
              color: weirdBlack,
              fontSize: 26,
              fontFamily: "Catamaran",
              fontWeight: FontWeight.w700,
            ),
            titleMedium: TextStyle(
              color: weirdBlack,
              fontSize: 24,
              fontFamily: "Catamaran",
              fontWeight: FontWeight.w700,
            ),
            titleSmall: TextStyle(
              color: weirdBlack,
              fontSize: 22,
              fontFamily: "Catamaran",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        themeMode: ThemeMode.light,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
    );
  }
}
