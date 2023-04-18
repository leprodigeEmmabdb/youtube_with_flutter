import 'package:flutter/material.dart';
import 'package:gestion_fidele/apps/Mon_application.dart';
import 'package:get_storage/get_storage.dart';

main() async {
  await GetStorage.init();
  runApp(MonApplication());
}
