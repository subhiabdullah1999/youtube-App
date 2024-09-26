import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

import '../../../logic/controllers/video_details_controller.dart';
import '../../../utils/variables_and_func.dart';

class VideoPipModeEnabled extends StatelessWidget {
  VideoPipModeEnabled({super.key});

  final videoController = Get.put(VideoDetailsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoDetailsController>(
      builder: (_) {
        return PodVideoPlayer(
          controller: youtubController!,
        );
      },
    );
  }
}
