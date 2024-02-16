import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vet_connect/components/notification.dart' as n;
import 'package:vet_connect/misc/constants.dart';
import 'package:vet_connect/misc/providers.dart';


class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    List<n.Notification> notifications = ref.watch(notificationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Notifications",
                    style: context.textTheme.titleMedium,
                  ),
                  IconButton(
                    onPressed: () => context.router.pushNamed(Pages.settings),
                    icon: const Icon(Remix.settings_line),
                    iconSize: 26.r,
                    splashRadius: 20.r,
                  )
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (_, index) {
              if (index == notifications.length) {
                return SizedBox(height: 30.h);
              }

              return ListTile(
                onTap: () {},
                title: Text(
                  notifications[index].header,
                  style: context.textTheme.titleSmall,
                ),
                subtitle: Text(
                  notifications[index].read ? "Read" : "Unread",
                  style: context.textTheme.bodySmall,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
