// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabSet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabSetModelAdapter extends TypeAdapter<VocabSetModel> {
  @override
  final int typeId = 2;

  @override
  VocabSetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabSetModel(
      word: fields[0] as String,
      learnt: fields[1] as bool,
      inProcess: fields[2] as bool,
      inComplete: fields[3] as bool,
      meaning: fields[4] as String,
      example: fields[5] as String,
      audioURL: fields[6] as String,
      antonym: (fields[8] as List)?.cast<dynamic>(),
      synonym: (fields[7] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, VocabSetModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.learnt)
      ..writeByte(2)
      ..write(obj.inProcess)
      ..writeByte(3)
      ..write(obj.inComplete)
      ..writeByte(4)
      ..write(obj.meaning)
      ..writeByte(5)
      ..write(obj.example)
      ..writeByte(6)
      ..write(obj.audioURL)
      ..writeByte(7)
      ..write(obj.synonym)
      ..writeByte(8)
      ..write(obj.antonym);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabSetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
