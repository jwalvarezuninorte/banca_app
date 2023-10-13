# Banca App

[Banca App Logo](/assets/icons/banca_icon.svg.png)

## Características Principales

- Registro de usuarios y autenticación (no cifrada).
- Generar simulación de crédito
- Guardar simulación de crédito
- Historial de simulaciones de crédito.

## Configuración del Proyecto

1. Clona este repositorio en tu máquina local:

   ```shell
   git clone https://github.com/jwalvarezuninorte/banca_app
   ```

2. Asegúrate de tener Flutter (3.10.6) y Dart (3.0.6) instalados. Puedes seguir la [documentación oficial de Flutter](https://flutter.dev/docs/get-started/install) para obtener instrucciones de instalación.

3. Abre el proyecto en tu editor de código favorito.

4. Ejecuta el siguiente comando para obtener las dependencias del proyecto:

   ```shell
   flutter pub get
   ```

5. Asegúrate de tener un emulador de Android o iOS configurado, o un dispositivo físico conectado.

6. Ejecuta la aplicación con el siguiente comando:

   ```shell
   flutter run
   ```

## Dependencias

El proyecto utiliza varios paquetes de Flutter y Dart. Algunos de los paquetes clave incluyen:

- [sqflite](https://pub.dev/packages/sqflite): Para el almacenamiento de datos en una base de datos SQLite local.

- [provider](https://pub.dev/packages/provider): Para la gestión del estado de la aplicación.

- [excel](https://pub.dev/packages/excel): Para guardar archivos en formato .xlsx

- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage): Para el almacenamiento seguro de datos sensibles en el dispositivo del usuario.

- [open_filex](https://pub.dev/packages/open_filex): Para abrir archivos con excel (o aplicación predeterminada)

- [path_provider](https://pub.dev/packages/path_provider): Para acceder a la ubicación del sistema de archivos en el dispositivo del usuario.

Puedes encontrar una lista completa de las dependencias en el archivo `pubspec.yaml`.
