import 'package:flutter/material.dart';
import 'package:flutter_template/ui/themes/text_styles.dart';

const buttonElevation = 8.0;
const borderRadius = 20.0;

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool disabled;
  final bool isLoading;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final IconData? icon;
  final Color? iconColor;

  const Button({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textStyle,
    this.disabled = false,
    this.isLoading = false,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => (disabled || isLoading) ? null : onPressed(),
        style: ButtonStyle(
            backgroundColor: backgroundColor != null
                ? MaterialStateProperty.all<Color>(backgroundColor!)
                : MaterialStateProperty.all<Color>(disabled || isLoading
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).primaryColor),
            textStyle: MaterialStateProperty.all<TextStyle>(textInput),
            elevation: MaterialStateProperty.all<double?>(borderRadius),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonElevation),
            ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isLoading)
              const SizedBox.square(
                dimension: 12,
                child: CircularProgressIndicator(
                  value: null,
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),
            if (!isLoading && icon != null)
              Icon(icon, color: iconColor ?? Colors.white),
            if (isLoading || icon != null) const SizedBox(width: 10),
            Text(text, style: textStyle),
          ],
        ));
  }
}
