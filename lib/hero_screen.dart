import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'course_data.dart';
import 'scroll_keys.dart';
import 'common.dart';

class HeroScreen extends StatelessWidget {
  const HeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 750;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: kBgGrad),
      child: Stack(
        children: [
          // Grid background
          Positioned.fill(child: CustomPaint(painter: GridPainter())),

          // Glow blobs
          Positioned(top: -120, right: -80,
            child: _Blob(size: 500, color: kRed.withValues(alpha: 0.06))),
          Positioned(top: 100, left: -100,
            child: _Blob(size: 350, color: kCyan.withValues(alpha: 0.05))),
          Positioned(bottom: -60, right: 200,
            child: _Blob(size: 300, color: kGold.withValues(alpha: 0.05))),

          Padding(
            padding: EdgeInsets.fromLTRB(
              isMobile ? 24 : w * 0.07,
              isMobile ? 80 : 110,
              isMobile ? 24 : w * 0.07,
              isMobile ? 60 : 90,
            ),
            child: isMobile ? _MobileHero() : _DesktopHero(),
          ),
        ],
      ),
    );
  }
}

// ── Desktop layout ────────────────────────────────────────────
class _DesktopHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(flex: 55, child: _HeroLeft()),
        const SizedBox(width: 48),
        Expanded(flex: 45, child: _HeroRight()),
      ],
    );
  }
}

// ── Mobile layout ─────────────────────────────────────────────
class _MobileHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const _HeroLeft(center: true),
      const SizedBox(height: 48),
      _HeroRight(),
    ]);
  }
}

// ── Left: text content ────────────────────────────────────────
class _HeroLeft extends StatelessWidget {
  final bool center;
  const _HeroLeft({this.center = false});

  @override
  Widget build(BuildContext context) {
    final align = center ? TextAlign.center : TextAlign.start;
    final cross = center ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return Column(crossAxisAlignment: cross, children: [
      const FadeInWidget(
        delay: Duration(milliseconds: 100),
        child: GlowTag(label: '🎬 Bangladesh\'s #1 YouTube Training', color: kRed),
      ),
      const SizedBox(height: 24),

      FadeInWidget(
        delay: const Duration(milliseconds: 200),
        child: Column(crossAxisAlignment: cross, children: [
          Text('Turn Your\nEditing Skills',
            textAlign: align,
            style: GoogleFonts.spaceGrotesk(
              fontSize: center ? 38 : 52,
              fontWeight: FontWeight.w800,
              color: kWhite, height: 1.1,
            )),
          ShaderMask(
            shaderCallback: (b) => kRedGold.createShader(b),
            child: Text('Into Income.',
              textAlign: align,
              style: GoogleFonts.spaceGrotesk(
                fontSize: center ? 38 : 52,
                fontWeight: FontWeight.w800,
                color: kWhite, height: 1.1,
              )),
          ),
        ]),
      ),
      const SizedBox(height: 20),

      FadeInWidget(
        delay: const Duration(milliseconds: 300),
        child: Text(
          'Learn Faceless YouTube, Documentary Editing & Cash Cow\nAutomation from Bangladesh\'s top creators. Start earning\nin 6 weeks — no camera, no following needed.',
          textAlign: align,
          style: GoogleFonts.dmSans(fontSize: 15, color: kTextMuted, height: 1.75),
        ),
      ),
      const SizedBox(height: 36),

      FadeInWidget(
        delay: const Duration(milliseconds: 400),
        child: Wrap(
          alignment: center ? WrapAlignment.center : WrapAlignment.start,
          spacing: 14, runSpacing: 12,
          children: [
            GradientButton(
              label: 'Start Learning Today',
              onTap: () => scrollTo(coursesKey),
              gradient: kRedGold,
              large: true,
              icon: Icons.play_circle_outline_rounded,
            ),
            GhostButton(
              label: 'View Courses',
              onTap: () => scrollTo(coursesKey),
              color: kCyan,
            ),
          ],
        ),
      ),
      const SizedBox(height: 48),

      // Stats row
      FadeInWidget(
        delay: const Duration(milliseconds: 500),
        child: Wrap(
          alignment: center ? WrapAlignment.center : WrapAlignment.start,
          spacing: 0, runSpacing: 16,
          children: kStats.asMap().entries.map((e) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StatBox(num: e.value['num']!, label: e.value['label']!),
              if (e.key < kStats.length - 1)
                Container(width: 1, height: 40, color: kBorder, margin: const EdgeInsets.symmetric(horizontal: 20)),
            ],
          )).toList(),
        ),
      ),
    ]);
  }
}

