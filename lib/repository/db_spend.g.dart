// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_spend.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DBSpendAdapter extends TypeAdapter<DBSpend> {
  @override
  final int typeId = 0;

  @override
  DBSpend read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DBSpend()
      ..name = fields[0] as String
      ..time = fields[1] as DateTime
      ..category = fields[2] as Category
      ..nominal = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, DBSpend obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.nominal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DBSpendAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
