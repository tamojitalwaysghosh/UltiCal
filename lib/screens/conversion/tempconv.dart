import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  TemperatureConverterScreenState createState() =>
      TemperatureConverterScreenState();
}

class TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  late TextEditingController _amountController;
  String _selectedBaseUnit = 'Celsius';
  String _selectedTargetUnit = 'Fahrenheit';
  double _convertedAmount = 0.0;
  //bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void updateConvertedAmount() {
    if (_amountController.text.isEmpty) {
      setState(() {
        _convertedAmount = 0.0;
      });
      return;
    }

    final amount = double.parse(_amountController.text);
    double convertedAmount = 0.0;

    if (_selectedBaseUnit == 'Celsius' && _selectedTargetUnit == 'Fahrenheit') {
      convertedAmount = (amount * 9 / 5) + 32;
    } else if (_selectedBaseUnit == 'Celsius' &&
        _selectedTargetUnit == 'Kelvin') {
      convertedAmount = amount + 273.15;
    } else if (_selectedBaseUnit == 'Fahrenheit' &&
        _selectedTargetUnit == 'Celsius') {
      convertedAmount = (amount - 32) * 5 / 9;
    } else if (_selectedBaseUnit == 'Fahrenheit' &&
        _selectedTargetUnit == 'Kelvin') {
      convertedAmount = (amount + 459.67) * 5 / 9;
    } else if (_selectedBaseUnit == 'Kelvin' &&
        _selectedTargetUnit == 'Celsius') {
      convertedAmount = amount - 273.15;
    } else if (_selectedBaseUnit == 'Kelvin' &&
        _selectedTargetUnit == 'Fahrenheit') {
      convertedAmount = (amount * 9 / 5) - 459.67;
    }

    setState(() {
      _convertedAmount = convertedAmount;
    });
  }

  void swapUnits() {
    setState(() {
      final temp = _selectedBaseUnit;
      _selectedBaseUnit = _selectedTargetUnit;
      _selectedTargetUnit = temp;
    });
    updateConvertedAmount();
  }

  Widget buildUnitDropdown(String unit) {
    return Row(
      children: [
        const SizedBox(
          width: 17,
        ),
        Text(unit),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height / 2.6,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(17.0),
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
                  width: MediaQuery.of(context).size.width / 2.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.5, color: Colors.black26)),
                  child: DropdownButton<String>(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 10,
                    underline: Container(),
                    value: _selectedBaseUnit,
                    onChanged: (value) {
                      setState(() {
                        //countryNmae = value!;
                        _selectedBaseUnit = value!;
                      });
                      updateConvertedAmount();
                    },
                    items: ['Celsius', 'Fahrenheit', 'Kelvin'].map((currency) {
                      return DropdownMenuItem(
                        value: currency,
                        child: buildUnitDropdown(currency),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  width: 13,
                ),
                Container(
                  // /height: 50,
                  width: MediaQuery.of(context).size.width / 2.7,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(96, 213, 212, 212),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.5, color: Colors.black26)),
                  child: TextField(
                    autofocus: true,
                    // controller: _expressionController,
                    //   keyboardType: TextInputType.none,
                    textAlign: TextAlign.right,
                    controller: _amountController,
                    style: GoogleFonts.montserratAlternates(
                      textStyle: const TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 20, 14, 56),
                          fontWeight: FontWeight.w400),
                    ),
                    //cursorColor: Color.fromARGB(255, 84, 81, 81),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        //labelText: 'Enter Amount',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        contentPadding: EdgeInsets.all(7)),
                    onChanged: (value) {
                      updateConvertedAmount();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 13,
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
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: SizedBox(
                    height: 44,
                    width: 44,
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 18, 42, 83),
                          borderRadius: BorderRadius.circular(40)),
                      child: IconButton(
                        icon: const Icon(
                          Icons.swap_vert,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: swapUnits,
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
              padding: const EdgeInsets.only(left: 8, bottom: 8),
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
                  width: MediaQuery.of(context).size.width / 2.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.5, color: Colors.black26)),
                  child: DropdownButton<String>(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 10,
                    underline: Container(),
                    value: _selectedTargetUnit,
                    onChanged: (value) {
                      setState(() {
                        _selectedTargetUnit = value!;
                      });
                      updateConvertedAmount();
                    },
                    items: ['Celsius', 'Fahrenheit', 'Kelvin'].map((currency) {
                      return DropdownMenuItem(
                        value: currency,
                        child: buildUnitDropdown(currency),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  width: 13,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2.7,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(96, 213, 212, 212),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.5, color: Colors.black26)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        _convertedAmount.toString(),
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
                ),
                const SizedBox(
                  height: 13,
                ),
              ],
            ),
            const SizedBox(
              height: 13,
            ),
          ],
        ),
      ),
    );
  }
}
