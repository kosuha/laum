import 'package:flutter/cupertino.dart';

class WriteModalTitleWidget extends StatelessWidget {
  const WriteModalTitleWidget({Key? key, required this.titleText})
      : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
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
}
