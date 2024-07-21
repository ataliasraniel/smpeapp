import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_number_constants.dart';
import '../../core/constants/style_constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.label,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.isPassword,
    this.validator,
    this.suffixText,
    this.initialValue,
    this.maskedTextController,
    this.inputFormatters,
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
    this.enabled = true,
  }) : super(key: key);
  final String? label;
  final String? hintText;
  final String? prefixText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final String? suffixText;
  final String? initialValue;
  final TextCapitalization? textCapitalization;
  final MaskedTextController? maskedTextController;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final bool? readOnly;
  final IconData? prefixIcon;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final bool enabled;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
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
      child: TextFormField(
        enabled: widget.enabled,
        readOnly: widget.readOnly ?? false,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        onTap: widget.onTap,
        focusNode: widget.focusNode,
        autofocus: widget.autoFocus ?? false,
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        maxLines: widget.isPassword != null && widget.isPassword! ? 1 : widget.maxLines,
        textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
        obscureText: _obscureText,

        controller: widget.controller ?? widget.maskedTextController,
        validator: widget.validator ??
            (value) {
              return null;
            },

        style: kCaption2.copyWith(
            // color: kDetailColor,
            ),
        onChanged: widget.onChanged,
        // cursorColor: kDetailColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: kMediumSize, vertical: kSmallSize),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: kDetailColor)),
          labelText: widget.label,
          hintStyle: kCaption2.copyWith(),
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
