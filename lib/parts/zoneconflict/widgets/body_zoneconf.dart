import 'package:son_roe/parts/zoneconflict/utility/services_zoneconflict.dart';

class BodyZoneConflict extends StatelessWidget {
  const BodyZoneConflict({
    Key key,
    @required ControllerZoneConflict controller,
  })  : _controller = controller,
        super(key: key);

  final ControllerZoneConflict _controller;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _singleRow(index: 0),
          _myRow(index1: 1, index2: 2),
          _myRow(index1: 3, index2: 4),
          _myRow(index1: 5, index2: 6),
          _singleRow(index: 7),
          _myRow(index1: 8, index2: 9),
          _myRow(index1: 10, index2: 11),
          _singleRow(index: 12),
          _myRow(index1: 13, index2: 14),
          ButtonBar(
            buttonPadding: EdgeInsets.all(12),
            alignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                  onPressed: () {
                    _resetLevels();
                  },
                  child: Text('Reset')),
              RaisedButton(
                onPressed: () {
                  _saveValueToLocal();
                  Get.snackbar('Save', 'Save Complete ✔');
                },
                child: Text('Save'),
                color: Colors.blue,
              )
            ],
          ),
          SizedBox(height: 50)
        ],
      )
    ]));
  }

  void _saveValueToLocal() {
    GetStorage box = GetStorage();
    List<dynamic> list = [
      _controller.model.value.levels,
      _controller.model.value.medals,
      _controller.model.value.totalLeft,
      _controller.model.value.percentage
    ];
    box.write('Zone Conflict', list);
  }

  void _resetLevels() {
    Get.defaultDialog(
        title: 'Reset',
        content: Text('Are you sure ?'),
        actions: [
          FlatButton(
              onPressed: () {
                Get.back();
              },
              child: Text('No')),
          RaisedButton(
            onPressed: () {
              _controller.reset();
              Get.back();
            },
            child: Text('Yes'),
          ),
        ]);
  }

  ItemContainer _singleRow({@required int index}) => ItemContainer(
        controller: _controller,
        researchTitle: ConstantZoneConflict.zoneComTitles[index],
        increase: () {
          _controller.arttir(index);
        },
        decrease: () {
          _controller.azalt(index);
        },
        researchID: index,
      );

  Row _myRow({@required int index1, @required int index2}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ItemContainer(
            controller: _controller,
            researchTitle: ConstantZoneConflict.zoneComTitles[index1],
            increase: () {
              _controller.arttir(index1);
            },
            decrease: () {
              _controller.azalt(index1);
            },
            researchID: index1,
          ),
          ItemContainer(
            controller: _controller,
            researchTitle: ConstantZoneConflict.zoneComTitles[index2],
            increase: () {
              _controller.arttir(index2);
            },
            decrease: () {
              _controller.azalt(index2);
            },
            researchID: index2,
          ),
        ],
      );
}
