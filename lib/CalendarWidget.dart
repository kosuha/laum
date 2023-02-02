import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

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
  int yearTo = now.year;
  int monthTo = now.month;
  double keyboardPadding = 0;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

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
        temps.add(dayContainer(dates[i * 7 + j]));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: temps,
      ));
    }

    return Container(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: yearAndMonth(),
          ),
          Container(
            child: monthContent(rows),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  GestureDetector dayContainer(Map<String, dynamic> dateMap) {
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
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter bottomState) {
                  return writeModalContainer(dateMap, bottomState);
                });
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

  Container xmarkIconContainer() {
    return Container(
      alignment: Alignment.centerRight,
      child: CupertinoButton(
        child: Icon(
          CupertinoIcons.xmark,
          color: Color(0xff191919),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Container writeModalTitleContainer(String titleText) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 20,
            margin: EdgeInsets.only(left: 24, right: 11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xff000000),
            ),
          ),
          Container(
            child: Text(
              titleText,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView writeModalInputList(StateSetter bottomState) {
    return ListView(
      controller: _scrollController,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 40),
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 265,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xfff2f2f2),
            ),
            child: Container(
                alignment: Alignment.center,
                width: 45,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Color(0xff8b8b8b)),
                ),
                child: Icon(
                  CupertinoIcons.plus,
                  color: Color(0xff000000),
                )),
          ),
        ),
        Container(
          child: CupertinoTextField(
            onTap: () {
              _scrollController.animateTo(320,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
              bottomState(() {
                setState(() {
                  keyboardPadding = 320;
                });
              });
            },
            onEditingComplete: () {
              FocusManager.instance.primaryFocus?.unfocus();
              bottomState(() {
                setState(() {
                  keyboardPadding = 0;
                });
              });
            },
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            placeholder: "제목을 입력해주세요.",
            placeholderStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xffbdbdbd),
              backgroundColor: Color(0x00000000),
            ),
            maxLines: 1,
            maxLength: 30,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xffe5e5e5)))),
          ),
        ),
        Container(
          child: CupertinoTextField(
            onTap: () {
              _scrollController.animateTo(320,
                  duration: Duration(milliseconds: 100), curve: Curves.ease);
              bottomState(() {
                setState(() {
                  keyboardPadding = 320;
                });
              });
            },
            onEditingComplete: () {
              FocusManager.instance.primaryFocus?.unfocus();
              bottomState(() {
                setState(() {
                  keyboardPadding = 0;
                });
              });
            },
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: Color(0xff555555),
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            maxLength: 200,
            placeholder: "하루를 기록해주세요.",
            placeholderStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xffbdbdbd),
              backgroundColor: Color(0x00000000),
            ),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xffe5e5e5)))),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 18),
            color: Color(0xff000000),
            borderRadius: BorderRadius.circular(50),
            onPressed: () {
              print("submit");
            },
            child: Text(
              "기록하기",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: keyboardPadding),
          // height: MediaQuery.of(context).viewInsets.bottom,
        ),
      ],
    );
  }

  GestureDetector writeModalContainer(
      Map<String, dynamic> dateMap, StateSetter bottomState) {
    String monthString = months[dateMap["month"] - 1];
    int date = dateMap["day"];
    String weekday = weekdays[
        DateTime(dateMap["year"], dateMap["month"], dateMap["day"]).weekday -
            1];

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        bottomState(() {
          setState(() {
            keyboardPadding = 0;
          });
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        child: Flex(
          direction: Axis.vertical,
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            xmarkIconContainer(),
            writeModalTitleContainer("$monthString $date, $weekday"),
            Expanded(child: writeModalInputList(bottomState)),
          ],
        ),
      ),
    );
  }

  Flex yearAndMonth() {
    return Flex(
      direction: Axis.vertical,
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
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 7),
              alignment: Alignment.bottomCenter,
              onPressed: calendarChangeButtonEvent,
              child: Icon(
                CupertinoIcons.calendar_today,
                color: Color(0xff777777),
              ),
            )
          ]),
        ),
      ],
    );
  }

  Flex monthContent(rows) {
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

  void calendarChangeButtonEvent() {
    setState(() {
      monthTo = month;
      yearTo = year;
    });
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter bottomState) {
            return calendarChangeModalContainer(context, bottomState);
          });
        });
  }

  Container calendarChangeModalContainer(
      BuildContext context, StateSetter bottomState) {
    return Container(
      // height: 200,
      padding: EdgeInsets.fromLTRB(15, 10, 15, 50),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            // decoration: BoxDecoration(
            //     border: Border.all(color: Color(0xff000000))),
            child: CupertinoButton(
              child: Icon(
                CupertinoIcons.xmark,
                color: Color(0xff8b8b8b),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            // decoration: BoxDecoration(
            //     border: Border.all(color: Color(0xff000000))),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
            alignment: Alignment.center,
            child: Column(children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: yearToChangeRow(bottomState),
                ),
              ),
              Column(
                children: monthsRow(months, bottomState),
              )
            ]),
          ),
          Container(
            height: 56,
            child: CupertinoButton(
                color: Color(0xff000000),
                minSize: MediaQuery.of(context).size.width,
                onPressed: () {
                  month = monthTo;
                  year = yearTo;
                  Navigator.pop(context);
                },
                child: Text('확인')),
          ),
        ],
      ),
    );
  }

  List<Row> monthsRow(List<String> months, StateSetter bottomState) {
    List<Row> res = [];
    Color borderColor = Color(0x00000000);

    for (int i = 0; i < 3; i++) {
      List<GestureDetector> textButtons = [];
      for (int j = 0; j < 4; j++) {
        String monthSymbol = months[i * 4 + j].substring(0, 3).toUpperCase();
        if (i * 4 + j + 1 == monthTo) {
          borderColor = Color(0xff000000);
        } else {
          borderColor = Color(0x00000000);
        }
        textButtons.add(GestureDetector(
          onTap: () {
            bottomState(() {
              setState(() {
                monthTo = i * 4 + j + 1;
              });
            });
          },
          child: Container(
              alignment: Alignment.center,
              width: 75,
              height: 50,
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                monthSymbol,
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )),
        ));
      }
      res.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: textButtons,
      ));
    }
    return res;
  }

  List<GestureDetector> yearToChangeRow(StateSetter bottomState) {
    List<GestureDetector> res = [];

    res.add(GestureDetector(
      onTap: () {
        bottomState(() {
          setState(() {
            yearTo--;
          });
        });
      },
      child: Container(
          padding: EdgeInsets.all(10),
          decoration:
              BoxDecoration(border: Border.all(color: Color(0x00000000))),
          child: Icon(
            CupertinoIcons.left_chevron,
            color: Color(0xff000000),
          )),
    ));
    res.add(GestureDetector(
      onDoubleTap: () {
        bottomState(() {
          setState(() {
            monthTo = now.month;
            yearTo = now.year;
          });
        });
      },
      child: Text(
        "$yearTo",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      ),
    ));
    res.add(GestureDetector(
      onTap: () {
        bottomState(() {
          setState(() {
            yearTo++;
          });
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Color(0x00000000))),
        child: Icon(
          CupertinoIcons.right_chevron,
          color: Color(0xff000000),
        ),
      ),
    ));

    return res;
  }
}
