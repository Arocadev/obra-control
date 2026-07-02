import 'package:hive/hive.dart';

part 'recordatorio.g.dart';

@HiveType(typeId: 5)
class Recordatorio extends HiveObject {
  @HiveField(0)
  String titulo;

  @HiveField(1)
  String descripcion;

  @HiveField(2)
  DateTime fecha;

  @HiveField(3)
  bool completado;

  @HiveField(4)
  bool avisarDiaAntes;

  @HiveField(5)
  bool avisar6HorasAntes;

  @HiveField(6)
  bool avisar1HoraAntes;

  Recordatorio({
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    this.completado = false,
    this.avisarDiaAntes = true,
    this.avisar6HorasAntes = false,
    this.avisar1HoraAntes = false,
  });
}