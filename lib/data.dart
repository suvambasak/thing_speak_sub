class Data {
  bool status = false;

  String savedDate = '0000-00-00';
  String savedTime = '00:00:00';
  String savedTemperature = '00';
  String savedHumidity = '00';

  void setLoaded() {
    status = true;
  }

  bool get isloaded {
    return this.status;
  }

  set date(String date) {
    this.savedDate = date;
  }

  String get date {
    return this.savedDate;
  }

  set time(String time) {
    this.savedTime = time;
  }

  String get time {
    return this.savedTime;
  }

  set temperature(String temperature) {
    this.savedTemperature = temperature + '\u{B0}C';
  }

  String get temperature {
    return this.savedTemperature;
  }

  set humidity(String humidity) {
    this.savedHumidity = humidity + '%';
  }

  String get humidity {
    return this.savedHumidity;
  }
}
