class AccountModel {
  int id = 0;
  int categoryId = 0;
  String image = '';
  String link = "";
  String contact = "";
  String password = "";
  int security;

  AccountModel({
    required this.id,
    required this.categoryId,
    required this.image,
    required this.link,
    required this.contact,
    required this.password,
    required this.security
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'image': image,
      'link': link,
      'contact': contact,
      'password': password,
      'security': security,
    };
  }
}
