
import 'package:hive/hive.dart';
part 'hive_entity.g.dart';

@HiveType(typeId: 0)
class HiveEntity{

  @HiveField(0)
  final dynamic name;

  @HiveField(1)
  final dynamic price;

  @HiveField(2)
  final dynamic id;

  @HiveField(3)
  final dynamic image;

  HiveEntity({
    required this.name,
    required this.price,
    required this.id,
    required this.image
});

}