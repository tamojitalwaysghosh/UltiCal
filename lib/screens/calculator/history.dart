import 'package:flutter/material.dart';

class CalcuPage extends StatefulWidget {
  final Widget body;
  const CalcuPage({super.key, required this.body});

  @override
  State<CalcuPage> createState() => _CalcuPageState();
}

class _CalcuPageState extends State<CalcuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 245, 251),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 245, 251),
        title: const Text("Calculation History"),
        centerTitle: true,
      ),
      body: widget.body,
    );
  }
}
