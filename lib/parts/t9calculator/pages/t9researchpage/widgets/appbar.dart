import 'package:son_roe/parts/t9calculator/utility/services_t9.dart';

class AppBarResearchPage extends StatelessWidget {
  const AppBarResearchPage({
    Key key,
    @required this.type,
    @required this.mainImage,
    @required this.controller,
  }) : super(key: key);

  final  type;
  final  mainImage;
  final  controller;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.256,
      pinned: false,
      floating: true,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        collapseMode: CollapseMode.parallax,

        title: Text(type),
        background: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(mainImage))),
            ),
// Status PART
            Positioned(
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.264,
                color: Colors.black87.withOpacity(0.4),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top:
                            MediaQuery.of(context).size.height * 0.026),
                    child: Obx(() => CircularPercentIndicator(
// Circular Percent Indicator
                          animateFromLastPercent: true,
                          progressColor: Colors.blue.shade400,
                          backgroundColor: Colors.white,
                          radius: 70,
                          lineWidth: 4,
                          percent: controller.model.value.percentage,
// Percentage Text Indicator
                          center: Text(
                            '${(controller.model.value.percentage * 100).toStringAsFixed(0)} %', 
                            style: TextStyle(color: Colors.white),
                          ),
                          animation: true,
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Center(
                    child: Container(
                      height:
                          MediaQuery.of(context).size.height * 0.032,
                      color: Colors.black87.withOpacity(0.45),
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Center(
                        child: Text(
                          'Left Cougrage',
                          style: TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.032,
                    color: Colors.black87.withOpacity(0.45),
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Center(
                      child: Obx(() => Text(
// Left Medals
                            '${controller.model.value.t9Left}', 
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ), 
      ),
    );
  }
}
