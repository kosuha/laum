import 'package:flutter/cupertino.dart';

class MonthTitleWidget extends StatelessWidget {
  const MonthTitleWidget(
      {Key? key,
      required this.year,
      required this.monthString,
      required this.onPressedEvent})
      : super(key: key);

  final int year;
  final String monthString;
  final VoidCallback onPressedEvent;

  @override
  Widget build(BuildContext context) {
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
                monthString,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 7),
              alignment: Alignment.bottomCenter,
              onPressed: onPressedEvent,
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
}
