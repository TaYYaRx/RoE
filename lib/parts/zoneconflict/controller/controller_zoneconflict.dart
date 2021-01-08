import 'package:son_roe/parts/t9calculator/utility/services_t9.dart';
import 'package:son_roe/parts/zoneconflict/utility/model_zoneconflict.dart';

import '../utility/constants_zoneconflict.dart';

class ControllerZoneConflict extends GetxController {
  final model = ZoneConflictModel(
          type: 'Zone Conflict',
          levels: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          medals: [
            1160,
            2310,
            2310,
            3470,
            3470,
            4610,
            4610,
            8650,
            10370,
            10370,
            12100,
            12100,
            1840,
            13820,
            13820
          ],
          totalLeft: 105010,
          percentage: 0.0)
      .obs;

  arttir(int index) {
    model.update((val) {
      levelArttir(index, val);
      medalcalculate(index, val);
      yuzdeHesapla(val);
    
    });
  }

  azalt(int index) {
    model.update((val) {
      levelAzalt(index, val);
      medalcalculate(index, val);
      yuzdeHesapla(val);     
    });
  }

  void yuzdeHesapla(ZoneConflictModel val) {
    val.percentage = 1 - (val.totalLeft / 105010);    
  }

  void medalcalculate(int index, ZoneConflictModel val) {
    switch (index) {
      case 0:
        if (val.levels[index] < 11) {
          val.medals[index] = ConstantZoneConflict.tier1[val.levels[index]];
        }
        break;
      case 1:
        if (val.levels[index] < 11) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier2[val.levels[index]];
        }
        break;
      case 2:
        if (val.levels[index] < 11) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier2[val.levels[index]];
        }
        break;
      case 3:
        if (val.levels[index] < 11) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier3[val.levels[index]];
        }
        break;
      case 4:
        if (val.levels[index] < 11) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier3[val.levels[index]];
        }
        break;
      case 5:
        if (val.levels[index] < 11) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier4[val.levels[index]];
        }
        break;
      case 6:
        if (val.levels[index] < 11) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier4[val.levels[index]];
        }
        break;
      case 7:
        if (val.levels[index] < 16) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier5[val.levels[index]];
        }
        break;
      case 8:
        if (val.levels[index] < 16) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier6[val.levels[index]];
        }
        break;
      case 9:
        if (val.levels[index] < 16) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier6[val.levels[index]];
        }
        break;
      case 10:
        if (val.levels[index] < 16) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier7[val.levels[index]];
        }
        break;
      case 11:
        if (val.levels[index] < 16) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier7[val.levels[index]];
        }
        break;
      case 12:
        if (val.levels[index] < 2) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier8[val.levels[index]];
        }
        break;
      case 13:
        if (val.levels[index] < 16) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier9[val.levels[index]];
        }
        break;
      case 14:
        if (val.levels[index] < 16) {
          val.medals[index] =
              val.medals[index] = ConstantZoneConflict.tier9[val.levels[index]];
        }
        break;
      default:
    }
  }

  void levelArttir(int index, ZoneConflictModel val) {
    switch (index) {
      case 0:
        if (val.levels[index] < 10) {
          val.levels[index]++;
          val.totalLeft -= ConstantZoneConflict.tier1F[val.levels[index] - 1];
        }
        break;
      case 1:
        if (val.levels[index] < 10) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier2F[val.levels[index] - 1];
        }
        break;
      case 2:
        if (val.levels[index] < 10) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier2F[val.levels[index] - 1];
        }
        break;
      case 3:
        if (val.levels[index] < 10) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier3F[val.levels[index] - 1];
        }
        break;
      case 4:
        if (val.levels[index] < 10) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier3F[val.levels[index] - 1];
        }
        break;
      case 5:
        if (val.levels[index] < 10) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier4F[val.levels[index] - 1];
        }
        break;
      case 6:
        if (val.levels[index] < 10) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier4F[val.levels[index] - 1];
        }
        break;
      case 7:
        if (val.levels[index] < 15) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier5F[val.levels[index] - 1];
        }
        break;
      case 8:
        if (val.levels[index] < 15) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier6F[val.levels[index] - 1];
        }
        break;
      case 9:
        if (val.levels[index] < 15) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier6F[val.levels[index] - 1];
        }
        break;
      case 10:
        if (val.levels[index] < 15) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier7F[val.levels[index] - 1];
        }
        break;
      case 11:
        if (val.levels[index] < 15) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier7F[val.levels[index] - 1];
        }
        break;
      case 12:
        if (val.levels[index] < 1) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier8F[val.levels[index] - 1];
        }
        break;
      case 13:
        if (val.levels[index] < 15) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier9F[val.levels[index] - 1];
        }
        break;
      case 14:
        if (val.levels[index] < 15) {
          val.levels[index]++;

          val.totalLeft -= ConstantZoneConflict.tier9F[val.levels[index] - 1];
        }
        break;
      default:
    }
  }

  void levelAzalt(int index, ZoneConflictModel val) {
    switch (index) {
      case 0:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier1F[val.levels[index]];
        }
        break;
      case 1:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier2F[val.levels[index]];
        }
        break;
      case 2:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier2F[val.levels[index]];
        }
        break;
      case 3:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier3F[val.levels[index]];
        }
        break;
      case 4:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier3F[val.levels[index]];
        }
        break;
      case 5:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier4F[val.levels[index]];
        }
        break;
      case 6:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier4F[val.levels[index]];
        }
        break;
      case 7:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier5F[val.levels[index]];
        }
        break;
      case 8:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier6F[val.levels[index]];
        }
        break;
      case 9:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier6F[val.levels[index]];
        }
        break;
      case 10:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier7F[val.levels[index]];
        }
        break;
      case 11:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier7F[val.levels[index]];
        }
        break;
      case 12:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier8F[val.levels[index]];
        }
        break;
      case 13:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier9F[val.levels[index]];
        }
        break;
      case 14:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantZoneConflict.tier9F[val.levels[index]];
        }
        break;
      default:
    }
  }

    /// Değerleri default haline döndürür.
  void reset() {
    model.update((val) {
      val.levels = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
      val.medals = [
        1160,
        2310,
        2310,
        3470,
        3470,
        4610,
        4610,
        8650,
        10370,
        10370,
        12100,
        12100,
        1840,
        13820,
        13820
      ];
      val.totalLeft = 105010;
      val.percentage = 0.0;
    });
  }
}

//[1160, 2310,2310, 3470,3470, 4610,4610, 8650, 10370,10370, 12100,12100, 1840, 13820,13820]
