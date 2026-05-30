import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'course_data.dart';
import 'common.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 750;
    final hPad = isMobile ? 24.0 : w * 0.07;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kBg2, kBg],
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 90),
      child: Column(children: [
        FadeInWidget(
          child: GlowTag(label: 'Why EditPro Academy', color: kGold, icon: Icons.star_rounded),
        ),
        const SizedBox(height: 16),
        FadeInWidget(
          delay: const Duration(milliseconds: 100),
          child: ShaderMask(
            shaderCallback: (b) => kCyanPurple.createShader(b),
            child: Text('Built Different.\nResults Guaranteed.',
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: isMobile ? 28 : 38,
                fontWeight: FontWeight.w800, color: kWhite, height: 1.2)),
          ),
        ),
        const SizedBox(height: 56),

        // Feature grid
        isMobile
            ? Column(
                children: kFeatures.asMap().entries.map((e) =>
                  FadeInWidget(
                    delay: Duration(milliseconds: 80 * e.key),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _FeatureCard(data: e.value),
                    ),
                  ),
                ).toList(),
              )
            : Row(
                children: kFeatures.asMap().entries.map((e) =>
                  Expanded(
                    child: FadeInWidget(
                      delay: Duration(milliseconds: 80 * e.key),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _FeatureCard(data: e.value),
                      ),
                    ),
                  ),
                ).toList(),
              ),

        const SizedBox(height: 70),

        // Bottom banner
        FadeInWidget(
          delay: const Duration(milliseconds: 200),
          child: _CtaBanner(),
        ),
      ]),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const _FeatureCard({required this.data});
  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}
class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final Color accent = widget.data['color'] as Color;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: kBg3,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _hovered ? accent.withValues(alpha: 0.4) : kBorder),
          boxShadow: _hovered
              ? [BoxShadow(color: accent.withValues(alpha: 0.12), blurRadius: 28)]
              : [],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              border: Border.all(color: accent.withValues(alpha: 0.25)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(widget.data['icon'] as IconData, color: accent, size: 24),
          ),
          const SizedBox(height: 16),
          Text(widget.data['title'] as String,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15, fontWeight: FontWeight.w700, color: kWhite)),
          const SizedBox(height: 8),
          Text(widget.data['desc'] as String,
            style: GoogleFonts.dmSans(fontSize: 13, color: kTextMuted, height: 1.6)),
        ]),
      ),
    );
  }
}

class _CtaBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 750;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kRed.withOpacity(0.15), kGold.withOpacity(0.08)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kRed.withOpacity(0.2)),
      ),
      child: isMobile
          ? Column(children: [
              _bannerText(center: true),
              const SizedBox(height: 24),
              _bannerBtn(),
            ])
          : Row(children: [
              Expanded(child: _bannerText()),
              _bannerBtn(),
            ]),
    );
  }

  Widget _bannerText({bool center = false}) => Column(
    crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
    children: [
      Text('🔥 Limited Seats — Next Batch Starts Soon!',
        textAlign: center ? TextAlign.center : TextAlign.start,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 20, fontWeight: FontWeight.w800, color: kWhite)),
      const SizedBox(height: 8),
      Text('Only 30 students per batch. Book your spot before it fills up.',
        textAlign: center ? TextAlign.center : TextAlign.start,
        style: GoogleFonts.dmSans(fontSize: 14, color: kTextMuted)),
    ],
  );

  Widget _bannerBtn() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
    decoration: BoxDecoration(
      gradient: kRedGold,
      borderRadius: BorderRadius.circular(50),
      boxShadow: [BoxShadow(color: kRed.withOpacity(0.35), blurRadius: 20)],
    ),
    child: Text('Reserve My Spot →',
      style: GoogleFonts.spaceGrotesk(
        fontSize: 14, fontWeight: FontWeight.w700, color: kWhite)),
  );
}
