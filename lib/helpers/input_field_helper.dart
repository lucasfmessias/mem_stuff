const kRequireField = 'Campo obrigatório';
const kInvalidValue = 'Valor inválido';

class ValidatorHelper {
  static String validateNumberField(String text) {
    if (text.isEmpty) return kRequireField;

    if (text.startsWith('.') || text.startsWith(',')) return kInvalidValue;

    return null;
  }
}
