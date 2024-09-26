import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube_clone/utils/app_theme.dart';
import '../../../logic/controllers/mainscreen_controller.dart';
import '../../../logic/controllers/video_trending_controller.dart';
import '../../../routes/routes.dart';
import '../../widgets/text_widget.dart';

class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({super.key});

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  final videoController = Get.put(VideoTrendingController());
  final mainController = Get.find<MainScreenController>();

  @override
  Widget build(BuildContext context) {
    var x = GetStorage().read('cashedHistory') == null
        ? []
        : json.decode(GetStorage().read('cashedHistory'));
    List history = x;
    videoController.searchQuery = '';
    return Container(
      color: ThemeService().isDarkMode() ? blackColor : primaryColor,
      child: SafeArea(
        child: Scaffold(body: GetBuilder<VideoTrendingController>(builder: (_) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: ThemeService().isDarkMode()
                      ? const Color.fromARGB(255, 22, 22, 22)
                      : whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeService().isDarkMode()
                          ? const Color.fromARGB(255, 70, 70, 70)
                          : Colors.grey,
                      offset: const Offset(0, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: TextField(
                  cursorColor: primaryColor,
                  decoration: const InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) async {
                    // videoController.searchQuery = value;
                    // print(videoController.searchQuery);
                    // await videoController.getSearchVideoPageData(q: value);
                  },
                  /////
                  onSubmitted: (value) async {
                    await videoController.cachHistory(searchVal: value);
                    Get.offNamed(Routes.searchedVideoScreen);
                    videoController.getSearchVideoPageData(q: value);
                    print(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: history.length,

                  // videoController.searchVideo == null
                  //     ? 0
                  //     : videoController.searchVideo!.items!.length,
                  itemBuilder: (context, index) {
                    return history == [] ||
                            mainController.enableSearchHistory == false

                        // (videoController.searchVideo == null ||
                        //         videoController.searchQuery == '')
                        ? Container()
                        : InkWell(
                            onTap: () {
                              Get.offNamed(Routes.searchedVideoScreen);
                              videoController.getSearchVideoPageData(
                                  q: history[index].toString());
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              width: double.infinity,
                              height: 60,
                              color: ThemeService().isDarkMode()
                                  ? blackColor
                                  : whiteColor,
                              child: ListTile(
                                leading: Icon(
                                  Icons.replay_outlined,
                                  color: ThemeService().isDarkMode()
                                      ? whiteColor
                                      : blackColor,
                                ),
                                title: TextWidget(
                                  text: history[index].toString(),
                                  color: ThemeService().isDarkMode()
                                      ? whiteColor
                                      : blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.start,
                                  maxline: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          );
                    // SearchWidget(
                    //     onTap: () {
                    //       // Get.offNamed(Routes.videoDetailsScreen,
                    //       //     arguments: [
                    //       //       videoController
                    //       //           .searchVideo!.items![index].id!.videoId
                    //       //     ]);
                    //     },
                    //     img: videoController.searchVideo!.items![index]
                    //         .snippet!.thumbnails!.high.url
                    //         .toString(),
                    //     title: videoController
                    //         .searchVideo!.items![index].snippet!.title
                    //         .toString(),
                    //   );
                  },
                ),
              ),
            ],
          );
        })),
      ),
    );
  }
}
