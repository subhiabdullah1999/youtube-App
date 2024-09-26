import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/view/widgets/text_widget.dart';

import '../../routes/routes.dart';
import '../../utils/app_theme.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      snap: false,
      pinned: false,
      floating: false,
      expandedHeight: 85,
      title: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration:
                const BoxDecoration(color: whiteColor, shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(4.5),
              child: Image.asset(
                'assets/images/icon.png',
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          TextWidget(
            text: 'AndroTube',
            color: whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            maxline: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),

      //IconButton
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {
            Get.toNamed(Routes.searchBarScreen);
          },
        ),
        //IconButton
        IconButton(
          icon: const Icon(Icons.subscriptions_rounded),
          tooltip: 'Subscriptions',
          onPressed: () {
            Get.toNamed(Routes.channelScreen);
          },
        ),
        //IconButton
        IconButton(
          icon: const Icon(Icons.settings_applications_sharp),
          tooltip: 'Setting',
          onPressed: () {
            Get.toNamed(Routes.settingScreen);
          },
        ),
      ], //
    );
  }
}
