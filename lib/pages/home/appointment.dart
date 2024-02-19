import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vet_connect/components/appointment.dart';
import 'package:vet_connect/misc/constants.dart';
import 'package:vet_connect/misc/functions.dart';
import 'package:vet_connect/misc/providers.dart';

class AppointmentsPage extends ConsumerStatefulWidget {
  const AppointmentsPage({super.key});

  @override
  ConsumerState<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends ConsumerState<AppointmentsPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> refreshPastAppointments() async {}

  Future<void> refreshUpcomingAppointments() async {}

  @override
  Widget build(BuildContext context) {
    List<Appointment> pastAppointments = ref.watch(pastAppointmentsProvider);
    List<Appointment> upcomingAppointments =
        ref.watch(upcomingAppointmentsProvider);

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
                    "Appointments",
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
              TabBar(
                controller: controller,
                indicatorColor: appPurple,
                labelColor: appPurple,
                unselectedLabelColor: Colors.grey,
                labelStyle: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600),
                unselectedLabelStyle: context.textTheme.bodyLarge,
                tabs: const [
                  Tab(text: "Upcoming"),
                  Tab(text: "Past"),
                ],
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 550.h,
                child: TabBarView(
                  controller: controller,
                  children: [
                    RefreshIndicator(
                      onRefresh: refreshUpcomingAppointments,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 210.h,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.w,
                        ),
                        itemBuilder: (_, index) => _AppointmentContainer(
                          appointment: upcomingAppointments[index],
                        ),
                        itemCount: upcomingAppointments.length,
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: refreshPastAppointments,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 210.h,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.w,
                        ),
                        itemBuilder: (_, index) => _AppointmentContainer(
                          appointment: pastAppointments[index],
                        ),
                        itemCount: pastAppointments.length,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _AppointmentContainer extends StatelessWidget {
  final Appointment appointment;

  const _AppointmentContainer({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 210.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.black12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, spreadRadius: 0.5, blurRadius: 1.0)
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          CircleAvatar(
            radius: 25.r,
            backgroundImage: AssetImage(appointment.image),
          ),
          SizedBox(height: 20.h),
          Text(
            appointment.name,
            style: context.textTheme.titleSmall,
          ),
          SizedBox(height: 10.h),
          Text(
            "Date: ${formatBareDate(appointment.date)}",
            style: context.textTheme.bodyMedium,
          ),
          SizedBox(height: 10.h),
          Text(
            "Time: ${appointment.time.format(context)}",
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
