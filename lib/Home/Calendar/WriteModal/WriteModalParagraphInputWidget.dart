import 'package:flutter/cupertino.dart';

class WriteModalParagraphInputWidget extends StatelessWidget {
  const WriteModalParagraphInputWidget(
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
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: Color(0xff000000),
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
    );
  }
}
