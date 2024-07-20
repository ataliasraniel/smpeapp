import 'package:flutter/material.dart';

import '../../core/constants/style_constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({Key? key, required this.title, required this.onPressed}) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          title,
          style: kBody2.copyWith(color: kTextButtonColor, fontFamily: 'Roboto'),
        ));
  }
}
