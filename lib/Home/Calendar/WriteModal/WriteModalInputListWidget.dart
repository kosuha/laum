import 'package:flutter/cupertino.dart';
import './WriteModalImageInputWidget.dart';
import 'WriteModalTitleInputWidget.dart';
import 'WriteModalParagraphInputWidget.dart';
import 'WriteModalSubmitWidget.dart';

class WriteModalInputListWidget extends StatefulWidget {
  const WriteModalInputListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<WriteModalInputListWidget> createState() =>
      _WriteModalInputListWidgetState();
}

class _WriteModalInputListWidgetState extends State<WriteModalInputListWidget> {
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
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter bottomState) {
      return ListView(
        controller: _scrollController,
        children: [
          WriteModalImageInputWidget(),
          WriteModalTitleInputWidget(
            bottomState: bottomState,
            onTabEvent: onTabTitleInputEvent,
            onEditingCompleteEvent: onEditingCompleteEvent,
          ),
          WriteModalParagraphInputWidget(
              bottomState: bottomState,
              onTabEvent: onTabTitleInputEvent,
              onEditingCompleteEvent: onEditingCompleteEvent),
          WriteModalSubmitWidget(titleText: "?"),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: keyboardPadding),
          ),
        ],
      );
    });
  }

  void onTabTitleInputEvent(StateSetter bottomState) {
    _scrollController.animateTo(320,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    bottomState(() {
      setState(() {
        keyboardPadding = 320;
      });
    });
  }

  void onEditingCompleteEvent(StateSetter bottomState) {
    FocusManager.instance.primaryFocus?.unfocus();
    bottomState(() {
      setState(() {
        keyboardPadding = 0;
      });
    });
  }
}
