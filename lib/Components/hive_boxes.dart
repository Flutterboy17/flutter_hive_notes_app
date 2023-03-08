import 'package:flutter_hive_notes_app/Models/hive_models.dart';
import 'package:hive/hive.dart';

class HiveBoxes {
  static Box<HiveModels> getData() {
    return Hive.box<HiveModels>('notes');
  }
}




