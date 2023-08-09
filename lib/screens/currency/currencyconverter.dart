import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  late TextEditingController _amountController;
  String _selectedBaseCurrency = 'USD';
  String _selectedTargetCurrency = 'EUR';
  double _convertedAmount = 0.0;
  bool _isLoading = false;
  String countryNmae = 'USD';
  final Map<String, String> _currencies = {
    'USD': 'United States Dollar',
    'EUR': 'Euro',
    'JPY': 'Japanese Yen',
    'INR': 'Indian Rupee',
    'RUB': 'Russian Ruble',
    'SEK': 'Swedish Krona',
    'ZAR': 'South African Rand',
    'CAD': 'Canadian Dollar',
    'GBP': 'British Pound',
    'AUD': 'Australian Dollar',
    'CHF': 'Swiss Franc',
    'CNY': 'Chinese Yuan',
    'NZD': 'New Zealand Dollar',
    'BRL': 'Brazilian Real',
    'MXN': 'Mexican Peso',
    'SGD': 'Singapore Dollar',
    'HKD': 'Hong Kong Dollar',
    'KRW': 'South Korean Won',
    'TRY': 'Turkish Lira',
    'NOK': 'Norwegian Krone',
    'DKK': 'Danish Krone',
    'PLN': 'Polish Złoty',
    'THB': 'Thai Baht',
    'MYR': 'Malaysian Ringgit',
    'HUF': 'Hungarian Forint',
    'CZK': 'Czech Koruna',
    'ILS': 'Israeli Shekel',
    'PHP': 'Philippine Peso',
    'IDR': 'Indonesian Rupiah',
    'SAR': 'Saudi Riyal',
    'AED': 'United Arab Emirates Dirham',
    'ARS': 'Argentine Peso',
    'BDT': 'Bangladeshi Taka',
    'PKR': 'Pakistani Rupee',
    'LKR': 'Sri Lankan Rupee',
    'COP': 'Colombian Peso',
    'EGP': 'Egyptian Pound',
    'GHS': 'Ghanaian Cedi',
    'KES': 'Kenyan Shilling',
    'MAD': 'Moroccan Dirham',
    'NAD': 'Namibian Dollar',
    'QAR': 'Qatari Riyal',
    'UGX': 'Ugandan Shilling',
    'UAH': 'Ukrainian Hryvnia',
    'VND': 'Vietnamese Đồng',
    'ZMW': 'Zambian Kwacha',
    'NPR': 'Nepalese Rupee',
    'BTN': 'Bhutanese Ngultrum',
    // Add more currencies as needed
  };

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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

  Future<double> convertCurrency() async {
    final apiUrl =
        'https://api.exchangerate-api.com/v4/latest/$_selectedBaseCurrency';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final rate = data['rates'][_selectedTargetCurrency];
      return rate.toDouble();
    } else {
      throw Exception('Failed to load currency conversion');
    }
  }

  void updateConvertedAmount() async {
    if (_amountController.text.isEmpty) {
      setState(() {
        _isLoading = false;
        _convertedAmount = 0.0;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    if (_amountController.text.isNotEmpty) {
      final conversionRate = await convertCurrency();
      final amount = double.parse(_amountController.text);
      final convertedAmount = amount * conversionRate;
      setState(() {
        _convertedAmount = convertedAmount;
        _isLoading = false;
      });
    }
  }

  void swapCurrencies() {
    setState(() {
      final temp = _selectedBaseCurrency;
      _selectedBaseCurrency = _selectedTargetCurrency;
      _selectedTargetCurrency = temp;
    });
    updateConvertedAmount();
  }

  Widget buildCurrencyDropdown(String currency) {
    return Row(
      children: [
        const SizedBox(
          width: 0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Image.asset(
              'icons/flags/png/${currency.toLowerCase().substring(0, 2)}.png',
              package: 'country_icons',
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              currency,
              style: GoogleFonts.cabin(
                textStyle: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 21, 51, 103),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getCurrencySymbol(String currencyCode) {
    String currencyCountry = _currencies[currencyCode]!;
    switch (currencyCode) {
      case 'USD':
        return '$currencyCountry (\$)';
      case 'EUR':
        return '$currencyCountry (€)';
      case 'JPY':
        return '$currencyCountry (¥)';
      case 'INR':
        return '$currencyCountry (₹)';
      case 'RUB':
        return '$currencyCountry (₽)';
      case 'SEK':
        return '$currencyCountry (kr)';
      case 'ZAR':
        return '$currencyCountry (R)';
      case 'CAD':
        return '$currencyCountry (\$)';
      case 'GBP':
        return '$currencyCountry (£)';
      case 'AUD':
        return '$currencyCountry (\$)';
      case 'CHF':
        return '$currencyCountry (CHF)';
      case 'CNY':
        return '$currencyCountry (¥)';
      case 'NZD':
        return '$currencyCountry (\$)';
      case 'BRL':
        return '$currencyCountry (R\$)';
      case 'MXN':
        return '$currencyCountry (\$)';
      case 'SGD':
        return '$currencyCountry (\$)';
      case 'HKD':
        return '$currencyCountry (HK\$)';
      case 'KRW':
        return '$currencyCountry (₩)';
      case 'TRY':
        return '$currencyCountry (₺)';
      case 'NOK':
        return '$currencyCountry (kr)';
      case 'DKK':
        return '$currencyCountry (kr)';
      case 'PLN':
        return '$currencyCountry (zł)';
      case 'THB':
        return '$currencyCountry (฿)';
      case 'MYR':
        return '$currencyCountry (RM)';
      case 'HUF':
        return '$currencyCountry (Ft)';
      case 'CZK':
        return '$currencyCountry (Kč)';
      case 'ILS':
        return '$currencyCountry (₪)';
      case 'PHP':
        return '$currencyCountry (₱)';
      case 'IDR':
        return '$currencyCountry (Rp)';
      case 'SAR':
        return '$currencyCountry (﷼)';
      case 'AED':
        return '$currencyCountry (د.إ)';
      case 'ARS':
        return '$currencyCountry (\$)';
      case 'BDT':
        return '$currencyCountry (৳)';
      case 'PKR':
        return '$currencyCountry (Rs)';
      case 'LKR':
        return '$currencyCountry (Rs)';
      case 'COP':
        return '$currencyCountry (\$)';
      case 'EGP':
        return '$currencyCountry (£)';
      case 'GHS':
        return '$currencyCountry (₵)';
      case 'KES':
        return '$currencyCountry (KSh)';
      case 'MAD':
        return '$currencyCountry (د.م.)';
      case 'NAD':
        return '$currencyCountry (N\$)';
      case 'QAR':
        return '$currencyCountry (﷼)';
      case 'UGX':
        return '$currencyCountry (USh)';
      case 'UAH':
        return '$currencyCountry (₴)';
      case 'VND':
        return '$currencyCountry (₫)';
      case 'ZMW':
        return '$currencyCountry (ZK)';
      case 'NPR':
        return '$currencyCountry (Rs)';
      case 'BTN':
        return '$currencyCountry (Nu.)';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 245, 251),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'Currency Converter',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 21, 51, 103),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      //height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Amount',
                                style: GoogleFonts.laila(
                                  textStyle: const TextStyle(
                                      fontSize: 13 - 1,
                                      color: Color.fromARGB(255, 20, 14, 56),
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 0.5, color: Colors.black26)),
                                  child: DropdownButton<String>(
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    elevation: 10,
                                    underline: Container(),
                                    value: _selectedBaseCurrency,
                                    onChanged: (value) {
                                      setState(() {
                                        //countryNmae = value!;
                                        _selectedBaseCurrency = value!;
                                      });
                                      updateConvertedAmount();
                                    },
                                    items: _currencies.keys.map((currency) {
                                      return DropdownMenuItem(
                                        value: currency,
                                        child: buildCurrencyDropdown(currency),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 17,
                                ),
                                Container(
                                  // /height: 50,
                                  width:
                                      MediaQuery.of(context).size.width / 2.7,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          96, 213, 212, 212),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 0.5, color: Colors.black26)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: TextField(
                                      autofocus: true,
                                      // controller: _expressionController,
                                      //   keyboardType: TextInputType.none,
                                      style: GoogleFonts.montserratAlternates(
                                        textStyle: const TextStyle(
                                            fontSize: 17,
                                            color:
                                                Color.fromARGB(255, 20, 14, 56),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      textAlign: TextAlign.right,
                                      controller: _amountController,
                                      //cursorColor: Color.fromARGB(255, 84, 81, 81),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(

                                          //labelText: 'Enter Amount',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          contentPadding: EdgeInsets.all(7)),
                                      onChanged: (value) {
                                        updateConvertedAmount();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Container(
                              height: 40,
                              //width: MediaQuery.of(context).size.width / 2.7,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(95, 248, 242, 242),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 0.5, color: Colors.black26)),
                              child: Center(
                                child: Text(
                                  getCurrencySymbol(_selectedBaseCurrency),
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 20, 14, 56),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 1,
                                  width: 100,
                                  color: Colors.black45,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: SizedBox(
                                    height: 44,
                                    width: 44,
                                    child: _isLoading
                                        ? const CircularProgressIndicator(
                                            color:
                                                Color.fromARGB(255, 18, 42, 83),
                                          )
                                        : Container(
                                            height: 42,
                                            width: 42,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 18, 42, 83),
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.swap_vert,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              onPressed: swapCurrencies,
                                            ),
                                          ),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: 100,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 0.5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                              child: Text(
                                'Converted Amount',
                                style: GoogleFonts.laila(
                                  textStyle: const TextStyle(
                                      fontSize: 13 - 1,
                                      color: Color.fromARGB(255, 20, 14, 56),
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 0.5, color: Colors.black26)),
                                  child: DropdownButton<String>(
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    elevation: 10,
                                    underline: Container(),
                                    value: _selectedTargetCurrency,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedTargetCurrency = value!;
                                      });
                                      updateConvertedAmount();
                                    },
                                    items: _currencies.keys.map((currency) {
                                      return DropdownMenuItem(
                                        value: currency,
                                        child: buildCurrencyDropdown(currency),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 17,
                                ),
                                Container(
                                  height:
                                      (_convertedAmount.toString().length < 11)
                                          ? 50
                                          : 70,
                                  width:
                                      MediaQuery.of(context).size.width / 2.7,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          96, 213, 212, 212),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 0.5, color: Colors.black26)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text(
                                        _convertedAmount.toString(),
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                              fontSize: 17,
                                              color: Color.fromARGB(
                                                  255, 20, 14, 56),
                                              fontWeight: FontWeight.w400),
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Container(
                              height: 40,
                              //width: MediaQuery.of(context).size.width / 2.7,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(95, 248, 242, 242),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 0.5, color: Colors.black26)),
                              child: Center(
                                child: Text(
                                  getCurrencySymbol(_selectedTargetCurrency),
                                  style: GoogleFonts.montserratAlternates(
                                    textStyle: const TextStyle(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 20, 14, 56),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _amountController.text.isNotEmpty
                      ? Column(
                          children: [
                            Text(
                              'Indicative Exchange Rate',
                              style: GoogleFonts.laila(
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 20, 14, 56),
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            _isLoading
                                ? Text(
                                    'Loading...',
                                    style: GoogleFonts.laila(
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 20, 14, 56),
                                          fontWeight: FontWeight.w300),
                                    ),
                                  )
                                : Text(
                                    '1 $_selectedBaseCurrency = ${(_convertedAmount / double.parse(_amountController.text))} $_selectedTargetCurrency',
                                    style: GoogleFonts.laila(
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 20, 14, 56),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                          ],
                        )
                      : Text(
                          'Echange Rate will appear here',
                          style: GoogleFonts.laila(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 20, 14, 56),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                  const SizedBox(
                    height: 32,
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
            ),
          ],
        ),
      ),
    );
  }
}
