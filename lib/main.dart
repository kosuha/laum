import 'package:flutter/cupertino.dart';
import 'PlayWidget.dart';
import 'HomeWidget.dart';
import 'SettingWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Laum';

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: _title,
      home: MainWidget(),
      theme:
          CupertinoThemeData(primaryColor: Color.fromARGB(255, 255, 255, 255)),
    );
  }
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.memories)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar_today)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.line_horizontal_3))
    ];

    return CupertinoTabScaffold(
        resizeToAvoidBottomInset: false,
        tabBar: CupertinoTabBar(
          items: items,
          activeColor: Color(0xff000000),
          backgroundColor: Color(0xffffffff),
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return PlayWidget();
            case 1:
              return HomeWidget();
            case 2:
              return SettingWidget();
            default:
              return HomeWidget();
          }
        });
  }
}
