import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_data.dart';
import '../widgets/common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 960;
    final isTablet = size.width > 600 && size.width <= 960;

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 36 : 20),
        vertical: 100,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const SectionTitle(
                title: 'Work Experience',
                subtitle: 'Proven track record across production apps, client products, and systems engineering',
              ),
              const SizedBox(height: 64),

              // Timeline list using natural Stack layout to completely prevent bottom overflow
              ...AppData.experience.asMap().entries.map((entry) {
                final i = entry.key;
                final exp = entry.value;
                final isLast = i == AppData.experience.length - 1;

                return _TimelineItem(
                  role: exp['role'] as String,
                  company: exp['company'] as String,
                  location: exp['location'] as String,
                  period: exp['period'] as String,
                  isCurrent: exp['isCurrent'] as bool? ?? false,
                  description: exp['description'] as String,
                  achievements: (exp['achievements'] as List).cast<String>(),
                  index: i,
                  isLast: isLast,
                  isDesktop: isDesktop,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  final String role;
  final String company;
  final String location;
  final String period;
  final bool isCurrent;
  final String description;
  final List<String> achievements;
  final int index;
  final bool isLast;
  final bool isDesktop;

  const _TimelineItem({
    super.key,
    required this.role,
    required this.company,
    required this.location,
    required this.period,
    required this.isCurrent,
    required this.description,
    required this.achievements,
    required this.index,
    required this.isLast,
    required this.isDesktop,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final dotTop = widget.isDesktop ? 32.0 : 22.0;
    final dotLeft = widget.isDesktop ? 13.0 : 5.0;
    final lineLeft = widget.isDesktop ? 23.0 : 15.0;
    final cardLeftPadding = widget.isDesktop ? 56.0 : 40.0;
    final itemBottomSpacing = widget.isLast ? 0.0 : 32.0;

    return Stack(
          clipBehavior: Clip.none,
          children: [
            // 1. Continuous Timeline Connecting Line (automatically matches card's natural height)
            if (!widget.isLast)
              Positioned(
                top: dotTop + 22,
                bottom: 0,
                left: lineLeft,
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.isCurrent
                            ? AppColors.secondary.withAlpha(160)
                            : AppColors.borderLight,
                        AppColors.borderLight.withAlpha(40),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

            // 2. Node Indicator (Dot)
            Positioned(
              top: dotTop,
              left: dotLeft,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: widget.isCurrent ? AppColors.primaryGradient : null,
                  color: widget.isCurrent ? null : AppColors.surfaceLight,
                  border: Border.all(
                    color: widget.isCurrent
                        ? AppColors.secondary
                        : AppColors.borderLight,
                    width: 2,
                  ),
                  boxShadow: widget.isCurrent
                      ? [
                          BoxShadow(
                            color: AppColors.secondary.withAlpha(120),
                            blurRadius: 14,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isCurrent
                          ? Colors.white
                          : AppColors.textMuted,
                    ),
                  ),
                ),
              ),
            ),

            // 3. Main Experience Card (Natural auto-sizing, 100% overflow proof)
            Padding(
              padding: EdgeInsets.only(
                left: cardLeftPadding,
                bottom: itemBottomSpacing,
              ),
              child: MouseRegion(
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 240),
                  transform: Matrix4.translationValues(
                    0,
                    _hovered ? -4.0 : 0.0,
                    0,
                  ),
                  padding: EdgeInsets.all(widget.isDesktop ? 30 : 20),
                  decoration: BoxDecoration(
                    gradient: _hovered
                        ? const LinearGradient(
                            colors: [Color(0xFF191830), Color(0xFF1B1936)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : AppColors.cardGradient,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: _hovered
                          ? AppColors.secondary.withAlpha(120)
                          : AppColors.borderLight,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _hovered
                            ? AppColors.primary.withAlpha(50)
                            : Colors.black.withAlpha(60),
                        blurRadius: _hovered ? 24 : 12,
                        offset: Offset(0, _hovered ? 8 : 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Role, Company, Location & Period
                      widget.isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildRoleCompany(isDesktop: true),
                                ),
                                _buildPeriodBadge(),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRoleCompany(isDesktop: false),
                                const SizedBox(height: 12),
                                _buildPeriodBadge(),
                              ],
                            ),

                      const SizedBox(height: 16),

                      // Role Overview Description
                      Text(
                        widget.description,
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Achievement bullets
                      ...widget.achievements.map((achievement) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  '▹ ',
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  achievement,
                                  style: GoogleFonts.inter(
                                    color: AppColors.textPrimary,
                                    fontSize: 13,
                                    height: 1.55,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(
          duration: 600.ms,
          delay: Duration(milliseconds: 150 * widget.index),
        )
        .slideX(begin: 0.1, end: 0);
  }

  Widget _buildRoleCompany({required bool isDesktop}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          widget.role,
          style: TextStyle(
            fontSize: isDesktop ? 20 : 18,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.company,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.textMuted,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.location,
              style: GoogleFonts.inter(
                color: AppColors.textMuted,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPeriodBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: widget.isCurrent
            ? AppColors.primary.withAlpha(35)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: widget.isCurrent
              ? AppColors.primary.withAlpha(120)
              : AppColors.borderLight,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.isCurrent) ...[
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            widget.period,
            style: GoogleFonts.inter(
              color: widget.isCurrent
                  ? AppColors.secondary
                  : AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
