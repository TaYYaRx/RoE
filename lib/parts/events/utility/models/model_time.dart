import 'package:time_machine/time_machine.dart';

class ModelServerTime {
  LocalTime serverTime;
  LocalTime reverse;
  int sec;
  int min;
  int hr;
  int day;
  int nextEventHr;
  ModelServerTime({this.serverTime, this.reverse, this.day}) {
    this.sec = serverTime.secondOfMinute;
    this.min = serverTime.minuteOfHour;
    this.hr = serverTime.hourOfDay;
    this.nextEventHr = serverTime.hourOfDay + 1;
  }
}
