import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/recordatorio.dart';
import 'notification_service.dart';
import 'storage_service.dart';

@pragma('vm:entry-point')
void alarmaCallback(int id) async {
  await NotificationService.init();

  final prefs = await SharedPreferences.getInstance();
  final titulo = prefs.getString('alarma_titulo_$id') ?? 'Recordatorio';
  final cuerpo = prefs.getString('alarma_cuerpo_$id') ?? 'Tienes un recordatorio pendiente';

  await NotificationService.mostrarNotificacion(
    id: id,
    titulo: titulo,
    cuerpo: cuerpo,
  );
}

class ReminderService {
  static List<Recordatorio> cargar() {
    final box = Hive.box<Recordatorio>(StorageService.recordatoriosBox);
    return box.values.toList();
  }

  static Future<void> _programarAlarma({
    required int id,
    required DateTime fecha,
    required String titulo,
    required String cuerpo,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('alarma_titulo_$id', titulo);
    await prefs.setString('alarma_cuerpo_$id', cuerpo);

    await AndroidAlarmManager.oneShotAt(
      fecha,
      id,
      alarmaCallback,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  static Future<void> guardar(Recordatorio r) async {
    final box = Hive.box<Recordatorio>(StorageService.recordatoriosBox);
    await box.add(r);

    final baseId = DateTime.now().millisecondsSinceEpoch % 100000;

    if (r.avisarDiaAntes) {
      final fecha = r.fecha.subtract(const Duration(days: 1));
      if (fecha.isAfter(DateTime.now())) {
        await _programarAlarma(
          id: baseId,
          fecha: fecha,
          titulo: '📋 ${r.titulo}',
          cuerpo: 'Mañana tienes un recordatorio',
        );
      }
    }

    if (r.avisar6HorasAntes) {
      final fecha = r.fecha.subtract(const Duration(hours: 6));
      if (fecha.isAfter(DateTime.now())) {
        await _programarAlarma(
          id: baseId + 1,
          fecha: fecha,
          titulo: '📋 ${r.titulo}',
          cuerpo: 'En 6 horas tienes un recordatorio',
        );
      }
    }

    if (r.avisar1HoraAntes) {
      final fecha = r.fecha.subtract(const Duration(hours: 1));
      if (fecha.isAfter(DateTime.now())) {
        await _programarAlarma(
          id: baseId + 2,
          fecha: fecha,
          titulo: '📋 ${r.titulo}',
          cuerpo: 'En 1 hora tienes un recordatorio',
        );
      }
    }

    if (r.fecha.isAfter(DateTime.now())) {
      await _programarAlarma(
        id: baseId + 3,
        fecha: r.fecha,
        titulo: '📋 ${r.titulo}',
        cuerpo: r.descripcion.isNotEmpty ? r.descripcion : 'Es la hora de tu recordatorio',
      );
    }
  }

  static Future<void> eliminar(int index) async {
    final box = Hive.box<Recordatorio>(StorageService.recordatoriosBox);
    await box.deleteAt(index);
  }

  static Future<void> actualizar(int index, Recordatorio r) async {
    final box = Hive.box<Recordatorio>(StorageService.recordatoriosBox);
    await box.putAt(index, r);
  }
}