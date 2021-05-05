import 'package:flutter/material.dart';
import 'package:mem_stuff/controllers/detail_controller.dart';
import 'package:mem_stuff/core/app_const.dart';
import 'package:mem_stuff/helpers/snackbar_helper.dart';
import 'package:mem_stuff/models/stuff_model.dart';
import 'package:mem_stuff/repositories/stuff_repository_impl.dart';
import 'package:mem_stuff/widgets/date_input_field.dart';
import 'package:mem_stuff/widgets/loading_dialog.dart';
import 'package:mem_stuff/widgets/phone_input_field.dart';
import 'package:mem_stuff/widgets/photo_input_area.dart';
import 'package:mem_stuff/widgets/primary_button.dart';
import 'package:mem_stuff/widgets/text_input_field.dart';

class DetailPage extends StatefulWidget {
  final StuffModel stuff;

  const DetailPage({
    Key key,
    this.stuff,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = DetailController(MockStuffRepositoryImpl());

  @override
  void initState() {
    // Para evitar que o ID e o caminho da foto venham nulo;
    _controller.setId(widget.stuff?.id);
    _controller.setPhoto(widget.stuff?.photoPath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.stuff == null ? kTitleNewLoad : kTitleDetail,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PhotoInputArea(
            initialValue: widget.stuff?.photoPath ?? '',
            onChanged: _controller.setPhoto,
          ),
          TextInputField(
            label: kLabelDescription,
            icon: Icons.description_outlined,
            initialValue: widget.stuff?.description ?? '',
            onSaved: _controller.setDescription,
          ),
          TextInputField(
            label: kLabelName,
            icon: Icons.person_outline,
            initialValue: widget.stuff?.contactName ?? '',
            onSaved: _controller.setName,
          ),
          PhoneInputField(
            label: kLabelPhone,
            icon: Icons.phone,
            initialValue: widget.stuff?.phoneNumber ?? '',
            onSaved: _controller.setPhone,
          ),
          DateInputField(
            label: kLabelLoadDate,
            initialValue: widget.stuff?.date ?? '',
            onSaved: _controller.setDate,
          ),
          PrimaryButton(
            label: kButtonSave,
            onPressed: _onSave,
          ),
        ],
      ),
    );
  }

  Future _onSave() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      LoadingDialog.show(
        context,
        message: widget.stuff == null ? 'Salvando...' : 'Atualizando...',
      );
      await _controller.save();
      LoadingDialog.hide();
      Navigator.of(context).pop();
      _onSuccessMessage();
    }
  }

  _onSuccessMessage() {
    if (widget.stuff == null) {
      SnackbarHelper.showCreateMessage(
        context: context,
        message: '${_controller.description} criado com sucesso!',
      );
    } else {
      SnackbarHelper.showUpdateMessage(
        context: context,
        message: '${_controller.description} atualizado com sucesso!',
      );
    }
  }
}
