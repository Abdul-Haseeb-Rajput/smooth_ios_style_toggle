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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
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
  // setState-controlled
  bool _notifications = true;
  bool _darkMode = false;
  bool _compact = false;

  // Controller
  final SmoothToggleController _wifiController =
      SmoothToggleController(value: true);

  // Large toggle
  bool _premium = false;

  @override
  void dispose() {
    _wifiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smooth iOS Toggle v0.2.0'),
      ),
      body: SmoothToggleTheme(
        data: const SmoothToggleStyle(
          trackHeight: 34,
          trackWidth: 110,
          animationDuration: Duration(milliseconds: 240),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            _IntroBanner(),
            const SizedBox(height: 20),
            _Section(
              title: '1 · setState + custom style',
              subtitle:
                  'thumbWidth, long labels, adaptive text, semanticLabel, onToggle',
              child: _DemoRow(
                label: _notifications ? 'Online' : 'Offline',
                child: SmoothIOSToggle(
                  value: _notifications,
                  activeText: 'Online',
                  inactiveText: 'Offline',
                  hapticFeedback: true,
                  onChanged: (v) => setState(() => _notifications = v),
                  onToggle: () => debugPrint('Notifications toggled'),
                  style: SmoothToggleStyle(
                    trackWidth: 120,
                    trackHeight: 36,
                    thumbWidth: 48,
                    trackPadding: 4,
                    activeTrackColor: Colors.deepPurple,
                    inactiveTrackColor: Colors.grey.shade700,
                    activeThumbColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                    activeTextColor: Colors.white,
                    inactiveTextColor: Colors.white70,
                    semanticLabel: 'Notifications',
                  ),
                ),
              ),
            ),
            _Section(
              title: '2 · SmoothToggleController',
              subtitle: 'ValueNotifier + ValueListenableBuilder',
              child: _DemoRow(
                label: _wifiController.value ? 'Connected' : 'Disconnected',
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
            ),
            _Section(
              title: '3 · Text inside thumb',
              subtitle: 'textInsideThumb + fitted label sizing',
              child: _DemoRow(
                label: _darkMode ? 'Dark' : 'Lite',
                child: SmoothIOSToggle(
                  value: _darkMode,
                  textInsideThumb: true,
                  activeText: 'Dark',
                  inactiveText: 'Lite',
                  onChanged: (v) => setState(() => _darkMode = v),
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
                ),
              ),
            ),
            _Section(
              title: '4 · Theme defaults',
              subtitle:
                  'No per-widget style — uses SmoothToggleTheme (height 34)',
              child: _DemoRow(
                label: 'Themed',
                child: SmoothIOSToggle(
                  value: true,
                  onChanged: (_) {},
                ),
              ),
            ),
            _Section(
              title: '5 · Large toggle (max height)',
              subtitle:
                  'trackHeight 70, custom thumbWidth 90, drag & fitted text',
              child: _DemoRow(
                label: _premium ? 'Premium ON' : 'Premium OFF',
                child: SmoothIOSToggle(
                  value: _premium,
                  activeText: 'Premium',
                  inactiveText: 'Standard',
                  onChanged: (v) => setState(() => _premium = v),
                  style: SmoothToggleStyle(
                    trackWidth: 200,
                    trackHeight: SmoothToggleStyle.maxTrackHeight,
                    thumbWidth: 90,
                    trackPadding: 6,
                    activeTrackColor: Colors.amber.shade700,
                    inactiveTrackColor: Colors.grey.shade600,
                    activeTextColor: Colors.white,
                    inactiveTextColor: Colors.white,
                  ),
                ),
              ),
            ),
            _Section(
              title: '6 · Compact (min height)',
              subtitle: 'trackHeight 25 — smallest validated size',
              child: _DemoRow(
                label: _compact ? 'ON' : 'OFF',
                child: SmoothIOSToggle(
                  value: _compact,
                  activeText: 'ON',
                  inactiveText: 'OFF',
                  onChanged: (v) => setState(() => _compact = v),
                  style: const SmoothToggleStyle(
                    trackHeight: SmoothToggleStyle.minTrackHeight,
                    trackWidth: 88,
                  ),
                ),
              ),
            ),
            _Section(
              title: '7 · Disabled',
              subtitle: 'enabled: false — tap & drag ignored',
              child: _DemoRow(
                label: 'Locked',
                child: SmoothIOSToggle(
                  value: true,
                  enabled: false,
                  activeText: 'ON',
                  inactiveText: 'OFF',
                  onChanged: (_) {},
                ),
              ),
            ),
            _Section(
              title: '8 · No labels',
              subtitle: 'showText: false',
              child: _DemoRow(
                label: 'Minimal',
                child: SmoothIOSToggle(
                  value: true,
                  showText: false,
                  onChanged: (_) {},
                  style: const SmoothToggleStyle(trackWidth: 72),
                ),
              ),
            ),
            _Section(
              title: '9 · Default thumb clamp',
              subtitle: 'Narrow trackWidth 80 — thumb auto-clamped to fit',
              child: _DemoRow(
                label: 'Clamped',
                child: SmoothIOSToggle(
                  value: true,
                  onChanged: (_) {},
                  style: const SmoothToggleStyle(
                    trackWidth: 80,
                    trackHeight: 30,
                  ),
                ),
              ),
            ),
            _Section(
              title: '10 · Keyboard',
              subtitle: 'autofocus — press Space or Enter to toggle',
              child: _KeyboardDemo(),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '0.2.0 feature tour',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Try tap, horizontal drag, and (section 10) keyboard toggling. '
              'Labels scale to fit; thumb width is validated and clamped.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 2),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _DemoRow extends StatelessWidget {
  const _DemoRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatusChip(text: label),
        ),
        const SizedBox(width: 12),
        child,
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}

/// Isolated demo so autofocus does not steal focus from other rows.
class _KeyboardDemo extends StatefulWidget {
  @override
  State<_KeyboardDemo> createState() => _KeyboardDemoState();
}

class _KeyboardDemoState extends State<_KeyboardDemo> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return _DemoRow(
      label: _value ? 'Focused ON' : 'Focused OFF',
      child: SmoothIOSToggle(
        value: _value,
        autofocus: true,
        activeText: 'ON',
        inactiveText: 'OFF',
        onChanged: (v) => setState(() => _value = v),
      ),
    );
  }
}
