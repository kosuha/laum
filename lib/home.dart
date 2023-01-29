import 'package:flutter/cupertino.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int tabNumber = 0;

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
      child: Text("Calendar"),
    );
  }

  Container dailyPage() {
    return Container(
      child: Text("Daily"),
    );
  }

  Container topTabBar(int tabNumber) {
    List<Color> textColors = [Color(0xff000000), Color(0xffb0b0b0)];
    List<Color> lineColors = [Color(0xff000000), Color(0x00000000)];

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
          Container(
            alignment: Alignment.bottomCenter,
            decoration: underTabLine(lineColors[0]),
            margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
            child: CupertinoButton(
              onPressed: _tabChangeEvent0,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Text(
                "Calendar",
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: textColors[0],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            decoration: underTabLine(lineColors[1]),
            margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
            child: CupertinoButton(
              onPressed: _tabChangeEvent1,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Text(
                "Daily",
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: textColors[1],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration underTabLine(Color lineColor) {
    return BoxDecoration(
        border: Border(bottom: BorderSide(color: lineColor, width: 3.0)));
  }

  void _tabChangeEvent0() {
    setState(() {
      tabNumber = 0;
    });
  }

  void _tabChangeEvent1() {
    setState(() {
      tabNumber = 1;
    });
  }
}
