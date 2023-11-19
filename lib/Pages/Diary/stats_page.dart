import 'package:flutter/material.dart';
import 'package:my_flutter_project/Service/db.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Personal Dairy ❤️'),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(DateTime.now().year, DateTime.now().month, 1),
        lastDay: DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        focusedDay: DateTime.now(),
        calendarBuilders: CalendarBuilders(
        rangeHighlightBuilder: (context, day, isWithinRange) {
            String dateStr = '${day.year}-${day.month}-${day.day}';
            print(dateStr);
            if (DairyService().isTrue(dateStr)) {
              return Container(
                padding: const EdgeInsets.all(15.0),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: Colors.green,
                ),
              );
            }
            else {
              return Container(
                padding: const EdgeInsets.all(15.0),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
