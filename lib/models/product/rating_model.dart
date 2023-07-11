import 'package:hive/hive.dart';

part 'rating_model.g.dart';

@HiveType(typeId: 2)
class RatingModel {
  @HiveField(0)
  double rate;
  @HiveField(1)
  int count;

  RatingModel({
    required this.count,
    required this.rate,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
