import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_clone/routes/routes.dart';

import '../../logic/controllers/mainscreen_controller.dart';
import '../../utils/app_theme.dart';
import '../widgets/text_widget.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final mainController = Get.find<MainScreenController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: TextWidget(
            text: 'Settings',
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
        body:
            // Container(),
            SettingsList(
          lightTheme: SettingsThemeData(
            settingsListBackground: ThemeService().isDarkMode()
                ? const Color.fromARGB(255, 32, 32, 32)
                : whiteColor,
          ),
          sections: [
            SettingsSection(
              title: TextWidget(
                text: 'App Settings',
                color: primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
              ),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  onToggle: (value) {
                    mainController.changeTheme();
                    print(ThemeService().isDarkMode());
                  },
                  initialValue: ThemeService().isDarkMode(),
                  activeSwitchColor: primaryColor,
                  leading: Icon(
                    Icons.dark_mode,
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                  ),
                  title: TextWidget(
                    text: 'Enable Dark Mode',
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.start,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //////////////////////////////
                // SettingsTile.switchTile(
                //   onToggle: (value) {},
                //   initialValue: false,
                //   activeSwitchColor: primaryColor,
                //   leading: Icon(
                //     Icons.manage_search,
                //     color:
                //         ThemeService().isDarkMode() ? whiteColor : blackColor,
                //   ),
                //   title: TextWidget(
                //     text: 'Search suggestions',
                //     color:
                //         ThemeService().isDarkMode() ? whiteColor : blackColor,
                //     fontSize: 15,
                //     fontWeight: FontWeight.normal,
                //     textAlign: TextAlign.start,
                //     maxline: 1,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                //   description: TextWidget(
                //     text: 'Show suggestions when searching',
                //     color:
                //         ThemeService().isDarkMode() ? whiteColor : blackColor,
                //     fontSize: 12,
                //     fontWeight: FontWeight.normal,
                //     textAlign: TextAlign.start,
                //     maxline: 1,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // ),
                //////////////////////////////
                SettingsTile.switchTile(
                  onToggle: (value) {
                    mainController.changeEnableSearchHistorey();
                  },
                  initialValue: mainController.enableSearchHistory,
                  activeSwitchColor: primaryColor,
                  leading: Icon(
                    Icons.youtube_searched_for,
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                  ),
                  title: TextWidget(
                    text: 'Search history',
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.start,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  description: TextWidget(
                    text: 'Enable Search history',
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.start,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //////////////////////////////
                SettingsTile.navigation(
                  leading: Icon(
                    Icons.search_off,
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                  ),
                  title: TextWidget(
                    text: 'Clear search history',
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.start,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  description: TextWidget(
                    text: 'Clear all search history from device',
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.start,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onPressed: (context) {
                    Get.defaultDialog(
                        title: "Are you sure to clear cashed history ?",
                        middleText: '',
                        backgroundColor:
                            const Color.fromARGB(255, 150, 150, 150),
                        titleStyle:
                            const TextStyle(color: Colors.white, fontSize: 15),
                        // onConfirm: () {
                        //   print('kk');
                        // },
                        confirm: InkWell(
                          onTap: () async {
                            await GetStorage().remove('cashedHistory');
                            Get.offAllNamed(Routes.mainScreen);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Center(
                                  child: Text(
                                'Confirm',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ),
                        // onCancel: () {
                        //   Get.close(0);
                        // },
                        radius: 15);
                    print('cleared');
                  },
                ),
              ],
            ),
            ///////////222222222/////////////////////////////////////////////////////////////////
            SettingsSection(
              title: TextWidget(
                text: 'About',
                color: primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (context) async {
                    openAppReview();
                  },
                  leading: Icon(
                    Icons.star_rate,
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                  ),
                  title: TextWidget(
                    text: 'Rate App',
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.start,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //////////////////////////
                SettingsTile.navigation(
                  onPressed: (context) async {
                    String appUrl =
                        'https://play.google.com/store/apps/details?id=com.view.androtube';
                    await Share.share(appUrl);
                  },
                  leading: Icon(
                    Icons.share,
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                  ),
                  title: TextWidget(
                    text: 'Share App',
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.start,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //////////////////////////
                SettingsTile.navigation(
                  leading: Icon(
                    Icons.error_outline,
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                  ),
                  title: TextWidget(
                    text: 'Version',
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.start,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  description: TextWidget(
                    text: '1.0.7',
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.start,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ///////////////////////////////
              ],
            ),
          ],
        ),
      );
    });
  }

  ///////////////////
  void openAppReview() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      // await inAppReview.requestReview();

      await inAppReview.openStoreListing(
        appStoreId: '...',
        microsoftStoreId: '...',
      );
    }
  }
}
