import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    this.icon,
    this.text,
    this.textStyle,
    this.iconColor,
    this.backgroundColor,
    this.isScientic = false,
    this.onPressed,
  });

  final IconData? icon;
  final String? text;
  final TextStyle? textStyle;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool isScientic;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor:
            backgroundColor ?? const Color.fromARGB(255, 242, 245, 251),
      ),
      icon: SizedBox(
        height: MediaQuery.of(context).size.height / (isScientic ? 9 : 6.3),
        width: MediaQuery.of(context).size.width / (isScientic ? 9 : 6.3),
        child: Center(
          child: icon == null
              ? Text(
                  text ?? "",
                  style: textStyle ??
                      const TextStyle(
                        color: Color.fromARGB(255, 242, 245, 251),
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                )
              : Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
        ),
      ),
    );
  }
}
