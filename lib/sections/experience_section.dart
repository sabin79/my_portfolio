import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_data.dart';
import '../models/experience_item.dart';
import '../widgets/common_widgets.dart';

/// Production-ready Experience Section built with flutter_screenutil.
/// Strictly enforces Clean Architecture, zero _build* helper methods,
/// dual-platform layout adaptability (Desktop vs. Mobile), and overflow immunity.
class ExperienceSection extends StatelessWidget {
  final List<ExperienceItem>? _customItems;

  const ExperienceSection({
    super.key,
    List<ExperienceItem>? items,
  }) : _customItems = items;

  List<ExperienceItem> get _items =>
      _customItems ??
      AppData.experience
          .map((m) => ExperienceItem.fromMap(m))
          .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 768;
        final horizontalPadding = isDesktop ? 60.w : 16.w;
        final verticalPadding = isDesktop ? 80.h : 48.h;
        final items = _items;

        return Container(
          color: AppColors.background,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SectionTitle(
                    title: 'Work Experience',
                    subtitle:
                        'Proven track record across production apps, client products, and systems engineering',
                  ),
                  SizedBox(height: isDesktop ? 56.h : 36.h),

                  // Declarative list of modular timeline entries
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isLast = index == items.length - 1;

                      return _TimelineEntry(
                        item: item,
                        index: index,
                        isLast: isLast,
                        isDesktop: isDesktop,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Orchestrates an individual timeline step: connects the node, line, and card.
/// Uses a Stack layout to ensure the connecting line matches the card's natural height
/// without triggering tight constraint overflow bugs.
class _TimelineEntry extends StatelessWidget {
  final ExperienceItem item;
  final int index;
  final bool isLast;
  final bool isDesktop;

  const _TimelineEntry({
    required this.item,
    required this.index,
    required this.isLast,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final dotTop = isDesktop ? 26.h : 20.h;
    final dotLeft = isDesktop ? 12.w : 4.w;
    final lineLeft = isDesktop ? 22.w : 14.w;
    final cardLeftPadding = isDesktop ? 54.w : 36.w;
    final itemBottomSpacing = isLast ? 0.0 : (isDesktop ? 32.h : 20.h);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1. Continuous Connecting Line (Rendered for all except the last item)
        if (!isLast)
          Positioned(
            top: dotTop + 22.r,
            bottom: 0,
            left: lineLeft,
            child: _TimelineConnectingLine(
              isCurrent: item.isCurrent,
              lineWidth: 2.w,
            ),
          ),

        // 2. Node Indicator (Dot)
        Positioned(
          top: dotTop,
          left: dotLeft,
          child: _TimelineNodeIndicator(
            isCurrent: item.isCurrent,
            size: 22.r,
          ),
        ),

        // 3. Modular Experience Card (Flexible auto-sizing, 100% overflow proof)
        Padding(
          padding: EdgeInsets.only(
            left: cardLeftPadding,
            bottom: itemBottomSpacing,
          ),
          child: _ExperienceCard(
            item: item,
            isDesktop: isDesktop,
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(
          duration: 500.ms,
          delay: Duration(milliseconds: 100 * index),
        )
        .slideX(begin: 0.08, end: 0);
  }
}

/// Modular vertical connecting line between timeline nodes
class _TimelineConnectingLine extends StatelessWidget {
  final bool isCurrent;
  final double lineWidth;

  const _TimelineConnectingLine({
    required this.isCurrent,
    required this.lineWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: lineWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isCurrent
                ? AppColors.secondary.withAlpha(160)
                : AppColors.borderLight,
            AppColors.borderLight.withAlpha(40),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

/// Modular glowing timeline node with status indicator
class _TimelineNodeIndicator extends StatelessWidget {
  final bool isCurrent;
  final double size;

  const _TimelineNodeIndicator({
    required this.isCurrent,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isCurrent ? AppColors.primaryGradient : null,
        color: isCurrent ? null : AppColors.surfaceLight,
        border: Border.all(
          color: isCurrent ? AppColors.secondary : AppColors.borderLight,
          width: 2.r,
        ),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: AppColors.secondary.withAlpha(120),
                  blurRadius: 14.r,
                ),
              ]
            : [],
      ),
      child: Center(
        child: Container(
          width: (size * 0.38).r,
          height: (size * 0.38).r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCurrent ? Colors.white : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

/// Interactive container with micro-state hover handling and Web affordances
class _ExperienceCard extends StatefulWidget {
  final ExperienceItem item;
  final bool isDesktop;

  const _ExperienceCard({
    required this.item,
    required this.isDesktop,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _hovered = false;

  void _onHover(bool value) {
    if (_hovered != value) {
      setState(() => _hovered = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final isDesktop = widget.isDesktop;

    return Tooltip(
      message: '${item.role} • ${item.company}',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(
            0,
            _hovered ? -4.0.h : 0.0,
            0,
          ),
          padding: EdgeInsets.all(isDesktop ? 26.r : 18.r),
          decoration: BoxDecoration(
            gradient: _hovered
                ? const LinearGradient(
                    colors: [Color(0xFF191830), Color(0xFF1B1936)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : AppColors.cardGradient,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: _hovered
                  ? AppColors.secondary.withAlpha(120)
                  : AppColors.borderLight,
              width: 1.5.r,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.primary.withAlpha(50)
                    : Colors.black.withAlpha(60),
                blurRadius: _hovered ? 22.r : 10.r,
                offset: Offset(0, _hovered ? 8.h : 4.h),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Dual-platform responsive layout
              _ExperienceHeader(
                item: item,
                isDesktop: isDesktop,
              ),

              SizedBox(height: 14.h),

              // Description with soft-wrapping
              _ExperienceDescription(
                description: item.description,
              ),

              SizedBox(height: 16.h),

              // Achievement bullet points
              _AchievementList(
                achievements: item.achievements,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Responsive header: Side-by-side on desktop, stacked on mobile
class _ExperienceHeader extends StatelessWidget {
  final ExperienceItem item;
  final bool isDesktop;

  const _ExperienceHeader({
    required this.item,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _RoleCompanyTitle(
              role: item.role,
              company: item.company,
              location: item.location,
            ),
          ),
          SizedBox(width: 12.w),
          _PeriodBadge(
            period: item.period,
            isCurrent: item.isCurrent,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RoleCompanyTitle(
          role: item.role,
          company: item.company,
          location: item.location,
        ),
        SizedBox(height: 10.h),
        _PeriodBadge(
          period: item.period,
          isCurrent: item.isCurrent,
        ),
      ],
    );
  }
}

/// Modular title component displaying Role and Company metadata
class _RoleCompanyTitle extends StatelessWidget {
  final String role;
  final String company;
  final String location;

  const _RoleCompanyTitle({
    required this.role,
    required this.company,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientText(
          role,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: 4.h),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.w,
          runSpacing: 4.h,
          children: [
            Text(
              company,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 4.r,
              height: 4.r,
              decoration: const BoxDecoration(
                color: AppColors.textMuted,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              location,
              style: GoogleFonts.inter(
                color: AppColors.textMuted,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Modular period badge chip with pulsing live status for active positions
class _PeriodBadge extends StatelessWidget {
  final String period;
  final bool isCurrent;

  const _PeriodBadge({
    required this.period,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isCurrent
            ? AppColors.primary.withAlpha(35)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(
          color: isCurrent
              ? AppColors.primary.withAlpha(120)
              : AppColors.borderLight,
          width: 1.r,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCurrent) ...[
            Container(
              width: 6.r,
              height: 6.r,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.w),
          ],
          Text(
            period,
            style: GoogleFonts.inter(
              color: isCurrent ? AppColors.secondary : AppColors.textSecondary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Modular overview description with soft-wrapping and responsive typography
class _ExperienceDescription extends StatelessWidget {
  final String description;

  const _ExperienceDescription({
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      softWrap: true,
      style: GoogleFonts.inter(
        color: AppColors.textSecondary,
        fontSize: 13.5.sp,
        height: 1.6,
      ),
    );
  }
}

/// Modular list of achievement bullet points
class _AchievementList extends StatelessWidget {
  final List<String> achievements;

  const _AchievementList({
    required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: achievements
          .map((a) => _AchievementBulletItem(achievement: a))
          .toList(growable: false),
    );
  }
}

/// Individual achievement bullet point with wrapped flexible text
class _AchievementBulletItem extends StatelessWidget {
  final String achievement;

  const _AchievementBulletItem({
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 7.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              '▹ ',
              style: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              achievement,
              softWrap: true,
              style: GoogleFonts.inter(
                color: AppColors.textPrimary,
                fontSize: 12.5.sp,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
