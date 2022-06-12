class Info {
  final DateTime date;
  final double temperatyre;
  final String iconId;

  Info({
    required this.date,
    required this.temperatyre,
    required this.iconId,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        date: DateTime.fromMillisecondsSinceEpoch(
          json['dt'].toInt() * 1000,
        ),
        temperatyre: json['temp'].toDouble(),
        iconId: json['weather'].first['icon'],
      );

  factory Info.fromJsonHourly(Map<String, dynamic> json) => Info(
        date: DateTime.fromMillisecondsSinceEpoch(
          json['dt'].toInt() * 1000,
        ),
        temperatyre: json['temp'].toDouble(),
        iconId: json['weather'].first['icon'],
      );

  factory Info.fromJsonDaily(Map<String, dynamic> json) => Info(
        date: DateTime.fromMillisecondsSinceEpoch(
          json['dt'].toInt() * 1000,
        ),
        temperatyre: json['temp']['day'].toDouble(),
        iconId: json['weather'].first['icon'],
      );

  factory Info.fromLocalJson(Map<String, dynamic> json) => Info(
        date: DateTime.fromMillisecondsSinceEpoch(int.parse(json['date'])),
        temperatyre: double.parse(json['temperatyre']),
        iconId: json['iconId'],
      );

  static Map<String, String> toMap(Info info) {
    return {
      'date': info.date.millisecondsSinceEpoch.toString(),
      'temperatyre': info.temperatyre.toString(),
      'iconId': info.iconId,
    };
  }
}
