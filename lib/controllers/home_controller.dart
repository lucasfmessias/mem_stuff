import 'package:mem_stuff/models/stuff_model.dart';
import 'package:mem_stuff/repositories/stuff_repository_impl.dart';

class HomeController {
  final MockStuffRepositoryImpl _repositoryImpl;

  HomeController(this._repositoryImpl);

  List<StuffModel> stuffs = <StuffModel>[];

  bool loading = false;

  Future<void> readAll() async {
    loading = true;
    stuffs = await _repositoryImpl.readAll();
    loading = false;
  }

  Future<void> delete(StuffModel stuff) async {
    loading = true;
    await _repositoryImpl.delete(stuff);
    loading = false;
  }

  Future undo(StuffModel stuff) async {
    await _repositoryImpl.create(stuff);
  }
}
