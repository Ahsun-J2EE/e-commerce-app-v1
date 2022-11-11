
import 'package:hive/hive.dart';
part 'hive_entity.g.dart';

@HiveType(typeId: 0)
class HiveEntity{

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String price;

  @HiveField(2)
  final String id;

  HiveEntity({
    required this.name,
    required this.price,
    required this.id,
});

}