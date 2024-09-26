import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:youtube_clone/model/trending_video_model.dart';
import 'package:youtube_clone/services/network/video_network.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';
import '../../model/related_video_model.dart';

class VideoTrendingController extends GetxController {
  bool noInternetConnection = false;
  bool isCircleProgressShown = false;
  ///////////////////////////////////
  bool noSearchInternetConnection = false;
  bool isSearchCircleProgressShown = false;
  ////////////////////////
  // int x = 0;
  String searchQuery = '';
  ////////////////////////////
  late List searchList;
  var searchStorage = GetStorage();

  //////////////////////////////////////////
  ///////////////////////////////
  bool addLoaded = false;
  late BannerAd myBanner;
////////////////////
  final AdManagerBannerAdListener listener = AdManagerBannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );
////////////////

  ///////////////////////////////////////////////
  Future<void> cachHistory({required String searchVal}) async {
    searchList = searchStorage.read('cashedHistory') == null
        ? []
        : json.decode(searchStorage.read('cashedHistory'));
    searchList.add(searchVal);
    var cashedList = json.encode(searchList);
    await searchStorage.write('cashedHistory', cashedList);
  }

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

/////////////////////////////////////////////////////
  ///
  ///////////////////////////////
  ///////////////////////////////////////////////////
  void showSearchNoInternetPage() {
    noSearchInternetConnection = true;
    update();
  }

  void hideSearchNoInternetPage() {
    noSearchInternetConnection = false;
    update();
  }

  /////////////////////////////////////////////////////
  void showSearchCircleProgressIndicator() {
    isSearchCircleProgressShown = true;
    update();
  }

  void hideSearchCircleProgressIndicator() {
    isSearchCircleProgressShown = false;
    update();
  }

  /////////////////////////////////////////////////////
////////
  void changeVideoTitle(String title) {
    videoDetailSTitle = title;
    update();
  }

/////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
////////
  void changeVideoDesc(String desc) {
    videoDetailSDesc = desc;
    update();
  }

/////////////////////////////////////////////////////
  ///////////////////////////////
  @override
  void onInit() async {
    super.onInit();
    await getTrendingVideoPageData();

    ///////////////////////////////////////////////
    myBanner = BannerAd(
      adUnitId: '',
      // 'ca-app-pub-4605716348832015/5350198288',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          addLoaded = true;
          update();
        },
        onAdFailedToLoad: (ad, error) {
          addLoaded = false;
          update();
        },
      ),
    );
    ////////////////////////////////////
    await myBanner.load();

    if (searchStorage.read('cashedHistory') != null) {
      searchList = json.decode(searchStorage.read('cashedHistory'));
    } else {
      searchList = [];
    }
  }

  ///////////////////
  late TrendingVideoModel trendingVideoData;

  Future<void> getTrendingVideoPageData() async {
    showCircleProgressIndicator();
    var result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        await VideoApi.getTrendingVideo().then((value) {
          trendingVideoData = value;
          print(trendingVideoData.kind);
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
      print('no connection');
      showNoInternetPage();
      hideCircleProgressIndicator();
      update();
    }
  }

  ////////////search ///////
  RelatedVideoModel? searchVideo;

  Future<void> getSearchVideoPageData({required String q}) async {
    showSearchCircleProgressIndicator();
    var result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        ///////////
        await VideoApi.getSearchVideo(q: q).then((value) {
          searchVideo = value;
          print(trendingVideoData.kind);
        });
        //////////////

        /////////
        hideSearchCircleProgressIndicator();
        hideSearchNoInternetPage();
        update();
      } catch (e) {
        // x = x + 1;
        hideSearchCircleProgressIndicator();
        showSearchNoInternetPage();
        print(e);
        update();
      }
    } else {
      print('no connection');
      showSearchNoInternetPage();
      hideSearchCircleProgressIndicator();
      update();
    }
  }
}
