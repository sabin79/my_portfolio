import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_data.dart';
import '../widgets/common_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTablet = size.width > 680 && size.width <= 1024;

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 36 : 20),
        vertical: 100,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: Column(
            children: [
              const SectionTitle(
                title: 'Skills & Expertise',
                subtitle:
                    'Specialized in Flutter, modular architecture, and native integrations',
              ),
              const SizedBox(height: 60),

              // Responsive Cards Layout using Wrap for perfect responsive sizing without overflow
              LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = isDesktop
                      ? (constraints.maxWidth - 48) / 3
                      : isTablet
                          ? (constraints.maxWidth - 24) / 2
                          : constraints.maxWidth;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: AppData.skills.asMap().entries.map((entry) {
                      final i = entry.key;
                      final skill = entry.value;
                      return SizedBox(
                        width: cardWidth,
                        child: _SkillCard(
                          category: skill['category'] as String,
                          icon: skill['icon'] as String,
                          items: (skill['items'] as List).cast<String>(),
                          index: i,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final String category;
  final String icon;
  final List<String> items;
  final int index;

  const _SkillCard({
    required this.category,
    required this.icon,
    required this.items,
    required this.index,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        transform: Matrix4.translationValues(0, _hovered ? -5.0 : 0.0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: _hovered
              ? const LinearGradient(
                  colors: [Color(0xFF191830), Color(0xFF1F1B3E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : AppColors.cardGradient,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: _hovered
                ? AppColors.secondary.withAlpha(140)
                : AppColors.borderLight,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? AppColors.primary.withAlpha(60)
                  : Colors.black.withAlpha(70),
              blurRadius: _hovered ? 26 : 14,
              offset: Offset(0, _hovered ? 10 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Category Header
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.border,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.icon,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.category,
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Skill Pills
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.items.map((item) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight.withAlpha(220),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _hovered
                          ? AppColors.secondary.withAlpha(80)
                          : AppColors.border,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    item,
                    style: GoogleFonts.inter(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 500.ms,
          delay: Duration(milliseconds: 80 * widget.index),
        )
        .slideY(begin: 0.15, end: 0);
  }
}
