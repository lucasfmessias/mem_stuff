const kRequireField = 'Campo obrigatório';
const kInvalidNumber = 'Telefone inválido';

class PhoneHelper {
  static String validatePhoneNumber(String phone) {
    if (phone.isNotEmpty) {
      bool phoneNumberValid =
          RegExp(r'^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$')
              .hasMatch(phone);

      return phoneNumberValid ? null : '$kInvalidNumber';
    }
    return null;
    // if (phone.isEmpty) {
    //   return kRequireField;
    // } else {
    //   bool phoneNumberValid =
    //       RegExp(r'^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$')
    //           .hasMatch(phone);

    //   return phoneNumberValid ? null : 'Telefone inválido';
    // }
  }
}

// A explicação completa dela é:

//         ^ - Início da string.

//         \( - Um abre parênteses.

//         [1-9]{2} - Dois dígitos de 1 a 9. Não existem códigos de DDD com o dígito 0.

//         \) - Um fecha parênteses.

//          - Um espaço em branco.

//         (?:[2-8]|9[1-9]) - O início do número. Representa uma escolha entre o um dígito entre 2 e 8 (a parte do [2-8]) e de um 9 seguido de um dígito de 1 a 9 (a parte do 9[1-9]). O | separa as opções a serem escolhidas. O (?: ... ) agrupa tais escolhas. Telefones fixos começam com dígitos de 2 a 8. Telefones celulares começam com 9 e têm um segundo dígito de 1 a 9. O primeiro dígito nunca será 0 ou 1. Celulares não podem começar com 90 porque esse é o prefixo para ligações a cobrar.

//         [0-9]{3} - Os demais três dígitos da primeira metade do número do telefone, perfazendo um total de 4 ou 5 dígitos na primeira metade.

//         \- - Um hífen.

//         [0-9]{4} - A segunda metade do número do telefone.

//         $ - Final da string.