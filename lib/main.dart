import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pages/intro/splash.dart';
import 'pages/intro/onboard.dart';
import 'pages/home/home.dart';
import 'pages/home/inbox.dart';
import 'pages/home/settings.dart';
import 'pages/home/book_appointment.dart';
import 'misc/constants.dart';

import 'components/conversation.dart';
import 'misc/notification_controller.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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

  if (await Permission.location.isDenied) {
    await Permission.location.request();
  }

  final mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  runApp(const ProviderScope(child: VetConnect()));

  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        GoRoute(
          path: Pages.home.path,
          name: Pages.home,
          builder: (_, __) => const Homepage(),
        ),
        GoRoute(
          path: Pages.settings.path,
          name: Pages.settings,
          builder: (_, __) => const SettingsPage(),
        ),
        GoRoute(
          path: Pages.bookAppointment.path,
          name: Pages.bookAppointment,
          builder: (_, __) => const BookAppointmentPage(),
        ),
        GoRoute(
          path: Pages.inbox.path,
          name: Pages.inbox,
          builder: (_, state) =>
              InboxPage(conversation: state.extra as Conversation),
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
