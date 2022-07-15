import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  double get screenHeight => mediaQuery.size.height;
  double get screenWidth => mediaQuery.size.width;

  double dynamicHeight(double value) => mediaQuery.size.height * value;
  double dynamicWidth(double value) => mediaQuery.size.width * value;
}

extension PaddingExtension on BuildContext {
  EdgeInsets paddingAll(double value) => EdgeInsets.all(value);
  EdgeInsets paddingSymmetric(double? vertical, double? horizontal) => EdgeInsets.symmetric(
        vertical: vertical ?? 0,
        horizontal: horizontal ?? 0,
      );
  EdgeInsets paddingOnly({double? left, double? top, double? right, double? bottom}) => EdgeInsets.only(
        left: left ?? 0,
        right: right ?? 0,
        top: top ?? 0,
        bottom: bottom ?? 0,
      );
}
