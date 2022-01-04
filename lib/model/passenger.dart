
import 'dart:convert';

PassengerData passengerDataFromJson(String str) => PassengerData.fromJson(json.decode(str));

String passengerDataToJson(PassengerData data) => json.encode(data.toJson());

class PassengerData {
  PassengerData({
    required this.totalPassengers,
    required this.totalPages,
    required this.data,
  });

  int totalPassengers;
  int totalPages;
  List<Passenger> data;

  factory PassengerData.fromJson(Map<String, dynamic> json) => PassengerData(
    totalPassengers: json["totalPassengers"],
    totalPages: json["totalPages"],
    data: List<Passenger>.from(json["data"].map((x) => Passenger.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalPassengers": totalPassengers,
    "totalPages": totalPages,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Passenger {
  Passenger({
    required this.id,
    this.name,
    this.trips,
    required this.airline,
  });

  String id;
  String? name;
  int? trips;
  List<Airline> airline;

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
    id: json["_id"],
    name: json["name"],
    trips: json["trips"],
    airline: List<Airline>.from(json["airline"].map((x) => Airline.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "trips": trips,
    "airline": List<dynamic>.from(airline.map((x) => x.toJson())),
  };
}

class Airline {
  Airline({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.slogan,
    required this.headQuaters,
    required this.website,
    required this.established,
  });

  int id;
  String name;
  String country;
  String logo;
  String slogan;
  String headQuaters;
  String website;
  String established;

  factory Airline.fromJson(Map<String, dynamic> json) => Airline(
    id: json["id"],
    name: json["name"],
    country: json["country"],
    logo: json["logo"],
    slogan: json["slogan"],
    headQuaters: json["head_quaters"],
    website: json["website"],
    established: json["established"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country,
    "logo": logo,
    "slogan": slogan,
    "head_quaters": headQuaters,
    "website": website,
    "established": established,
  };
}
