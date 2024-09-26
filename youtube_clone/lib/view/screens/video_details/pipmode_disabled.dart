import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/logic/controllers/video_details_controller.dart';
import '../../../logic/controllers/mainscreen_controller.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/variables_and_func.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/video_widget.dart';
import 'package:share_plus/share_plus.dart';

class VideoPipModeDisabled extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final enablePopup;
  VideoPipModeDisabled({super.key, this.enablePopup});

  final videoController = Get.put(VideoDetailsController());
  final mainController = Get.find<MainScreenController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoDetailsController>(builder: (_) {
      return Column(
        children: [
          VideoPlayerWidget(mainController: mainController),
          VideoPlayerControlButton(videoController: videoController),
          //////////////
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextWidget(
                              text: videoDetailSTitle,
                              color: ThemeService().isDarkMode()
                                  ? whiteColor
                                  : blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.start,
                              maxline: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                videoController.openAndCloseDesc();
                              },
                              icon: const Icon(Icons.arrow_drop_down_outlined))
                        ],
                      ),
                      ///////////////////////
                      ///
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),

                      ///
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Expanded(
                                // flex: 3,
                                child: InkWell(
                              onTap: () async {
                                String videoUrl =
                                    'https://www.youtube.com/watch?v=$videoDetailSid';
                                await Share.share(videoUrl);
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: primaryColor,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextWidget(
                                          text: 'Share',
                                          color: whiteColor,
                                          fontSize: getSp(context, 9),
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center,
                                          maxline: 2),
                                      const Icon(
                                        Icons.share,
                                        color: whiteColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                            ////////////////////
                            const SizedBox(
                              width: 5,
                            ),
                            ///////////////////
                            GetBuilder<MainScreenController>(builder: (_) {
                              return Expanded(
                                  child: mainController.ifSubscribed(
                                          channelId: channelDetailSid)
                                      ? InkWell(
                                          onTap: () async {
                                            mainController.removeChannel(
                                                channelId: channelDetailSid);
                                          },
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: ThemeService().isDarkMode()
                                                  ? whiteColor
                                                  : blackColor,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4, left: 3),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  TextWidget(
                                                      text: 'Subscribed',
                                                      color: ThemeService()
                                                              .isDarkMode()
                                                          ? blackColor
                                                          : whiteColor,
                                                      fontSize:
                                                          getSp(context, 9),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxline: 2),
                                                  Icon(
                                                    Icons
                                                        .subscriptions_outlined,
                                                    color: ThemeService()
                                                            .isDarkMode()
                                                        ? blackColor
                                                        : whiteColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () async {
                                            await mainController
                                                .getChannelInfoPageData(
                                                    channelId: channelDetailSid)
                                                .then((value) {
                                              mainController.manageSubscribe(
                                                  channelId: channelDetailSid,
                                                  channelList: mainController
                                                      .channelInfoData);
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: primaryColor,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 2, left: 2),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextWidget(
                                                        text: 'Subscribe',
                                                        color: whiteColor,
                                                        fontSize:
                                                            getSp(context, 9),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxline: 2),
                                                    mainController
                                                            .isCircleProgressShown
                                                        ? const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: SizedBox(
                                                                height: 20,
                                                                width: 20,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color:
                                                                      whiteColor,
                                                                )),
                                                          )
                                                        : const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        3),
                                                            child: Icon(
                                                              Icons
                                                                  .subscriptions_outlined,
                                                              color: whiteColor,
                                                            ),
                                                          ),
                                                  ]),
                                            ),
                                          ),
                                        ));
                            }),
                            ////////////////////
                            const SizedBox(
                              width: 5,
                            ),
                            ///////////////////
                            Expanded(
                                child: InkWell(
                              onTap: enablePopup,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: primaryColor,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 4, left: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextWidget(
                                          text: 'Popup',
                                          color: whiteColor,
                                          fontSize: 5,
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center,
                                          maxline: 1),
                                      const Icon(
                                        Icons.picture_in_picture,
                                        color: whiteColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),

                      ///
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Container(
                          height: 2,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),

                      ////////////////////
                      videoController.isDescOpen
                          ? TextWidget(
                              text: videoDetailSDesc,
                              color: ThemeService().isDarkMode()
                                  ? whiteColor
                                  : blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.start,
                              maxline: 30,
                              overflow: TextOverflow.ellipsis,
                            )
                          : Container(),

                      ///
                      const SizedBox(
                        height: 10,
                      ),

                      videoController.isCircleProgressShown
                          ? Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : videoController.noInternetConnection
                              ? Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/no_connection.png',
                                      fit: BoxFit.contain,
                                      width: getWidthInPercent(context, 60),
                                    ),
                                    ////////////////
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 70, vertical: 30),
                                      child: ButtonWidget(
                                          onTap: () {
                                            videoController
                                                .getrelatedVideoPageData(
                                                    videoId: videoDetailSid);
                                          },
                                          text: TextWidget(
                                              text: 'Try Again',
                                              color: whiteColor,
                                              fontSize: getSp(context, 13),
                                              fontWeight: FontWeight.bold,
                                              textAlign: TextAlign.center,
                                              maxline: 2),
                                          color: primaryColor,
                                          radius: 5,
                                          icon: Container(),
                                          width: double.infinity,
                                          height: 40),
                                    ),
                                  ],
                                )
                              : Container(
                                  color:
                                      const Color.fromARGB(255, 224, 224, 224),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () async {
                                          videoDetailSid = videoController
                                              .relatedVideoData.items![index].id
                                              .toString();
                                          ////////////////////////////////////
                                          channelDetailSid = videoController
                                              .relatedVideoData
                                              .items![index]
                                              .snippet!
                                              .channelId
                                              .toString();
                                          /////////////////////////////////////
                                          ///
                                          miniPlayerImg = videoController
                                              .relatedVideoData
                                              .items![index]
                                              .snippet!
                                              .thumbnails!
                                              .high
                                              .url
                                              .toString();

                                          /////////////////////
                                          miniPlayerTitle = videoController
                                              .relatedVideoData
                                              .items![index]
                                              .snippet!
                                              .title
                                              .toString();

                                          ////////////////////////
                                          videoController.changeVideoTitle(
                                              videoController.relatedVideoData
                                                  .items![index].snippet!.title
                                                  .toString());
                                          ////////////////////////////////
                                          /////////////////////////////
                                          videoController.changeVideoDesc(
                                              videoController
                                                  .relatedVideoData
                                                  .items![index]
                                                  .snippet!
                                                  .description
                                                  .toString());
                                          ////////////////////////////
                                          videoController.changeVideoId(
                                              videoController.relatedVideoData
                                                  .items![index].id!.videoId
                                                  .toString());
                                          ///////////////////////
                                          videoController.reloadWithNewVideo(
                                              videoDetailSid.toString());
                                          ///////////////////////////////////
                                          await videoController
                                              .getrelatedVideoPageData(
                                                  videoId: videoDetailSid);
                                        },
                                        child: VideoWidget(
                                            img: videoController
                                                .relatedVideoData
                                                .items![index]
                                                .snippet!
                                                .thumbnails!
                                                .high
                                                .url,
                                            title: videoController
                                                .relatedVideoData
                                                .items![index]
                                                .snippet!
                                                .title
                                                .toString(),
                                            channelTitle: videoController
                                                .relatedVideoData
                                                .items![index]
                                                .snippet!
                                                .channelTitle
                                                .toString(),
                                            publishTime: videoController
                                                .relatedVideoData
                                                .items![index]
                                                .snippet!
                                                .publishTime
                                                .toString(),
                                            viewCount: ''),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 5,
                                      );
                                    },
                                  ),
                                )
                    ],
                  )),
            ),
          ),
        ],
      );
    });
  }
}

