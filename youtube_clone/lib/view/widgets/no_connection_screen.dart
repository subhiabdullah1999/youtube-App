import 'package:flutter/material.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';
import 'package:youtube_clone/view/widgets/button_widget.dart';
import 'package:youtube_clone/view/widgets/text_widget.dart';

import '../../utils/app_theme.dart';

class NoConnectionScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onTap;

  const NoConnectionScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Image.asset(
              'assets/images/no_connection.png',
              fit: BoxFit.contain,
              width: getWidthInPercent(context, 60),
            )),
        Column(
          children: [
            TextWidget(
                text: 'No Connection',
                color: ThemeService().isDarkMode()
                    ? whiteColor
                    : Colors.black.withOpacity(0.5),
                fontSize: getSp(context, 15),
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                maxline: 2),
            TextWidget(
                text: 'Try again',
                color: ThemeService().isDarkMode()
                    ? whiteColor
                    : Colors.black.withOpacity(0.5),
                fontSize: getSp(context, 15),
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                maxline: 2),
          ],
        ),
        Expanded(
            flex: 1,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ButtonWidget(
                    onTap: onTap,
                    icon: Container(),
                    text: TextWidget(
                        text: 'Try Again',
                        color: whiteColor,
                        fontSize: getSp(context, 15),
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                        maxline: 2),
                    color: primaryColor,
                    radius: 5,
                    width: double.infinity,
                    height: 50),
              ),
            ]))
      ],
    );
  }
}
