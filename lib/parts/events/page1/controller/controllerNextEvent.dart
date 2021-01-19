import 'package:get/get.dart';

class ControllerNextEvent extends GetxController {
  var titleOfNextEvent = 'Null'.obs;

  updateNextEventTitle(String net) {
    titleOfNextEvent.value = net;
  }
}
