import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'course_data.dart';
import 'common.dart';
import 'course_card.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 750;
    final hPad = isMobile ? 24.0 : w * 0.07;

    return Container(
      width: double.infinity,
      color: kBg,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 90),
      child: Column(children: [
        // ── Header ──
        const FadeInWidget(
          child: GlowTag(label: 'Our Courses', color: kCyan, icon: Icons.play_lesson_rounded),
        ),
        const SizedBox(height: 16),
        FadeInWidget(
          delay: const Duration(milliseconds: 100),
          child: Column(children: [
            Text('Pick Your Path to', textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: isMobile ? 30 : 40,
                fontWeight: FontWeight.w800, color: kWhite)),
            ShaderMask(
              shaderCallback: (b) => kRedGold.createShader(b),
              child: Text('YouTube Success', textAlign: TextAlign.center,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: isMobile ? 30 : 40,
                  fontWeight: FontWeight.w800, color: kWhite)),
            ),
          ]),
        ),
        const SizedBox(height: 12),
        FadeInWidget(
          delay: const Duration(milliseconds: 150),
          child: Text(
            'From complete beginner to running a full cash cow agency — we have a course for every level.',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(fontSize: 15, color: kTextMuted, height: 1.6),
          ),
        ),
        const SizedBox(height: 56),

        // ── Cards ──
        isMobile
            ? Column(
                children: kCourses.asMap().entries.map((e) =>
                  FadeInWidget(
                    delay: Duration(milliseconds: 100 * e.key),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: CourseCard(course: e.value, index: e.key),
                    ),
                  ),
                ).toList(),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: kCourses.asMap().entries.map((e) =>
                  Expanded(
                    child: FadeInWidget(
                      delay: Duration(milliseconds: 100 * e.key),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CourseCard(course: e.value, index: e.key),
                      ),
                    ),
                  ),
                ).toList(),
              ),
      ]),
    );
  }
}
