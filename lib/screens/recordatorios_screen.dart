import 'package:flutter/material.dart';

import '../models/recordatorio.dart';
import '../services/reminder_service.dart';
import 'formulario_recordatorio_screen.dart';

class RecordatoriosScreen
    extends StatefulWidget {
  const RecordatoriosScreen({
    super.key,
  });

  @override
  State<RecordatoriosScreen>
      createState() =>
          _RecordatoriosScreenState();
}

class _RecordatoriosScreenState
    extends State<
        RecordatoriosScreen> {
  List<Recordatorio>
      recordatorios = [];

  @override
  void initState() {
    super.initState();
    cargar();
  }

  void cargar() {
    setState(() {
      recordatorios =
          ReminderService
              .cargar();
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recordatorios',
        ),
      ),
      floatingActionButton:
          FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () async {
          final creado =
              await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const FormularioRecordatorioScreen(),
            ),
          );

          if (creado ==
              true) {
            cargar();
          }
        },
      ),
      body:
          recordatorios.isEmpty
              ? const Center(
                  child: Text(
                    'No hay recordatorios',
                  ),
                )
              : ListView.builder(
                  itemCount:
                      recordatorios
                          .length,
                  itemBuilder:
                      (
                        context,
                        index,
                      ) {
                    final r =
                        recordatorios[
                            index];

                    return Card(
                      child:
                          ListTile(
                        leading:
                            Icon(
                          r.completado
                              ? Icons
                                  .check_circle
                              : Icons
                                  .notifications,
                          color:
                              r.completado
                                  ? Colors
                                      .green
                                  : Colors
                                      .purple,
                        ),
                        title:
                            Text(
                          r.titulo,
                        ),
                        subtitle:
                            Text(
                          '${r.fecha.day}/${r.fecha.month}/${r.fecha.year}',
                        ),
                        onTap:
                            () async {
                          r.completado =
                              !r.completado;

                          await r.save();

                          cargar();
                        },
                        trailing:
                            IconButton(
                          icon:
                              const Icon(
                            Icons
                                .delete,
                          ),
                          onPressed:
                              () async {
                            await ReminderService
                                .eliminar(
                              index,
                            );

                            cargar();
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}