// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveEntityAdapter extends TypeAdapter<HiveEntity> {
  @override
  final int typeId = 0;

  @override
  HiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEntity(
      name: fields[0] as String,
      price: fields[1] as String,
      id: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