class VideoPlayerControlButton extends StatelessWidget {
  const VideoPlayerControlButton({
    Key? key,
    required this.videoController,
  }) : super(key: key);

  final VideoDetailsController videoController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 190, 190, 190),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                videoController.muteSound();
              },
              icon: videoController.isMuted
                  ? Icon(
                      Icons.volume_off,
                      color: primaryColor,
                    )
                  : Icon(
                      Icons.volume_up,
                      color: primaryColor,
                    ),
            ),
            ////////////////
            IconButton(
                onPressed: () {
                  videoController.pauseVideo();
                },
                icon: Icon(
                  Icons.pause_circle_rounded,
                  color: primaryColor,
                )),
            ////////////////
            IconButton(
                onPressed: () {
                  videoController.playVideo();
                },
                icon: Icon(
                  Icons.play_circle,
                  color: primaryColor,
                )),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.mainController,
  }) : super(key: key);

  final MainScreenController mainController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 8) {
          mainController.showOrHideMiniPlayer(true);
          ////////////////////////////////////////////////
          !(youtubController!.isVideoPlaying)
              ? youtubController!.pause()
              : null;
          ////////////////////////////////////////////////
          Get.back();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 5),
        child: PodVideoPlayer(
          controller: youtubController!,
        ),
      ),
    );
  }
}
