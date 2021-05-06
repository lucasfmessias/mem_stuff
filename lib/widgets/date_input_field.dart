import 'package:flutter/material.dart';
import 'package:mem_stuff/helpers/date_helper.dart';

class DateInputField extends StatefulWidget {
  final String label;
  final String initialValue;
  final Function(String) onSaved;

  const DateInputField({
    Key key,
    this.label,
    this.initialValue,
    this.onSaved,
  }) : super(key: key);

  @override
  _DateInputFieldState createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  DateTime _selectedDate;
  TextEditingController _controller;

  @override
  void initState() {
    if (widget.initialValue == null || widget.initialValue.isEmpty) {
      _selectedDate = DateTime.now();
    } else {
      _selectedDate = DateHelper.parse(widget.initialValue);
    }
    _controller = TextEditingController(text: DateHelper.format(_selectedDate));
    super.initState();
  }

  // Remover o controller da memória
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: DateHelper.dateIsLessOrEqualToday,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.date_range_outlined),
        suffixIcon: Icon(Icons.arrow_drop_down),
        labelText: widget.label,
      ),
      readOnly: true,
      onTap: () => _onSelectDate(context),
      controller: _controller,
    );
  }

  Future _onSelectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      // lastDate: DateTime.now(),
    );
    print(date);
    if (date != null && date != _selectedDate) {
      _selectedDate = date;
      print('DateHelper: ${DateHelper.format(date)}');
      _controller.text = DateHelper.format(date);
    }
  }
}
