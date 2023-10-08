class CategoryModel {
  int id = 0;
  String name = "";
  String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
