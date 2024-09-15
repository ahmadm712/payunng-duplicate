import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<File> uint8ListToFile(Uint8List uint8list, String fileName) async {
  // Get the directory to store the file
  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/$fileName';

  // Create a file and write the Uint8List data to it
  final file = File(path);
  await file.writeAsBytes(uint8list);

  return file;
}
