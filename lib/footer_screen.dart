import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'scroll_keys.dart';

class FooterScreen extends StatelessWidget {
  const FooterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 750;
    final hPad = isMobile ? 24.0 : w * 0.07;

    return Container(
      color: kBg2,
      child: Column(children: [
        // ── Contact section ──────────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 70),
          child: isMobile
              ? Column(children: [const _ContactLeft(center: true), const SizedBox(height: 40), _ContactRight()])
              : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Expanded(flex: 5, child: _ContactLeft()),
                  const SizedBox(width: 60),
                  Expanded(flex: 4, child: _ContactRight()),
                ]),
        ),

        // ── Bottom bar ───────────────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 24),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: kBorder)),
          ),
          child: isMobile
              ? Column(children: [
                  _logo(), const SizedBox(height: 12),
                  Text('© 2026 EditPro Academy. All rights reserved.',
                    style: GoogleFonts.dmSans(fontSize: 12, color: kTextMuted)),
                  const SizedBox(height: 16),
                  _quickLinks(),
                ])
              : Row(children: [
                  _logo(), const Spacer(),
                  Text('© 2026 EditPro Academy. All rights reserved.',
                    style: GoogleFonts.dmSans(fontSize: 12, color: kTextMuted)),
                  const Spacer(),
                  _quickLinks(),
                ]),
        ),
      ]),
    );
  }

  Widget _logo() => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(
      width: 28, height: 28,
      decoration: const BoxDecoration(gradient: kRedGold, shape: BoxShape.circle),
      child: const Icon(Icons.play_arrow_rounded, color: kWhite, size: 16),
    ),
    const SizedBox(width: 8),
    RichText(text: TextSpan(children: [
      TextSpan(text: 'Edit', style: GoogleFonts.spaceGrotesk(
        fontSize: 16, fontWeight: FontWeight.w800, color: kWhite)),
      TextSpan(text: 'Pro', style: GoogleFonts.spaceGrotesk(
        fontSize: 16, fontWeight: FontWeight.w800, color: kRed)),
    ])),
  ]);

  Widget _quickLinks() => Wrap(spacing: 24, children: [
    _lnk('Home',     () => scrollTo(heroKey)),
    _lnk('Courses',  () => scrollTo(coursesKey)),
    _lnk('Why Us',   () => scrollTo(featuresKey)),
    _lnk('Contact',  () => scrollTo(footerKey)),
  ]);

  Widget _lnk(String label, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Text(label,
      style: GoogleFonts.dmSans(fontSize: 13, color: kTextMuted)),
  );
}

class _ContactLeft extends StatelessWidget {
  final bool center;
  const _ContactLeft({this.center = false});

  @override
  Widget build(BuildContext context) {
    final align = center ? TextAlign.center : TextAlign.start;
    final cross = center ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return Column(crossAxisAlignment: cross, children: [
      ShaderMask(
        shaderCallback: (b) => kRedGold.createShader(b),
        child: Text('Start Your Journey\nToday', textAlign: align,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 32, fontWeight: FontWeight.w800, color: kWhite, height: 1.2)),
      ),
      const SizedBox(height: 16),
      Text('Have questions? Reach out — our team replies within 2 hours.',
        textAlign: align,
        style: GoogleFonts.dmSans(fontSize: 14, color: kTextMuted, height: 1.6)),
      const SizedBox(height: 28),
      const _ContactItem(icon: Icons.email_rounded,       color: kRed,    label: 'info@editproacademy.com'),
      const SizedBox(height: 12),
      const _ContactItem(icon: Icons.phone_rounded,        color: kGold,   label: '+880 1700-000000'),
      const SizedBox(height: 12),
      const _ContactItem(icon: Icons.location_on_rounded,  color: kCyan,   label: 'Mohakhali, Dhaka, Bangladesh'),
      const SizedBox(height: 28),
      // Social icons
      Row(
        mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: const [
          _SocialBtn(icon: Icons.play_circle_fill_rounded, color: kRed,    label: 'YouTube'),
          SizedBox(width: 12),
          _SocialBtn(icon: Icons.camera_alt_rounded,       color: kPurple, label: 'Instagram'),
          SizedBox(width: 12),
          _SocialBtn(icon: Icons.chat_bubble_rounded,      color: kCyan,   label: 'Discord'),
        ],
      ),
    ]);
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  const _ContactItem({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) => Row(children: [
    Container(
      width: 38, height: 38,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 17, color: color),
    ),
    const SizedBox(width: 12),
    Text(label, style: GoogleFonts.dmSans(fontSize: 14, color: kText)),
  ]);
}

class _SocialBtn extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String label;
  const _SocialBtn({required this.icon, required this.color, required this.label});
  @override
  State<_SocialBtn> createState() => _SocialBtnState();
}
class _SocialBtnState extends State<_SocialBtn> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit:  (_) => setState(() => _hovered = false),
    cursor: SystemMouseCursors.click,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: _hovered ? widget.color.withValues(alpha: 0.15) : kBg3,
        border: Border.all(color: _hovered ? widget.color.withValues(alpha: 0.5) : kBorder),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(widget.icon, size: 15, color: widget.color),
        const SizedBox(width: 6),
        Text(widget.label, style: GoogleFonts.spaceGrotesk(
          fontSize: 12, color: kText, fontWeight: FontWeight.w600)),
      ]),
    ),
  );
}

class _ContactRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: kBg3,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorder),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Quick Enquiry', style: GoogleFonts.spaceGrotesk(
          fontSize: 18, fontWeight: FontWeight.w700, color: kWhite)),
        const SizedBox(height: 6),
        Text('We\'ll get back to you within 2 hours.',
          style: GoogleFonts.dmSans(fontSize: 13, color: kTextMuted)),
        const SizedBox(height: 24),
        const _Field(hint: 'Your full name', icon: Icons.person_outline_rounded),
        const SizedBox(height: 14),
        const _Field(hint: 'Email address', icon: Icons.email_outlined),
        const SizedBox(height: 14),
        const _Field(hint: 'Phone number', icon: Icons.phone_outlined),
        const SizedBox(height: 14),
        const _Field(hint: 'Which course interests you?', icon: Icons.school_outlined, multiline: true),
        const SizedBox(height: 22),
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: kRedGold,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [BoxShadow(color: kRed.withValues(alpha: 0.3), blurRadius: 16)],
            ),
            child: Center(child: Text('Send Message →',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14, fontWeight: FontWeight.w700, color: kWhite))),
          ),
        ),
      ]),
    );
  }
}

class _Field extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool multiline;
  const _Field({required this.hint, required this.icon, this.multiline = false});

  @override
  Widget build(BuildContext context) => TextField(
    maxLines: multiline ? 3 : 1,
    style: GoogleFonts.dmSans(fontSize: 14, color: kText),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.dmSans(fontSize: 13, color: kTextMuted),
      prefixIcon: multiline ? null : Icon(icon, size: 18, color: kTextMuted),
      filled: true,
      fillColor: kBg2,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kRed, width: 1.5),
      ),
    ),
  );
}
