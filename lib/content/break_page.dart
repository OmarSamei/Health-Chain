import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BreakPage extends StatelessWidget {
  const BreakPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان الرئيسي
            Text(
              'Short activities to relax',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // كروت النشاطات
            ActivityCard(
              title: 'Breathing Exercise',
              subtitle: 'Simple box breathing to calm your mind',
              frameAsset: 'assets/frames/Frame8.png',
              durations: ['1 min', '1:30', '2 min'],
              steps: const [
                'Sit comfortably, relax shoulders.',
                'Inhale for 4s.',
                'Hold for 4s.',
                'Exhale for 4s.',
                'Hold for 4s.',
              ],
            ),
            const SizedBox(height: 12),
            ActivityCard(
              title: 'Light Stretching',
              subtitle: 'Gentle moves to relax your body',
              frameAsset: 'assets/frames/Frame9.png',
              durations: ['2 min', '3 min'],
              steps: const [
                'Stand straight, relax arms.',
                'Stretch slowly upwards.',
                'Hold position for 5s.',
                'Return gently.',
              ],
            ),
            const SizedBox(height: 12),
            ActivityCard(
              title: 'Quick Meditation',
              subtitle: 'Sit comfortably and focus on your breath',
              frameAsset: 'assets/frames/Frame10.png',
              durations: ['2 min', '3 min', '5 min'],
              steps: const [
                'Sit down comfortably.',
                'Close your eyes and relax.',
                'Take deep breaths slowly.',
                'Focus on inhaling and exhaling.',
              ],
            ),

            const SizedBox(height: 24),

            // العنوان التاني
            Text(
              'Relaxing Music',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // جريد كروت الصوت
            _MusicGrid(
              music: const [
                MusicItem(
                  title: 'Ocean Waves',
                  subtitle: 'Gentle ocean sounds for deep relaxation',
                  imageAsset: 'assets/frames/ocean.png',
                  audioAsset: 'assets/audio/ocean.mp3',
                ),
                MusicItem(
                  title: 'Forest Sounds',
                  subtitle: 'Birds and wind of a peaceful forest',
                  imageAsset: 'assets/frames/forest.png',
                  audioAsset: 'assets/audio/forest.mp3',
                ),
                MusicItem(
                  title: 'Rain Ambience',
                  subtitle: 'Calming rain sounds for a cozy mood',
                  imageAsset: 'assets/frames/rain.png',
                  audioAsset: 'assets/audio/rain.mp3',
                ),
                MusicItem(
                  title: 'Soft Piano',
                  subtitle: 'Slow piano melodies to help you focus',
                  imageAsset: 'assets/frames/piano.png',
                  audioAsset: 'assets/audio/piano.mp3',
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> durations;
  final String frameAsset;
  final List<String> steps;

  const ActivityCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.durations,
    required this.frameAsset,
    required this.steps,
  });

  // فتح البوب أب الجديد
  void _showTimerDialog(BuildContext context, String durationText) {
    int totalSeconds = 0;

    // تحويل النص لثواني
    if (durationText.contains(':')) {
      final parts = durationText.split(':');
      totalSeconds = int.parse(parts[0]) * 60 + int.parse(parts[1]);
    } else {
      totalSeconds = int.parse(durationText.split(' ')[0]) * 60;
    }

    int remainingSeconds = totalSeconds;
    bool started = false;
    Timer? timer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setStateDialog) {
            void startTimer() {
              started = true;
              timer?.cancel();
              timer = Timer.periodic(const Duration(seconds: 1), (t) {
                if (remainingSeconds > 0) {
                  setStateDialog(() => remainingSeconds--);
                } else {
                  timer?.cancel();
                  Navigator.pop(ctx);
                }
              });
            }

            return AlertDialog(
              backgroundColor: Colors.white, // ✅ خليت البوب أب أبيض
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              titlePadding: const EdgeInsets.only(top: 12),
              title: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Duration: $durationText",
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(frameAsset, height: 100), // ✅ صغرت الصور شوية
                    const SizedBox(height: 12),
                    ...List.generate(
                      steps.length,
                      (i) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          '${i + 1}. ${steps[i]}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    started
                        ? Text(
                            " ${_formatTime(remainingSeconds)}",
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: startTimer,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: const Size(double.infinity, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Start",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        timer?.cancel();
                        Navigator.pop(ctx);
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    final Color border = Colors.blue.shade300;

    return InkWell(
      onTap: () => _showTimerDialog(context, durations.first),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border, width: 1.8),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 2),
              color: Color(0x11000000),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان + وصف + المدد الزمنية
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.blue.shade600,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: durations
                        .map(
                          (d) => GestureDetector(
                            onTap: () => _showTimerDialog(context, d),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                d,
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: Colors.blue.shade400),
          ],
        ),
      ),
    );
  }
}

// ========== كود المزيكا المعدل ==========

class _MusicGrid extends StatelessWidget {
  final List<MusicItem> music;
  const _MusicGrid({required this.music});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: music.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72, // ✅ عدلنا النسبة لحل مشكلة الـ overflow
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (_, i) => AudioCard(item: music[i]),
    );
  }
}

class MusicItem {
  final String title;
  final String subtitle;
  final String imageAsset;
  final String audioAsset;

  const MusicItem({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.audioAsset,
  });
}

class AudioCard extends StatefulWidget {
  final MusicItem item;
  const AudioCard({super.key, required this.item});

  @override
  State<AudioCard> createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  late final AudioPlayer _player;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.onPlayerStateChanged.listen((state) {
      final playing = state == PlayerState.playing;
      if (mounted && playing != _isPlaying) {
        setState(() => _isPlaying = playing);
      }
    });
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.play(
        AssetSource(widget.item.audioAsset.replaceFirst('assets/', '')),
      );
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100, width: 1),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 2),
            color: Color(0x11000000),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ صغرنا الصور شوية
            AspectRatio(
              aspectRatio: 16 / 11,
              child: Container(
                color: Colors.blue.shade50,
                child: Image.asset(widget.item.imageAsset, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 6, 10, 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: _togglePlay,
                    child: Icon(
                      _isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: _togglePlay,
                      child: Text(
                        _isPlaying ? 'Pause' : 'Play',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
