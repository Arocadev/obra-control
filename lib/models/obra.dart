import 'package:hive/hive.dart';

import 'material_obra.dart';
import 'tarea.dart';

part 'obra.g.dart';

@HiveType(typeId: 2)
class Obra extends HiveObject {
  @HiveField(0)
  String nombre;

  @HiveField(1)
  double presupuesto;

  @HiveField(2)
  double cobrado;

  @HiveField(3)
  List<Tarea> tareas;

  @HiveField(4)
  List<MaterialObra> materiales;

  @HiveField(5)
  String estado;

  @HiveField(6)
  DateTime? fechaInicio;

  @HiveField(7)
  DateTime? fechaFin;

  Obra({
    required this.nombre,
    this.presupuesto = 0,
    this.cobrado = 0,
    this.estado = 'Pendiente',
    this.fechaInicio,
    this.fechaFin,
    List<Tarea>? tareas,
    List<MaterialObra>? materiales,
  })  : tareas = tareas ?? [],
        materiales = materiales ?? [];
}