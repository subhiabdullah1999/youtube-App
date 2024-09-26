import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/mainscreen_controller.dart';
import 'nav_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final mainController = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return NavBar();
  }
}
