import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vet_connect/misc/constants.dart';
import 'package:vet_connect/misc/providers.dart';

typedef BoolCallback = void Function(bool);

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          iconSize: 26.r,
          splashRadius: 20.r,
          onPressed: () => context.router.pop(),
        ),
        centerTitle: true,
        title: Text(
          "Settings",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                "Access",
                style: context.textTheme.titleMedium,
              ),
              SizedBox(height: 20.h),
              _SettingContainer(
                header: "Location Access",
                content: "Access to your location",
                icon: Remix.user_location_fill,
                value: ref.watch(locationAccessProvider),
                onChanged: (val) =>
                    invertBoolProvider(ref, locationAccessProvider),
              ),
              SizedBox(height: 10.h),
              _SettingContainer(
                header: "Photo Access",
                content: "Access to your media",
                icon: Remix.image_fill,
                value: ref.watch(photoAccessProvider),
                onChanged: (val) =>
                    invertBoolProvider(ref, photoAccessProvider),
              ),
              SizedBox(height: 20.h),
              Text(
                "Notifications",
                style: context.textTheme.titleMedium,
              ),
              SizedBox(height: 20.h),
              _SettingContainer(
                header: "App Notifications",
                content: "Get push notifications",
                icon: Remix.notification_fill,
                value: ref.watch(pushNotificationsProvider),
                onChanged: (val) =>
                    invertBoolProvider(ref, pushNotificationsProvider),
              ),
              SizedBox(height: 10.h),
              _SettingContainer(
                header: "Appointment Reminder",
                content: "Get regular updates",
                icon: Remix.calendar_fill,
                value: ref.watch(appointmentReminderProvider),
                onChanged: (val) =>
                    invertBoolProvider(ref, appointmentReminderProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingContainer extends StatelessWidget {
  final String header;
  final String content;
  final IconData icon;
  final bool value;
  final BoolCallback onChanged;

  const _SettingContainer({
    super.key,
    required this.header,
    required this.content,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 80.r,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5,
            spreadRadius: 1.2,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80.r,
                width: 80.r,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: brightBlue.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: disabled),
                  ),
                  child: Icon(
                    icon,
                    size: 26.r,
                    color: appPurple,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    header,
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    content,
                    style: context.textTheme.bodyMedium,
                  )
                ],
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: appPurple,
          )
        ],
      ),
    );
  }
}
