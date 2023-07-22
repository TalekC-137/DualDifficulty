import 'package:hive/hive.dart';
part 'map_data.g.dart';

@HiveType(typeId: 0)
class MapData extends HiveObject {

  @HiveField(0)
  String mapName;

  @HiveField(1)
  List<BlockData> blocks;

  MapData({required this.mapName, required this.blocks});
}

@HiveType(typeId: 1)
class BlockData extends HiveObject {

  @HiveField(0)
  double gridPositionX;

  @HiveField(1)
  double gridPositionY;

  @HiveField(2)
  String blockType;

  BlockData(this.gridPositionX, this.gridPositionY, this.blockType);
}