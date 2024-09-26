import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/logic/controllers/mainscreen_controller.dart';
import 'package:youtube_clone/view/screens/explore_screens/music_video_screen.dart';
import 'package:youtube_clone/view/screens/explore_screens/news_video_screen.dart';
import 'package:youtube_clone/view/screens/explore_screens/sport_video_screen.dart';
import 'package:youtube_clone/view/widgets/silver_app_bar.dart';

import '../../../logic/controllers/video_explore_controller.dart';
import '../../../utils/app_theme.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  final videoController = Get.put(VideoExploreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const CustomSliverAppBar(),
            //////////////////////
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: primaryColor,
                  labelColor:
                      ThemeService().isDarkMode() ? whiteColor : blackColor,
                  onTap: (value) {
                    switch (value) {
                      case 0:
                        videoController.currentPage != 0
                            ? videoController.getMusicVideoPageData()
                            : null;
                        break;
                      case 1:
                        videoController.currentPage != 1
                            ? videoController.getsportVideoDataPageData()
                            : null;
                        break;
                      case 2:
                        videoController.currentPage != 2
                            ? videoController.getNewsVideoDataPageData()
                            : null;
                        break;
                    }

                    videoController.changePage(value);
                  },
                  tabs: [
                    Tab(
                        icon: Icon(
                          Icons.music_note_outlined,
                          color: primaryColor,
                        ),
                        text: "Music"),
                    Tab(
                        icon: Icon(
                          Icons.sports_soccer,
                          color: primaryColor,
                        ),
                        text: "Sport"),
                    Tab(
                        icon: Icon(
                          Icons.newspaper,
                          color: primaryColor,
                        ),
                        text: "News"),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        }, body: GetBuilder<VideoExploreController>(builder: (_) {
          switch (videoController.currentPage) {
            case 0:
              return MusicVideoScreen();

            case 1:
              return SportVideoScreen();
            case 2:
              return NewsVideoScreen();
          }

          return Container();
        })),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GetBuilder<MainScreenController>(builder: (_) {
      return Container(
        color: ThemeService().isDarkMode()
            ? const Color.fromARGB(255, 24, 24, 24)
            : whiteColor,
        child: _tabBar,
      );
    });
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
