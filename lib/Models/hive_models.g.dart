// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveModelsAdapter extends TypeAdapter<HiveModels> {
  @override
  final int typeId = 0;

  @override
  HiveModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveModels(
      title: fields[1] as String,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveModels obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
