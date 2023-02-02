import 'package:flutter/cupertino.dart';
import './MonthTitleWidget.dart';
import './MonthBodyWidget.dart';
import './MonthChangeModal/MonthChangeModalWidget.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  List<String> weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  static DateTime now = DateTime.now();
  int year = 0;
  int month = 0;

  @override
  void initState() {
    super.initState();
    year = now.year;
    month = now.month;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: MonthTitleWidget(
                year: year,
                monthString: months[month - 1],
                onPressedEvent: calendarChangeButtonEvent),
          ),
          Container(
            child: GestureDetector(
              child: MonthBodyWidget(
                year: year,
                month: month,
                weekdays: weekdays,
                months: months,
              ),
            ),
          )
        ],
      ),
    );
  }

  void calendarChangeButtonEvent() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return MonthChangeModalWidget(
            setYear: setYear,
            setMonth: setMonth,
            selectedYear: year,
            selectedMonth: month,
          );
        });
  }

  void setYear(int yearTo) {
    setState(() {
      year = yearTo;
    });
  }

  void setMonth(int monthTo) {
    setState(() {
      month = monthTo;
    });
  }
}
