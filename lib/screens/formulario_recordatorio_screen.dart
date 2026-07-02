import 'package:flutter/material.dart';

import '../models/recordatorio.dart';
import '../services/notification_service.dart';
import '../services/reminder_service.dart';
import '../widgets/selector_recordatorio.dart';

class FormularioRecordatorioScreen
    extends StatefulWidget {
  const FormularioRecordatorioScreen({
    super.key,
  });

  @override
  State<FormularioRecordatorioScreen>
      createState() =>
          _FormularioRecordatorioScreenState();
}

class _FormularioRecordatorioScreenState
    extends State<FormularioRecordatorioScreen> {
  final tituloController =
      TextEditingController();

  final descripcionController =
      TextEditingController();

  DateTime fecha =
      DateTime.now();

  bool diaAntes = true;
  bool horas6 = false;
  bool hora1 = false;

  Future<void> guardar() async {
    if (tituloController.text
        .trim()
        .isEmpty) {
      return;
    }

    final recordatorio =
        Recordatorio(
      titulo:
          tituloController.text,
      descripcion:
          descripcionController.text,
      fecha: fecha,
      avisarDiaAntes:
          diaAntes,
      avisar6HorasAntes:
          horas6,
      avisar1HoraAntes:
          hora1,
    );

    await ReminderService.guardar(
      recordatorio,
    );

    await NotificationService
        .mostrarNotificacion(
      id:
          DateTime.now()
              .millisecondsSinceEpoch %
          2147483647,
      titulo:
          'Recordatorio creado',
      cuerpo:
          recordatorio.titulo,
    );

    if (!mounted) return;

    Navigator.pop(
      context,
      true,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nuevo recordatorio',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(
          16,
        ),
        child: ListView(
          children: [
            TextField(
              controller:
                  tituloController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Título',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller:
                  descripcionController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Descripción',
              ),
              maxLines: 3,
            ),
            const SizedBox(
              height: 16,
            ),
            ListTile(
              leading:
                  const Icon(
                Icons.calendar_month,
              ),
              title: Text(
                '${fecha.day}/${fecha.month}/${fecha.year}',
              ),
              onTap: () async {
                final nueva =
                    await showDatePicker(
                  context:
                      context,
                  initialDate:
                      fecha,
                  firstDate:
                      DateTime(
                        2020,
                      ),
                  lastDate:
                      DateTime(
                        2100,
                      ),
                );

                if (nueva ==
                    null) {
                  return;
                }

                setState(() {
                  fecha = DateTime(
                    nueva.year,
                    nueva.month,
                    nueva.day,
                    fecha.hour,
                    fecha.minute,
                  );
                });
              },
            ),
            ListTile(
              leading:
                  const Icon(
                Icons.access_time,
              ),
              title: Text(
                '${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}',
              ),
              onTap: () async {
                final hora =
                    await showTimePicker(
                  context:
                      context,
                  initialTime:
                      TimeOfDay(
                    hour:
                        fecha.hour,
                    minute:
                        fecha.minute,
                  ),
                );

                if (hora ==
                    null) {
                  return;
                }

                setState(() {
                  fecha = DateTime(
                    fecha.year,
                    fecha.month,
                    fecha.day,
                    hora.hour,
                    hora.minute,
                  );
                });
              },
            ),
            const Divider(),
            SelectorRecordatorio(
              texto:
                  'Avisar 1 día antes',
              valor:
                  diaAntes,
              onChanged: (v) {
                setState(() {
                  diaAntes =
                      v ?? false;
                });
              },
            ),
            SelectorRecordatorio(
              texto:
                  'Avisar 6 horas antes',
              valor:
                  horas6,
              onChanged: (v) {
                setState(() {
                  horas6 =
                      v ?? false;
                });
              },
            ),
            SelectorRecordatorio(
              texto:
                  'Avisar 1 hora antes',
              valor:
                  hora1,
              onChanged: (v) {
                setState(() {
                  hora1 =
                      v ?? false;
                });
              },
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed:
                  guardar,
              child: const Text(
                'Guardar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}