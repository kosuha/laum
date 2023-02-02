import 'package:flutter/cupertino.dart';

class WriteModalImageInputWidget extends StatelessWidget {
  const WriteModalImageInputWidget({Key? key, required this.titleText})
      : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 40),
      child: GestureDetector(
        onTap: () {
          print("pic");
        },
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
    );
  }
}
