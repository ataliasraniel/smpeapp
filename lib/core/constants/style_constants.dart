///This file should contain all the constants style used in the app
///like texts, fonts, colors, etc.
///you should use the standard naming convention for constants like the following:

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//**FONT CONFIGURATION*/
final kDefaultFontFamily = GoogleFonts.poppins(
  fontSize: 16,
).fontFamily;
final kSecondaryFontFamily = GoogleFonts.nunito().fontFamily;
final kDescriptionFontFamily = GoogleFonts.firaSans().fontFamily;
//**LIGHT COLORS */
// const Color kPrimaryColor = Color(0xFF132567);
const Color kPrimaryColor = Color(0xFF0E1532);
const Color kBackgroundColor = Colors.white;
const Color kBackgroundModal = Color.fromRGBO(248, 248, 255, 0.75);
// const Color kBackgroundColor = Color.fromARGB(255, 225, 225, 225);
const Color kSecondaryColor = Color(0xFFfeca57);
const Color kDetailColor = Color(0xFFf0932b);
const Color kOnBackgroundColor = Colors.white;
const Color kTextColor = Color.fromARGB(255, 95, 105, 113);
const Color kOnSurfaceColor = Colors.white;
const Color kTextButtonColor = Color(0xFF5f27cd);
const Color kGreyColor = Color.fromARGB(255, 236, 236, 236);
const Color kRedColor = Colors.red;
//**LIGHT COLORS */

//**DARK COLORS */
const Color kPrimaryDarkColor = Color(0xFF303841);
const Color kSecondaryDarkColor = Color(0xFF3A4750);
const Color kDarkTextColor = Colors.white;
//**DARK COLORS */

//*GENERAL COLORS*//
const Color kSuccessColor = Colors.lightGreen;
const Color kErrorColor = Colors.redAccent;
const Color kAlertColor = Colors.orangeAccent;
//*GENERAL COLORS*//

//**TEXT STYLES */
const TextStyle kTitle1 = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w900,
);
const TextStyle kTitle2 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w900,
);
const TextStyle kBody1 = TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: kTextColor);
const TextStyle kBody2 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w900,
);
const TextStyle kBody3 = TextStyle(
  fontSize: 16,
);
const TextStyle kCaption1 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w900,
);
const TextStyle kCaption2 = TextStyle(
  fontSize: 14,
);
const TextStyle kCaption3 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  color: kGreyColor,
);
