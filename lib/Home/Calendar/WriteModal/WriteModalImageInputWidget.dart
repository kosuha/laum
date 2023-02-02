import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class WriteModalImageInputWidget extends StatefulWidget {
  const WriteModalImageInputWidget({super.key});

  @override
  State<WriteModalImageInputWidget> createState() =>
      _WriteModalImageInputWidgetState();
}

class _WriteModalImageInputWidgetState
    extends State<WriteModalImageInputWidget> {
  final ImagePicker _picker = ImagePicker();
  late PickedFile? pickedFile;
  late File? f;

  @override
  void initState() {
    super.initState();
    f = null;
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxImageDeco = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xfff2f2f2),
    );
    if (f != null) {
      print("hi");
      boxImageDeco = BoxDecoration(
        image: DecorationImage(image: FileImage(f!)),
        borderRadius: BorderRadius.circular(20),
      );
    }
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 40),
      child: GestureDetector(
        onTap: () {
          _pickImage();
        },
        child: Container(
          alignment: Alignment.center,
          width: 200,
          height: 265,
          decoration: boxImageDeco,
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

  Future<void> _pickImage() async {
    // Navigator.pop(context);
    XFile? imageFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageFile != null) {
      setState(() {
        f = File(imageFile.path);
      });
    }
  }
}
