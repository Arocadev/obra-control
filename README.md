# ObrasControl

App móvil de gestión de obras y finanzas para profesionales de la construcción | Mobile app for construction work and finance management

---

🇪🇸 **Español**

ObrasControl es una aplicación Android para gestionar obras, tareas, materiales, pagos, cobros, calendario y recordatorios desde el móvil. Diseñada para autónomos y pequeñas empresas del sector de la construcción.

## ✨ Funcionalidades

🏗️ **Gestión de obras** — crea y organiza tus obras con estado, fechas de inicio y fin  
✅ **Tareas** — lista de tareas por obra con seguimiento de completadas y pendientes  
🧱 **Materiales** — registro de materiales con cantidad, precio unitario, total e IVA  
💶 **Economía** — presupuesto, cobrado, pendiente, gastos y beneficio estimado por obra  
💸 **Pagos** — control de pagos a trabajadores con estado pagado/pendiente  
🏦 **Cobros** — registro de cobros por obra con concepto y fecha  
📊 **Resumen** — dashboard con totales globales, gráfica circular y gráfica de barras  
📅 **Calendario** — vista mensual con eventos de obras, pagos, cobros y recordatorios  
🔔 **Recordatorios** — avisos con notificación 1 día antes, 6 horas antes y 1 hora antes  
📄 **PDF** — genera y comparte un resumen en PDF de cada obra  
💾 **Backup** — exporta e importa todos los datos en formato JSON  

## 🛠️ Stack tecnológico

| Capa | Tecnología |
|------|-----------|
| Framework | Flutter 3 + Dart |
| Base de datos local | Hive |
| Gráficas | fl_chart |
| Calendario | table_calendar |
| Notificaciones | flutter_local_notifications |
| PDF | pdf + printing |
| Fuentes | Google Fonts (Inter) |
| Backup | share_plus + file_selector |

## 📁 Estructura del proyecto

```
lib/
├── models/
│   ├── obra.dart
│   ├── tarea.dart
│   ├── material_obra.dart
│   ├── pago.dart
│   ├── cobro.dart
│   ├── recordatorio.dart
│   └── evento_calendario.dart
├── screens/
│   ├── home_screen.dart
│   ├── obras_screen.dart
│   ├── detalle_obra_screen.dart
│   ├── tareas_screen.dart
│   ├── materiales_screen.dart
│   ├── economia_screen.dart
│   ├── finanzas_screen.dart
│   ├── pagos_screen.dart
│   ├── cobros_screen.dart
│   ├── estadisticas_screen.dart
│   ├── calendario_screen.dart
│   ├── eventos_dia_screen.dart
│   ├── eventos_agrupados_screen.dart
│   ├── recordatorios_screen.dart
│   └── formulario_recordatorio_screen.dart
├── services/
│   ├── storage_service.dart
│   ├── backup_service.dart
│   ├── pdf_service.dart
│   ├── notification_service.dart
│   └── reminder_service.dart
├── widgets/
│   ├── tarjeta_evento.dart
│   ├── leyenda_calendario.dart
│   └── selector_recordatorio.dart
└── main.dart
```

## 🚀 Instalación y arranque

```bash
# Clonar el repositorio
git clone https://github.com/Arocadev/obras-control
cd obras-control

# Instalar dependencias
flutter pub get

# Generar adaptadores Hive
dart run build_runner build

# Generar icono
dart run flutter_launcher_icons

# Generar splash
dart run flutter_native_splash:create

# Arrancar la app
flutter run
```

## 📱 Requisitos

- Android 6.0 (API 23) o superior
- Flutter 3.x
- Dart 3.x

## 💾 Backup y restauración de datos

Los datos se almacenan localmente en el dispositivo con Hive. Para no perder los datos al desinstalar la app, usa la función de backup:

- **Exportar** → Pantalla Resumen → menú ··· → Exportar backup
- **Importar** → Pantalla Resumen → menú ··· → Importar backup

---

🇬🇧 **English**

ObrasControl is an Android app to manage construction works, tasks, materials, payments, invoicing, calendar and reminders from your phone. Designed for freelancers and small companies in the construction sector.

## ✨ Features

🏗️ **Work management** — create and organize your works with status and dates  
✅ **Tasks** — task list per work with completed/pending tracking  
🧱 **Materials** — material registry with quantity, unit price, total and VAT  
💶 **Economy** — budget, collected, pending, expenses and estimated profit per work  
💸 **Payments** — payment tracking with paid/pending status  
🏦 **Invoicing** — invoice registry per work with concept and date  
📊 **Summary** — global dashboard with pie chart and bar chart  
📅 **Calendar** — monthly view with work, payment, invoice and reminder events  
🔔 **Reminders** — alerts with notifications 1 day, 6 hours and 1 hour before  
📄 **PDF** — generate and share a PDF summary of each work  
💾 **Backup** — export and import all data in JSON format  

## 🚀 Getting Started

```bash
git clone https://github.com/Arocadev/obras-control
cd obras-control
flutter pub get
dart run build_runner build
flutter run
```

## 👤 Autor / Author

Alejandro Rodríguez Calabuig — [github.com/Arocadev](https://github.com/Arocadev)

## 📄 Licencia / License

Proyecto personal en desarrollo. Personal project under development.
