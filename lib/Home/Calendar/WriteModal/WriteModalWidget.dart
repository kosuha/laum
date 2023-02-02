import 'package:flutter/cupertino.dart';
import './WriteModalTitleWidget.dart';
import 'WriteModalInputListWidget.dart';

class WriteModalWidget extends StatefulWidget {
  const WriteModalWidget({
    Key? key,
    required this.monthString,
    required this.date,
    required this.weekday,
  }) : super(key: key);

  final String monthString;
  final int date;
  final String weekday;

  @override
  State<WriteModalWidget> createState() => _WriteModalWidgetState();
}

class _WriteModalWidgetState extends State<WriteModalWidget> {
  double keyboardPadding = 0;

  @override
  void initState() {
    super.initState();
    keyboardPadding = 0;
  }

  @override
  Widget build(BuildContext context) {
    String titleText =
        "${widget.monthString} ${widget.date}, ${widget.weekday}";

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter bottomState) {
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
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              xmarkIconContainer(),
              WriteModalTitleWidget(titleText: titleText),
              Expanded(child: WriteModalInputListWidget()),
            ],
          ),
        ),
      );
    });
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
}
