# How to get visible dates details from the Flutter event calendar (SfCalendar)?

In flutter event calendar, you can get the details of visible dates using the `onViewChanged` callback of the flutter calendar widget.

## Step 1
In initState(), set the default values for calendar view that is start date and end date.

```xml
CalendarView _calendarView;
String _startDate,
    _endDate;
 
@override
void initState() {
  _calendarView = CalendarView.week;
  _startDate = '';
  _endDate = '';
  super.initState();
}
```
 

## Step 2
Trigger the `onViewChanged` callback of the calendar widget and get the visible dates details through the viewChangedDetails.

```xml
body: Column(
  children: <Widget>[
    Expanded(
      child: SfCalendar(
        view: _calendarView,
        dataSource: getCalendarDataSource(),
        onViewChanged: viewChanged,
      ),
    ),
  ],
),
void viewChanged(ViewChangedDetails viewChangedDetails) {
 
  if(_calendarView==CalendarView.day)
    {
      _startDate = DateFormat('dd, MMMM yyyy')
          .format(viewChangedDetails.visibleDates[0])
          .toString();
      _endDate = DateFormat('dd, MMMM yyyy')
          .format(viewChangedDetails
          .visibleDates[viewChangedDetails.visibleDates.length - 1])
          .toString();
    }
  else
    {
      _startDate = DateFormat('dd, MMMM yyyy')
          .format(viewChangedDetails.visibleDates[0])
          .toString();
      _endDate = DateFormat('dd, MMMM yyyy')
          .format(viewChangedDetails
          .visibleDates[viewChangedDetails.visibleDates.length - 1])
          .toString();
    }
 
  SchedulerBinding.instance.addPostFrameCallback((duration) {
    setState(() {});
  });
}
```

**[View document in Syncfusion Flutter Knowledge base](https://www.syncfusion.com/kb/11026/how-to-get-visible-dates-details-from-the-flutter-event-calendar-sfcalendar)**

**Screenshots**

![visible dates](http://www.syncfusion.com/uploads/user/kb/flut/flut-710/flut-710_img1.jpeg)
