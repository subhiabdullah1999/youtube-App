import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:youtube_clone/utils/app_theme.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';
import 'package:youtube_clone/view/screens/explore_screens/explore_screen.dart';

import '../../model/channel_info_model.dart';
import '../../model/related_video_model.dart';
import '../../services/network/video_network.dart';
import '../../utils/google_ads.dart';
import '../../view/screens/trending_screen/trendingscreen.dart';
import '../../view/screens/shorts_screen/shortscreen.dart';

class MainScreenController extends GetxController {
  int i = 0;

  List<ChannelinfoModel> subscribedList = [];
  bool isSubscribed = false;
  GetStorage subscribedStorage = GetStorage();

//////////////////////////
  @override
  void onInit() async {
    super.onInit();
    debugPrint('main////////////////');

    //////////////////// for favourite
    final storedSubscribion = GetStorage().read<String>('subscribe');
    // String? storedShopping = GetStorage.read<String>('favorite');
    if (storedSubscribion != null) {
      debugPrint('list not null');
      List decodeJsonData = json.decode(storedSubscribion);
      subscribedList =
          decodeJsonData.map((e) => ChannelinfoModel.fromJson(e)).toList();
    } else {
      debugPrint('list  null');
    }
    ////////////////////////

    await createInterstitialAd();
    await createRewardedAd();
  }

  @override
  void onClose() {
    print('closed ');

    super.onClose();
    interstitialAd?.dispose();
    rewardedAd?.dispose();

    youtubController!.dispose();
  }

  void changeIndex(int index) {
    i = index;
    update();
  }

  /////////////////////////////////////////////

  List<Widget> screens = [
    TrendingScreen(),
    ExploreScreen(),
    const ShortScreen(),
  ];

  /////////////theme///////////
  void changeTheme() {
    ///////////////////
    Get.changeThemeMode(
        ThemeService().isDarkMode() ? ThemeMode.light : ThemeMode.dark);

    ThemeService().saveThemeData(!ThemeService().isDarkMode());

    update();
  }

  bool enableSearchHistory = true;
  ///////////////////////////////////////////////////
  void changeEnableSearchHistorey() {
    enableSearchHistory = !enableSearchHistory;
    update();
  }

////////mini player ////////////////////////////////
  bool isMiniPlayerShown = false;

  bool isIconPlayingVideo = true;

  void showOrHideMiniPlayer(bool val) {
    isMiniPlayerShown = val;
    update();
  }

  bool noInternetConnection = false;
  bool isCircleProgressShown = false;
  // int x = 0;
  ///////////////////////////////////

  ///////////////////////////////////////////////////
  void showNoInternetPage() {
    noInternetConnection = true;
    update();
  }

  void hideNoInternetPage() {
    noInternetConnection = false;
    update();
  }

  /////////////////////////////////////////////////////
  void showCircleProgressIndicator() {
    isCircleProgressShown = true;
    update();
  }

  void hideCircleProgressIndicator() {
    isCircleProgressShown = false;
    update();
  }

////////////////////////////////////////////////////
  ///////////////////
  late ChannelinfoModel channelInfoData;

  Future<void> getChannelInfoPageData({required String channelId}) async {
    showCircleProgressIndicator();
    var result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        await VideoApi.getChannelInfo(channelId: channelId).then((value) {
          channelInfoData = value;
          print(channelInfoData.kind);
        });

        hideCircleProgressIndicator();
        update();
      } catch (e) {
        // x = x + 1;
        hideCircleProgressIndicator();
        Get.snackbar('Get channel data failed', '',
            backgroundColor: const Color.fromARGB(255, 158, 15, 5),
            colorText: whiteColor,
            snackStyle: SnackStyle.GROUNDED,
            duration: const Duration(seconds: 3));
        print(e);
        update();
      }
    } else {
      debugPrint('no connection');
      hideCircleProgressIndicator();
      Get.snackbar('Get channel data failed', '',
          backgroundColor: const Color.fromARGB(255, 158, 15, 5),
          colorText: whiteColor,
          snackStyle: SnackStyle.GROUNDED,
          duration: const Duration(seconds: 3));
      update();
    }
  }

  ///////////////////
  late RelatedVideoModel videoInChannelData;

  Future<void> getVideoInChannePageData({required String channelId}) async {
    showCircleProgressIndicator();
    var result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        await VideoApi.getVideosInChannel(channelId: channelId).then((value) {
          videoInChannelData = value;
          print(videoInChannelData.kind);
        });

        hideCircleProgressIndicator();
        hideNoInternetPage();
        update();
      } catch (e) {
        // x = x + 1;
        hideCircleProgressIndicator();
        showNoInternetPage();
        print(e);
        update();
      }
    } else {
      debugPrint('no connection');
      showNoInternetPage();
      hideCircleProgressIndicator();
      update();
    }
  }

  /////////////////////////////////////////
  void manageSubscribe(
      {required String channelId,
      required ChannelinfoModel channelList}) async {
    var existingIndex = subscribedList
        .indexWhere((element) => element.items[0].id == channelId);
    //when the the product is not in the list it returns -1
    if (existingIndex >= 0) {
      subscribedList.removeAt(existingIndex);
      // encode for getStorage
      var subToJson = subscribedList.map((e) => e.toJson()).toList();
      String encodedSub = json.encode(subToJson);
      print(encodedSub);
      ///////////////////
      await subscribedStorage
          .write('subscribe', encodedSub)
          .then((value) => debugPrint('write'));
    } else {
      subscribedList.add(channelList);
      // encode for getStorage
      var subToJson = subscribedList.map((e) => e.toJson()).toList();
      String encodedFav = json.encode(subToJson);
      print(encodedFav);
      ////////////
      await subscribedStorage.write('subscribe', encodedFav).then((value) {
        debugPrint('write');
      });
    }
    update();
  }

  void removeChannel({required String channelId}) async {
    var index = subscribedList
        .indexWhere((element) => element.items[0].id == channelId);
    subscribedList.removeAt(index);
    // encode for getStorage
    var subToJson = subscribedList.map((e) => e.toJson()).toList();
    String encodedFav = json.encode(subToJson);
    ////////////
    await subscribedStorage.write('subscribe', encodedFav);
    update();
  }

  bool ifSubscribed({required String channelId}) {
    return subscribedList.any((element) => element.items[0].id == channelId);
  }
}
