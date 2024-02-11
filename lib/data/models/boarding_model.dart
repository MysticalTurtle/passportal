import 'dart:convert';
import 'package:passportal/domain/entities/boarding_entity.dart';

BoardingModel boardingModelFromJson(String str) => BoardingModel.fromJson(json.decode(str));
String boardingModelToJson(BoardingModel data) => json.encode(data.toJson());

class BoardingModel extends BoardingEntity{
  BoardingModel({
    super.age,
    super.airport,
    super.arrivalTime,
    super.departureTime,
    super.email,
    super.flight,
    super.id,
    super.lastName,
    super.name,
  });

  factory BoardingModel.fromJson(Map<String, dynamic> json) => BoardingModel(
      age: (json["age"]).toInt(),
      airport: json["airport"],
      arrivalTime: json["arrivalTime"] == null ? null : DateTime.parse(json["arrivalTime"]),
      departureTime: json["departureTime"] == null ? null : DateTime.parse(json["departureTime"]),
      email: json["email"],
      flight: json["flight"],
      id: json["id"],
      lastName: json["lastName"],
      name: json["name"],
    );

  Map<String, dynamic> toJson() => {
      "age": age,
      "airport": airport,
      "arrivalTime": arrivalTime?.toIso8601String(),
      "departureTime": departureTime?.toIso8601String(),
      "email": email,
      "flight": flight,
      "id": id,
      "lastName": lastName,
      "name": name,
    };
}
