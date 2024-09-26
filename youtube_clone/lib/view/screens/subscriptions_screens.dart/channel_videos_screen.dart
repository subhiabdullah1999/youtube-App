import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/logic/controllers/mainscreen_controller.dart';

import '../../../logic/controllers/video_trending_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/google_ads.dart';
import '../../../utils/variables_and_func.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/circle_indecator_screen.dart';
import '../../widgets/mini_player_widget.dart';
import '../../widgets/no_connection_screen.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/video_widget.dart';

class ChannelVideosScreen extends StatelessWidget {
  ChannelVideosScreen({super.key});
  final mainController = Get.put(MainScreenController());
  final videoController = Get.put(VideoTrendingController());

  @override
  Widget build(BuildContext context) {
    String channelId = Get.arguments[0];
    String img = Get.arguments[1];
    String title = Get.arguments[2];

    return Container(
      color: ThemeService().isDarkMode() ? blackColor : primaryColor,
      child: SafeArea(
        child: Scaffold(body: GetBuilder<MainScreenController>(builder: (_) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                color: ThemeService().isDarkMode()
                    ? const Color.fromARGB(255, 109, 109, 109)
                    : const Color.fromARGB(255, 224, 224, 224),
                child: CustomScrollView(slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: 250.0,
                    floating: false,
                    pinned: true,
                    backgroundColor: ThemeService().isDarkMode()
                        ? blackColor
                        : const Color.fromARGB(255, 224, 224, 224),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      expandedTitleScale: 1.5,
                      titlePadding: const EdgeInsets.only(bottom: 1),
                      title: Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.all(5),
                        child: TextWidget(
                          text: title,
                          color: whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          maxline: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      background: FancyShimmerImage(
                        imageUrl: img,
                        boxFit: BoxFit.contain,
                        shimmerBaseColor: ThemeService().isDarkMode()
                            ? Colors.black.withOpacity(0.5)
                            : whiteColor,
                        shimmerHighlightColor: primaryColor,
                        shimmerBackColor: greyColor,
                      ),
                    ),
                  ),
                  //////////////////////////
                  SliverToBoxAdapter(
                    child: mainController.ifSubscribed(channelId: channelId)
                        ? ButtonWidget(
                            onTap: () async {
                              mainController.removeChannel(
                                  channelId: channelId);
                            },
                            text: TextWidget(
                                text: 'Subscribed',
                                color: ThemeService().isDarkMode()
                                    ? blackColor
                                    : whiteColor,
                                fontSize: getSp(context, 12),
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                                maxline: 2),
                            color: ThemeService().isDarkMode()
                                ? whiteColor
                                : blackColor,
                            radius: 0,
                            icon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: Icon(
                                Icons.subscriptions_outlined,
                                color: ThemeService().isDarkMode()
                                    ? blackColor
                                    : whiteColor,
                              ),
                            ),
                            width: double.infinity,
                            height: 40)
                        : ButtonWidget(
                            onTap: () async {
                              await mainController
                                  .getChannelInfoPageData(channelId: channelId)
                                  .then((value) {
                                mainController.manageSubscribe(
                                    channelId: channelId,
                                    channelList:
                                        mainController.channelInfoData);
                              });
                            },
                            text: TextWidget(
                                text: 'Subscribe',
                                color: whiteColor,
                                fontSize: getSp(context, 12),
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                                maxline: 2),
                            color: primaryColor,
                            radius: 0,
                            icon: mainController.isCircleProgressShown
                                ? const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: whiteColor,
                                        )),
                                  )
                                : const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                    child: Icon(
                                      Icons.subscriptions_outlined,
                                      color: whiteColor,
                                    ),
                                  ),
                            width: double.infinity,
                            height: 40),
                  ),
                  ///////////////////////////////////
                  mainController.isCircleProgressShown
                      ? SliverToBoxAdapter(
                          child: Container(
                              height: getHeightInPercent(context, 60),
                              color: ThemeService().isDarkMode()
                                  ? const Color.fromARGB(255, 56, 56, 56)
                                  : whiteColor,
                              child: const CircleIndicatorScreen(
                                isWhite: true,
                              )),
                        )
                      : mainController.noInternetConnection
                          ? SliverToBoxAdapter(
                              child: Container(
                                height: getHeightInPercent(context, 60),
                                color: ThemeService().isDarkMode()
                                    ? const Color.fromARGB(255, 56, 56, 56)
                                    : whiteColor,
                                child: NoConnectionScreen(onTap: () async {
                                  await mainController.getVideoInChannePageData(
                                      channelId: channelId);
                                }),
                              ),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  childCount: mainController.videoInChannelData
                                      .items!.length, (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: InkWell(
                                    onTap: () async {
                                      youtubController != null
                                          ? youtubController!.dispose()
                                          : null;
                                      //////////////////////////////
                                      youtubController = PodPlayerController(
                                          playVideoFrom: PlayVideoFrom.youtube(
                                              'https://youtu.be/${mainController.videoInChannelData.items![index].id!.videoId.toString()}',
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
                                      ////////////////////////////////////////////
                                      ///////////////////

                                      videoDetailSid = mainController
                                          .videoInChannelData
                                          .items![index]
                                          .id!
                                          .videoId
                                          .toString();
                                      // ////////////////////////////////////
                                      channelDetailSid = channelId;
                                      // /////////////////////////////////////
                                      // ///
                                      miniPlayerImg = mainController
                                          .videoInChannelData
                                          .items![index]
                                          .snippet!
                                          .thumbnails!
                                          .high
                                          .url
                                          .toString();

                                      // /////////////////////
                                      miniPlayerTitle = mainController
                                          .videoInChannelData
                                          .items![index]
                                          .snippet!
                                          .title
                                          .toString();

                                      // ////////////////////////

                                      videoController.changeVideoTitle(
                                          mainController.videoInChannelData
                                              .items![index].snippet!.title
                                              .toString());
                                      // ////////////////////////////
                                      /////////////////////////////
                                      videoController.changeVideoDesc(
                                          mainController
                                              .videoInChannelData
                                              .items![index]
                                              .snippet!
                                              .description
                                              .toString());
                                      ////////////////////////////
                                      ///////////////
                                      showInterstitialAd();
                                      // ////////////////////////
                                      Get.toNamed(
                                        Routes.videoDetailsScreen,
                                      );
                                    },
                                    child: VideoWidget(
                                        img: mainController
                                            .videoInChannelData
                                            .items![index]
                                            .snippet!
                                            .thumbnails!
                                            .high
                                            .url
                                            .toString(),
                                        title: mainController.videoInChannelData
                                            .items![index].snippet!.title
                                            .toString(),
                                        channelTitle: mainController
                                            .videoInChannelData
                                            .items![index]
                                            .snippet!
                                            .channelTitle
                                            .toString(),
                                        publishTime: mainController
                                            .videoInChannelData
                                            .items![index]
                                            .snippet!
                                            .publishedAt
                                            .toString(),
                                        viewCount: ''),
                                  ),
                                );
                              }),
                            )
                ]),
              ),
              //////////////////////////
              mainController.isMiniPlayerShown
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
                  : Container()
            ],
          );
        })),
      ),
    );
  }
}
