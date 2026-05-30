import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

// ── Gradient text ─────────────────────────────────────────────
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  const GradientText(this.text, {super.key, required this.style, required this.gradient});

  @override
  Widget build(BuildContext context) => ShaderMask(
    shaderCallback: (b) => gradient.createShader(b),
    child: Text(text, style: style.copyWith(color: kWhite)),
  );
}

// ── Glowing pill tag ─────────────────────────────────────────
class GlowTag extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  const GlowTag({super.key, required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.15), blurRadius: 12)],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[Icon(icon, size: 12, color: color), const SizedBox(width: 6)],
        Text(label.toUpperCase(),
          style: GoogleFonts.spaceGrotesk(fontSize: 10, color: color,
            fontWeight: FontWeight.w700, letterSpacing: 1.5)),
      ]),
    );
  }
}

// ── Gradient button ───────────────────────────────────────────
class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Gradient gradient;
  final bool large;
  final IconData? icon;
  const GradientButton({super.key, required this.label, required this.onTap,
    required this.gradient, this.large = false, this.icon});
  @override
  State<GradientButton> createState() => _GradientButtonState();
}
class _GradientButtonState extends State<GradientButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          padding: EdgeInsets.symmetric(
            horizontal: widget.large ? 32 : 22,
            vertical:   widget.large ? 16 : 11,
          ),
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [BoxShadow(
              color: kRed.withValues(alpha: _hovered ? 0.5 : 0.25),
              blurRadius: _hovered ? 28 : 14,
              offset: const Offset(0, 6),
            )],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, size: widget.large ? 18 : 14, color: kWhite),
              const SizedBox(width: 8),
            ],
            Text(widget.label, style: GoogleFonts.spaceGrotesk(
              fontSize: widget.large ? 15 : 13,
              fontWeight: FontWeight.w700,
              color: kWhite,
            )),
          ]),
        ),
      ),
    );
  }
}

// ── Ghost button ──────────────────────────────────────────────
class GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;
  const GhostButton({super.key, required this.label, required this.onTap, required this.color});
  @override
  State<GhostButton> createState() => _GhostButtonState();
}
class _GhostButtonState extends State<GhostButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          decoration: BoxDecoration(
            color: _hovered ? widget.color.withValues(alpha: 0.08) : Colors.transparent,
            border: Border.all(color: _hovered ? widget.color : widget.color.withValues(alpha: 0.35)),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(widget.label, style: GoogleFonts.spaceGrotesk(
            fontSize: 14, fontWeight: FontWeight.w600, color: widget.color)),
        ),
      ),
    );
  }
}

// ── Animated fade-in on scroll ─────────────────────────────────
class FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;
  const FadeInWidget({super.key, required this.child, this.delay = Duration.zero});
  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}
class _FadeInWidgetState extends State<FadeInWidget> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide   = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(widget.delay, () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _opacity,
    child: SlideTransition(position: _slide, child: widget.child),
  );
}

// ── Noise/grid background painter ────────────────────────────
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..strokeWidth = 0.5;
    const step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  @override
  bool shouldRepaint(_) => false;
}
