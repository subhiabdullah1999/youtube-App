import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/view/widgets/silver_app_bar.dart';
import '../../../logic/controllers/mainscreen_controller.dart';
import '../../../logic/controllers/video_trending_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/variables_and_func.dart';
import '../../widgets/circle_indecator_screen.dart';
import '../../widgets/mini_player_widget.dart';
import '../../widgets/no_connection_screen.dart';
import '../../widgets/video_widget.dart';

class SearchedVideoScreen extends StatelessWidget {
  SearchedVideoScreen({super.key});
  final videoController = Get.put(VideoTrendingController());
  final mainController = Get.find<MainScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ThemeService().isDarkMode() ? blackColor : primaryColor,
        child: SafeArea(child: Scaffold(
          body: GetBuilder<VideoTrendingController>(builder: (_) {
            return RefreshIndicator(
              color: primaryColor,
              onRefresh: () async {
                await videoController.getTrendingVideoPageData();
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: ThemeService().isDarkMode()
                        ? const Color.fromARGB(255, 56, 56, 56)
                        : whiteColor,
                    child: CustomScrollView(
                      slivers: [
                        const CustomSliverAppBar(),
                        /////////////
                        videoController.isSearchCircleProgressShown
                            ? SliverToBoxAdapter(
                                child: Container(
                                    height: getHeightInPercent(context, 90),
                                    color: ThemeService().isDarkMode()
                                        ? const Color.fromARGB(255, 24, 24, 24)
                                        : whiteColor,
                                    child: const CircleIndicatorScreen(
                                      isWhite: true,
                                    )),
                              )
                            : videoController.noSearchInternetConnection
                                ? SliverToBoxAdapter(
                                    child: Container(
                                      height: getHeightInPercent(context, 90),
                                      color: ThemeService().isDarkMode()
                                          ? const Color.fromARGB(
                                              255, 24, 24, 24)
                                          : whiteColor,
                                      child:
                                          NoConnectionScreen(onTap: () async {
                                        await videoController
                                            .getSearchVideoPageData(
                                                q: videoController.searchQuery);
                                      }),
                                    ),
                                  )
                                :
                                /////////////////
                                SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3),
                                        child: InkWell(
                                          onTap: () {
                                            youtubController != null
                                                ? youtubController!.dispose()
                                                : null;

                                            youtubController = PodPlayerController(
                                                playVideoFrom: PlayVideoFrom.youtube(
                                                    'https://youtu.be/${videoController.searchVideo!.items![index].id!.videoId.toString()}',
                                                    videoPlayerOptions:
                                                        VideoPlayerOptions(
                                                            allowBackgroundPlayback:
                                                                true)),
                                                podPlayerConfig:
                                                    const PodPlayerConfig(
                                                        autoPlay: true,
                                                        isLooping: false,
                                                        videoQualityPriority: [
                                                      1080,
                                                      720,
                                                      360,
                                                      144
                                                    ]))
                                              ..initialise();

                                            miniPlayerImg = videoController
                                                .searchVideo!
                                                .items![index]
                                                .snippet!
                                                .thumbnails!
                                                .high
                                                .url
                                                .toString();

                                            /////////////////////
                                            miniPlayerTitle = videoController
                                                .searchVideo!
                                                .items![index]
                                                .snippet!
                                                .title
                                                .toString();
                                            ///////////////////
                                            ////////////////////////////////////
                                            channelDetailSid = videoController
                                                .searchVideo!
                                                .items![index]
                                                .snippet!
                                                .channelId
                                                .toString();
                                            /////////////////////////////////////
                                            ////////////////////
                                            videoDetailSid = videoController
                                                .searchVideo!
                                                .items![index]
                                                .id!
                                                .videoId
                                                .toString();
                                            /////////////////
                                            videoController.changeVideoTitle(
                                                videoController
                                                    .searchVideo!
                                                    .items![index]
                                                    .snippet!
                                                    .title
                                                    .toString());
                                            /////////////////////////////////////
                                            /////////////////////////////
                                            videoController.changeVideoDesc(
                                                videoController
                                                    .searchVideo!
                                                    .items![index]
                                                    .snippet!
                                                    .description
                                                    .toString());
                                            ////////////////////////////
                                            Get.toNamed(
                                              Routes.videoDetailsScreen,
                                            );
                                          },
                                          child: VideoWidget(
                                              img: videoController
                                                  .searchVideo!
                                                  .items![index]
                                                  .snippet!
                                                  .thumbnails!
                                                  .high
                                                  .url,
                                              title: videoController
                                                  .searchVideo!
                                                  .items![index]
                                                  .snippet!
                                                  .title
                                                  .toString(),
                                              channelTitle: videoController
                                                  .searchVideo!
                                                  .items![index]
                                                  .snippet!
                                                  .channelTitle
                                                  .toString(),
                                              publishTime: videoController
                                                  .searchVideo!
                                                  .items![index]
                                                  .snippet!
                                                  .publishedAt
                                                  .toString(),
                                              viewCount: ''),
                                        ),
                                      );
                                    },
                                    childCount: videoController
                                        .searchVideo!.items!.length
                                        .toInt(),
                                  ))
                      ],
                      /////////////
                    ),
                  ),
                  /////////////////
                  GetBuilder<MainScreenController>(builder: (_) {
                    return mainController.isMiniPlayerShown
                        ? GestureDetector(
                            onTap: () {
                              print(videoDetailSid);
                              Get.toNamed(
                                Routes.videoDetailsScreen,
                              );
                            },
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
                        : Container();
                  })
                ],
              ),
            );
          }),
        )));
  }
}
