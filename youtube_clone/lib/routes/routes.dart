import 'package:get/route_manager.dart';
import 'package:youtube_clone/view/screens/subscriptions_screens.dart/channel_screen.dart';
import 'package:youtube_clone/view/screens/video_details/video_details.dart';

import '../view/screens/mainscreen.dart/main_screen.dart';
import '../view/screens/search_screens/search_screen.dart';
import '../view/screens/search_screens/searched_video_screen.dart';
import '../view/screens/settings_screen.dart';
import '../view/screens/splash_screen.dart';
import '../view/screens/subscriptions_screens.dart/channel_videos_screen.dart';

class Routes {
  static const splashScreen = '/splashScreen';
  static const mainScreen = '/mainScreen';
  static const videoDetailsScreen = '/videoDetailsScreen';
  static const settingScreen = '/settingScreen';
  static const searchBarScreen = '/searchBarScreen';
  static const searchedVideoScreen = '/searchedVideoScreen';
  static const channelScreen = '/subscriptionScreen';
  static const channelVideosScreen = '/channelVideosScreen';
}

class AppRoutes {
  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),

    /// app route
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 800),
    ),

    /// app route
    GetPage(
      name: Routes.videoDetailsScreen,
      page: () => const VideoDetailsScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    ////////////////////
    GetPage(
      name: Routes.settingScreen,
      page: () => SettingScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    ////////////////////
    GetPage(
      name: Routes.searchBarScreen,
      page: () => const SearchBarScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    ////////////////////
    GetPage(
      name: Routes.searchedVideoScreen,
      page: () => SearchedVideoScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    ////////////////////
    GetPage(
      name: Routes.channelScreen,
      page: () => ChannelScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    ////////////////////
    GetPage(
      name: Routes.channelVideosScreen,
      page: () => ChannelVideosScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
