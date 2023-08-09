import 'package:ultical/screens/about_us.dart';
import 'package:ultical/screens/calculator/calculator.dart';
import 'package:ultical/screens/conversion/conversion.dart';
import 'package:ultical/screens/currency/currencyconverter.dart';
import 'package:ultical/screens/help_support.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class DS extends StatefulWidget {
  const DS({super.key});

  @override
  State<DS> createState() => _DSState();
}

class _DSState extends State<DS> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            colorLineSelected: const Color.fromARGB(255, 18, 42, 83),
            name: "Calculator",
            baseStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 28, 19, 84),
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
            selectedStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 18, 42, 83),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const CalculatorApp()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            colorLineSelected: const Color.fromARGB(255, 18, 42, 83),
            name: "Currency Converter",
            baseStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 28, 19, 84),
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
            selectedStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 18, 42, 83),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const CurrencyConverter()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            colorLineSelected: const Color.fromARGB(255, 18, 42, 83),
            name: "The Converter",
            baseStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 28, 19, 84),
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
            selectedStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 18, 42, 83),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const ConversionScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            colorLineSelected: const Color.fromARGB(255, 18, 42, 83),
            name: "About the App",
            baseStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 28, 19, 84),
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
            selectedStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 18, 42, 83),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const AboutUs()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            colorLineSelected: const Color.fromARGB(255, 18, 42, 83),
            name: "Help & Support",
            baseStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 28, 19, 84),
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
            selectedStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 18, 42, 83),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const HelpAndSupport()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: const Color.fromARGB(255, 242, 245, 251),
      screens: _pages,
      initPositionSelected: 0,
      elevationAppBar: 0,
      slidePercent: 60,
      withAutoTittleName: true,
      contentCornerRadius: 23,
      backgroundColorAppBar: const Color.fromARGB(255, 242, 245, 251),
      tittleAppBar: Text(
        "UltiCal",
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
              color: Color.fromARGB(255, 28, 19, 84),
              fontSize: 19,
              fontWeight: FontWeight.w300),
        ),
      ),
      isTitleCentered: true,
      leadingAppBar: const Icon(Icons.menu),
    );
  }
}
