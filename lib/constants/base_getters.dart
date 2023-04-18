import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appConfig.dart';

class AppServices {
  /* Height and Width Factors */

  // get width of the screen
  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // get height of the screen
  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // used to add space between two vertical objects
  static addHeight(double space) => SizedBox(height: space);

  // used to add space between two horizontal objects
  static addWidth(double space) => SizedBox(width: space);

// to check the screen is android or web
  static bool isSmallScreen(BuildContext context) =>
      getScreenWidth(context) <= 360;

// rupees currency symbol
  static String getCurrencySymbol = "\u{20B9}";

  /* Navigation and routing */
  static pushTo(Widget screen) =>
      Get.to(screen, transition: Transition.leftToRightWithFade);

  static pushAndReplace(Widget screen, BuildContext context) =>
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  // navigate to next screen and remove all the screens behind
  static pushAndRemove(Widget screen) => Get.offAll(() => screen);

  // navigation and routing with fade transition
  static fadeTransitionNavigation(BuildContext context, Widget screen) =>
      Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => screen,
              transitionDuration: const Duration(milliseconds: 1100),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child)),
          (route) => false);

  // navigate to the previous screen or previous state
  static popView() => Get.back();

  // function to unfocus the keyboard on tap on screen
  static keyboardUnfocus(BuildContext context) =>
      FocusScope.of(context).unfocus();

  /* UI Scale Factor */
  static double scaleFactor(BuildContext context) {
    if (getScreenWidth(context) > AppConfig.screenWidth) {
      return AppConfig.screenWidth / getScreenWidth(context);
    } else {
      return getScreenWidth(context) / AppConfig.screenWidth;
    }
  }

  static bool isDarkMode(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark;
  }

  static TextTheme textTheme(BuildContext context) =>
      Theme.of(context).textTheme;
  static ThemeData theme(BuildContext context) => Theme.of(context);
}
