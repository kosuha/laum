import 'package:flutter/cupertino.dart';

class WriteModalTitleInputWidget extends StatelessWidget {
  const WriteModalTitleInputWidget(
      {Key? key,
      required this.bottomState,
      required this.onTabEvent,
      required this.onEditingCompleteEvent})
      : super(key: key);

  final Function bottomState;
  final Function onTabEvent;
  final Function onEditingCompleteEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoTextField(
        onTap: () {
          onTabEvent(bottomState);
        },
        onEditingComplete: () {
          onEditingCompleteEvent(bottomState);
        },
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        cursorColor: Color(0xff000000),
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
    );
  }
}
