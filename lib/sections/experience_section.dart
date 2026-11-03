import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_data.dart';
import '../models/experience_item.dart';
import '../widgets/common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  final List<ExperienceItem>? items;

  const ExperienceSection({super.key, this.items});

  List<ExperienceItem> get _data =>
      items ??
      AppData.experience.map((m) => ExperienceItem.fromMap(m)).toList();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 768;
        final list = _data;

        return Container(
          color: AppColors.background,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 60.w : 16.w,
            vertical: isDesktop ? 80.h : 48.h,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100.w),
              child: Column(
                children: [
                  const SectionTitle(
                    title: 'Work Experience',
                    subtitle: 'Proven track record across production apps, client products, and systems engineering',
                  ),
                  SizedBox(height: isDesktop ? 56.h : 36.h),
                  ...list.asMap().entries.map((entry) {
                    final index = entry.key;
                    final exp = entry.value;
                    return _TimelineItem(
                          item: exp,
                          isLast: index == list.length - 1,
                          isDesktop: isDesktop,
                        )
                        .animate()
                        .fadeIn(
                          duration: 450.ms,
                          delay: Duration(milliseconds: 80 * index),
                        )
                        .slideX(begin: 0.05, end: 0);
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final ExperienceItem item;
  final bool isLast;
  final bool isDesktop;

  const _TimelineItem({
    required this.item,
    required this.isLast,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    // Aligns the indicator dot with the card's top title baseline
    final dotTop = isDesktop ? 26.h : 20.h;
    final dotLeft = isDesktop ? 12.w : 4.w;
    final lineLeft = isDesktop ? 22.w : 14.w;
    final cardPaddingLeft = isDesktop ? 54.w : 36.w;
    final bottomMargin = isLast ? 0.0 : (isDesktop ? 32.h : 20.h);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (!isLast)
          Positioned(
            top: dotTop + 22,
            bottom: 0,
            left: lineLeft,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    item.isCurrent
                        ? AppColors.secondary.withAlpha(160)
                        : AppColors.borderLight,
                    AppColors.borderLight.withAlpha(30),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        Positioned(
          top: dotTop,
          left: dotLeft,
          child: _TimelineDot(isCurrent: item.isCurrent),
        ),
        Padding(
          padding: EdgeInsets.only(left: cardPaddingLeft, bottom: bottomMargin),
          child: _ExperienceCard(item: item, isDesktop: isDesktop),
        ),
      ],
    );
  }
}

class _TimelineDot extends StatelessWidget {
  final bool isCurrent;

  const _TimelineDot({required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isCurrent ? AppColors.primaryGradient : null,
        color: isCurrent ? null : AppColors.surfaceLight,
        border: Border.all(
          color: isCurrent ? AppColors.secondary : AppColors.borderLight,
          width: 2,
        ),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: AppColors.secondary.withAlpha(120),
                  blurRadius: 12,
                ),
              ]
            : null,
      ),
      child: Center(
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCurrent ? Colors.white : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final ExperienceItem item;
  final bool isDesktop;

  const _ExperienceCard({required this.item, required this.isDesktop});

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final isDesktop = widget.isDesktop;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -3.h : 0, 0),
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
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? AppColors.primary.withAlpha(50)
                  : Colors.black.withAlpha(50),
              blurRadius: _hovered ? 20.r : 8.r,
              offset: Offset(0, _hovered ? 6.h : 3.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _TitleBlock(item: item)),
                  SizedBox(width: 12.w),
                  _PeriodBadge(period: item.period, isCurrent: item.isCurrent),
                ],
              )
            else ...[
              _TitleBlock(item: item),
              SizedBox(height: 10.h),
              _PeriodBadge(period: item.period, isCurrent: item.isCurrent),
            ],
            SizedBox(height: 14.h),
            Text(
              item.description,
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
                height: 1.6,
              ),
            ),
            SizedBox(height: 16.h),
            ...item.achievements.map((text) => _BulletPoint(text: text)),
          ],
        ),
      ),
    );
  }
}

class _TitleBlock extends StatelessWidget {
  final ExperienceItem item;

  const _TitleBlock({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientText(
          item.role,
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
              item.company,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.textMuted,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              item.location,
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

class _PeriodBadge extends StatelessWidget {
  final String period;
  final bool isCurrent;

  const _PeriodBadge({required this.period, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isCurrent
            ? AppColors.primary.withAlpha(35)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isCurrent
              ? AppColors.primary.withAlpha(120)
              : AppColors.borderLight,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCurrent) ...[
            Container(
              width: 6,
              height: 6,
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

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
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
              text,
              style: GoogleFonts.inter(
                color: AppColors.textPrimary,
                fontSize: 13.sp,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
