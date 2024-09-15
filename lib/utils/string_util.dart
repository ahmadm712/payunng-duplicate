import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convertToIdr(double number, int decimalDigit) {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: decimalDigit,
  );
  return currencyFormatter.format(number);
}

void setInitialValueTextField(
        String? value, TextEditingController controller) =>
    controller.text = value ?? '';

String getFileName(String filePath) {
  // Extract the file name with extension from the file path
  final fileNameWithExtension = filePath.split('/').last;
  return fileNameWithExtension.split('.').first;
}

String getFileExtension(String filePath) {
  // Extract the file extension from the file path
  final fileNameWithExtension = filePath.split('/').last;
  final parts = fileNameWithExtension.split('.');
  return parts.length > 1
      ? parts.last
      : ''; // Return the last part as the file extension
}

int getRandomInt() {
  final random = Random();
  return 1 + random.nextInt(1000 - 80 + 1);
}
