import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'scroll_keys.dart';
import 'common.dart';

class NavBar extends StatelessWidget {
  final bool scrolled;
  const NavBar({super.key, required this.scrolled});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 750;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 48, vertical: 16),
      decoration: BoxDecoration(
        color: scrolled ? kBg.withValues(alpha: 0.96) : Colors.transparent,
        border: scrolled ? const Border(bottom: BorderSide(color: kBorder)) : null,
        boxShadow: scrolled
            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 24)]
            : [],
      ),
      child: isMobile ? _MobileNav() : _DesktopNav(),
    );
  }
}

Widget _buildLogo() => Row(mainAxisSize: MainAxisSize.min, children: [
  Container(
    width: 32, height: 32,
    decoration: const BoxDecoration(
      gradient: kRedGold,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.play_arrow_rounded, color: kWhite, size: 18),
  ),
  const SizedBox(width: 10),
  RichText(text: TextSpan(children: [
    TextSpan(text: 'Edit',
      style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w800, color: kWhite)),
    TextSpan(text: 'Pro',
      style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w800, color: kRed)),
    TextSpan(text: ' Academy',
      style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w400, color: kTextMuted)),
  ])),
]);

class _DesktopNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(children: [
    _buildLogo(),
    const Spacer(),
    _Link('Home',     () => scrollTo(heroKey)),
    const SizedBox(width: 32),
    _Link('Courses',  () => scrollTo(coursesKey)),
    const SizedBox(width: 32),
    _Link('Why Us',   () => scrollTo(featuresKey)),
    const SizedBox(width: 32),
    _Link('Contact',  () => scrollTo(footerKey)),
    const SizedBox(width: 28),
    GradientButton(
      label: 'Enroll Now',
      onTap: () => scrollTo(coursesKey),
      gradient: kRedGold,
      icon: Icons.arrow_forward_rounded,
    ),
  ]);
}

class _MobileNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(children: [
    _buildLogo(),
    const Spacer(),
    PopupMenuButton<String>(
      icon: const Icon(Icons.menu_rounded, color: kWhite, size: 26),
      color: kBg3,
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: kBorder),
      ),
      onSelected: (v) {
        if (v == 'home')     scrollTo(heroKey);
        if (v == 'courses')  scrollTo(coursesKey);
        if (v == 'why')      scrollTo(featuresKey);
        if (v == 'contact')  scrollTo(footerKey);
      },
      itemBuilder: (_) => [
        _item('home',    Icons.home_rounded,          'Home'),
        _item('courses', Icons.play_lesson_rounded,   'Courses'),
        _item('why',     Icons.star_rounded,          'Why Us'),
        _item('contact', Icons.mail_rounded,          'Contact'),
      ],
    ),
  ]);

  PopupMenuItem<String> _item(String val, IconData icon, String label) =>
    PopupMenuItem(value: val, child: Row(children: [
      Icon(icon, size: 16, color: kRed),
      const SizedBox(width: 10),
      Text(label, style: GoogleFonts.spaceGrotesk(color: kText, fontWeight: FontWeight.w600)),
    ]));
}

class _Link extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _Link(this.label, this.onTap);
  @override
  State<_Link> createState() => _LinkState();
}
class _LinkState extends State<_Link> {
  bool _h = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _h = true),
    onExit:  (_) => setState(() => _h = false),
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: GoogleFonts.spaceGrotesk(
          fontSize: 14, fontWeight: FontWeight.w600,
          color: _h ? kWhite : kTextMuted,
        ),
        child: Text(widget.label),
      ),
    ),
  );
}
