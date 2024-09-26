import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/logic/controllers/mainscreen_controller.dart';
import 'package:youtube_clone/utils/app_theme.dart';
import 'package:youtube_clone/view/widgets/text_widget.dart';

import '../../utils/variables_and_func.dart';

class MiniPlayer extends StatefulWidget {
  final String img, title;
  final MainScreenController mainController;

  const MiniPlayer({
    super.key,
    required this.img,
    required this.title,
    required this.mainController,
  });

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      color: ThemeService().isDarkMode()
          ? const Color.fromARGB(255, 43, 43, 43)
          : const Color.fromARGB(255, 236, 236, 236),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: FancyShimmerImage(
                // width: double.infinity,
                // height: 190,
                imageUrl: widget.img,
                // ,
                boxFit: BoxFit.cover,
                shimmerBaseColor: ThemeService().isDarkMode()
                    ? Colors.black.withOpacity(0.5)
                    : whiteColor,
                shimmerHighlightColor: primaryColor,
                shimmerBackColor: greyColor,
              ),
            ),
            ///////////////////
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: TextWidget(
                    text: widget.title,
                    // ,
                    color:
                        ThemeService().isDarkMode() ? whiteColor : blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    maxline: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            ////////////////////
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        youtubController!.isVideoPlaying
                            ? youtubController!.pause()
                            : youtubController!.play();
                      });
                      ///////////////////////////
                    },
                    icon: youtubController!.isVideoPlaying
                        ? Icon(
                            Icons.pause,
                            color: ThemeService().isDarkMode()
                                ? whiteColor
                                : blackColor,
                          )
                        : Icon(
                            Icons.play_arrow,
                            color: ThemeService().isDarkMode()
                                ? whiteColor
                                : blackColor,
                          ),
                  ),
                  //////////////////
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          widget.mainController.showOrHideMiniPlayer(false);
                          youtubController!.dispose();
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: ThemeService().isDarkMode()
                              ? whiteColor
                              : blackColor,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
