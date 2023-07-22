// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MapDataAdapter extends TypeAdapter<MapData> {
  @override
  final int typeId = 0;

  @override
  MapData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MapData(
      mapName: fields[0] as String,
      blocks: (fields[1] as List).cast<BlockData>(),
    );
  }

  @override
  void write(BinaryWriter writer, MapData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.mapName)
      ..writeByte(1)
      ..write(obj.blocks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BlockDataAdapter extends TypeAdapter<BlockData> {
  @override
  final int typeId = 1;

  @override
  BlockData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BlockData(
      fields[0] as double,
      fields[1] as double,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BlockData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.gridPositionX)
      ..writeByte(1)
      ..write(obj.gridPositionY)
      ..writeByte(2)
      ..write(obj.blockType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
