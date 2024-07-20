import 'package:flutter/material.dart';

import '../../core/constants/style_constants.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.customColor,
      this.hasIcon,
      this.icon,
      this.customTextColor,
      this.isLoading,
      this.customIconColor,
      this.isFullWidth})
      : super(key: key);
  final String text;
  final Function onPressed;
  final Color? customColor;
  final Color? customTextColor;
  final bool? hasIcon;
  final IconData? icon;
  final bool? isLoading;
  final Color? customIconColor;
  final bool? isFullWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth != null && isFullWidth == true ? MediaQuery.of(context).size.width : null,
      height: 38,
      child: hasIcon != null && hasIcon == true
          ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                enableFeedback: false,
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: const BorderSide(color: kTextColor, width: 2),
                ),
              ),
              onPressed: isLoading! ? null : () => onPressed(),
              icon: Icon(
                icon ?? Icons.done,
                color: customIconColor ?? kPrimaryColor,
              ),
              label: isLoading != null && isLoading == true
                  ? const CircularProgressIndicator(color: kOnBackgroundColor)
                  : Text(
                      text,
                      style: kBody3.copyWith(color: kTextColor),
                    ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                enableFeedback: false,
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: const BorderSide(color: kTextColor, width: 2),
                ),
              ),
              onPressed: isLoading != null && isLoading == true ? null : () => onPressed.call(),
              child: isLoading != null && isLoading == true
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ConstrainedBox(constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20), child: const CircularProgressIndicator()),
                        const SizedBox(width: 8),
                        Text(
                          'Aguarde...',
                          style: kBody2.copyWith(color: kTextColor),
                        ),
                      ],
                    )
                  : Text(
                      text,
                      style: kCaption1.copyWith(color: kTextColor),
                    ),
            ),
    );
  }
}
