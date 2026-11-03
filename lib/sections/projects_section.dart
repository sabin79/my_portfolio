import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_data.dart';
import '../widgets/common_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
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
    final project = AppData.projects.first;

    return Container(
      color: AppColors.surface,
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
                title: 'Featured Project',
                subtitle:
                    'Production-grade architecture, live client deployment, and real-time systems',
              ),
              const SizedBox(height: 60),

              // Flagship Project Showcase Card
              _RosheshFutsalShowcase(
                project: project,
                isDesktop: isDesktop,
                onDownloadApk: () => _launch(project['apkUrl'] as String),
                onViewGithub: () => _launch(project['github'] as String),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RosheshFutsalShowcase extends StatelessWidget {
  final Map<String, dynamic> project;
  final bool isDesktop;
  final VoidCallback onDownloadApk;
  final VoidCallback onViewGithub;

  const _RosheshFutsalShowcase({
    required this.project,
    required this.isDesktop,
    required this.onDownloadApk,
    required this.onViewGithub,
  });

  @override
  Widget build(BuildContext context) {
    final highlights = (project['highlights'] as List).cast<String>();
    final tags = (project['tags'] as List).cast<String>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.secondary.withAlpha(90),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(45),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: AppColors.secondary.withAlpha(25),
            blurRadius: 50,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Accent Gradient Strip
            Container(
              height: 6,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(isDesktop ? 44 : 24),
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column: Details & Highlights
                        Expanded(
                          flex: 7,
                          child: _buildDetailsColumn(highlights, tags),
                        ),
                        const SizedBox(width: 48),
                        // Right Column: QR Code & Download Box
                        Expanded(
                          flex: 4,
                          child: _buildQrDownloadCard(context),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailsColumn(highlights, tags),
                        const SizedBox(height: 36),
                        _buildQrDownloadCard(context),
                      ],
                    ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildDetailsColumn(List<String> highlights, List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Badges Row
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withAlpha(30),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF22C55E).withAlpha(120),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Color(0xFF22C55E),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Production Client Project',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF4ADE80),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.secondary.withAlpha(90),
                ),
              ),
              child: Text(
                'v1.0 Live Release',
                style: GoogleFonts.inter(
                  color: AppColors.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Title
        Text(
          project['title'] as String,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: isDesktop ? 30 : 24,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: 12),

        // Summary
        Text(
          project['description'] as String,
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.7,
          ),
        ),

        const SizedBox(height: 24),

        // Key Architectural Highlights
        Text(
          'Key Technical Architectural Achievements:',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),

        const SizedBox(height: 14),

        ...highlights.map(
          (point) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 11,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    point,
                    style: GoogleFonts.inter(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Tech Tags
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.borderLight,
                ),
              ),
              child: Text(
                tag,
                style: GoogleFonts.inter(
                  color: AppColors.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 32),

        // Action Buttons Row
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _ApkDownloadButton(
              onTap: onDownloadApk,
            ),
            _OutlineIconButton(
              label: 'GitHub Release',
              faIcon: FontAwesomeIcons.github,
              onTap: onViewGithub,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQrDownloadCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF161528),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.secondary.withAlpha(100),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(120),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.qr_code_scanner_rounded,
                color: AppColors.secondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Scan QR to Install',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Point your phone camera to download the Android APK instantly',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),

          // High-Res QR Code Image with glow frame
          InkWell(
            onTap: onDownloadApk,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withAlpha(60),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  project['qrImage'] as String,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 200,
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.qr_code, size: 80, color: Colors.black26),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Clickable hint
          GestureDetector(
            onTap: onDownloadApk,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.borderLight,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.touch_app_rounded,
                    color: AppColors.secondary,
                    size: 15,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Or tap here to download APK file',
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApkDownloadButton extends StatefulWidget {
  final VoidCallback onTap;

  const _ApkDownloadButton({ required this.onTap});

  @override
  State<_ApkDownloadButton> createState() => _ApkDownloadButtonState();
}

class _ApkDownloadButtonState extends State<_ApkDownloadButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            gradient: _hovered
                ? const LinearGradient(
                    colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                  )
                : const LinearGradient(
                    colors: [Color(0xFF16A34A), Color(0xFF15803D)],
                  ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF22C55E)
                    .withAlpha(_hovered ? 120 : 60),
                blurRadius: _hovered ? 20 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.download_rounded,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Download Android APK',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlineIconButton extends StatefulWidget {
  final String label;
  final FaIconData? faIcon;
  final IconData? icon;
  final VoidCallback onTap;

  const _OutlineIconButton({
    required this.label,
    this.faIcon,
    this.icon,
    required this.onTap,
  }) : assert(faIcon != null || icon != null);

  @override
  State<_OutlineIconButton> createState() => _OutlineIconButtonState();
}

class _OutlineIconButtonState extends State<_OutlineIconButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.surfaceLight : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: _hovered ? AppColors.secondary : AppColors.borderLight,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.faIcon != null)
                FaIcon(
                  widget.faIcon,
                  color: _hovered ? AppColors.secondary : Colors.white,
                  size: 16,
                )
              else if (widget.icon != null)
                Icon(
                  widget.icon,
                  color: _hovered ? AppColors.secondary : Colors.white,
                  size: 16,
                ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  color: _hovered ? AppColors.secondary : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
