import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Widget child;
  final FontWeight? fontWeight;
  final Function() onClicked;
  final double? radiusAll;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final Color buttonColor;
  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final BoxConstraints? constraints;
  const ButtonWidget({
    required this.child,
    this.fontWeight,
    required this.onClicked,
    this.width,
    this.margin,
    this.padding,
    Key? key,
    required this.buttonColor,
    this.constraints,
    this.height,
    this.radiusAll,
    this.borderRadius,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      constraints: constraints,
      decoration: BoxDecoration(
        borderRadius: borderRadius ??
            BorderRadius.all(
              Radius.circular(radiusAll ?? 5),
            ),
        color: buttonColor,
        border: border,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onClicked,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0),
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
        ),
        child: child,
      ),
    );
  }
}
