import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/logic/controllers/mainscreen_controller.dart';
import 'package:youtube_clone/routes/routes.dart';
import 'package:youtube_clone/utils/app_theme.dart';
import 'package:youtube_clone/utils/google_ads.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';
import 'package:youtube_clone/view/widgets/circle_indecator_screen.dart';
import 'package:youtube_clone/view/widgets/no_connection_screen.dart';
import 'package:youtube_clone/view/widgets/silver_app_bar.dart';
import 'package:youtube_clone/view/widgets/video_widget.dart';

import '../../../logic/controllers/video_trending_controller.dart';

class TrendingScreen extends StatelessWidget {
  TrendingScreen({super.key});

  final videoController = Get.put(VideoTrendingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoTrendingController>(
      builder: (_) {
        return GetBuilder<MainScreenController>(builder: (_) {
          return RefreshIndicator(
            color: primaryColor,
            onRefresh: () async {
              await videoController.getTrendingVideoPageData();
            },
            child: Container(
              color: ThemeService().isDarkMode()
                  ? const Color.fromARGB(255, 109, 109, 109)
                  : const Color.fromARGB(255, 224, 224, 224),
              child: CustomScrollView(
                slivers: [
                  const CustomSliverAppBar(),
                  /////////google ads banner///////
                  SliverToBoxAdapter(
                      child: videoController.addLoaded == true
                          ? SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: AdWidget(ad: videoController.myBanner),
                            )
                          : Container()),
                  /////////////
                  videoController.isCircleProgressShown
                      ? SliverToBoxAdapter(
                          child: Container(
                              height: getHeightInPercent(context, 80),
                              color: ThemeService().isDarkMode()
                                  ? const Color.fromARGB(255, 56, 56, 56)
                                  : whiteColor,
                              child: const CircleIndicatorScreen(
                                isWhite: true,
                              )),
                        )
                      : videoController.noInternetConnection
                          ? SliverToBoxAdapter(
                              child: Container(
                                height: getHeightInPercent(context, 80),
                                color: ThemeService().isDarkMode()
                                    ? const Color.fromARGB(255, 56, 56, 56)
                                    : whiteColor,
                                child: NoConnectionScreen(onTap: () async {
                                  await videoController
                                      .getTrendingVideoPageData();
                                }),
                              ),
                            )
                          :
                          /////////////////
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: InkWell(
                                    onTap: () async {
                                      youtubController != null
                                          ? youtubController!.dispose()
                                          : null;

                                      youtubController = PodPlayerController(
                                          playVideoFrom: PlayVideoFrom.youtube(
                                              'https://youtu.be/${videoController.trendingVideoData.items![index].id}',
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

                                      videoDetailSid = videoController
                                          .trendingVideoData.items![index].id;
                                      ////////////////////////////////////
                                      channelDetailSid = videoController
                                          .trendingVideoData
                                          .items![index]
                                          .snippet
                                          .channelId
                                          .toString();
                                      /////////////////////////////////////
                                      ///
                                      miniPlayerImg = videoController
                                          .trendingVideoData
                                          .items![index]
                                          .snippet
                                          .thumbnails
                                          .high
                                          .url
                                          .toString();

                                      /////////////////////
                                      miniPlayerTitle = videoController
                                          .trendingVideoData
                                          .items![index]
                                          .snippet
                                          .title
                                          .toString();

                                      ////////////////////////

                                      videoController.changeVideoTitle(
                                          videoController.trendingVideoData
                                              .items![index].snippet.title
                                              .toString());
                                      /////////////////////////////
                                      videoController.changeVideoDesc(
                                          videoController.trendingVideoData
                                              .items![index].snippet.description
                                              .toString());
                                      ////////////////////////////
                                      showInterstitialAd();
                                      ////////////////////////
                                      Get.toNamed(
                                        Routes.videoDetailsScreen,
                                      );
                                    },
                                    child: VideoWidget(
                                        img: videoController
                                            .trendingVideoData
                                            .items![index]
                                            .snippet
                                            .thumbnails
                                            .high
                                            .url,
                                        title: videoController.trendingVideoData
                                            .items![index].snippet.title
                                            .toString(),
                                        channelTitle: videoController
                                            .trendingVideoData
                                            .items![index]
                                            .snippet
                                            .channelTitle,
                                        publishTime: videoController
                                            .trendingVideoData
                                            .items![index]
                                            .snippet
                                            .publishedAt,
                                        viewCount: videoController
                                            .trendingVideoData
                                            .items![index]
                                            .statistics
                                            .viewCount),
                                  ),
                                );
                              },
                              childCount: videoController
                                  .trendingVideoData.items!.length
                                  .toInt(),
                            ))
                ],
                /////////////
              ),
            ),
          );
        });
      },
    );
  }
}
