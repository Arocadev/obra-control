import 'package:hive/hive.dart';

import '../models/recordatorio.dart';
import 'notification_service.dart';
import 'storage_service.dart';

class ReminderService {
  static List<Recordatorio> cargar() {
    final box = Hive.box<Recordatorio>(StorageService.recordatoriosBox);
    return box.values.toList();
  }

  static Future<void> _programarNotificaciones(Recordatorio r, int baseId) async {
    if (r.avisarDiaAntes) {
      final fecha = r.fecha.subtract(const Duration(days: 1));
      if (fecha.isAfter(DateTime.now())) {
        await NotificationService.programarNotificacion(
          id: baseId * 10,
          titulo: '📋 ${r.titulo}',
          cuerpo: 'Mañana tienes un recordatorio',
          fecha: fecha,
        );
      }
    }

    if (r.avisar6HorasAntes) {
      final fecha = r.fecha.subtract(const Duration(hours: 6));
      if (fecha.isAfter(DateTime.now())) {
        await NotificationService.programarNotificacion(
          id: baseId * 10 + 1,
          titulo: '📋 ${r.titulo}',
          cuerpo: 'En 6 horas tienes un recordatorio',
          fecha: fecha,
        );
      }
    }

    if (r.avisar1HoraAntes) {
      final fecha = r.fecha.subtract(const Duration(hours: 1));
      if (fecha.isAfter(DateTime.now())) {
        await NotificationService.programarNotificacion(
          id: baseId * 10 + 2,
          titulo: '📋 ${r.titulo}',
          cuerpo: 'En 1 hora tienes un recordatorio',
          fecha: fecha,
        );
      }
    }

    if (r.fecha.isAfter(DateTime.now())) {
      await NotificationService.programarNotificacion(
        id: baseId * 10 + 3,
        titulo: '📋 ${r.titulo}',
        cuerpo: r.descripcion.isNotEmpty
            ? r.descripcion
            : 'Es la hora de tu recordatorio',
        fecha: r.fecha,
      );
    }
  }

  static Future<void> guardar(Recordatorio r) async {
    final box = Hive.box<Recordatorio>(StorageService.recordatoriosBox);
    await box.add(r);

    final baseId = box.length - 1;
    await _programarNotificaciones(r, baseId);
  }

  static Future<void> eliminar(int index) async {
    final box = Hive.box<Recordatorio>(StorageService.recordatoriosBox);

    await NotificationService.cancelar(index * 10);
    await NotificationService.cancelar(index * 10 + 1);
    await NotificationService.cancelar(index * 10 + 2);
    await NotificationService.cancelar(index * 10 + 3);

    await box.deleteAt(index);
  }

  static Future<void> actualizar(int index, Recordatorio r) async {
    final box = Hive.box<Recordatorio>(StorageService.recordatoriosBox);

    await NotificationService.cancelar(index * 10);
    await NotificationService.cancelar(index * 10 + 1);
    await NotificationService.cancelar(index * 10 + 2);
    await NotificationService.cancelar(index * 10 + 3);

    await box.putAt(index, r);

    await _programarNotificaciones(r, index);
  }
}