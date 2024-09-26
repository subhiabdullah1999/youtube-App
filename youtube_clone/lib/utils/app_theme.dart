import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

final primaryColor = HexColor('#D81A01');
final primaryColor2 = HexColor('#66C086');
const blackColor = Colors.black;
const whiteColor = Colors.white;
final greyColor = Colors.grey.shade600;
// final fillTextFormColor = HexColor("#C5C5C5");

class ThemeService {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(color: primaryColor),
    dividerColor: Colors.black12,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
  );
  ////////////////////
  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: blackColor,
    appBarTheme: const AppBarTheme(color: blackColor),
    dividerColor: Colors.white54,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
  );

  final themeStorage = GetStorage();

  final darkThemeKey = 'isDarkTheme';

  void saveThemeData(bool isDarkMode) async {
    await themeStorage.write(darkThemeKey, isDarkMode);
  }

  bool isDarkMode() {
    return themeStorage.read(darkThemeKey) ?? true;
  }

  ThemeMode getThemeMode() {
    return isDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }
}
