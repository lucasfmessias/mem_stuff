import 'package:flutter/material.dart';
import 'package:mem_stuff/controllers/home_controller.dart';
import 'package:mem_stuff/core/app_const.dart';
import 'package:mem_stuff/helpers/snackbar_helper.dart';
import 'package:mem_stuff/models/stuff_model.dart';
import 'package:mem_stuff/pages/detail_page.dart';
import 'package:mem_stuff/repositories/stuff_repository_impl.dart';
import 'package:mem_stuff/services/calls_and_messages_service.dart';
import 'package:mem_stuff/services/service_locator.dart';
import 'package:mem_stuff/widgets/stuff_card.dart';
import 'package:mem_stuff/widgets/stuff_listview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController(MockStuffRepositoryImpl());
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future _initialize() async {
    await _controller.readAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onCreate,
        label: Text('Empréstimo'),
        icon: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _initialize,
        child: StuffListView(
          loading: _controller.loading,
          itemCount: _controller.stuffs.length,
          itemBuilder: _buildStuffCard,
        ),
      ),
    );
  }

  Widget _buildStuffCard(BuildContext context, int index) {
    final stuff = _controller.stuffs[index];

    return StuffCard(
      stuff: stuff,
      onUpdate: () => _onUpdate(stuff),
      onDelete: () => _onDelete(stuff),
      onCall: () => _onCall(stuff),
    );
  }

  _onCreate() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailPage(),
      ),
    );
    _initialize();
  }

  _onUpdate(StuffModel stuff) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailPage(stuff: stuff),
      ),
    );
    _initialize();
  }

  _onDelete(StuffModel stuff) async {
    await _controller.delete(stuff);
    _initialize();
    SnackbarHelper.showDeleteMessage(
      context: context,
      message: '${stuff.description} excluído!',
      onPressed: () => _onDeleteUndo(stuff),
    );
  }

  _onDeleteUndo(StuffModel stuff) async {
    await _controller.undo(stuff);
    _initialize();
  }

  _onCall(StuffModel stuff) {
    _service.call(number: stuff.phoneNumber);
  }
}
