import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'jokes.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Jokes {
  @JsonKey(name: 'created_at')
  @HiveField(0)
  String? creationDate;

  @JsonKey(name: 'icon_url')
  @HiveField(1)
  String? iconUrl;

  @HiveField(2)
  String? id;

  @HiveField(3)
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @HiveField(4)
  String? url;

  @HiveField(5)
  String? value;

  Jokes({this.value, this.iconUrl});

  factory Jokes.fromJson(Map<String, dynamic> json) => $JokeFromJson(json);
  Map<String, dynamic> toJson() => $JokeToJson(this);

  @override
  String toString() {
    return 'value: ${value!}';
  }
}
