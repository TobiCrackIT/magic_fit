import 'package:intl/intl.dart';

class Formatters{
  static String toLocalDateWithTime(DateTime timeStamp) {
    var dateFormat = DateFormat('MMM d, y ● h:mm a');
    var utcDate = dateFormat.format(timeStamp);
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String realDate = dateFormat.format(DateTime.parse(localDate));
    return realDate;
  }
}