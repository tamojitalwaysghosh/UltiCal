import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ultical/screens/conversion/tempconv.dart';
import 'package:ultical/screens/conversion/unitconversion.dart';
import 'package:ultical/screens/conversion/volconv.dart';
import 'package:ultical/screens/conversion/wecond.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  String _typeof = 'Unit Conversion';

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
      size: AdSize.banner,
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

  Widget button(String data) {
    return GestureDetector(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 2.4,
        decoration: BoxDecoration(
            color: const Color.fromARGB(96, 213, 212, 212),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 0.5, color: Colors.black26)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  (data == 'Unit Conversion')
                      ? 'Unit'
                      : (data == 'Volume Conversion')
                          ? 'Volume'
                          : (data == 'Weight Conversion')
                              ? 'Weight'
                              : 'Temperature',
                  //_convertedAmount.toString(),
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 21, 51, 103),
                        fontWeight: FontWeight.w500),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (_typeof == data)
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.7,
                          color: const Color.fromARGB(255, 21, 51, 103),
                        ),
                        borderRadius: BorderRadius.circular(40)),
                    child: const Icon(
                      Icons.circle,
                      color: Color.fromARGB(255, 21, 51, 103),
                    ))
              else
                const Icon(
                  Icons.circle_outlined,
                  color: Color.fromARGB(255, 21, 51, 103),
                )
            ],
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _typeof = data;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 245, 251),
      body: SafeArea(
          child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    _typeof,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 28, 19, 84),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      button('Unit Conversion'),
                      button('Weight Conversion')
                    ],
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      button('Volume Conversion'),
                      button('Temperature Conversion')
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 11,
              ),
              Padding(
                padding: const EdgeInsets.all(19.0),
                child: (_typeof == 'Unit Conversion')
                    ? const UnitConverterScreen()
                    : (_typeof == 'Weight Conversion')
                        ? const WeightConverterScreen()
                        : (_typeof == 'Volume Conversion')
                            ? const VolumeConvertScreen()
                            : (_typeof == 'Temperature Conversion')
                                ? const TemperatureConverterScreen()
                                : Container(),
              ),
              const SizedBox(
                height: 19,
              ),
              //----------- Show Ads like this -------
              if (_isBannerAdReady)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                ),
              const SizedBox(
                height: 63,
              )
            ],
          ),
        ],
      )),
    );
  }
}
