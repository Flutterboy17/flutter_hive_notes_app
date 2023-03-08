import 'package:hive/hive.dart';
part 'hive_models.g.dart';

@HiveType(typeId: 0)
class HiveModels extends HiveObject {
  
  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  HiveModels({required this.title, required this.description});
}


