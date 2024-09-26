import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/logic/controllers/mainscreen_controller.dart';
import 'package:youtube_clone/utils/app_theme.dart';
import 'package:youtube_clone/view/widgets/text_widget.dart';

class SearchWidget extends StatelessWidget {
  final String img;
  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final onTap;
  const SearchWidget(
      {super.key, required this.img, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(builder: (_) {
      return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          width: double.infinity,
          height: 60,
          color: ThemeService().isDarkMode() ? blackColor : whiteColor,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: primaryColor,
              backgroundImage: NetworkImage(img),
            ),
            title: TextWidget(
              text: title,
              color: ThemeService().isDarkMode() ? whiteColor : blackColor,
              fontSize: 13,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.start,
              maxline: 3,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: onTap,
          ));
    });
  }
}
