import 'package:intl/intl.dart';

class DateFormatUtils {
  static final DateFormat _onlyDateFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat _onlyTimeFormat = DateFormat('HH:mm:ss');
  static final DateFormat _dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

  static String formatDate(DateTime date) {
    return _onlyDateFormat.format(date);
  }

  static String formatTime(DateTime date) {
    return _onlyTimeFormat.format(date);
  }

  static String formatDateTime(DateTime date) {
    return _dateTimeFormat.format(date);
  }

  static DateTime parseDate(String date) {
    return _onlyDateFormat.parse(date);
  }

  static DateTime parseTime(String time) {
    return _onlyTimeFormat.parse(time);
  }

  static DateTime parseDateTime(String dateTime) {
    return _dateTimeFormat.parse(dateTime);
  }
}
