import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/routes/routes.dart';

import '../../../logic/controllers/video_explore_controller.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/google_ads.dart';
import '../../../utils/variables_and_func.dart';
import '../../widgets/circle_indecator_screen.dart';
import '../../widgets/no_connection_screen.dart';
import '../../widgets/video_widget.dart';

class NewsVideoScreen extends StatelessWidget {
  NewsVideoScreen({super.key});
  final videoController = Get.find<VideoExploreController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoExploreController>(
      builder: (_) {
        return videoController.isCircleProgressShown
            ? const CircleIndicatorScreen(
                isWhite: true,
              )
            : videoController.noInternetConnection
                ? NoConnectionScreen(onTap: () async {
                    await videoController.getNewsVideoDataPageData();
                  })
                : RefreshIndicator(
                    color: primaryColor,
                    onRefresh: () async {
                      await videoController.getNewsVideoDataPageData();
                    },
                    child: Container(
                      color: ThemeService().isDarkMode()
                          ? const Color.fromARGB(255, 56, 56, 56)
                          : whiteColor,
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: InkWell(
                              onTap: () {
                                youtubController != null
                                    ? youtubController!.dispose()
                                    : null;
                                //////////////////////////////
                                youtubController = PodPlayerController(
                                    playVideoFrom: PlayVideoFrom.youtube(
                                      'https://youtu.be/${videoController.newsVideoData.items![index].id}',
                                      // videoPlayerOptions: VideoPlayerOptions(
                                      //     allowBackgroundPlayback: true)
                                    ),
                                    podPlayerConfig: const PodPlayerConfig(
                                        autoPlay: true,
                                        isLooping: false,
                                        videoQualityPriority: [
                                          1080,
                                          720,
                                          360,
                                          144
                                        ]))
                                  ..initialise();
                                ////////////////////////////////////////////
                                miniPlayerImg = videoController.newsVideoData
                                    .items![index].snippet.thumbnails.high.url
                                    .toString();

                                /////////////////////
                                miniPlayerTitle = videoController
                                    .newsVideoData.items![index].snippet.title
                                    .toString();
                                ///////////////////
                                ////////////////////////////////////
                                channelDetailSid = videoController.newsVideoData
                                    .items![index].snippet.channelId
                                    .toString();
                                /////////////////////////////////////
                                ////////////////////
                                videoDetailSid = videoController
                                    .newsVideoData.items![index].id;
                                /////////////////
                                videoController.changeVideoTitle(videoController
                                    .newsVideoData.items![index].snippet.title);
                                /////////////////////////////
                                videoController.changeVideoDesc(videoController
                                    .newsVideoData
                                    .items![index]
                                    .snippet
                                    .description
                                    .toString());
                                ////////////////////////////
                                //////////////////////////
                                showInterstitialAd();
                                /////////////////////
                                Get.toNamed(
                                  Routes.videoDetailsScreen,
                                );
                              },
                              child: VideoWidget(
                                  img: videoController
                                      .newsVideoData
                                      .items![index]
                                      .snippet
                                      .thumbnails
                                      .high
                                      .url,
                                  title: videoController
                                      .newsVideoData.items![index].snippet.title
                                      .toString(),
                                  channelTitle: videoController.newsVideoData
                                      .items![index].snippet.channelTitle,
                                  publishTime: videoController.newsVideoData
                                      .items![index].snippet.publishedAt,
                                  viewCount: videoController.newsVideoData
                                      .items![index].statistics.viewCount),
                            ),
                          );
                        },
                      ),
                    ),
                  );
      },
    );
  }
}
