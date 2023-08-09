//import 'package:cali/preference_provider.dart';

import 'package:ultical/screens/calculator/history.dart';
import 'package:ultical/model/cal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'keypad.dart';
import 'mathparser.dart';

//import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'appbar.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final _expressionController = TextEditingController();
  late final Box calBox;

  String _output = "";
  double _fontSize = 48;

  void parseExpression(String expression) {
    setState(() {
      _expressionController.text = _output;

      _output = "";
    });

    // set cursor to the end of the expression
    _expressionController.selection = TextSelection.fromPosition(
      TextPosition(offset: _expressionController.text.length),
    );
  }

  void parseExpressionOnChange(String expression) {
    if (expression.isEmpty) {
      setState(() => _output = "");
    }
    // replace sin-1, cos-1, tan-1 with arcsin, arccos, arctan
    expression = expression.replaceAll("sin\u207B\u00B9", "arcsin");
    expression = expression.replaceAll("cos\u207B\u00B9", "arccos");
    expression = expression.replaceAll("tan\u207B\u00B9", "arctan");

    // replace x² with x^2
    expression = expression.replaceAll("\u00B2", "^2");

    // replace π with *3.141592653589793
    expression = expression.replaceAll("π", "*3.141592653589793");

    // replace x with *
    expression = expression.replaceAll("x", "*");

    // replace √ with sqrt
    expression = expression.replaceAll("√", "sqrt(");

    // update the expression to always use base 10 log
    expression = expression.replaceAllMapped(
        RegExp(r'log\s*\(\s*([^,]+)\s*\)?'),
        (match) => 'log(${match.group(1)}, 10)');

    String result = MathParser.parseExpression(expression);

    // if expression is invalid, return
    if (result == "Expression Error") {
      return;
    }

    // if expression contains only numbers, return
    if (RegExp(r'^[\d.]+$').hasMatch(expression)) {
      return;
    }

    // if resulte ends with .0, remove it
    if (result.endsWith(".0")) {
      result = result.substring(0, result.length - 2);
    }

    setState(() => _output = result);
  }

  _addCal() async {
    Calitory cali =
        Calitory(calculation: _expressionController.text, result: _output);
    calBox.add(cali);
  }

  void setFontSize() {
    setState(() {
      if (_expressionController.text.length > 20) {
        _fontSize = 20;
      } else if (_expressionController.text.length > 15) {
        _fontSize = 28;
      } else if (_expressionController.text.length > 22) {
        _fontSize = 15;
      } else if (_expressionController.text.length > 24) {
        _fontSize = 10;
      } else if (_expressionController.text.length > 18) {
        _fontSize = 24;
      } else if (_expressionController.text.length > 12) {
        _fontSize = 36;
      } else {
        _fontSize = 48;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    calBox = Hive.box("cal");
  }

  @override
  void dispose() {
    _expressionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final isTabView = ref.watch(prefrencesProvider).tabView;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 245, 251),
      //appBar: isTabView ? null : const MainAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  autofocus: true,
                  // controller: _expressionController,
                  //   keyboardType: TextInputType.none,
                  style: GoogleFonts.montserratAlternates(
                    textStyle: TextStyle(
                        fontSize: _fontSize,
                        color: const Color.fromARGB(255, 20, 14, 56),
                        fontWeight: FontWeight.w400),
                  ),
                  textAlign: TextAlign.right,
                  controller: _expressionController,
                  //cursorColor: Color.fromARGB(255, 84, 81, 81),
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(

                      //labelText: 'Enter Amount',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      contentPadding: EdgeInsets.all(18)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    _output,
                    style: GoogleFonts.montserratAlternates(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
          Expanded(
            //height: MediaQuery.of(context).size.height * 0.60,
            child: Keypad(
              isScientific: false,
              controller: _expressionController,
              isCalculator: true,
              history: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * .26,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(168, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'History',
                      style: GoogleFonts.laila(
                        textStyle: const TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 21, 51, 103),
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalcuPage(
                                body: _body(context: context),
                              )));
                },
              ),
              onChanged: () {
                parseExpressionOnChange(_expressionController.text);
                setFontSize();
              },
              onPressed: () {
                _addCal();
                parseExpression(_expressionController.text);
              },
            ),
          ),
          Container(
            color: const Color.fromARGB(168, 255, 255, 255),
          ),
        ],
      ),
    );
  }

  _body({required BuildContext context}) {
    return ValueListenableBuilder(
        valueListenable: calBox.listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return Center(
              child: Text(
                "No History Found",
                style: GoogleFonts.monda(
                  textStyle: const TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 20, 14, 56),
                      fontWeight: FontWeight.w600),
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (BuildContext context, int index) {
                var currentBox = box;
                var caldata = currentBox.getAt(index);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    caldata.result,
                                    style: GoogleFonts.monda(
                                      textStyle: const TextStyle(
                                          fontSize: 17,
                                          color:
                                              Color.fromARGB(255, 20, 14, 56),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Text(
                                    caldata.calculation,
                                    style: GoogleFonts.laila(
                                      textStyle: const TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromARGB(255, 20, 14, 56),
                                          fontWeight: FontWeight.w300),
                                    ),
                                    //overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: caldata.result));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Result Copied to Clipboard"),
                                  ));
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  size: 17,
                                  //color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _deleteInfo(index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 17,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
  }

  _deleteInfo(int index) {
    calBox.deleteAt(index);
  }
}
