import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-4144363381355439/5904568063",
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          setState(() {
            _isBannerAdReady = false;
          });
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 245, 251),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  '''About the App:
              \nWelcome to UltiCal, your all-in-one calculator and converter app designed to simplify your daily calculations and conversions. With UltiCal, you have a powerful tool at your fingertips that combines a feature-rich calculator, currency converter, and unit converter into a single, convenient application.
              
              \n🔵 Calculator:
              \nPerform both basic and scientific calculations effortlessly with our intuitive calculator interface. Whether you need to add, subtract, multiply, divide, or tackle more complex mathematical operations, UltiCal has got you covered. Enjoy a seamless and efficient calculation experience that adapts to your needs.
              
              \n🔵 Currency Converter:
              \nTraveling or dealing with international transactions? UltiCal's currency converter is here to help. Stay up-to-date with the latest exchange rates and effortlessly convert between different currencies. Our app utilizes a free API to provide accurate and reliable currency conversion, ensuring you have the information you need at your fingertips.
              
              \n🔵 The Converter:
              \nNeed to convert units? UltiCal's unit converter is your go-to tool. Whether it's weight, temperature, volume, or other common measurement units, our converter streamlines the process for you. Simply input the value and unit, and UltiCal will quickly provide the converted result. Say goodbye to manual calculations and let our app handle the conversions for you.
              
              \nWe at RhobustDev are committed to delivering a user-friendly experience with UltiCal. Our app is designed to be reliable, efficient, and easy to use, ensuring that your calculations and conversions are hassle-free. We value your feedback and continuously strive to improve and enhance the app to meet your needs.''',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 20, 14, 56),
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              const SizedBox(
                height: 110,
              ),
            ],
          ),
          (_isBannerAdReady)
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
