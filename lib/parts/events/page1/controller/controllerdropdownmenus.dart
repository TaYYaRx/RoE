import 'package:son_roe/parts/events/utility/services_event.dart';

class ControllerDropdownMenu extends GetxController {
  var castleLevelTitle = '6-8'.obs;
  var castleLevelIndex = 0.obs;

  var sundayEventIndex = 5.obs;
  var sundayEventTitle = ' '.obs;

  updateCastleLevel(int value) {
    castleLevelTitle.value = getCastleLevelTitle(value);
    castleLevelIndex.value = value;
  }

  updateEvent(int value) {
    sundayEventTitle.value = getSundayEventTitle(value);
    sundayEventIndex.value = value;
  }

  String getCastleLevelTitle(int value) {
    return getIt<ConstantOfEvents>().castleLv.keys.firstWhere(
        (element) => getIt<ConstantOfEvents>().castleLv[element] == value,
        orElse: () => null);
  }

  String getSundayEventTitle(int value) {
    return getIt<ConstantOfEvents>().eventTitles.keys.firstWhere(
        (element) => getIt<ConstantOfEvents>().eventTitles[element] == value,
        orElse: () => null);
  }

  @override
  void onInit() {
    super.onInit();


    var sundayLvInBox = getIt<GetStorage>().read('sundayEvent');
    if (sundayLvInBox != null) {
  

      castleLevelIndex.value = sundayLvInBox;
      sundayEventTitle.value = getSundayEventTitle(sundayLvInBox);
    }
  

    sundayEventTitle.value = getSundayEventTitle(sundayEventIndex.value);
  }
}
