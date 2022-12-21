import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const VisibleDatesDetails());

class VisibleDatesDetails extends StatelessWidget {
  const VisibleDatesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VisibleDates(),
    );
  }
}

class VisibleDates extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

List<String> _colors = <String>[
  'Pink',
  'Blue',
  'Wall Brown',
  'Yellow',
  'Default'
];

class ScheduleExample extends State<VisibleDates> {
  String? _startDate, _endDate;
  Color? _headerColor, _viewHeaderColor, _calendarColor;

  @override
  void initState() {
    _startDate = '';
    _endDate = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: const Icon(Icons.color_lens),
              itemBuilder: (BuildContext context) {
                return _colors.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              onSelected: (String value) {
                setState(() {
                  if (value == 'Pink') {
                    _headerColor = const Color(0xFF09e8189);
                    _viewHeaderColor = const Color(0xFF0f3acb6);
                    _calendarColor = const Color(0xFF0ffe5d8);
                  } else if (value == 'Blue') {
                    _headerColor = const Color(0xFF0007eff);
                    _viewHeaderColor = const Color(0xFF03aa4f6);
                    _calendarColor = const Color(0xFF0bae5ff);
                  } else if (value == 'Wall Brown') {
                    _headerColor = const Color(0xFF0937c5d);
                    _viewHeaderColor = const Color(0xFF0e6d9b1);
                    _calendarColor = const Color(0xFF0d1d2d6);
                  } else if (value == 'Yellow') {
                    _headerColor = const Color(0xFF0f7ed53);
                    _viewHeaderColor = const Color(0xFF0fff77f);
                    _calendarColor = const Color(0xFF0f7f2cc);
                  } else if (value == 'Default') {
                    _headerColor = null;
                    _viewHeaderColor = null;
                    _calendarColor = null;
                  }
                });
              },
            ),
          ],
          backgroundColor: _headerColor,
          centerTitle: true,
          titleSpacing: 60,
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: Text('StartDate : ' '$_startDate'),
            ),
            Container(
              height: 50,
              child: Text('EndDate : ' '$_endDate'),
            ),
            Expanded(
              child: SfCalendar(
                viewHeaderStyle:
                ViewHeaderStyle(backgroundColor: _viewHeaderColor),
                allowedViews: const [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.workWeek,
                  CalendarView.month,
                  CalendarView.timelineDay,
                  CalendarView.timelineWeek,
                  CalendarView.timelineWorkWeek
                ],
                backgroundColor: _calendarColor,
                view: CalendarView.week,
                monthViewSettings: const MonthViewSettings(showAgenda: true),
                dataSource: getCalendarDataSource(),
                onViewChanged: viewChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _DataSource getCalendarDataSource() {
    final List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      color: Colors.pink,
      isAllDay: true,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 4, days: -1)),
      endTime: DateTime.now().add(const Duration(hours: 5, days: -1)),
      subject: 'Release Meeting',
      color: Colors.lightBlueAccent,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 2, days: -2)),
      endTime: DateTime.now().add(const Duration(hours: 4, days: -2)),
      subject: 'Performance check',
      color: Colors.amber,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 6, days: -3)),
      endTime: DateTime.now().add(const Duration(hours: 7, days: -3)),
      subject: 'Support',
      color: Colors.green,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 6, days: 2)),
      endTime: DateTime.now().add(const Duration(hours: 7, days: 2)),
      subject: 'Retrospective',
      color: Colors.purple,
    ));

    return _DataSource(appointments);
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    _startDate = DateFormat('dd, MMMM yyyy')
        .format(viewChangedDetails.visibleDates[0])
        .toString();
    _endDate = DateFormat('dd, MMMM yyyy')
        .format(viewChangedDetails
        .visibleDates[viewChangedDetails.visibleDates.length - 1])
        .toString();

    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {});
    });
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}