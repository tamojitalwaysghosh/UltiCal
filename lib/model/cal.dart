import 'package:hive/hive.dart';
part 'cal.g.dart';

@HiveType(typeId: 1)
class Calitory {
  @HiveField(0)
  final String calculation;

  @HiveField(1)
  final String result;

  Calitory({required this.calculation, required this.result});
}
