import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:son_roe/events/utility/services_event.dart';
import 'package:time_machine/time_machine.dart';

class RepositoryClass {

  /// Returns Server Time
  Future<ZonedDateTime> fetchServerTime() async {
    try {
      var tzdb = await DateTimeZoneProviders.tzdb;
      var noronha = await tzdb['America/Noronha'];
      var now = Instant.now();

      return now.inZone(noronha);
    } catch (e) {
      print('HATA :> ' + e);
      return null;
    }
  }

  Future<ModelEvents> fetchJsonData() async {
    String jsonData = await rootBundle.loadString('assets/events.json');

    final res = json.decode(jsonData);
    ModelEvents eventModel = ModelEvents.fromMap(res);
    print('ControllerServerTime: Json oluşturuldu');
    return eventModel;
  }


}
