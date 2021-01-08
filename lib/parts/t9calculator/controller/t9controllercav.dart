import '../utility/services_t9.dart';

class ControllerT9Cavalry extends GetxController {
  final model = T9Model(
          type: 'Cavalry',
          levels: [0, 0, 0, 0, 0, 0],
          medals: [8760, 8760, 11670, 46700, 46700, 17500],
          t9Left: 131380,
          totalLeft: 140090,
          percentage: 0.0)
      .obs;

  arttir(int index) {
    model.update((val) {
      levelArttir(index, val);
      medalcalculate(index, val);
      yuzdeHesapla(index);
    });
  }

  azalt(int index) {
    model.update((val) {
      levelAzalt(index, val);
      medalcalculate(index, val);
      yuzdeHesapla(index);
    });
  }

  reset() {
    model.update((val) {
      val.levels = [0, 0, 0, 0, 0, 0];
      val.medals = [8760, 8760, 11670, 46700, 46700, 17500];
      val.t9Left = 131380;
      val.totalLeft = 140090;
      val.percentage = 0.0;
    });
  }

  yuzdeHesapla(int index) {
    int toplam = 81;
    int current = 0;

    model.update((val) {
      val.levels.forEach((element) {
        current += element;
      });
      val.percentage = current / toplam;
    });
  }

  levelArttir(int index, T9Model val) {
    switch (index) {
      case 0:
        if (val.levels[index] < 15) {
          val.levels[index]++;

          val.totalLeft -=
              ConstantsT9.cavalryRecruitmentsFARK[val.levels[index] - 1];
          if (val.levels[index] != 15) {
            val.t9Left -=
                ConstantsT9.cavalryRecruitmentsFARK[val.levels[index] - 1];
          }
        }
        break;
      case 1:
        if (val.levels[index] < 15) {
          val.levels[index]++;
          val.totalLeft -=
              ConstantsT9.cavalryRecruitmentsFARK[val.levels[index] - 1];

          if (val.levels[index] != 15) {
            val.t9Left -=
                ConstantsT9.cavalryRecruitmentsFARK[val.levels[index] - 1];
          }
        }
        break;
      case 2:
        if (val.levels[index] < 10) {
          val.levels[index]++;
          val.totalLeft -= ConstantsT9.warPathFARK[val.levels[index] - 1];

          if (val.levels[index] != 10) {
            val.t9Left -= ConstantsT9.warPathFARK[val.levels[index] - 1];
          }
        }
        break;

      case 3:
        if (val.levels[index] < 20) {
          val.levels[index]++;

          val.totalLeft -= ConstantsT9.plainSkirmishFARK[val.levels[index] - 1];
          val.t9Left -= ConstantsT9.plainSkirmishFARK[val.levels[index] - 1];
        }
        break;

      case 4:
        if (val.levels[index] < 20) {
          val.levels[index]++;
          val.totalLeft -= ConstantsT9.plainSkirmishFARK[val.levels[index] - 1];
          val.t9Left -= ConstantsT9.plainSkirmishFARK[val.levels[index] - 1];
        }
        break;
      case 5:
        if (val.levels[index] < 1) {
          val.levels[index]++;
          val.totalLeft -= ConstantsT9.empireDefenderFARK[val.levels[index] - 1];
          val.t9Left -= ConstantsT9.empireDefenderFARK[val.levels[index] - 1];
        }
        break;
      default:
    }
  }

  levelAzalt(int index, T9Model val) {
    switch (index) {
      case 0:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantsT9.cavalryRecruitmentsFARK[val.levels[index]];

          if (val.levels[index] != 14) {
            val.t9Left += ConstantsT9.cavalryRecruitmentsFARK[val.levels[index]];
          }
        }
        break;
      case 1:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantsT9.cavalryRecruitmentsFARK[val.levels[index]];

          if (val.levels[index] != 14) {
            val.t9Left += ConstantsT9.cavalryRecruitmentsFARK[val.levels[index]];
          }
        }
        break;
      case 2:
        if (val.levels[index] > 0) {
          val.levels[index]--;
          val.totalLeft += ConstantsT9.warPathFARK[val.levels[index]];

          if (val.levels[index] != 9) {
            val.t9Left += ConstantsT9.warPathFARK[val.levels[index]];
          }
        }
        break;
      case 3:
        if (val.levels[index] > 0) {
          val.levels[index]--;

          val.totalLeft += ConstantsT9.plainSkirmishFARK[val.levels[index]];
          val.t9Left += ConstantsT9.plainSkirmishFARK[val.levels[index]];
        }
        break;
      case 4:
        if (val.levels[index] > 0) {
          val.levels[index]--;

          val.totalLeft += ConstantsT9.plainSkirmishFARK[val.levels[index]];
          val.t9Left += ConstantsT9.plainSkirmishFARK[val.levels[index]];
        }
        break;
      case 5:
        if (val.levels[index] > 0) {
          val.levels[index]--;

          val.totalLeft += ConstantsT9.empireDefenderFARK[val.levels[index]];
          val.t9Left += ConstantsT9.empireDefenderFARK[val.levels[index]];
        }
        break;
      default:
    }
  }

  medalcalculate(int index, T9Model val) {
    switch (index) {
      case 0:
        if (val.levels[index] < 16) {
          val.medals[index] =
              ConstantsT9.cavalryRecruitmentList[val.levels[index]];
        }
        break;
      case 1:
        if (val.levels[index] < 16) {
          val.medals[index] =
              ConstantsT9.cavalryRecruitmentList[val.levels[index]];
        }

        break;
      case 2:
        if (val.levels[index] < 11) {
          val.medals[index] = ConstantsT9.warPathList[val.levels[index]];
        }
        break;
      case 3:
        if (val.levels[index] < 21) {
          val.medals[index] = ConstantsT9.ebonyBardingList[val.levels[index]];
        }
        break;
      case 4:
        if (val.levels[index] < 21) {
          val.medals[index] = ConstantsT9.ebonyBardingList[val.levels[index]];
        }
        break;
      case 5:
        if (val.levels[index] < 2) {
          val.medals[index] = ConstantsT9.empireDefenderList[val.levels[index]];
        }
        break;
      default:
    }
  }
}
