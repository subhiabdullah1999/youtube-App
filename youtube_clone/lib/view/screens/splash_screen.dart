import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:youtube_clone/routes/routes.dart';
import 'package:youtube_clone/utils/app_theme.dart';
import 'package:youtube_clone/utils/variables_and_func.dart';

import '../widgets/text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () => goToHomeScreen());
  }

  goToHomeScreen() {
    Get.offNamed(Routes.mainScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ///////////////
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, 1.5),
                colors: [
                  HexColor('#D81A01'),
                  greyColor,
                ],
              ),
            ),
          ),
          ///////////////
          Positioned(
            top: getHeightInPercent(context, 30),
            child: Column(
              children: [
                Container(
                  width: getWidthInPercent(context, 45),
                  height: getWidthInPercent(context, 45),
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/icon.png')),
                      ),
                    ),
                  ),
                ),
                ///////////
                SizedBox(
                  height: getHeightInPercent(context, 5),
                ),

                ///
                TextWidget(
                  text: 'AndroTube',
                  color: whiteColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
