import 'dart:convert';

class StuffModel {
  int id;
  String description;
  String contactName;
  String photoPath;
  String date;
  String phoneNumber;

  StuffModel({
    this.id,
    this.description,
    this.contactName,
    this.photoPath,
    this.date,
    this.phoneNumber,
  });

  bool get hasPhoto => photoPath != null && photoPath.isNotEmpty;

  // Necessário uma validação para o ID do map criado
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'description': description,
      'contactName': contactName,
      'photoPath': photoPath,
      'phoneNumber': phoneNumber,
      'date': date,
    };

    if (id != null) data['id'] = id;
    return data;
  }

  factory StuffModel.fromMap(Map<String, dynamic> map) {
    return StuffModel(
      id: map['id'],
      description: map['description'],
      contactName: map['contactName'],
      photoPath: map['photoPath'],
      phoneNumber: map['phoneNumber'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StuffModel.fromJson(String source) =>
      StuffModel.fromMap(json.decode(source));
}
