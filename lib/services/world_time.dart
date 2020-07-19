import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    try {
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      print(datetime);
      String offset_hour = data['utc_offset'].substring(1, 3);
      String offset_minute = data['utc_offset'].substring(4, 6);

      DateTime now = DateTime.parse(datetime);
      //print(now);
      isDaytime =  int.parse(datetime.substring(11, 13)) > 6 && int.parse(datetime.substring(11, 13)) < 19 ? true : false;

      now = now.add(Duration(
          hours: int.parse(offset_hour), minutes: int.parse(offset_minute)));
      time = DateFormat.jm().format(now);
    }
    catch(error){
      print('$error');
      time = 'could not get time data';
    }
  }

}