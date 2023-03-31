import 'dart:io';

import 'package:path_provider/path_provider.dart';

var constDirectory = getApplicationSupportDirectory();
class PathServices {
  Future<String?> get localPath async {
    final directory = await constDirectory;

    return directory.path;
  }

  Future<File> get localFile async {
    final path = await PathServices().localPath;
    return File('$path/${DateTime.now()}.html');
  }

  Future<List<FileSystemEntity>> getFiles() async {
    List<FileSystemEntity> atata = [];
    try {
      final directory = await constDirectory;
      final dir = directory.path;
      String fileDirectory = '$dir/';
      final myDir = Directory(fileDirectory);
      atata = myDir.listSync(recursive: true, followLinks: false).toList();
      return atata;
    } catch (e) {
      return [];
    }
  }
}
