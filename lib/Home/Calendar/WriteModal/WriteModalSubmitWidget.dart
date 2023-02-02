import 'package:flutter/cupertino.dart';

class WriteModalSubmitWidget extends StatelessWidget {
  const WriteModalSubmitWidget({Key? key, required this.titleText})
      : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
