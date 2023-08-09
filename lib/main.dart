import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ultical/model/cal.dart';
import 'package:ultical/screendrawer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  //nedded
  WidgetsFlutterBinding.ensureInitialized();

  ///initialixa ad
  MobileAds.instance.initialize();

  //initialize
  await Hive.initFlutter();

  //set path
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  //register adaptar
  Hive.registerAdapter(CalitoryAdapter());

  //open a box
  await Hive.openBox("cal");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 21, 51, 103),
          ),
          useMaterial3: true,
        ),
        home: const DS());
  }
}
