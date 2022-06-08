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
}
