import 'package:flutter/material.dart';
import '../models/obra.dart';
import '../services/storage_service.dart';
import 'detalle_obra_screen.dart';

class ObrasScreen extends StatefulWidget {
  const ObrasScreen({super.key});

  @override
  State<ObrasScreen> createState() => _ObrasScreenState();
}

class _ObrasScreenState extends State<ObrasScreen> {
  List<Obra> obras = [];

  @override
  void initState() {
    super.initState();
    cargarObras();
  }

  void cargarObras() {
    obras = StorageService.cargarObras();
    setState(() {});
  }

  Future<void> guardarObras() async {
    await StorageService.guardarObras(obras);
  }

  void crearObra() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Nueva obra'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Nombre de la obra',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  obras.add(
                    Obra(
                      nombre: controller.text.trim(),
                    ),
                  );
                });

                await guardarObras();

                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> editarObra(int index) async {
    final controller = TextEditingController(
      text: obras[index].nombre,
    );

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Editar obra'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Nombre de la obra',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  obras[index].nombre =
                      controller.text.trim();
                });

                await guardarObras();

                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> eliminarObra(int index) async {
    setState(() {
      obras.removeAt(index);
    });

    await guardarObras();
  }

  Future<bool> confirmarEliminar(
    String nombre,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title:
                  const Text('Eliminar obra'),
              content: Text(
                '¿Eliminar "$nombre"?',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      false,
                    );
                  },
                  child:
                      const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      true,
                    );
                  },
                  child:
                      const Text('Eliminar'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obras'),
      ),
      body: obras.isEmpty
          ? const Center(
              child: Text(
                'No hay obras todavía',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: obras.length,
              itemBuilder: (context, index) {
                final obra = obras[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(obra.nombre),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetalleObraScreen(
                            obra: obra,
                          ),
                        ),
                      );

                      await guardarObras();

                      setState(() {});
                    },
                    trailing:
                        PopupMenuButton<String>(
                      onSelected:
                          (value) async {
                        if (value ==
                            'edit') {
                          await editarObra(
                            index,
                          );
                        }

                        if (value ==
                            'delete') {
                          final borrar =
                              await confirmarEliminar(
                            obra.nombre,
                          );

                          if (borrar) {
                            await eliminarObra(
                              index,
                            );
                          }
                        }
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: 'edit',
                          child:
                              Text('Editar'),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child:
                              Text('Eliminar'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton:
          FloatingActionButton(
        onPressed: crearObra,
        child: const Icon(Icons.add),
      ),
    );
  }
}