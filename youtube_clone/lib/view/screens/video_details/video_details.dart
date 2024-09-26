import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/logic/controllers/mainscreen_controller.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';
import 'package:youtube_clone/view/screens/video_details/pipmode_disabled.dart';
import 'package:youtube_clone/view/screens/video_details/pipmode_enabled.dart';
import '../../../logic/controllers/video_details_controller.dart';
import '../../../utils/app_theme.dart';

class VideoDetailsScreen extends StatefulWidget {
  const VideoDetailsScreen({super.key});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen>
    with WidgetsBindingObserver {
  final videoController = Get.put(VideoDetailsController());
  final mainController = Get.find<MainScreenController>();
  //////////////////////
  final floating = Floating();
//////////////////////////
///////////////////////\
  Future<void> enablePip() async {
    final status = await floating.enable(const Rational.landscape());
    debugPrint('PiP enabled? $status');
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);

        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }
  /////////////////////////////////////////////////

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
    floating.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ThemeService().isDarkMode() ? blackColor : primaryColor,
        child: SafeArea(
            child: WillPopScope(
          onWillPop: () async {
            mainController.showOrHideMiniPlayer(true);
            ////////////////////////////////////////////////
            !(youtubController!.isVideoPlaying)
                ? youtubController!.pause()
                : null;
            ////////////////////////////////////////////////

            return true;
          },
          child: Scaffold(
              body: PiPSwitcher(
                  floating: floating,
                  childWhenEnabled: VideoPipModeEnabled(),
                  childWhenDisabled: VideoPipModeDisabled(
                    enablePopup: enablePip,
                  ))),
        )));
  }
}
