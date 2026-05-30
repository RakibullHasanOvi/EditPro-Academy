import 'package:flutter/material.dart';
import 'colors.dart';

class CourseModel {
  final String tag;
  final String title;
  final String subtitle;
  final String description;
  final String duration;
  final String fee;
  final String emoji;
  final Color accent;
  final List<String> topics;
  final String income;

  const CourseModel({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.duration,
    required this.fee,
    required this.emoji,
    required this.accent,
    required this.topics,
    required this.income,
  });
}

const List<CourseModel> kCourses = [
  CourseModel(
    tag: 'BEGINNER',
    emoji: '🎬',
    accent: kCyan,
    title: 'Faceless YouTube',
    subtitle: 'Cash Cow Blueprint',
    description:
        'Start earning without showing your face. Learn to create viral faceless channels from scratch — niche selection, scripting, voiceover, and basic editing with CapCut & DaVinci.',
    duration: '6 Weeks',
    fee: '৳ 6,500',
    income: 'Earn ৳15k–40k/mo',
    topics: ['Niche Research', 'CapCut Editing', 'AI Voiceover', 'Thumbnail Design', 'Upload Strategy'],
  ),
  CourseModel(
    tag: 'INTERMEDIATE',
    emoji: '🎥',
    accent: kRed,
    title: 'Documentary &',
    subtitle: 'Cinematic Storytelling',
    description:
        'Master the art of documentary-style videos. Learn color grading, cinematic cuts, background music layering, and storytelling techniques that get millions of views.',
    duration: '8 Weeks',
    fee: '৳ 12,000',
    income: 'Earn ৳40k–80k/mo',
    topics: ['DaVinci Resolve', 'Color Grading', 'Sound Design', 'B-roll Editing', 'Premiere Pro'],
  ),
  CourseModel(
    tag: 'ADVANCED',
    emoji: '💰',
    accent: kGold,
    title: 'Cash Cow Agency',
    subtitle: 'Scale to \$5K/Month',
    description:
        'Build and run a full cash cow video agency. Outsource editing, manage multiple channels, automate uploads, and scale your YouTube income to a passive 5-figure business.',
    duration: '10 Weeks',
    fee: '৳ 22,000',
    income: 'Earn ৳1L+/mo',
    topics: ['Agency Setup', 'Client Management', 'Outsourcing', 'YouTube SEO', 'Monetization'],
  ),
];

// Stats shown on hero
const List<Map<String, String>> kStats = [
  {'num': '3,200+', 'label': 'Students Enrolled'},
  {'num': '\$2M+',  'label': 'Student Earnings'},
  {'num': '94%',   'label': 'Success Rate'},
  {'num': '50+',   'label': 'Video Lessons'},
];

// Features/USPs
const List<Map<String, dynamic>> kFeatures = [
  {'icon': Icons.play_circle_filled, 'color': kCyan,   'title': 'Real Project-Based',    'desc': 'Build actual YouTube channels during the course, not just watch theory.'},
  {'icon': Icons.trending_up,        'color': kRed,    'title': 'Income from Day 1',      'desc': 'Learn monetization strategies that work even with a small subscriber count.'},
  {'icon': Icons.smart_toy,          'color': kGold,   'title': 'AI-Powered Workflow',    'desc': 'Use ChatGPT, ElevenLabs & MidJourney to speed up content creation 10x.'},
  {'icon': Icons.groups,             'color': kPurple, 'title': 'Private Community',      'desc': 'Join our exclusive Discord with 1000+ active creators for support.'},
];
