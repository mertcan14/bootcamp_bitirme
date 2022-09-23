class AddressUser{
  String AddressId;
  String Address;
  String AddressTitle;
  String City;
  String District;

  AddressUser({required this.AddressId, required this.Address, required this.AddressTitle, required this.City, required this.District});

  factory AddressUser.fromJson(Map<dynamic,dynamic> json){
    return AddressUser(AddressId: json["AddressId"] as String, Address: json["Address"] as String,
        AddressTitle: json["AddressTitle"] as String, City: json["City"] as String, District: json["District"] as String);
  }
}