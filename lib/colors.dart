import 'package:flutter/material.dart';

// ── Brand Colors (YouTube Cinematic Dark) ──────────────────────
const Color kBg        = Color(0xFF080B10);   // near-black background
const Color kBg2       = Color(0xFF0E1318);   // card bg
const Color kBg3       = Color(0xFF141C24);   // elevated card
const Color kRed       = Color(0xFFFF2D55);   // YouTube-ish red/pink
const Color kRedDark   = Color(0xFFCC1A3D);
const Color kGold      = Color(0xFFFFB800);   // gold accent
const Color kGoldLight = Color(0xFFFFD966);
const Color kCyan      = Color(0xFF00E5FF);   // electric cyan
const Color kCyanDim   = Color(0xFF00B8CC);
const Color kPurple    = Color(0xFF9B5DE5);
const Color kWhite     = Color(0xFFFFFFFF);
const Color kText      = Color(0xFFDDE3ED);
const Color kTextMuted = Color(0xFF6B7A8D);
const Color kBorder    = Color(0xFF1E2A38);

// ── Gradients ──────────────────────────────────────────────────
const LinearGradient kRedGold = LinearGradient(
  colors: [kRed, kGold],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const LinearGradient kCyanPurple = LinearGradient(
  colors: [kCyan, kPurple],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kBgGrad = LinearGradient(
  colors: [kBg, kBg2],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
