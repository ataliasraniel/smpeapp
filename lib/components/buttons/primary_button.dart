import 'package:flutter/material.dart';

import '../../core/constants/style_constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.customColor,
      this.hasIcon,
      this.icon,
      this.customTextColor,
      this.isLoading,
      this.isEnabled,
      this.isFullWidth = false})
      : super(key: key);
  final String text;
  final Function onPressed;
  final Color? customColor;
  final Color? customTextColor;
  final bool? hasIcon;
  final IconData? icon;
  final bool? isLoading;
  final bool? isEnabled;
  final bool isFullWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? MediaQuery.of(context).size.width : null,
      height: 38,
      child: hasIcon != null && hasIcon == true
          ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: customColor ?? kDetailColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: isLoading! ? null : () => onPressed(),
              icon: Icon(
                icon ?? Icons.done,
                color: kOnBackgroundColor,
              ),
              label: isLoading != null && isLoading == true
                  ? const CircularProgressIndicator(color: kOnBackgroundColor)
                  : Text(
                      text,
                      style: kCaption2.copyWith(color: customTextColor ?? kOnBackgroundColor),
                    ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: customColor ?? kDetailColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: isLoading != null && isLoading == true
                  ? null
                  : isEnabled != null && isEnabled == false
                      ? null
                      : () => onPressed.call(),
              child: isLoading != null && isLoading == true
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ConstrainedBox(constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20), child: const CircularProgressIndicator()),
                        const SizedBox(width: 8),
                        Text(
                          'Aguarde...',
                          style: kCaption2.copyWith(color: customTextColor ?? kOnBackgroundColor),
                        ),
                      ],
                    )
                  : Text(
                      text,
                      style: kCaption2.copyWith(color: customTextColor ?? kOnBackgroundColor),
                    ),
            ),
    );
  }
}
