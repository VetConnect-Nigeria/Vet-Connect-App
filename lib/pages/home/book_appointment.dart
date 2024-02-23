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
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  TimeOfDay? _selectedTime;

  final List<TimeOfDay> _availableTimes = [
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 16, minute: 0),
  ];

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showModalBottomSheet<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250.h, // Adjust the height as necessary
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ..._availableTimes.map((TimeOfDay time) {
                return ListTile(
                  title: Text('${time.format(context)}'),
                  onTap: () => Navigator.of(context).pop(time),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          iconSize: 26.r,
          splashRadius: 20.r,
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "Book an Appointment",
          style: Theme.of(context).textTheme.titleMedium,
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text:
                          "The date and time depends on the availability of the veterinarian, kindly choose available options.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              SizedBox(height: 30.h),
              Text("Available Time",
                  style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedTime?.format(context) ?? "Select Time",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Icon(Icons.arrow_drop_down, size: 24.r),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Or your custom navigation logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepPurple, // Replace with your appPurple color
                  minimumSize: Size(327.w, 50.h),
                  maximumSize: Size(327.w, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  "Book Appointment",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
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
