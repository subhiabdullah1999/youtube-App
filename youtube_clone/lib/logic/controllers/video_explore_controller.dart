import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';

import '../../model/trending_video_model.dart';
import '../../services/network/video_network.dart';

class VideoExploreController extends GetxController {
  int currentPage = 0;
  bool noInternetConnection = false;
  bool isCircleProgressShown = false;
  // int x = 0;

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

//////////////////////////
  void changeVideoTitle(String title) {
    videoDetailSTitle = title;
    update();
  }

//////////////////////////////
  /////////////////////////////////////////////////////
////////
  void changeVideoDesc(String desc) {
    videoDetailSDesc = desc;
    update();
  }

/////////////////////////////////////////////////////

  void changePage(int val) {
    currentPage = val;
    update();
  }

  ///
  late TrendingVideoModel musicVideoData;

  Future<void> getMusicVideoPageData() async {
    showCircleProgressIndicator();
    var result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        await VideoApi.getMusicVideo().then((value) {
          musicVideoData = value;
          print(musicVideoData.kind);
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

  //////////////
  ///
  late TrendingVideoModel sportVideoData;

  Future<void> getsportVideoDataPageData() async {
    showCircleProgressIndicator();
    var result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        await VideoApi.getSportVideo().then((value) {
          sportVideoData = value;
          print(sportVideoData.kind);
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

  ////////////////////
  ///
  late TrendingVideoModel newsVideoData;

  Future<void> getNewsVideoDataPageData() async {
    showCircleProgressIndicator();
    var result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        await VideoApi.getNewsVideo().then((value) {
          newsVideoData = value;
          print(newsVideoData.kind);
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
}
