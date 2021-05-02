import 'package:intl/intl.dart';

class InsaneDateTime {
  DateTime _dateTime;

  final DateFormat formatterNumeric = DateFormat('yyyy-MM-dd');
  final DateFormat formatterString = DateFormat('MMMM d, yyyy');
  final DateFormat dateMonthString = DateFormat('d MMMM');

  InsaneDateTime.fromString(String formattedString) {
    _dateTime = DateTime.parse(formattedString);
  }

  InsaneDateTime();

  InsaneDateTime.now() {
    _dateTime = DateTime.now();
  }

  InsaneDateTime.fromDateTime(dateTime) {
    _dateTime = dateTime;
  }

  int get hashCode => _dateTime.hashCode;
  bool operator ==(other) => (this._dateTime == other.dateTime);
  bool isAfter(other) => _dateTime.isAfter(other.dateTime);
  int compareTo(other) => _dateTime.compareTo(other.dateTime);
  bool isAtSameMomentAs(other) => _dateTime.isAtSameMomentAs(other.dateTime);
  bool isBefore(other) => _dateTime.isBefore(other.dateTime);

  String get timeZoneName => _dateTime.timeZoneName;
  Duration get timeZoneOffset => _dateTime.timeZoneOffset;

  int get weekday => _dateTime.weekday;
  String get weekdayString => DateFormat.EEEE().format(_dateTime);
  String get weekdayInitial => DateFormat.E().format(_dateTime).substring(0, 1);

  DateTime get dateTime => _dateTime;
  String toString() => _dateTime.toString();

  String get dateNumeric {
    return formatterNumeric.format(_dateTime);
  }

  String get dateString {
    return formatterString.format(_dateTime);
  }

  String get dateStringWithoutYear {
    return dateMonthString.format(_dateTime);
  }

  int get minute => _dateTime.minute;

  int get second => _dateTime.second;

  int timeDiffInSeconds(InsaneDateTime otherDateTime) {
    Duration difference = _dateTime.difference(otherDateTime._dateTime);
    return difference.inSeconds;
  }

  String get time12HrFormat {
    int hour = _dateTime.hour;
    String amOrpm = 'AM';
    if (hour > 12) {
      hour -= 12;
      amOrpm = 'PM';
    }
    String time = hour.toString() + ' ' + amOrpm;
    return time;
  }

  String get time12HrFormatWithMins {
    int hour = _dateTime.hour;
    String amOrpm = 'AM';
    if (hour > 12) {
      hour -= 12;
      amOrpm = 'PM';
    }
    String time = hour.toString() + '.' + minute.toString().padLeft(2, '0') + " " + amOrpm;
    return time;
  }

  InsaneDateTime addDays(int numDays) {
    return InsaneDateTime.fromDateTime(_dateTime.add(Duration(days: numDays)));
  }
  InsaneDateTime subtractDays(int numDays) {
    return InsaneDateTime.fromDateTime(_dateTime.subtract(Duration(days: numDays)));
  }  

  InsaneDateTime addSeconds(int numSeconds) {
    return InsaneDateTime.fromDateTime(
        _dateTime.add(Duration(seconds: numSeconds)));
  }

  InsaneDateTime addMinutes(int numMinutes) {
    return InsaneDateTime.fromDateTime(
        _dateTime.add(Duration(minutes: numMinutes)));
  }

  InsaneDateTime addDuration(int durationValue, String durationUnit) {
    if (durationUnit == "mins") {
      return addMinutes(durationValue);
    } else {
      if (durationUnit == "secs") {
        return addSeconds(durationValue);
      } else {
        throw ("Add Duration Operation on " +
            durationUnit.toString() +
            " is not supported");
      }
    }
  }

  int matchingDateIndex(List fullList) {
    return fullList.indexWhere((element) => element.date == this.dateNumeric);
  }
}

class InsaneDate extends InsaneDateTime {
  InsaneDate.today() {
    this._dateTime = _formattedDateTime(InsaneDateTime.now());
  }

  InsaneDate.fromString(String formattedString) {
    this._dateTime =
        _formattedDateTime(InsaneDateTime.fromString(formattedString));
  }

  InsaneDate(InsaneDateTime insaneDateTime) {
    this._dateTime = _formattedDateTime(insaneDateTime);
  }

  DateTime _formattedDateTime(InsaneDateTime insaneDateTime) {
    DateTime curr = insaneDateTime._dateTime;
    return DateTime(curr.year, curr.month, curr.day);
  }

  InsaneDate addDays(int numDays) => InsaneDate(super.addDays(numDays));
  InsaneDate subtractDays(int numDays) => InsaneDate(super.subtractDays(numDays));

  List<InsaneDate> get datesInWeek => List.generate(7, (weekdayIndex) {
    if(weekdayIndex < (this.weekday % 7)){
     return this.subtractDays((this.weekday % 7) - weekdayIndex);
    } else if(weekdayIndex > (this.weekday % 7)){
      return this.addDays(weekdayIndex - (this.weekday % 7));
    } else{
      return this;
    }
  });
}
