import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String baseUrl = 'https://www.googleapis.com/youtube/v3';

const youtubeApiKey1 = 'AIzaSyCxMU8BQfm1s57TbsVYO3BQuVDUDAS6F9U';
const youtubeApiKey2 = 'AIzaSyAJAJhmbpXuXushSSfvupCusqjx_QNtgcs';
const youtubeApiKey3 = 'AIzaSyB5G704w5yd6aPlHY0FS4A0TRvIaTZZ6vE';
const youtubeApiKey4 = 'AIzaSyBkJIFV7uJ0eZe2PHvKfSmNnr-upGnHkyw';
const youtubeApiKey5 = 'AIzaSyCxufBVaXYaDLnDPKki6f0xu3kHeWGfhQI';
const youtubeApiKey6 = 'AIzaSyAst1ufcPH4tH7BgzYDwRa5ecpjvnFWIC0';
const youtubeApiKey7 = 'AIzaSyABhMZekcrvV2Lh1yqntJPWJhiLcgWRigY';
const youtubeApiKey8 = 'AIzaSyBKqaNNC9yqtGmUodjij6LjSKjnlxsNQUw';
const youtubeApiKey9 = 'AIzaSyB-wKmGOZwrbdAsI-FXyK3pAUicPctiqf4';
const youtubeApiKey10 = 'AIzaSyBZ-M9ziWPOkn3p3dHMtxHNFyIa_BjN58Q';
const youtubeApiKey11 = 'AIzaSyDUH3dc_LhwNou80H9hCOYMg81AaE1bM7o';
const youtubeApiKey12 = 'AIzaSyBbVICN-UNv3S58Dltnm7xWe6i_-tp5O6w';
const youtubeApiKey13 = 'AIzaSyCIp6AnUoSzfGY4kvdcrCeJ9pLFJcHbrxM';
const youtubeApiKey14 = 'AIzaSyCVNagrT953pK2Ihzo2rXLZiiAqHa6MfF0';
const youtubeApiKey15 = 'AIzaSyCOqVlDQf9Ngfo68xFWl0fBFGepohF_3L0';
const youtubeApiKey16 = 'AIzaSyB0e7Waig6yLkcnr8dURl-Dkj-GtHQ6SdU';
const youtubeApiKey17 = 'AIzaSyCYsJsKdFWewyR-kFJAv_13U5ociigiaF4';
//////////////////////////////////////////////////////////////////////
List<String> keys = [
  youtubeApiKey1,
  youtubeApiKey2,
  youtubeApiKey3,
  youtubeApiKey4,
  youtubeApiKey5,
  youtubeApiKey6,
  youtubeApiKey8,
  youtubeApiKey9,
  youtubeApiKey10,
  youtubeApiKey11,
  youtubeApiKey12,
  youtubeApiKey13,
  youtubeApiKey14,
  youtubeApiKey15,
  youtubeApiKey16,
  youtubeApiKey17,
];
//////////////////////////////////////////////////
double getHeightInPercent(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.height) * (percent / 100);
}

////////////////////////////////////////////////////////////////
double getWidthInPercent(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.width) * (percent / 100);
}

////////////////////////////////////////////////////////////////
double getSp(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.width) * (percent / 300);
}

/////////////////////////////////////////////////////////////////
String getViewNum(int viewNum) {
  int num;
  if (viewNum >= 1000 && viewNum < 1000000) {
    num = (viewNum / 1000).round();
    return '${num.toString()}K Views';
  } else if (viewNum >= 1000000) {
    num = (viewNum / 1000000).round();
    return '${num.toString()}M Views';
  } else {
    return '${viewNum.toString()} Views';
  }
}

///////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
String getSubscNum(int subNum) {
  int num;
  if (subNum >= 1000 && subNum < 1000000) {
    num = (subNum / 1000).round();
    return '${num.toString()}K Subscribers';
  } else if (subNum >= 1000000) {
    num = (subNum / 1000000).round();
    return '${num.toString()}M Subscribers';
  } else {
    return '${subNum.toString()} Subscribers';
  }
}
///////////////////////////////////////////////////////////////

WebViewController? webController;

PodPlayerController? youtubController;

String miniPlayerImg = '';
String miniPlayerTitle = '';

String videoDetailSTitle = '';

String videoDetailSDesc = '';

String videoDetailSid = '';

String channelDetailSid = '';
