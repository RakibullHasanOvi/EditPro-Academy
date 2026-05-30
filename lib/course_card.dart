import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'course_data.dart';

class CourseCard extends StatefulWidget {
  final CourseModel course;
  final int index;
  const CourseCard({super.key, required this.course, required this.index});
  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _scale = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final c = widget.course;

    return MouseRegion(
      onEnter: (_) { setState(() => _hovered = true);  _ctrl.forward(); },
      onExit:  (_) { setState(() => _hovered = false); _ctrl.reverse(); },
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: kBg2,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: _hovered ? c.accent.withOpacity(0.5) : kBorder,
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [BoxShadow(color: c.accent.withOpacity(0.18), blurRadius: 40, spreadRadius: 2)]
                : [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 16)],
          ),
          child: Stack(
            children: [
              // Background glow
              Positioned(top: -60, right: -40,
                child: Container(
                  width: 180, height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c.accent.withOpacity(0.04),
                  ),
                )),

              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    // Tag + emoji
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: c.accent.withOpacity(0.1),
                          border: Border.all(color: c.accent.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(c.tag, style: GoogleFonts.spaceGrotesk(
                          fontSize: 10, color: c.accent,
                          fontWeight: FontWeight.w700, letterSpacing: 1.5)),
                      ),
                      const Spacer(),
                      Text(c.emoji, style: const TextStyle(fontSize: 28)),
                    ]),
                    const SizedBox(height: 16),

                    // Title
                    Text(c.title, style: GoogleFonts.spaceGrotesk(
                      fontSize: 22, fontWeight: FontWeight.w800, color: kWhite, height: 1.2)),
                    Text(c.subtitle, style: GoogleFonts.spaceGrotesk(
                      fontSize: 14, fontWeight: FontWeight.w500, color: c.accent)),
                    const SizedBox(height: 12),

                    // Description
                    Text(c.description, style: GoogleFonts.dmSans(
                      fontSize: 13, color: kTextMuted, height: 1.65)),
                    const SizedBox(height: 20),

                    // Income badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [c.accent.withOpacity(0.15), c.accent.withOpacity(0.05)]),
                        border: Border.all(color: c.accent.withOpacity(0.25)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.trending_up_rounded, size: 14, color: c.accent),
                        const SizedBox(width: 6),
                        Text(c.income, style: GoogleFonts.spaceGrotesk(
                          fontSize: 12, color: c.accent, fontWeight: FontWeight.w700)),
                      ]),
                    ),
                    const SizedBox(height: 20),

                    // Duration & Fee
                    Row(children: [
                      _Pill(icon: Icons.timer_outlined,    label: c.duration, color: kTextMuted),
                      const SizedBox(width: 10),
                      _Pill(icon: Icons.account_balance_wallet_outlined, label: c.fee, color: kGold),
                    ]),
                    const SizedBox(height: 20),

                    // Topics
                    Wrap(spacing: 8, runSpacing: 8,
                      children: c.topics.map((t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.04),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(t, style: GoogleFonts.dmSans(fontSize: 11, color: kTextMuted)),
                      )).toList()),
                    const SizedBox(height: 24),

                    // CTA button
                    SizedBox(
                      width: double.infinity,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _hovered
                                ? [c.accent, c.accent.withOpacity(0.7)]
                                : [c.accent.withOpacity(0.8), c.accent.withOpacity(0.5)]),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: _hovered
                              ? [BoxShadow(color: c.accent.withOpacity(0.4), blurRadius: 20)]
                              : [],
                        ),
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          ),
                          child: Text('Enroll in This Course →',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 13, fontWeight: FontWeight.w700, color: kWhite)),
                        ),
                      ),
                    ),
                  ]),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _Pill({required this.icon, required this.label, required this.color});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, size: 13, color: color),
    const SizedBox(width: 5),
    Text(label, style: GoogleFonts.dmSans(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
  ]);
}
