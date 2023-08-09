// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalitoryAdapter extends TypeAdapter<Calitory> {
  @override
  final int typeId = 1;

  @override
  Calitory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Calitory(
      calculation: fields[0] as String,
      result: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Calitory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.calculation)
      ..writeByte(1)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalitoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
