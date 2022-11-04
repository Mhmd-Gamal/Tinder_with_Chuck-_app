part of 'jokes.dart';

class JokeAdapter extends TypeAdapter<Jokes> {
  @override
  final int typeId = 1;

  @override
  Jokes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Jokes(
      value: fields[5] as String?,
      iconUrl: fields[1] as String?,
    )
      ..creationDate = fields[0] as String?
      ..id = fields[2] as String?
      ..updatedAt = fields[3] as String?
      ..url = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, Jokes obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.creationDate)
      ..writeByte(1)
      ..write(obj.iconUrl)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JokeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

Jokes $JokeFromJson(Map<String, dynamic> json) => Jokes(
      value: json['value'] as String?,
      iconUrl: json['icon_url'] as String?,
    )
      ..creationDate = json['creation_date'] as String?
      ..url = json['url'] as String?
      ..updatedAt = json['updated_at'] as String?
      ..id = json['id'] as String?
      ..value = json['value'] as String?
      ..iconUrl = json['icon_url'] as String?;

Map<String, dynamic> $JokeToJson(Jokes instance) => <String, dynamic>{
      'created_at': instance.creationDate,
      'icon_url': instance.iconUrl,
      'value': instance.value,
      'url': instance.url,
      'updated_at': instance.updatedAt,
      'id': instance.id,
    };
