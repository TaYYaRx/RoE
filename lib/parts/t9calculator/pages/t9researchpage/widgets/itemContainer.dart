import 'package:son_roe/parts/t9calculator/utility/services_t9.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({
    Key key,
    @required this.researchTitle,
    this.controller,
    this.increase,
    this.decrease,
    this.researchID,
  }) : super(key: key);
  final String researchTitle;
  final Function increase;
  final Function decrease;
  final controller;
  final int researchID;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.55 - 36,
        width: MediaQuery.of(context).size.width * 0.5 - 36,
        child: Column(
          children: [
            Card(
              elevation: 15,
              child: Container(
                width: (MediaQuery.of(context).size.width * 0.5 - 36),
                height: (MediaQuery.of(context).size.width * 0.55 - 36) * 0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
// Item Levels
                      child: Obx(() => Text(
                            '${controller.model.value.levels[researchID]}',
                            style: TextStyle(fontSize: 30),
                          )),
                    ),
                    Divider(),
// Item Title
                    Text('$researchTitle', style: TextStyle(fontSize: 12)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
// Item Left Medals
                      child: Obx(() =>
                          Text('${controller.model.value.medals[researchID]}')),
                    )
                  ],
                ),
              ),
            ),
            Container(
// Increase and Decrease Buttons
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
// Increase
                    padding: EdgeInsets.all(8),
                    onPressed: increase,
                    height: 25,
                    minWidth: 40,
                    child: Icon(Icons.add),
                  ),
                  MaterialButton(
// Decrease
                    padding: EdgeInsets.all(8),
                    onPressed: decrease,
                    height: 25,
                    minWidth: 40,
                    child: Icon(Icons.remove),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
