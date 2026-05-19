import 'package:flutter/material.dart';
import 'package:smooth_ios_style_toggle/smooth_ios_style_toggle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smooth iOS Toggle Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _notifications = true;
  bool _darkMode = false;
  final SmoothToggleController _wifiController =
      SmoothToggleController(value: true);

  @override
  void dispose() {
    _wifiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smooth iOS Toggle')),
      body: SmoothToggleTheme(
        data: const SmoothToggleStyle(
          trackHeight: 34,
          trackWidth: 110,
          animationDuration: Duration(milliseconds: 240),
        ),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Pattern 1: parent setState + per-widget SmoothToggleStyle
            _DemoRow(
              title: 'Notifications',
              subtitle: 'Controlled with setState',
              child: SmoothIOSToggle(
                hapticFeedback: true,
                value: _notifications,
                activeText: 'Online',
                inactiveText: 'Offline',
                onChanged: (v) => setState(() => _notifications = v),
                style: SmoothToggleStyle(
                  trackWidth: 115,
                  trackHeight: 40,
                  trackPadding: 5,
                  activeTrackColor: Colors.deepPurple,
                  inactiveTrackColor: Colors.grey.shade700,
                  activeThumbColor: Colors.white,
                  inactiveThumbColor: Colors.black,
                  activeTextColor: Colors.white,
                  inactiveTextColor: Colors.white,
                ),
                onToggle: () => debugPrint('Notifications toggled!'),
              ),
            ),
            const SizedBox(height: 20),
            // Pattern 2: SmoothToggleController (ValueNotifier) + ValueListenableBuilder
            _DemoRow(
              title: 'Wi‑Fi',
              subtitle: 'SmoothToggleController + ValueListenableBuilder',
              child: ValueListenableBuilder<bool>(
                valueListenable: _wifiController,
                builder: (context, value, _) {
                  return SmoothIOSToggle(
                    value: value,
                    controller: _wifiController,
                    activeText: 'Yes',
                    inactiveText: 'No',
                    onChanged: (v) => _wifiController.value = v,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Pattern 3: labels rendered inside the pill thumb
            _DemoRow(
              title: 'Dark mode',
              subtitle: 'Custom colors & text inside thumb',
              child: SmoothIOSToggle(
                value: _darkMode,
                textInsideThumb: true,
                activeText: 'Dark',
                inactiveText: 'Lite',
                style: SmoothToggleStyle(
                  trackWidth: 116,
                  trackHeight: 36,
                  activeTrackColor: Colors.deepPurple,
                  inactiveTrackColor: Colors.grey.shade300,
                  activeThumbColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  activeTextColor: Colors.deepPurple,
                  inactiveTextColor: Colors.black87,
                ),
                onChanged: (v) => setState(() => _darkMode = v),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoRow extends StatelessWidget {
  const _DemoRow({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
