import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
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
                  '''\nHelp and Support:
\nIf you have any questions, feedback, or need assistance with UltiCal, please don't hesitate to contact us at "rhobustdev@gmail.com". \nWe are here to help and will do our best to respond promptly to your inquiries. Your suggestions and input are invaluable to us as we work towards providing you with the best user experience.

Thank you for choosing UltiCal by RhobustDev. We hope you find our app useful and enjoy using it in your daily life.''',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 20, 14, 56),
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
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
