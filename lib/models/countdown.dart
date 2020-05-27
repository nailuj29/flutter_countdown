@deprecated
class Countdown {
  final int id;
  final DateTime date;
  final String name;

  Countdown({this.id, this.date, this.name});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date.millisecondsSinceEpoch,
      "name": name
    };
  }
}