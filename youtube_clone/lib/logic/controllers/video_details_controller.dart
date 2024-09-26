import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';

import '../../model/related_video_model.dart';
import '../../services/network/video_network.dart';

class VideoDetailsController extends GetxController {
  ////////////////////////////////
  //////////////////////////////
  int videoStartAt = 0;
  bool isMuted = false;
  bool noInternetConnection = false;
  bool isCircleProgressShown = false;
  bool isDescOpen = false;
  // int x = 0;

  ///////////////////////////////////////////////////
  Future<void> changeStartAt(int val) async {
    videoStartAt = val;
    update();
  }

  ///////////////////////////////////////////////
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

  ///////////////////////////////////
  void muteSound() {
    isMuted = !isMuted;
    isMuted == true ? youtubController!.mute() : youtubController!.unMute();

    update();
  }

  ////////////////////
  void openAndCloseDesc() {
    isDescOpen = !isDescOpen;
    update();
  }

//////////////////////////
  void playVideo() {
    youtubController!.play();

    update();
  }

  //////////////////////////
  void pauseVideo() {
    youtubController!.pause();

    update();
  }

  void reloadWithNewVideo(String value) {
    youtubController!.changeVideo(
      playerConfig: const PodPlayerConfig(
        autoPlay: true,
        isLooping: false,
        videoQualityPriority: [1080, 720, 360, 144],
      ),
      playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/$value'),
    );

    update();
  }

  void changeVideoId(String videoid) {
    videoDetailSid = videoid;
    update();
  }

  ////////
  void changeVideoTitle(String title) {
    videoDetailSTitle = title;
    update();
  }

  /////////////////////////////////////////////////////
////////
  void changeVideoDesc(String desc) {
    videoDetailSDesc = desc;
    update();
  }

/////////////////////////////////////////////////////

/////////////////////////////////////////////////////
  ///
  ///

  @override
  void onInit() async {
    super.onInit();
///////////////////////////////////

    ///////////////
    await getrelatedVideoPageData(
      videoId: videoDetailSid,
    );
  }

  ///
  late RelatedVideoModel relatedVideoData;

  Future<void> getrelatedVideoPageData({required String videoId}) async {
    showCircleProgressIndicator();
    var result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        await VideoApi.getRelatedVideo(videoId: videoId).then((value) {
          relatedVideoData = value;
          print(relatedVideoData.kind);
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
