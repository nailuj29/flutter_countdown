import 'package:intl/intl.dart';

class DateUtils {
  static String shortMonthDayYear(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String month(DateTime date) {
    return DateFormat.MMM().format(date);
  }

  static String day(DateTime date) {
    return DateFormat.d().format(date);
  }
}
