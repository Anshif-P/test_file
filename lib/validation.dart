class TextFieldValidation {
  static emtyValidation(String? value) {
    if (value == null) {
      return 'fill the field';
    } else {
      return null;
    }
  }
}
