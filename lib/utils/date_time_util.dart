String dateTimeConvertToString(int oldDataTimeStamp) {
  var newDateTimeStamp = DateTime.now().millisecondsSinceEpoch;

  var timeDifferenceValue = newDateTimeStamp - oldDataTimeStamp;
  var second = timeDifferenceValue / 1000;
  var minute = second / 60;
  var hour = minute / 60;

  if (second < 60) {
    return "$second 秒前";
  } else if (minute < 60) {
    return "$minute 分钟前";
  } else if (hour < 24) {
    return "$hour 小时前";
  } else {
    return DateTime.fromMillisecondsSinceEpoch(oldDataTimeStamp).toString().substring(0, 16);
  }
}