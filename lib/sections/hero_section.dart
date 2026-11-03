import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_data.dart';
import '../widgets/common_widgets.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onExploreWork;

  const HeroSection({super.key, this.onExploreWork});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse(AppData.whatsappUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 960;
    final isTablet = size.width > 600 && size.width <= 960;

    return Container(
      constraints: BoxConstraints(minHeight: size.height - 80),
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ambient background glow orbs
          Positioned(
            top: -60,
            left: -80,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, _) => Container(
                width: 450,
                height: 450,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withAlpha(
                          (40 + (_pulseController.value * 25)).toInt()),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, _) => Container(
                width: 550,
                height: 550,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.secondary.withAlpha(
                          (30 + (_pulseController.value * 20)).toInt()),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main Hero Grid / Row
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1280),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 60 : (isTablet ? 36 : 20),
                vertical: isDesktop ? 80 : 40,
              ),
              child: isDesktop
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _buildTextContent(isDesktop),
                        ),
                        const SizedBox(width: 48),
                        Expanded(
                          flex: 5,
                          child: _buildFloatingAvatar(isDesktop),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        _buildFloatingAvatar(isDesktop),
                        const SizedBox(height: 44),
                        _buildTextContent(isDesktop),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(bool isDesktop) {
    return Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Available for work pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF161F2E),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: AppColors.secondary.withAlpha(80),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withAlpha(20),
                blurRadius: 16,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
              )
                  .animate(onPlay: (c) => c.repeat())
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.5, 1.5),
                    duration: 1000.ms,
                  )
                  .then()
                  .scale(
                    begin: const Offset(1.5, 1.5),
                    end: const Offset(1, 1),
                    duration: 1000.ms,
                  ),
              const SizedBox(width: 10),
              Text(
                'Available for Senior & Full-time Roles',
                style: GoogleFonts.inter(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3),

        const SizedBox(height: 24),

        // Intro
        Text(
          "Hello, I'm",
          style: GoogleFonts.inter(
            fontSize: isDesktop ? 22 : 18,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 150.ms),

        const SizedBox(height: 8),

        // Name
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            AppData.name,
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 68 : 44,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.05,
              letterSpacing: -1.5,
            ),
          ),
        ).animate().fadeIn(duration: 700.ms, delay: 250.ms).slideX(begin: -0.1),

        const SizedBox(height: 16),

        // Dynamic Role Typewriter
        Wrap(
          alignment:
              isDesktop ? WrapAlignment.start : WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Crafting ',
              style: GoogleFonts.inter(
                fontSize: isDesktop ? 26 : 20,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Scalable Flutter Apps',
                  textStyle: GoogleFonts.inter(
                    fontSize: isDesktop ? 26 : 20,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                  speed: const Duration(milliseconds: 70),
                ),
                TypewriterAnimatedText(
                  'Clean Architecture Code',
                  textStyle: GoogleFonts.inter(
                    fontSize: isDesktop ? 26 : 20,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                  speed: const Duration(milliseconds: 70),
                ),
                TypewriterAnimatedText(
                  'iOS & Android Experiences',
                  textStyle: GoogleFonts.inter(
                    fontSize: isDesktop ? 26 : 20,
                    color: const Color(0xFF38BDF8),
                    fontWeight: FontWeight.w700,
                  ),
                  speed: const Duration(milliseconds: 70),
                ),
                TypewriterAnimatedText(
                  'Resilient BLoC Systems',
                  textStyle: GoogleFonts.inter(
                    fontSize: isDesktop ? 26 : 20,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  speed: const Duration(milliseconds: 70),
                ),
              ],
              totalRepeatCount: 100,
              pause: const Duration(milliseconds: 1400),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms),

        const SizedBox(height: 20),

        // Pitch description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            'Flutter developer with 3+ years of experience engineering mobile applications from architectural design to store release. '
            'Successfully deployed 4 apps on Google Play Store and 2 on Apple App Store.',
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.7,
            ),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms),

        const SizedBox(height: 32),

        // Action Buttons
        Wrap(
          spacing: 16,
          runSpacing: 14,
          alignment:
              isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            GradientButton(
              label: 'View Project',
              icon: Icons.rocket_launch_rounded,
              onPressed: widget.onExploreWork,
            ),
            _WhatsAppHeroButton(
              onTap: _openWhatsApp,
            ),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 650.ms).slideY(begin: 0.2),

        const SizedBox(height: 36),

        // Social Links: GitHub, LinkedIn, WhatsApp, Email
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            _SocialIcon(
              faIcon: FontAwesomeIcons.github,
              tooltip: 'GitHub',
              url: AppData.github,
            ),
            const SizedBox(width: 14),
            _SocialIcon(
              faIcon: FontAwesomeIcons.linkedin,
              tooltip: 'LinkedIn',
              url: AppData.linkedin,
            ),
            const SizedBox(width: 14),
            _SocialIcon(
              faIcon: FontAwesomeIcons.whatsapp,
              tooltip: 'WhatsApp (+977 9861393634)',
              url: AppData.whatsappUrl,
              customColor: AppColors.whatsapp,
            ),
            const SizedBox(width: 14),
            _SocialIcon(
              icon: Icons.email_rounded,
              tooltip: 'Email (dsabin729@gmail.com)',
              url: 'mailto:${AppData.email}',
            ),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
      ],
    );
  }

  // Floating Full Avatar with floating badges like a rich Lottie illustration
  Widget _buildFloatingAvatar(bool isDesktop) {
    final avatarWidth = isDesktop ? 340.0 : 260.0;
    final avatarHeight = isDesktop ? 440.0 : 340.0;

    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final floatValue = math.sin(_floatController.value * math.pi);
        final floatOffset = floatValue * 14.0;
        final floatRotate = math.sin(_floatController.value * math.pi) * 0.015;

        return Transform.translate(
          offset: Offset(0, -floatOffset),
          child: Transform.rotate(
            angle: floatRotate,
            child: child,
          ),
        );
      },
      child: Center(
        child: SizedBox(
          width: avatarWidth + 80,
          height: avatarHeight + 60,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Ambient glow backplate
              Container(
                width: avatarWidth,
                height: avatarHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(70),
                      blurRadius: 50,
                      spreadRadius: 4,
                      offset: const Offset(-8, 8),
                    ),
                    BoxShadow(
                      color: AppColors.secondary.withAlpha(60),
                      blurRadius: 60,
                      spreadRadius: -4,
                      offset: const Offset(8, -8),
                    ),
                  ],
                ),
              ),

              // Full Portrait Image Card (NOT Circle!)
              Container(
                width: avatarWidth,
                height: avatarHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF201B42), Color(0xFF131A36)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: AppColors.secondary.withAlpha(120),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Full portrait image
                      Image.asset(
                        AppData.avatarImage,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.person_rounded,
                              size: 80,
                              color: AppColors.secondary.withAlpha(150),
                            ),
                          );
                        },
                      ),

                      // Vignette / sleek gradient at bottom of avatar for depth
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                const Color(0xFF0A0A0F).withAlpha(180),
                              ],
                              stops: const [0.0, 0.65, 1.0],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Floating Chip 1 (Top-Right): "4 Play Store Apps"
              Positioned(
                top: 15,
                right: isDesktop ? -10 : 0,
                child: _FloatingChip(
                  icon: FontAwesomeIcons.googlePlay,
                  iconColor: const Color(0xFF34A853),
                  title: '4 Apps Published',
                  subtitle: 'Google Play Store',
                  offsetYMultiplier: -0.6,
                  controller: _floatController,
                ),
              ),

              // Floating Chip 2 (Bottom-Left): "2 App Store Apps"
              Positioned(
                bottom: 25,
                left: isDesktop ? -15 : -5,
                child: _FloatingChip(
                  icon: FontAwesomeIcons.apple,
                  iconColor: Colors.white,
                  title: '2 Live on App Store',
                  subtitle: 'iOS Architecture',
                  offsetYMultiplier: 0.8,
                  controller: _floatController,
                ),
              ),

              // Floating Badge 3 (Top-Left): "3+ Yrs Exp"
              Positioned(
                top: 40,
                left: isDesktop ? -20 : -10,
                child: _SmallFloatingBadge(
                  text: '3+ Yrs Exp',
                  icon: Icons.verified_rounded,
                  color: AppColors.primary,
                  controller: _floatController,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 300.ms).scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          curve: Curves.easeOutCubic,
        );
  }
}

