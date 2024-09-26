import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/routes/routes.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';

import '../../../logic/controllers/video_explore_controller.dart';
import '../../../utils/app_theme.dart';
import '../../widgets/circle_indecator_screen.dart';
import '../../widgets/no_connection_screen.dart';
import '../../widgets/video_widget.dart';

class SportVideoScreen extends StatelessWidget {
  SportVideoScreen({super.key});
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
                    await videoController.getsportVideoDataPageData();
                  })
                : RefreshIndicator(
                    color: primaryColor,
                    onRefresh: () async {
                      await videoController.getsportVideoDataPageData();
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
                                      'https://youtu.be/${videoController.sportVideoData.items![index].id}',
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
                                miniPlayerImg = videoController.sportVideoData
                                    .items![index].snippet.thumbnails.high.url
                                    .toString();

                                /////////////////////
                                miniPlayerTitle = videoController
                                    .sportVideoData.items![index].snippet.title
                                    .toString();
                                ///////////////////
                                ////////////////////////////////////
                                channelDetailSid = videoController
                                    .sportVideoData
                                    .items![index]
                                    .snippet
                                    .channelId
                                    .toString();
                                /////////////////////////////////////
                                ////////////////////
                                videoDetailSid = videoController
                                    .sportVideoData.items![index].id;
                                /////////////////
                                videoController.changeVideoTitle(videoController
                                    .sportVideoData
                                    .items![index]
                                    .snippet
                                    .title);
                                //////////////////////////
                                /////////////////////////////
                                videoController.changeVideoDesc(videoController
                                    .sportVideoData
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
                                      .sportVideoData
                                      .items![index]
                                      .snippet
                                      .thumbnails
                                      .high
                                      .url,
                                  title: videoController.sportVideoData
                                      .items![index].snippet.title
                                      .toString(),
                                  channelTitle: videoController.sportVideoData
                                      .items![index].snippet.channelTitle,
                                  publishTime: videoController.sportVideoData
                                      .items![index].snippet.publishedAt,
                                  viewCount: videoController.sportVideoData
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
