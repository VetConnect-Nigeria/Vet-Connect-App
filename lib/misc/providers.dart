import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vet_connect/components/appointment.dart';
import 'package:vet_connect/components/notification.dart' as n;
import 'package:vet_connect/components/conversation.dart';
import 'package:vet_connect/components/user.dart';

final StateProvider<int> dashboardIndexProvider = StateProvider((ref) => 0);
final StateProvider<List<Conversation>> conversationListProvider =
    StateProvider(
  (ref) => [
    Conversation(
      id: "ID 0",
      image: "assets/yacht.jpg",
      header: "Sam's Pet Place",
      subtitle: "Please take a look at the images",
      timestamp: DateTime.now(),
      active: true,
      userId: "123456",
      count: 2,
    ),
    Conversation(
      id: "ID 1",
      image: "assets/doc1.jpg",
      header: "Dr. Ben",
      subtitle: "Good morning doc, When next wi...",
      timestamp: DateTime.now(),
      active: false,
      userId: "123456",
      count: 12,
    ),
    Conversation(
      id: "ID 2",
      image: "assets/doc2.jpg",
      header: "Dr. Taiwo",
      subtitle: "Thank you, doc!",
      timestamp: DateTime.now(),
      active: false,
      userId: "123456",
      count: 0,
    )
  ],
);

final StateProvider<List<Appointment>> upcomingAppointmentsProvider =
    StateProvider(
  (ref) => [
    Appointment(
      id: "id1",
      image: "assets/jet.jpg",
      name: "Sam's Place",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: "id0",
      image: "assets/doc2.jpg",
      name: "Dr. Taiwo",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: "id2",
      image: "assets/jet.jpg",
      name: "Sam's Place",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: "id3",
      image: "assets/doc1.jpg",
      name: "Dr. Ben",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: "id4",
      image: "assets/vth.jpg",
      name: "FUNAAB VTH",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: "id5",
      image: "assets/jet.jpg",
      name: "Sam's Place",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: "id4",
      image: "assets/doc1.jpg",
      name: "Dr. Ben",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
  ],
);

final StateProvider<List<Appointment>> pastAppointmentsProvider = StateProvider(
  (ref) => [
    Appointment(
      id: "id0",
      image: "assets/doc1.jpg",
      name: "Dr. Ben",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: "id1",
      image: "assets/jet.jpg",
      name: "Sam's Place",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: "id2",
      image: "assets/jet.jpg",
      name: "Sam's Place",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: "id3",
      image: "assets/vth.jpg",
      name: "FUNAAB VTH",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: "id4",
      image: "assets/doc2.jpg",
      name: "Dr. Taiwo",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: "id5",
      image: "assets/doc1.jpg",
      name: "Dr. Ben",
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
  ],
);

final StateProvider<List<n.Notification>> notificationProvider = StateProvider(
  (ref) => const [
    n.Notification(
      header: "Upcoming appointment at Sam's place",
      id: "ID 0",
      read: true,
    ),
    n.Notification(
      header: "Upcoming appointment at FUNAAB VTH",
      id: "ID 1",
      read: false,
    ),
    n.Notification(
      header: "Upcoming appointment with Dr. Taiwo",
      id: "ID 2",
      read: false,
    ),
    n.Notification(
      header: "Upcoming appointment with Dr. Ben",
      id: "ID 3",
      read: true,
    ),
  ],
);

void invertBoolProvider(WidgetRef ref, StateProvider<bool> provider) {
  bool value = ref.watch(provider);
  ref.watch(provider.notifier).state = !value;
}

final StateProvider<bool> locationAccessProvider =
    StateProvider((ref) => false);
final StateProvider<bool> photoAccessProvider = StateProvider((ref) => false);
final StateProvider<bool> pushNotificationsProvider =
    StateProvider((ref) => false);
final StateProvider<bool> appointmentReminderProvider =
    StateProvider((ref) => false);

final StateProvider<User> userProvider = StateProvider(
  (ref) => const User(id: "dummy"),
);
