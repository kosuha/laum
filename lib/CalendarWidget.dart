import 'package:flutter/cupertino.dart';

class CalendarWidget extends StatefulWidget {
  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
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
  int year = now.year;
  int month = now.month;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dates = [];
    List<Row> rows = [];

    for (int i = 1; i <= DateTime(year, month + 1, 0).day; i++) {
      dates.add({
        "year": year,
        "month": month,
        "day": i,
        "inMonth": true,
      });
    }

    if (DateTime(year, month, 1).weekday != 7) {
      List<Map<String, dynamic>> temps = [];
      int prevLastDay = DateTime(year, month, 0).day;
      for (int i = DateTime(year, month, 1).weekday - 1; i >= 0; i--) {
        temps.add({
          "year": year,
          "month": month - 1,
          "day": prevLastDay - i,
          "inMonth": false,
        });
      }
      dates = [...temps, ...dates];
    }

    List<Map<String, dynamic>> temps = [];
    int maxIndex = 6 - DateTime(year, month + 1, 0).weekday;
    if (maxIndex == -1) {
      maxIndex = 6;
    }
    for (int i = 1; i <= maxIndex; i++) {
      temps.add({
        "year": year,
        "month": month + 1,
        "day": i,
        "inMonth": false,
      });
    }
    dates = [...dates, ...temps];

    int rowsLength = dates.length ~/ 7;
    for (int i = 0; i < rowsLength; i++) {
      List<Container> temps = [];
      for (int j = 0; j < 7; j++) {
        temps.add(dayContainer(dates[i * 7 + j]));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: temps,
      ));
    }

    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "$year",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  child: Row(children: [
                    Container(
                      child: Text(
                        months[month - 1],
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text("icon"),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Container(
            child: Column(children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: weekdaysText(weekdays),
                  ),
                  Column(
                    children: rows,
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }

  Container dayContainer(Map<String, dynamic> dateMap) {
    int date = dateMap["day"];
    BoxDecoration boxDecoration = BoxDecoration(
        color: Color(0x158B95A1), borderRadius: BorderRadius.circular(50));
    TextStyle textStyle = TextStyle(
        color: Color(0xff8B95A1), fontSize: 16, fontWeight: FontWeight.w400);

    if (DateTime(dateMap["year"], dateMap["month"], dateMap["day"])
        .isAfter(now)) {
      boxDecoration = BoxDecoration(color: Color(0x00000000));
      textStyle = textStyle = TextStyle(
          color: Color(0xff8B95A1), fontSize: 16, fontWeight: FontWeight.w400);
    }

    if (now.year == dateMap["year"] &&
        now.month == dateMap["month"] &&
        now.day == dateMap["day"]) {
      boxDecoration = BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Color(0xff000000)));
      textStyle = TextStyle(
          color: Color(0xff000000), fontSize: 16, fontWeight: FontWeight.w700);
    }

    if (now.year == dateMap["year"] &&
        now.month == dateMap["month"] &&
        now.day - 1 == dateMap["day"]) {
      boxDecoration = BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Color(0x00000000)));
      textStyle = TextStyle(
          color: Color(0xff000000), fontSize: 16, fontWeight: FontWeight.w400);
    }

    if (!dateMap["inMonth"]) {
      boxDecoration = BoxDecoration(color: Color(0x008B95A1));
      textStyle = TextStyle(color: Color(0x008B95A1), fontSize: 16);
    }

    return Container(
      alignment: Alignment.center,
      height: 75,
      width: 50,
      margin: EdgeInsets.all(1.0),
      decoration: boxDecoration,
      child: Text(
        "$date",
        style: textStyle,
      ),
    );
  }

  List<Container> weekdaysText(List<String> weekdays) {
    List<Container> res = [];
    for (int i = 0; i < weekdays.length; i++) {
      res.add(Container(
        alignment: Alignment.center,
        width: 50,
        margin: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 30),
        child: Text(
          weekdays[i],
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ));
    }
    return res;
  }
}
