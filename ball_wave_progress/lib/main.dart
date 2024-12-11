import 'package:ball_wave_progress/painters/progress_painter.dart';
import 'package:ball_wave_progress/painters/wave_painter.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xFF003366),
          body: SafeArea(child: CircularWaveProgress()),
        ),
      );
}

class CircularWaveProgress extends StatefulWidget {
  const CircularWaveProgress({super.key});

  @override
  State<StatefulWidget> createState() => _CircularWaveProgressState();
}

class _CircularWaveProgressState extends State<CircularWaveProgress> with TickerProviderStateMixin {
  late final ValueNotifier<double> _progress;
  late final AnimationController _progressController;
  late final AnimationController _waveController;
  late final Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _waveController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _progress = ValueNotifier<double>(_progressController.value);

    /// to speed up the wave animation, increase tween range
    _waveAnimation = Tween(begin: 0.0, end: 5.0).animate(_waveController);
    _progressController.addListener(_progressListener);
    _waveController.repeat();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _waveController.dispose();
    _progress.dispose();
    super.dispose();
  }

  void _progressListener() {
    _progress.value = _progressController.value;
    if (_progress.value == 1) setState(() {});
  }

  void _runAnimation() {
    _progressController.forward();
    setState(() {});
  }

  void _refreshAnimation() {
    _progressController.reset();
    setState(() {});
  }

  void _stopAnimation() {
    _progressController.stop();
    setState(() {});
  }

  IconData get _icon {
    if (_progressController.isAnimating) return Icons.stop_rounded;
    if (_progressController.isCompleted) return Icons.refresh_rounded;
    return Icons.play_arrow_rounded;
  }

  VoidCallback get _callback {
    if (_progressController.isAnimating) return _stopAnimation;
    if (_progressController.isCompleted) return _refreshAnimation;
    return _runAnimation;
  }

  Color get _buttonColor {
    if (_progressController.isAnimating) return const Color(0xFFF44336);
    if (_progressController.isCompleted) return const Color(0xFF2196F3);
    return const Color(0xFF4CAF50);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SphericalWaterRippleProgressBar(
                progress: _progress,
                waveAnimation: _waveAnimation,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
              iconSize: 77,
              onPressed: _callback,
              icon: Icon(_icon, color: _buttonColor),
            ),
          ),
        ],
      ),
    );
  }
}

class SphericalWaterRippleProgressBar extends StatelessWidget {
  const SphericalWaterRippleProgressBar({
    super.key,
    required ValueNotifier<double> progress,
    required Animation<double> waveAnimation,
  })  : _progress = progress,
        _waveAnimation = waveAnimation;

  final ValueNotifier<double> _progress;
  final Animation<double> _waveAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => CustomPaint(
        size: constraints.biggest,
        painter: WavePainter(
          progress: _progress,
          waveAnimation: _waveAnimation,
          circleRadius: constraints.biggest.shortestSide / 2,
        ),
        foregroundPainter: ProgressPainter(
          progress: _progress,
          circleRadius: constraints.biggest.shortestSide / 2,
        ),
      ),
    );
  }
}
