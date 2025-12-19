String? validateMobileNo(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter mobile number';
  }
  final pattern = RegExp(r'^07\d{8}$');
  if (!pattern.hasMatch(value)) {
    return 'Enter a valid mobile number';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter email';
  }
  final pattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!pattern.hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}

String? validateNotEmpty(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return 'Please enter $fieldName';
  }
  return null;
}
