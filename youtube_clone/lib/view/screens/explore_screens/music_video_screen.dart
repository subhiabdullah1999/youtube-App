import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/utils/google_ads.dart';

import '../../../logic/controllers/video_explore_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/variables_and_func.dart';
import '../../widgets/circle_indecator_screen.dart';
import '../../widgets/no_connection_screen.dart';
import '../../widgets/video_widget.dart';

class MusicVideoScreen extends StatelessWidget {
  MusicVideoScreen({super.key});
  final videoController = Get.put(VideoExploreController());

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
                    await videoController.getMusicVideoPageData();
                  })
                : RefreshIndicator(
                    color: primaryColor,
                    onRefresh: () async {
                      await videoController.getMusicVideoPageData();
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
                                      'https://youtu.be/${videoController.musicVideoData.items![index].id}',
                                      // videoPlayerOptions: VideoPlayerOptions(
                                      //     allowBackgroundPlayback: true)
                                    ),
                                    podPlayerConfig: const PodPlayerConfig(
                                        autoPlay: true,
                                        isLooping: false,
                                        videoQualityPriority: [1080, 720, 360]))
                                  ..initialise();
                                ////////////////////////////////////////////
                                miniPlayerImg = videoController.musicVideoData
                                    .items![index].snippet.thumbnails.high.url
                                    .toString();

                                /////////////////////
                                miniPlayerTitle = videoController
                                    .musicVideoData.items![index].snippet.title
                                    .toString();
                                ///////////////////
                                ////////////////////////////////////
                                channelDetailSid = videoController
                                    .musicVideoData
                                    .items![index]
                                    .snippet
                                    .channelId
                                    .toString();
                                /////////////////////////////////////

                                videoDetailSid = videoController
                                    .musicVideoData.items![index].id;
                                /////////////////////////////////
                                showInterstitialAd();
                                ///////////////
                                videoController.changeVideoTitle(videoController
                                    .musicVideoData
                                    .items![index]
                                    .snippet
                                    .title);
                                //////////////////////////
                                /////////////////////////////
                                videoController.changeVideoDesc(videoController
                                    .musicVideoData
                                    .items![index]
                                    .snippet
                                    .description
                                    .toString());
                                ////////////////////////////
                                Get.toNamed(
                                  Routes.videoDetailsScreen,
                                );
                              },
                              child: VideoWidget(
                                  img: videoController
                                      .musicVideoData
                                      .items![index]
                                      .snippet
                                      .thumbnails
                                      .high
                                      .url,
                                  title: videoController.musicVideoData
                                      .items![index].snippet.title
                                      .toString(),
                                  channelTitle: videoController.musicVideoData
                                      .items![index].snippet.channelTitle,
                                  publishTime: videoController.musicVideoData
                                      .items![index].snippet.publishedAt,
                                  viewCount: videoController.musicVideoData
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
