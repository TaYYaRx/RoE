import 'package:son_roe/parts/t9calculator/utility/services_t9.dart';

class T9MenuPageItemWidget extends StatelessWidget {
  const T9MenuPageItemWidget({
    Key key,
    @required this.image,
    this.title,
    this.controller,
  }) : super(key: key);

  final String image;
  final String title;
  final controller;

  @override
  Widget build(BuildContext context) {
    var itemHeight = MediaQuery.of(context).size.height * 0.154;
    var padding = MediaQuery.of(context).size.width * 0.05;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        height: itemHeight,
        decoration: BoxDecoration(
            border: Border.all(width: 0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.15),
                spreadRadius: 2,
                offset: Offset(6, 6),
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
// Leading Image Part
              child: Image.asset(
                image,
              ),
              width: MediaQuery.of(context).size.width * 0.30,
            ),
            VerticalDivider(
              thickness: 1,
              endIndent: 12,
              indent: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
// Information PART
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
// Title of Type
                    Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() => LinearPercentIndicator(
// Linear Percentage Indicator
                              width: MediaQuery.of(context).size.width * 0.40,
                              lineHeight: 12,
                              curve: Curves.linear,
                              percent: controller.model.value.percentage,
                              progressColor: Colors.blue,
                              center: Text(
// Percentage Value
                                (controller.model.value.percentage * 100)
                                        .toStringAsFixed(0) +
                                    ' %',
                                style: TextStyle(fontSize: 10),
                              ),
                            )),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Left Medal to Tier 9 :   ',
                          style: TextStyle(fontSize: 12),
                        ),
                        Obx(() => Text(
// Left Medal Value
                              '${controller.model.value.t9Left} ',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
