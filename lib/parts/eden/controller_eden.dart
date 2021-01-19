import 'services_eden.dart';

class ControllerEDEN extends GetxController {
  var list = [].obs;
  var coalitionBaseCampLv = [0, 0, 0, 0].obs;

  updateList() async {
    try {
      await fetchEdenDB().then((value) {
        if (value != null) list.assign(value);

        coalitionBaseCampLv[0] = _checkCoalitionBaseCampLevel(
                liste: value, coalitionTitle: 'Coalition Base Camp I') -
            1;
        coalitionBaseCampLv[1] = _checkCoalitionBaseCampLevel(
                liste: value, coalitionTitle: 'Coalition Base Camp II') -
            1;
        coalitionBaseCampLv[2] = _checkCoalitionBaseCampLevel(
                liste: value, coalitionTitle: 'Coalition Base Camp III') -
            1;
        coalitionBaseCampLv[3] = _checkCoalitionBaseCampLevel(
                liste: value, coalitionTitle: 'Coalition Base Camp IV') -
            1;
      });
    } catch (e) {
      print(e);
    }
  }

  int _checkCoalitionBaseCampLevel({List<ModelRoc> liste, String coalitionTitle}) {
    ModelRoc result = liste.firstWhere((model) {
      if (model.name == coalitionTitle) {}
      if ((model.name == coalitionTitle && model.isDone == 0) ||
          (model.levels == '20' && model.isDone == 1 && model.name == coalitionTitle)) {
        return true;
      } else {
        return false;
      }
    }, orElse: () => null);

    return int.parse(result.levels) == 20 &&
            result.isDone == 1 &&
            result.name == coalitionTitle
        ? 21
        : int.parse(result.levels);
  }

  @override
  void onInit() async {
    try {
      await fetchEdenDB().then((value) {
        list.assign(value); // [[80 tane item]]
      });
    } catch (e) {}

    super.onInit();
  }

  Future<List<ModelRoc>> fetchEdenDB() async {
    List<ModelRoc> _listRoc = List();
    await getIt<DatabaseHelper>().getList().then((value) {
      (value as List).forEach((element) {
        _listRoc.add(ModelRoc(
          id: element['id'],
          sector: element['sector'],
          name: element['name'],
          bcmaterials: element['bcmaterials'],
          levels: element['levels'],
          isDone: element['isDone'],
        ));
      });
    });
    return _listRoc;
  }
}
/**
 *   print(model.id);
        print(model.name);
        print(model.bcmaterials);
        print(model.isDone);
        print(model.levels);
        print('-------------------');
 */
