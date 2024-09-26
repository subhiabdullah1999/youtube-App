import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';

class CircleIndicatorScreen extends StatelessWidget {
  final bool isWhite;
  const CircleIndicatorScreen({Key? key, this.isWhite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: isWhite
              ? ThemeService().isDarkMode()
                  ? Colors.black.withOpacity(0.5)
                  : whiteColor
              : Colors.black.withOpacity(0.3),
        ),
        CircularProgressIndicator(
          color: primaryColor,
        )
      ],
    );
  }
}
