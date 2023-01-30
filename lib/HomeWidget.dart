import 'package:flutter/cupertino.dart';
import 'CalendarWidget.dart';
import 'DailyWidget.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int tabNumber = 0;
  List<Color> textColors = [Color(0xff000000), Color(0xffb0b0b0)];
  List<Color> lineColors = [Color(0xff000000), Color(0x00000000)];
  List<String> tabNames = ["Calendar", "Daily"];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topTabBar(tabNumber),
          displayedPage(tabNumber),
        ],
      ),
    );
  }

  Container displayedPage(int tabNumber) {
    if (tabNumber == 0) {
      return calendarPage();
    } else if (tabNumber == 1) {
      return dailyPage();
    }
    return calendarPage();
  }

  Container calendarPage() {
    return Container(
      alignment: Alignment.center,
      child: CalendarWidget(),
    );
  }

  Container dailyPage() {
    return Container(
      child: DailyWidget(),
    );
  }

  Container topTabBar(int tabNumber) {
    if (tabNumber == 0) {
      textColors[0] = Color(0xff000000);
      textColors[1] = Color(0xffb0b0b0);
      lineColors[0] = Color(0xff000000);
      lineColors[1] = Color(0x00000000);
    } else if (tabNumber == 1) {
      textColors[0] = Color(0xffb0b0b0);
      textColors[1] = Color(0xff000000);
      lineColors[0] = Color(0x00000000);
      lineColors[1] = Color(0xff000000);
    }

    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffe5e5e5)))),
      height: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          tabContainer(0),
          tabContainer(1),
        ],
      ),
    );
  }

  Container tabContainer(int number) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: underTabLine(lineColors[number]),
      margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
      child: CupertinoButton(
        onPressed: () {
          setState(() {
            tabNumber = number;
          });
        },
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Text(
          tabNames[number],
          style: TextStyle(
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: textColors[number],
          ),
        ),
      ),
    );
  }

  BoxDecoration underTabLine(Color lineColor) {
    return BoxDecoration(
        border: Border(bottom: BorderSide(color: lineColor, width: 3.0)));
  }
}
