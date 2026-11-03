import 'package:flutter/material.dart';

class AppColors {
  // Background
  static const Color background = Color(0xFF0A0A0F);
  static const Color surface = Color(0xFF12121A);
  static const Color surfaceLight = Color(0xFF1A1A26);
  static const Color cardBg = Color(0xFF14141E);

  // Accent gradient
  static const Color primary = Color(0xFF7C3AED);    // Electric Purple
  static const Color secondary = Color(0xFF06B6D4);  // Cyber Cyan
  static const Color accent = Color(0xFFA855F7);     // Violet
  static const Color whatsapp = Color(0xFF25D366);   // WhatsApp Green

  // Text
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF475569);

  // Border
  static const Color border = Color(0xFF1E1E2E);
  static const Color borderLight = Color(0xFF2A2A3E);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0A0A0F), Color(0xFF12102A), Color(0xFF0A0A0F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF14141E), Color(0xFF1A1A2E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient whatsappGradient = LinearGradient(
    colors: [Color(0xFF25D366), Color(0xFF128C7E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