class _StatBox extends StatelessWidget {
  final String num, label;
  const _StatBox({required this.num, required this.label});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ShaderMask(
        shaderCallback: (b) => kRedGold.createShader(b),
        child: Text(num, style: GoogleFonts.spaceGrotesk(
          fontSize: 24, fontWeight: FontWeight.w800, color: kWhite)),
      ),
      Text(label, style: GoogleFonts.dmSans(fontSize: 11, color: kTextMuted)),
    ],
  );
}

// ── Right: visual mock player ─────────────────────────────────
class _HeroRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInWidget(
      delay: const Duration(milliseconds: 300),
      child: Column(children: [
        // Main "video player" card
        Container(
          decoration: BoxDecoration(
            color: kBg3,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kBorder),
            boxShadow: [
              BoxShadow(color: kRed.withValues(alpha: 0.1), blurRadius: 40, spreadRadius: 4),
            ],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Fake video thumbnail
            Container(
              height: 180,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A0A0A), kBg3],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Fake waveform bars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [32, 60, 45, 80, 55, 90, 40, 70, 50, 85, 35, 65, 75, 48, 88].map((h) =>
                      Container(
                        width: 6, height: h.toDouble(),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          gradient: kRedGold,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      )
                    ).toList(),
                  ),
                  // Play button
                  Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(
                      color: kRed.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: kRed.withValues(alpha: 0.5), blurRadius: 20)],
                    ),
                    child: const Icon(Icons.play_arrow_rounded, color: kWhite, size: 30),
                  ),
                  // Duration badge
                  Positioned(bottom: 10, right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('3:42', style: GoogleFonts.spaceGrotesk(
                        fontSize: 11, color: kWhite, fontWeight: FontWeight.w600)),
                    )),
                ],
              ),
            ),

            // Video info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('How I Made \$4,200 From One\nFaceless YouTube Channel',
                  style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w700, color: kWhite, height: 1.4)),
                const SizedBox(height: 10),
                const Row(children: [
                  _Chip(label: '2.3M views', color: kGold),
                  SizedBox(width: 8),
                  _Chip(label: 'Cash Cow', color: kCyan),
                ]),
              ]),
            ),
          ]),
        ),

        const SizedBox(height: 16),

        // Bottom two mini cards
        const Row(children: [
          Expanded(child: _MiniCard(
            icon: Icons.auto_awesome_rounded,
            color: kGold,
            title: 'AI Tools',
            sub: 'ElevenLabs · MidJourney',
          )),
          SizedBox(width: 12),
          Expanded(child: _MiniCard(
            icon: Icons.verified_rounded,
            color: kCyan,
            title: 'Certificate',
            sub: 'Industry Recognised',
          )),
        ]),
      ]),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip({required this.label, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      borderRadius: BorderRadius.circular(50),
    ),
    child: Text(label, style: GoogleFonts.dmSans(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
  );
}

class _MiniCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, sub;
  const _MiniCard({required this.icon, required this.color, required this.title, required this.sub});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kBg3,
      border: Border.all(color: kBorder),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(children: [
      Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          border: Border.all(color: color.withValues(alpha: 0.25)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.w700, color: kWhite)),
        Text(sub,   style: GoogleFonts.dmSans(fontSize: 10, color: kTextMuted)),
      ])),
    ]),
  );
}

class _Blob extends StatelessWidget {
  final double size;
  final Color color;
  const _Blob({required this.size, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}
