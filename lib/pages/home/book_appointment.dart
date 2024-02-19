import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vet_connect/misc/constants.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({super.key});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
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
          "Book Appointments",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Note: ",
                      style: context.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text:
                          "The disabled date and time shows the unavailablilty of the doctor, kindly choose available options",
                      style: context.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),
              SizedBox(height: 30.h),
              Text("Available Time", style: context.textTheme.titleSmall),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () => showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ),
                child: const Text("Select Time"),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () => context.router.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appPurple,
                  minimumSize: Size(327.w, 50.h),
                  maximumSize: Size(327.w, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  "Book Appointment",
                  style: context.textTheme.bodySmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
