import 'package:mem_stuff/models/stuff_model.dart';
import 'package:mem_stuff/repositories/stuff_repository.dart';

class DetailController {
  final StuffRepository _repository;

  DetailController(this._repository);

  int id;
  String photo = '';
  String description = '';
  String name = '';
  String phone = '';
  String date = '';

  setId(int value) => id = value;
  setPhoto(String value) => photo = value;
  setDescription(String value) => description = value;
  setName(String value) => name = value;
  setPhone(String value) => phone = value;
  setDate(String value) => date = value;

  Future save() async {
    final stuff = StuffModel(
      id: id,
      photoPath: photo,
      description: description,
      contactName: name,
      phoneNumber: phone,
      date: date,
    );

    if (id == null) {
      await _repository.create(stuff);
    } else {
      await _repository.update(stuff);
    }
  }
}
