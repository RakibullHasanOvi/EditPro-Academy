import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'scroll_keys.dart';
import 'hero_screen.dart';
import 'courses_screen.dart';
import 'features_screen.dart';
import 'footer_screen.dart';
import 'navbar.dart';

void main() => runApp(const EditProApp());

class EditProApp extends StatelessWidget {
  const EditProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EditPro Academy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kBg,
        colorScheme: const ColorScheme.dark(primary: kRed, secondary: kGold),
        textTheme: GoogleFonts.dmSansTextTheme().apply(
          bodyColor: kText, displayColor: kWhite),
      ),
      home: const _RootPage(),
    );
  }
}

class _RootPage extends StatefulWidget {
  const _RootPage();
  @override
  State<_RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<_RootPage> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    appScroll.addListener(() {
      final s = appScroll.offset > 60;
      if (s != _scrolled) setState(() => _scrolled = s);
    });
  }

  @override
  void dispose() {
    appScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Stack(children: [
        // ── Scrollable content ──
        SingleChildScrollView(
          controller: appScroll,
          child: Column(children: [
            const SizedBox(height: 70),
            HeroScreen(key: heroKey),
            CoursesScreen(key: coursesKey),
            FeaturesScreen(key: featuresKey),
            FooterScreen(key: footerKey),
          ]),
        ),

        // ── Fixed Navbar ──
        Positioned(
          top: 0, left: 0, right: 0,
          child: NavBar(scrolled: _scrolled),
        ),
      ]),
    );
  }
}
