// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obra.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ObraAdapter extends TypeAdapter<Obra> {
  @override
  final int typeId = 2;

  @override
  Obra read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Obra(
      nombre: fields[0] as String,
      presupuesto: fields[1] as double,
      cobrado: fields[2] as double,
      estado: fields[5] as String,
      fechaInicio: fields[6] as DateTime?,
      fechaFin: fields[7] as DateTime?,
      tareas: (fields[3] as List?)?.cast<Tarea>(),
      materiales: (fields[4] as List?)?.cast<MaterialObra>(),
    );
  }

  @override
  void write(BinaryWriter writer, Obra obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.presupuesto)
      ..writeByte(2)
      ..write(obj.cobrado)
      ..writeByte(3)
      ..write(obj.tareas)
      ..writeByte(4)
      ..write(obj.materiales)
      ..writeByte(5)
      ..write(obj.estado)
      ..writeByte(6)
      ..write(obj.fechaInicio)
      ..writeByte(7)
      ..write(obj.fechaFin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObraAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
