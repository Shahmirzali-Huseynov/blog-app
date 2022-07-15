import 'package:flutter/material.dart';

InputDecoration textFormFieldDecoration({
  required BuildContext context,
  String? label,
  double? iconHeight,
  Color? fillColor,
  Widget? suffixIcon,
  Widget? prefixIcon,
  EdgeInsets? contentPadding,
  String? errorText,
  BorderSide? borderSide,
  BorderSide? focusedBorderSide,
  BorderSide? enabledBorderSide,
  String? hintText,
  TextStyle? hintStyle,
}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: fillColor,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: borderSide ?? const BorderSide(
        color: Colors.transparent,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: focusedBorderSide ??
          const BorderSide(
            color: Colors.transparent,
          ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: enabledBorderSide ??
          const BorderSide(
            color: Colors.transparent,
          ),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
     disabledBorder : const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    errorStyle: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.red),
    labelText: label,
    errorText: errorText,
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    hintText: hintText,
    alignLabelWithHint: true,
    isDense: true,
    hintStyle: hintStyle ??
        Theme.of(context).textTheme.headline6?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
    labelStyle: Theme.of(context).textTheme.headline6?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
    contentPadding: contentPadding ?? const EdgeInsets.all(0),
  );
}
