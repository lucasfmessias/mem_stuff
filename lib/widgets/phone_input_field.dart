import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mem_stuff/helpers/phone_helper.dart';

class PhoneInputField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String initialValue;
  final Function onSaved;

  const PhoneInputField({
    Key key,
    this.icon,
    this.label,
    this.initialValue,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TelefoneInputFormatter(),
      ],
      validator: PhoneHelper.validatePhoneNumber,
      keyboardType: TextInputType.number,
      onSaved: onSaved,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
      ),
    );
  }
}
