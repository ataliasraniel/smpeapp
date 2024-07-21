import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_number_constants.dart';
import '../../core/constants/style_constants.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    Key? key,
    this.label,
    this.keyboardType,
    this.hintText,
    this.isPassword,
    this.validator,
    this.suffixText,
    this.initialValue,
    this.maskedTextController,
    this.onChanged,
    this.prefixText,
    this.textCapitalization,
    this.maxLength,
    this.maxLines,
    this.readOnly,
    this.onTap,
    this.prefixIcon,
    this.autoFocus,
    this.focusNode,
    required this.items,
    this.isExpanded,
    this.enabled = true,
    required this.value,
  }) : super(key: key);
  final String? label;
  final String? hintText;
  final String? prefixText;
  final TextInputType? keyboardType;
  final List<DropdownMenuItem> items;
  final bool? isPassword;
  final String? Function(dynamic value)? validator;
  final void Function(dynamic value)? onChanged;
  final void Function()? onTap;
  final String? suffixText;
  final String? initialValue;
  final TextCapitalization? textCapitalization;
  final MaskedTextController? maskedTextController;
  final int? maxLength;
  final int? maxLines;
  final bool? readOnly;
  final IconData? prefixIcon;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final bool enabled;
  final bool? isExpanded;
  final dynamic value;
  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  bool _obscureText = false;
  @override
  void initState() {
    if (widget.isPassword != null) {
      _obscureText = widget.isPassword!;
    }
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kSmallSize, top: kSmallSize),
      child: DropdownButtonFormField(
        items: widget.items,
        onTap: widget.onTap,
        focusNode: widget.focusNode,
        autofocus: widget.autoFocus ?? false,

        isExpanded: widget.prefixIcon != null ? true : widget.isExpanded ?? false,
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          return null;
        },
        value: widget.value,

        isDense: true,
        style: kCaption2.copyWith(
          color: kDetailColor,
        ),
        onChanged: widget.onChanged,

        // cursorColor: kDetailColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: kMediumSize, vertical: kSmallSize),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: kDetailColor)),
          labelText: widget.label,
          hintStyle: kCaption2.copyWith(),
          disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          labelStyle: kCaption2.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          counterText: '',
          suffixText: widget.suffixText,
          filled: true,
          prefixText: widget.prefixText,
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: kDetailColor,
                )
              : null,
          focusColor: kDetailColor,
          hintText: widget.hintText,
          suffixIcon: widget.isPassword == true
              ? InkWell(
                  onTap: () => _toggleVisibility(),
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    // color: kDetailColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
