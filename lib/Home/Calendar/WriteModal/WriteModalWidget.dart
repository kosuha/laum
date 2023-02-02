import 'package:flutter/cupertino.dart';

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
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String titleText = "${widget.monthString} ${widget.date} ${widget.weekday}";

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
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              xmarkIconContainer(),
              writeModalTitleContainer(titleText),
              Expanded(child: writeModalInputList(bottomState)),
            ],
          ),
        ),
      );
    });
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
        ),
      ],
    );
  }
}
