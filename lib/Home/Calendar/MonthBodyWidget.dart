import 'package:flutter/cupertino.dart';
import './WriteModal/WriteModalWidget.dart';

class MonthBodyWidget extends StatelessWidget {
  const MonthBodyWidget(
      {Key? key,
      required this.year,
      required this.month,
      required this.weekdays,
      required this.months})
      : super(key: key);

  final int year;
  final int month;
  final List<String> weekdays;
  final List<String> months;

  static DateTime now = DateTime.now();

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
      List<GestureDetector> temps = [];
      for (int j = 0; j < 7; j++) {
        temps.add(dayContainer(dates[i * 7 + j], context));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: temps,
      ));
    }

    return Flex(direction: Axis.vertical, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: weekdaysText(weekdays),
      ),
      Flex(
        direction: Axis.vertical,
        children: rows,
      )
    ]);
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

  GestureDetector dayContainer(
      Map<String, dynamic> dateMap, BuildContext context) {
    int date = dateMap["day"];
    BoxDecoration boxDecoration = BoxDecoration(
        color: Color(0x158B95A1), borderRadius: BorderRadius.circular(50));
    TextStyle textStyle = TextStyle(
        color: Color(0xff8B95A1), fontSize: 16, fontWeight: FontWeight.w400);
    bool isToday = (now.year == dateMap["year"] &&
        now.month == dateMap["month"] &&
        now.day == dateMap["day"]);
    bool isYesterday =
        (DateTime(dateMap["year"], dateMap["month"], dateMap["day"])
                .isBefore(DateTime(now.year, now.month, now.day)) &&
            DateTime(dateMap["year"], dateMap["month"], dateMap["day"])
                .isAfter(DateTime(now.year, now.month, now.day - 2)));

    if (DateTime(dateMap["year"], dateMap["month"], dateMap["day"])
        .isAfter(now)) {
      boxDecoration = BoxDecoration(color: Color(0x00000000));
      textStyle = textStyle = TextStyle(
          color: Color(0xff8B95A1), fontSize: 16, fontWeight: FontWeight.w400);
    }

    if (isToday) {
      isToday = true;
      boxDecoration = BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Color(0xff000000)));
      textStyle = TextStyle(
          color: Color(0xff000000), fontSize: 16, fontWeight: FontWeight.w700);
    }

    if (isYesterday) {
      isYesterday = true;
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

    return GestureDetector(
      onTap: () {
        if ((isYesterday || isToday) && dateMap["inMonth"]) {
          showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return WriteModalWidget(
                    monthString: months[dateMap["month"] - 1],
                    date: dateMap["day"],
                    weekday: weekdays[DateTime(
                            dateMap["year"], dateMap["month"], dateMap["day"])
                        .weekday]);
              });
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 75,
        width: 50,
        margin: EdgeInsets.all(1.0),
        decoration: boxDecoration,
        child: Text(
          "$date",
          style: textStyle,
        ),
      ),
    );
  }
}
