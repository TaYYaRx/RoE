import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

import 'parts/events/utility/models/model_events.dart';

class RepositoryClass {
  RepositoryClass() {
    tz.initializeTimeZones();
  }

  /// Zamanı iste
  TZDateTime fetchServerTime() {
    return tz.TZDateTime.now(tz.getLocation('America/Noronha'));
  }

  // ignore: missing_return

  /// Listeleri Getir
  Future<ModelEvents> fetchJsonData() async {
    String jsonData = await rootBundle.loadString('assets/events.json');

    final res = json.decode(jsonData);
    ModelEvents eventModel = ModelEvents.fromMap(res);
    print('ControllerServerTime: Json oluşturuldu');
    return eventModel;
  }
}
