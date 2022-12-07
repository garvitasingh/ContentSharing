
import 'package:clg_content_sharing/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonFatButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Function() onPressed;
  CommonFatButton({required this.text, this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    final height = Get.height;
    return Container(
      height: height * 0.062,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text,
              style: textTheme.displayMedium?.copyWith(color: Colors.white)),
          style: ElevatedButton.styleFrom(
              primary: Constants.PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
    );
  }
}
