import 'package:flutter/cupertino.dart';
import '../CalendarWidget.dart';

class MonthChangeModalWidget extends StatefulWidget {
  const MonthChangeModalWidget({
    Key? key,
    required this.setYear,
    required this.setMonth,
    required this.selectedYear,
    required this.selectedMonth,
  }) : super(key: key);

  final Function setYear;
  final Function setMonth;
  final int selectedYear;
  final int selectedMonth;

  @override
  State<MonthChangeModalWidget> createState() => _MonthChangeModalWidgetState();
}

class _MonthChangeModalWidgetState extends State<MonthChangeModalWidget> {
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
  int yearTo = 0;
  int monthTo = 0;

  @override
  void initState() {
    super.initState();
    yearTo = widget.selectedYear;
    monthTo = widget.selectedMonth;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter bottomState) {
      return calendarChangeModalContainer(context, bottomState);
    });
  }

  Container calendarChangeModalContainer(
      BuildContext context, StateSetter bottomState) {
    // yearTo = widget.selectedYear;
    // monthTo = widget.selectedMonth;
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
                  widget.setMonth(monthTo);
                  widget.setYear(yearTo);
                  Navigator.pop(context);
                },
                child: Text('확인')),
          ),
        ],
      ),
    );
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

  List<Row> monthsRow(
    List<String> months,
    StateSetter bottomState,
  ) {
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
}