class _FloatingChip extends StatelessWidget {
  final FaIconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final double offsetYMultiplier;
  final AnimationController controller;

  const _FloatingChip({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.offsetYMultiplier,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final offset =
            math.sin((controller.value * math.pi) + (offsetYMultiplier * 2)) *
                8.0;
        return Transform.translate(
          offset: Offset(0, offset),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF141324).withAlpha(240),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withAlpha(35),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(160),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: iconColor.withAlpha(35),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: FaIcon(
                  icon,
                  size: 16,
                  color: iconColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallFloatingBadge extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final AnimationController controller;

  const _SmallFloatingBadge({
    required this.text,
    required this.icon,
    required this.color,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final offset =
            math.cos(controller.value * math.pi) * 6.0;
        return Transform.translate(
          offset: Offset(0, offset),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A).withAlpha(240),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: color.withAlpha(120),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(40),
              blurRadius: 14,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 14),
            const SizedBox(width: 6),
            Text(
              text,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhatsAppHeroButton extends StatefulWidget {
  final VoidCallback onTap;

  const _WhatsAppHeroButton({ required this.onTap});

  @override
  State<_WhatsAppHeroButton> createState() => _WhatsAppHeroButtonState();
}

class _WhatsAppHeroButtonState extends State<_WhatsAppHeroButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: AppColors.whatsapp,
              width: 1.5,
            ),
            color: _hovered
                ? AppColors.whatsapp.withAlpha(40)
                : AppColors.whatsapp.withAlpha(18),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.whatsapp.withAlpha(80),
                      blurRadius: 20,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FaIcon(
                FontAwesomeIcons.whatsapp,
                color: AppColors.whatsapp,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                'WhatsApp Me',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final FaIconData? faIcon;
  final IconData? icon;
  final String tooltip;
  final String url;
  final Color? customColor;

  const _SocialIcon({
    this.faIcon,
    this.icon,
    required this.tooltip,
    required this.url,
    this.customColor,
  }) : assert(faIcon != null || icon != null);

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.customColor ?? AppColors.secondary;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(widget.url)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovered
                  ? activeColor.withAlpha(35)
                  : AppColors.surfaceLight,
              border: Border.all(
                color: _hovered ? activeColor : AppColors.border,
                width: 1.5,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: activeColor.withAlpha(80),
                        blurRadius: 16,
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: widget.faIcon != null
                  ? FaIcon(
                      widget.faIcon,
                      color: _hovered ? activeColor : AppColors.textSecondary,
                      size: 18,
                    )
                  : Icon(
                      widget.icon,
                      color: _hovered ? activeColor : AppColors.textSecondary,
                      size: 18,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
