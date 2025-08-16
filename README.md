# mini_task_manager

Flutter project: Mini Task Manager

## App Structure

The project structure is based on clean architecture, and has following directories:
- [config: Manages constants, extensions, services, snackbar, themes, etc]
- [core: Generic response classes, app_routes, widgets i.e. AppText, AppButton, AppLoader, etc]
- [features: Contains features of the app]
    - [auth: Authentication feature]
    - [dashboard: Dashboard feature]

Each feature has following directories:
- [data: Contains data sources, repositories, models, etc]
- [presentation: Contains UI components, custom widgets, cubit directories, etc]

Apart from this, there are following .dart files:
- [exports.dart: All imports are at one place to prevent repetitive actions]
- [firebase_options.dart: Firebase config file]
- [locator_setup.dart: Dependency injection setup]
- [app.dart: Entry point of the app]

## How Firebase is configured

The project is configured to use Firebase via FlutterFire CLI.

Following Services are used:
- [Authentication]
- [Cloud Firestore]

Test credentials:
- [Email: test@yopmail.com]
- [Password: abc123]

## Area(s) where I faced challenges:

- [Flutter form builder]
I've used this plugin for the first time, and I had to search quite a bit to make the best use of it. I've used it for the following features:

- [Login]
- [Signup]
- [Add/Edit task]

- [Cloud Firestore]
I was completely stuck with:

-[updating the "id_done" of a task]
-[deleting a task]

I've searched quite a bit for this and found:

- [At the time of record insertion, I updated the object with a new field "id" and updated it with the existing record, and this is how I was able to perform the operations I was stuck on before]

Lastly, this project is build with Flutter 3.32.8.
Thank You!