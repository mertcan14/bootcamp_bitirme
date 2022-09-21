class Category{
  String CategoryName;
  String ImagePath;
  List<dynamic> Yemekler;

  Category({required this.CategoryName, required this.ImagePath, required this.Yemekler});

  factory Category.fromJson( Map<dynamic, dynamic> json){
    return Category(CategoryName: json["CategoryName"] as String, ImagePath: json["ImagePath"] as String, Yemekler: json["Yemekler"] as List<dynamic>);
  }
}