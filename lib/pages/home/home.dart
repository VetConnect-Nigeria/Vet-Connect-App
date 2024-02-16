import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vet_connect/misc/constants.dart';
import 'package:vet_connect/misc/providers.dart';

import 'appointment.dart';
import 'chat.dart';
import 'map.dart';
import 'notification.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  late List<Widget> navItems;

  @override
  void initState() {
    super.initState();
    navItems = const [
      AppointmentsPage(),
      ChatPage(),
      MapPage(),
      NotificationPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    int index = ref.watch(dashboardIndexProvider);

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: index,
          children: navItems,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1.0,
        onTap: (page) =>
            ref.watch(dashboardIndexProvider.notifier).state = page,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle:
            context.textTheme.bodyMedium!.copyWith(color: Colors.grey),
        selectedItemColor: appPurple,
        selectedLabelStyle: context.textTheme.bodyMedium!.copyWith(
          color: appPurple,
          fontWeight: FontWeight.w500,
        ),
        currentIndex: index,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: AnimatedSwitcherZoom.zoomIn(
              duration: const Duration(milliseconds: 500),
              child: Icon(
                index == 0 ? Remix.map_fill : Remix.map_line,
                key: ValueKey<bool>(index == 0),
              ),
            ),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: AnimatedSwitcherZoom.zoomIn(
              duration: const Duration(milliseconds: 500),
              child: Icon(
                index == 1 ? Remix.message_fill : Remix.message_line,
                key: ValueKey<bool>(index == 1),
              ),
            ),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: AnimatedSwitcherZoom.zoomIn(
              duration: const Duration(milliseconds: 500),
              child: Icon(
                index == 2 ? Remix.calendar_fill : Remix.calendar_line,
                key: ValueKey<bool>(index == 2),
              ),
            ),
            label: "Appointments",
          ),
          BottomNavigationBarItem(
            icon: AnimatedSwitcherZoom.zoomIn(
              duration: const Duration(milliseconds: 500),
              child: Icon(
                index == 3 ? Remix.notification_fill : Remix.notification_line,
                key: ValueKey<bool>(index == 3),
              ),
            ),
            label: "Notification",
          ),
        ],
      ),
    );
  }
}
