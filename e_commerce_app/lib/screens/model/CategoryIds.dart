class CategoryIds {
  CategoryIds({
      this.id, 
      this.position,});

  CategoryIds.fromJson(dynamic json) {
    id = json['id'];
    position = json['position'];
  }
  String? id;
  int? position;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['position'] = position;
    return map;
  }

}