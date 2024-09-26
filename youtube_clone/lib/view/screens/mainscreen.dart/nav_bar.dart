import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/routes/routes.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';
import 'package:youtube_clone/view/widgets/mini_player_widget.dart';
import 'package:youtube_clone/view/widgets/text_widget.dart';

import '../../../logic/controllers/mainscreen_controller.dart';
import '../../../logic/controllers/video_explore_controller.dart';
import '../../../logic/controllers/video_trending_controller.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/google_ads.dart';

class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);

  final mainController = Get.put(MainScreenController());
  final videoController1 = Get.put(VideoTrendingController());
  final videoController = Get.put(VideoExploreController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(builder: (_) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          color: ThemeService().isDarkMode() ? blackColor : primaryColor,
          child: SafeArea(
            child: Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        icon: mainController.i == 0
                            ? navBarIcon('assets/images/trending.png',
                                'Trending', 25, 13)
                            : navBarIcon('assets/images/trending-grey.png',
                                'Trending', 22, 11),
                        label: ''),

                    ////////////////////
                    BottomNavigationBarItem(
                        icon: mainController.i == 1
                            ? navBarIcon(
                                'assets/images/explorer.png', 'Explore', 28, 13)
                            : navBarIcon('assets/images/explorer-grey.png',
                                'Explore', 24, 11),
                        label: ''),
                    //////////////////////
                    BottomNavigationBarItem(
                        icon: mainController.i == 2
                            ? navBarIcon(
                                'assets/images/shorts.png', 'Shorts', 26, 13)
                            : navBarIcon('assets/images/shorts-grey.png',
                                'Shorts', 22, 11),
                        label: ''),
                  ],
                  backgroundColor: ThemeService().isDarkMode()
                      ? Colors.black.withOpacity(0.2)
                      : whiteColor,
                  elevation: 10,
                  currentIndex: mainController.i,
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) async {
                    if (index == 0) {
                      if (mainController.i != 0) {
                        videoController.changePage(0);
                        videoController1.getTrendingVideoPageData();
                      }

                      print(0);
                    }
                    if (index == 1) {
                      if (mainController.i != 1) {
                        videoController.getMusicVideoPageData();

                        showRewardedAd();
                      }

                      print(1);
                    }

                    if (index == 2) {
                      if (mainController.i != 2) {
                        showInterstitialAd();
                      }

                      print(2);
                    }
                    mainController.changeIndex(index);
                  },
                ),
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    mainController.screens[mainController.i],
                    ////////////////////////
                    mainController.isMiniPlayerShown
                        ? GestureDetector(
                            onTap: () {
                              // print(videoDetailSid);
                              Get.toNamed(
                                Routes.videoDetailsScreen,
                              );
                            },
                            ///////////////
                            onVerticalDragUpdate: (details) {
                              if (details.delta.dy < 0) {
                                Get.toNamed(
                                  Routes.videoDetailsScreen,
                                );
                              }
                            },
                            child: MiniPlayer(
                              img: miniPlayerImg,
                              title: miniPlayerTitle,
                              mainController: mainController,
                            ),
                          )
                        : Container()
                  ],
                )),
          ),
        ),
      );
    });
  }

  Widget navBarIcon(String img, String text, double iconSize, double textSize) {
    return Column(
      children: [
        Image.asset(
          img,
          width: iconSize,
        ),
        TextWidget(
          text: text,
          color: ThemeService().isDarkMode() ? whiteColor : blackColor,
          fontSize: textSize,
          fontWeight: FontWeight.normal,
          textAlign: TextAlign.center,
          maxline: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
