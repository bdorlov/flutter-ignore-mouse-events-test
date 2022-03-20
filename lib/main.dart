import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    // Hide window title bar
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.setSize(const Size(1200, 800));
    await windowManager
        .setBackgroundColor(const Color.fromARGB(100, 255, 255, 0));
    await windowManager.center();
    await windowManager.setAlwaysOnTop(true);
    windowManager.setIgnoreMouseEvents(false);
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Window manager test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(255, 100, 100, 0.1),
      ),
      home: const MyHomePage(title: 'Window manager test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset _offset = const Offset(0, 0);
  bool isMouseIgnoring = false;

  void handleMouseMovement(event) {
    double dx = event.position.dx;
    double dy = event.position.dy;
    setState(() {
      _offset = Offset(dx, dy);
    });
  }

  void toggleMouseIgnoring() {
    setState(() {
      isMouseIgnoring = !isMouseIgnoring;
      windowManager.setIgnoreMouseEvents(isMouseIgnoring, forward: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: handleMouseMovement,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                isMouseIgnoring ? 'Ignore' : 'Not ignore',
              ),
              Text(
                '$_offset',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleMouseIgnoring,
          tooltip: 'Toggle',
          child: Icon(
              isMouseIgnoring ? Icons.toggle_off_sharp : Icons.toggle_on_sharp),
        ),
      ),
    );
  }
}
