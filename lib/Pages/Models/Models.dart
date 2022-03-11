import 'dart:convert';
List<CardModel> imagejsonFromJson(String str) => List<CardModel>.from(json.decode(str).map((x) => CardModel.fromJson(x)));
String imagejsonToJson(List<CardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class CardModel{
  String? CreatedTime;
  String? cardNumber;
  String? name;
  String? sv;
  String? id;
  CardModel({this.id,this.cardNumber,this.CreatedTime,this.name,this.sv});
  CardModel.fromJson(Map<String,dynamic>json):
      id = json['id'],
  cardNumber = json['cardNumber'],
  CreatedTime = json['CreatedTime'],
  name = json['name'],
  sv = json['sv'];

  Map<String, dynamic> toJson() => {
    "CreatedTime": CreatedTime,
    "cardNumber": cardNumber,
    "name": name,
    "sv": sv,
    "id": id,
  };
}