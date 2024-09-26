import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_clone/utils/app_theme.dart';
import 'package:youtube_clone/view/widgets/text_widget.dart';

import '../../logic/controllers/mainscreen_controller.dart';
import '../../utils/variables_and_func.dart';

class VideoWidget extends StatelessWidget {
  final String img;
  final String title;
  final String channelTitle;
  final String viewCount;
  final String publishTime;
  const VideoWidget(
      {super.key,
      required this.img,
      required this.title,
      required this.channelTitle,
      required this.viewCount,
      required this.publishTime});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(builder: (_) {
      return Container(
        width: double.infinity,
        // height: 250,
        color: ThemeService().isDarkMode()
            ? Colors.black.withOpacity(0.8)
            : whiteColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FancyShimmerImage(
                width: double.infinity,
                height: 190,
                imageUrl: img,
                boxFit: BoxFit.cover,
                shimmerBaseColor: ThemeService().isDarkMode()
                    ? Colors.black.withOpacity(0.5)
                    : whiteColor,
                shimmerHighlightColor: primaryColor,
                shimmerBackColor: greyColor,
              ),
              ////////////
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextWidget(
                  text: title,
                  color: ThemeService().isDarkMode() ? whiteColor : blackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                  maxline: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              ////////////
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                  maxLines: 4,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: channelTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: ThemeService().isDarkMode()
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5),
                        fontSize: 12,
                        fontFamily: 'EuclidCircularARegular'),
                    children: [
                      const TextSpan(
                        text: ' . ',
                      ),
                      TextSpan(
                        text: viewCount == ''
                            ? ''
                            : getViewNum(int.parse(viewCount)),
                      ),
                      const TextSpan(text: ' . '),
                      TextSpan(
                        text: DateFormat.yMMMd()
                            .format(DateTime.parse(publishTime)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
