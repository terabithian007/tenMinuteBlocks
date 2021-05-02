import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';


class BlockDataManager {
  BlockDataManager._internal();
  factory BlockDataManager() => _instance;

  static BlockDataManager _instance = BlockDataManager._internal();  

  Box _userBlockData;
  Box _blockConfigData;
  Future<void> init() async {
    _blockConfigData = await Hive.openBox('blockConfigData');
    _userBlockData = await Hive.openBox('userBlockData');
  }

  


}