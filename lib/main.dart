import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:pomodoro_timer/extensions/build_context_ext.dart';
import 'package:pomodoro_timer/provider/pomodoro_mode.dart';
import 'package:pomodoro_timer/provider/stop_watch_timer.dart';
import 'package:pomodoro_timer/provider/todo_provider.dart';
import 'package:pomodoro_timer/widgets/page_controle_widget.dart';
import 'package:pomodoro_timer/widgets/switch_page_button.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initWindow();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StopWatchTimer(
            presetTime: const Duration(minutes: 25),
            updateInterval: const Duration(seconds: 1),
            countMode: CountMode.countDown,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PomodoroModeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TodoProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> initWindow() async {
  // Window only works on desktop
  if (Platform.isAndroid || Platform.isIOS) {
    return;
  }

  await windowManager.ensureInitialized();
  await Window.initialize();

  await Window.setEffect(effect: WindowEffect.transparent);

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    minimumSize: Size(250, 450),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setHasShadow(false);
    await windowManager.show();
    await windowManager.focus();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroModeProvider>(
      builder: (context, pomodoroMode, child) {
        final appColors = pomodoroMode.getColors();

        return MaterialApp(
          title: 'Pomodoro Timer',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: appColors.$1,
              background: appColors.$1,
              secondary: appColors.$2,
            ),
            fontFamily: "Inconsolata",
            useMaterial3: true,
          ),
          builder: (context, child) {
            if (Platform.isAndroid || Platform.isIOS) {
              return child!;
            }

            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: DragToResizeArea(
                enableResizeEdges: const [
                  ResizeEdge.topLeft,
                  ResizeEdge.top,
                  ResizeEdge.topRight,
                  ResizeEdge.left,
                  ResizeEdge.right,
                  ResizeEdge.bottomLeft,
                  ResizeEdge.bottomLeft,
                  ResizeEdge.bottomRight,
                ],
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: WindowCaption(
                        title: const Text(
                          "Pomodoro Timer",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        backgroundColor: context.colorScheme.background,
                      ),
                    ),
                    Expanded(child: child!),
                  ],
                ),
              ),
            );
          },
          home: MediaQuery.of(context).size.width > 500
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    PageControleWidget(pomodoroMode: pomodoroMode),
                    Positioned(
                      right: 20,
                      child: SwitchPageButton(
                        icon: const Icon(Icons.arrow_forward_rounded),
                        show: pomodoroMode.pomodoroMode ==
                                PomodoroMode.pomodoro ||
                            pomodoroMode.pomodoroMode ==
                                PomodoroMode.shortBreak ||
                            pomodoroMode.pomodoroMode == PomodoroMode.todos,
                        onPressed: () {
                          switch (pomodoroMode.pomodoroMode) {
                            case PomodoroMode.pomodoro:
                              pomodoroMode.changePage(
                                PomodoroMode.shortBreak,
                              );
                              break;
                            case PomodoroMode.todos:
                              pomodoroMode.changePage(
                                PomodoroMode.shortBreak,
                              );
                              break;
                            case PomodoroMode.shortBreak:
                              pomodoroMode.changePage(
                                PomodoroMode.longBreak,
                              );
                              break;
                            default:
                              break;
                          }
                        },
                      ),
                    ),
                    Positioned(
                      left: 20,
                      child: SwitchPageButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        show: pomodoroMode.pomodoroMode ==
                                PomodoroMode.shortBreak ||
                            pomodoroMode.pomodoroMode == PomodoroMode.longBreak,
                        onPressed: () {
                          switch (pomodoroMode.pomodoroMode) {
                            case PomodoroMode.shortBreak:
                              pomodoroMode.changePage(
                                PomodoroMode.pomodoro,
                              );
                              break;
                            case PomodoroMode.longBreak:
                              pomodoroMode.changePage(
                                PomodoroMode.shortBreak,
                              );
                              break;
                            default:
                              break;
                          }
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      child: SwitchPageButton(
                        icon: const Icon(Icons.arrow_downward_rounded),
                        show:
                            pomodoroMode.pomodoroMode == PomodoroMode.pomodoro,
                        onPressed: () {
                          pomodoroMode.changeHomePageState(
                            PomodoroMode.todos,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 20,
                      child: SwitchPageButton(
                        icon: const Icon(Icons.arrow_upward_rounded),
                        show: pomodoroMode.pomodoroMode == PomodoroMode.todos,
                        onPressed: () {
                          pomodoroMode.changeHomePageState(
                            PomodoroMode.pomodoro,
                          );
                        },
                      ),
                    ),
                  ],
                )
              : PageControleWidget(pomodoroMode: pomodoroMode),
        );
      },
    );
  }
}
