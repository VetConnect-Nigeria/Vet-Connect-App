import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            itemCount: notifications.length,
            itemBuilder: (_, index) {
              if (index == notifications.length) {
                return SizedBox(height: 30.h);
              }

              return ListTile(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Colors.black12)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        notifications[index].header,
                        overflow: TextOverflow.fade,
                        style: context.textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 19.sp),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => ref
                              .watch(dashboardIndexProvider.notifier)
                              .state = 1,
                          child: Container(
                            width: 40.r,
                            height: 40.r,
                            padding: EdgeInsets.all(10.r),
                            decoration: const BoxDecoration(
                              color: Color(0xFFD1E6FF),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/Vector.svg",
                              width: 26.r,
                              height: 26.r,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () => ref
                              .watch(dashboardIndexProvider.notifier)
                              .state = 0,
                          child: Container(
                            width: 40.r,
                            height: 40.r,
                            padding: EdgeInsets.all(10.r),
                            decoration: const BoxDecoration(
                                color: Color(0xFFD1E6FF),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              "assets/Vector-1.svg",
                              width: 26.r,
                              height: 26.r,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
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
