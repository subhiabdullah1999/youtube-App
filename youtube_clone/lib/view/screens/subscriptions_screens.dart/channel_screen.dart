import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:youtube_clone/routes/routes.dart';
import 'package:youtube_clone/utils/app_theme.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';

import '../../../logic/controllers/mainscreen_controller.dart';
import '../../../logic/controllers/video_trending_controller.dart';
import '../../widgets/mini_player_widget.dart';
import '../../widgets/text_widget.dart';

class ChannelScreen extends StatelessWidget {
  ChannelScreen({super.key});
  final videoController = Get.put(VideoTrendingController());
  final mainController = Get.find<MainScreenController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeService().isDarkMode() ? blackColor : primaryColor,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: TextWidget(
                text: 'Subscription',
                color: whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
              ),
              backgroundColor:
                  ThemeService().isDarkMode() ? blackColor : primaryColor,
            ),
            body: GetBuilder<VideoTrendingController>(builder: (_) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  videoController.addLoaded == true
                      ? SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: AdWidget(ad: videoController.myBanner),
                        )
                      : Container(),
                  ////////////////////////////////////////////////////
                  Expanded(
                    child: GetBuilder<MainScreenController>(builder: (_) {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          mainController.subscribedList.isEmpty
                              ? Center(
                                  child: TextWidget(
                                    text: 'No Items',
                                    color: ThemeService().isDarkMode()
                                        ? whiteColor
                                        : blackColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.start,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: ListView.separated(
                                    itemCount:
                                        mainController.subscribedList.length,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 3,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes.channelVideosScreen,
                                              arguments: [
                                                //channelid
                                                mainController
                                                    .subscribedList[index]
                                                    .items[0]
                                                    .id,
                                                //channel image
                                                mainController
                                                    .subscribedList[index]
                                                    .items[0]
                                                    .snippet
                                                    .thumbnails
                                                    .high
                                                    .url,
                                                //channel title
                                                mainController
                                                    .subscribedList[index]
                                                    .items[0]
                                                    .snippet
                                                    .title,
                                              ]);

                                          ///////////////////
                                          mainController
                                              .getVideoInChannePageData(
                                            channelId: mainController
                                                .subscribedList[index]
                                                .items[0]
                                                .id,
                                          );
                                        },
                                        child: Dismissible(
                                          key: ValueKey<String>(mainController
                                              .subscribedList[index]
                                              .items[0]
                                              .id),
                                          onDismissed: (direction) {
                                            mainController.removeChannel(
                                                channelId: mainController
                                                    .subscribedList[index]
                                                    .items[0]
                                                    .id);
                                          },
                                          direction:
                                              DismissDirection.endToStart,
                                          background: Container(
                                            color: primaryColor,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: const [
                                                  Icon(
                                                    Icons.delete,
                                                    color: whiteColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            height: 120,
                                            color: ThemeService().isDarkMode()
                                                ? const Color.fromARGB(
                                                    255, 75, 75, 75)
                                                : const Color.fromARGB(
                                                    255, 235, 235, 235),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 5),
                                              child: Row(
                                                children: [
                                                  FancyShimmerImage(
                                                    width: 100,
                                                    height: 100,
                                                    imageUrl: mainController
                                                        .subscribedList[index]
                                                        .items[0]
                                                        .snippet
                                                        .thumbnails
                                                        .high
                                                        .url,
                                                    // ,
                                                    boxFit: BoxFit.contain,
                                                    shimmerBaseColor:
                                                        ThemeService()
                                                                .isDarkMode()
                                                            ? Colors.black
                                                                .withOpacity(
                                                                    0.5)
                                                            : whiteColor,
                                                    shimmerHighlightColor:
                                                        primaryColor,
                                                    shimmerBackColor: greyColor,
                                                  ),

                                                  ///////////////////////////
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10,
                                                          horizontal: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          //////title/////////////
                                                          TextWidget(
                                                            text: mainController
                                                                .subscribedList[
                                                                    index]
                                                                .items[0]
                                                                .snippet
                                                                .title,
                                                            color: ThemeService()
                                                                    .isDarkMode()
                                                                ? whiteColor
                                                                : blackColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxline: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          //////////////////////////////////
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          ////////////disc/////////////////////////
                                                          TextWidget(
                                                            text: mainController
                                                                .subscribedList[
                                                                    index]
                                                                .items[0]
                                                                .snippet
                                                                .description,
                                                            color: ThemeService()
                                                                    .isDarkMode()
                                                                ? whiteColor
                                                                : blackColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxline: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          /////////////////////////////////////
                                                          TextWidget(
                                                            text: getSubscNum(int
                                                                .parse(mainController
                                                                    .subscribedList[
                                                                        index]
                                                                    .items[0]
                                                                    .statistics
                                                                    .subscriberCount)),
                                                            color: ThemeService()
                                                                    .isDarkMode()
                                                                ? whiteColor
                                                                : blackColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxline: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          ////////////////////
                          mainController.isMiniPlayerShown
                              ? InkWell(
                                  onTap: () {
                                    print(videoDetailSid);
                                    Get.toNamed(
                                      Routes.videoDetailsScreen,
                                    );
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
                    }),
                  )
                ],
              );
            })),
      ),
    );
  }
}
