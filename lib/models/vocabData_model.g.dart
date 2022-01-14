// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabData_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabDataAdapter extends TypeAdapter<VocabData> {
  @override
  final int typeId = 0;

  @override
  VocabData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabData(
      word: fields[0] as String,
      learnt: fields[1] as bool,
      inProcess: fields[2] as bool,
      inComplete: fields[3] as bool,
      meaning: fields[4] as String,
      example: fields[5] as String,
      audioURL: fields[6] as String,
      antonym: (fields[8] as List)?.cast<String>(),
      synonym: (fields[7] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, VocabData obj) {
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
      other is VocabDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
