import 'package:flutter/material.dart';
import '../models/material_obra.dart';
import '../models/obra.dart';

class MaterialesScreen extends StatefulWidget {
  final Obra obra;

  const MaterialesScreen({
    super.key,
    required this.obra,
  });

  @override
  State<MaterialesScreen> createState() =>
      _MaterialesScreenState();
}

class _MaterialesScreenState
    extends State<MaterialesScreen> {
  void crearMaterial() {
    final nombreController =
        TextEditingController();

    final cantidadController =
        TextEditingController();

    final precioController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Nuevo material'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreController,
                  decoration:
                      const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller:
                      cantidadController,
                  keyboardType:
                      const TextInputType
                          .numberWithOptions(
                    decimal: true,
                  ),
                  decoration:
                      const InputDecoration(
                    labelText: 'Cantidad',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: precioController,
                  keyboardType:
                      const TextInputType
                          .numberWithOptions(
                    decimal: true,
                  ),
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Precio unidad (€)',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nombreController.text
                    .trim()
                    .isEmpty) {
                  return;
                }

                final cantidad =
                    double.tryParse(
                          cantidadController
                              .text
                              .replaceAll(
                                ',',
                                '.',
                              ),
                        ) ??
                        0;

                final precio =
                    double.tryParse(
                          precioController.text
                              .replaceAll(
                                ',',
                                '.',
                              ),
                        ) ??
                        0;

                setState(() {
                  widget.obra.materiales.add(
                    MaterialObra(
                      nombre:
                          nombreController
                              .text
                              .trim(),
                      cantidad: cantidad,
                      precioUnidad:
                          precio,
                    ),
                  );
                });

                Navigator.pop(context);
              },
              child:
                  const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void editarMaterial(int index) {
    final material =
        widget.obra.materiales[index];

    final nombreController =
        TextEditingController(
      text: material.nombre,
    );

    final cantidadController =
        TextEditingController(
      text:
          material.cantidad == 0
              ? ''
              : material.cantidad
                  .toString(),
    );

    final precioController =
        TextEditingController(
      text:
          material.precioUnidad == 0
              ? ''
              : material
                  .precioUnidad
                  .toString(),
    );

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title:
              const Text('Editar material'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                TextField(
                  controller:
                      nombreController,
                  decoration:
                      const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller:
                      cantidadController,
                  keyboardType:
                      const TextInputType
                          .numberWithOptions(
                    decimal: true,
                  ),
                  decoration:
                      const InputDecoration(
                    labelText: 'Cantidad',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller:
                      precioController,
                  keyboardType:
                      const TextInputType
                          .numberWithOptions(
                    decimal: true,
                  ),
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Precio unidad (€)',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final cantidad =
                    double.tryParse(
                          cantidadController
                              .text
                              .replaceAll(
                                ',',
                                '.',
                              ),
                        ) ??
                        0;

                final precio =
                    double.tryParse(
                          precioController
                              .text
                              .replaceAll(
                                ',',
                                '.',
                              ),
                        ) ??
                        0;

                setState(() {
                  material.nombre =
                      nombreController
                          .text
                          .trim();

                  material.cantidad =
                      cantidad;

                  material
                          .precioUnidad =
                      precio;
                });

                Navigator.pop(context);
              },
              child:
                  const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> confirmarEliminar(
    String nombre,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(
                'Eliminar material',
              ),
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

  double get total {
    return widget.obra.materiales.fold(
      0,
      (sum, material) =>
          sum + material.total,
    );
  }

  double get totalConIva {
    return widget.obra.materiales.fold(
      0,
      (sum, material) =>
          sum + material.totalConIva,
    );
  }

  @override
  Widget build(BuildContext context) {
    final materiales =
        widget.obra.materiales;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Materiales'),
      ),
      body: Column(
        children: [
          Expanded(
            child: materiales.isEmpty
                ? const Center(
                    child: Text(
                      'No hay materiales',
                    ),
                  )
                : ListView.builder(
                    itemCount:
                        materiales.length,
                    itemBuilder:
                        (context, index) {
                      final material =
                          materiales[index];

                      return Card(
                        margin:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          title: Text(
                            material.nombre,
                          ),
                          subtitle: Text(
                            '${material.cantidad} x ${material.precioUnidad.toStringAsFixed(2)} €',
                          ),
                          trailing:
                              PopupMenuButton<
                                  String>(
                            onSelected:
                                (
                                  value,
                                ) async {
                              if (value ==
                                  'edit') {
                                editarMaterial(
                                  index,
                                );
                              }

                              if (value ==
                                  'delete') {
                                final borrar =
                                    await confirmarEliminar(
                                  material
                                      .nombre,
                                );

                                if (borrar) {
                                  setState(() {
                                    materiales
                                        .removeAt(
                                      index,
                                    );
                                  });
                                }
                              }
                            },
                            itemBuilder:
                                (_) => const [
                              PopupMenuItem(
                                value:
                                    'edit',
                                child: Text(
                                  'Editar',
                                ),
                              ),
                              PopupMenuItem(
                                value:
                                    'delete',
                                child: Text(
                                  'Eliminar',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding:
                const EdgeInsets.all(
              16,
            ),
            child: Column(
              children: [
                Text(
                  'Total: ${total.toStringAsFixed(2)} €',
                  style:
                      const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Total + IVA: ${totalConIva.toStringAsFixed(2)} €',
                  style:
                      const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(
        onPressed: crearMaterial,
        child:
            const Icon(Icons.add),
      ),
    );
  }
}