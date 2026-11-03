import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_data.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

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
    final isDesktop = size.width > 768;

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 40,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Container(height: 1, color: AppColors.border),
              const SizedBox(height: 32),
              isDesktop
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBrand(),
                        _buildCopyright(),
                        _buildSocialRow(),
                      ],
                    )
                  : Column(
                      children: [
                        _buildBrand(),
                        const SizedBox(height: 16),
                        _buildSocialRow(),
                        const SizedBox(height: 16),
                        _buildCopyright(),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrand() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            'SD',
            style: GoogleFonts.spaceMono(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '— Sabin Dahal',
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCopyright() {
    return Text(
      '© 2026 ${AppData.name} • Built with Flutter Web',
      style: GoogleFonts.inter(
        color: AppColors.textMuted,
        fontSize: 12,
      ),
    );
  }

  Widget _buildSocialRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FooterIcon(
          faIcon: FontAwesomeIcons.whatsapp,
          color: AppColors.whatsapp,
          onTap: () => _launch(AppData.whatsappUrl),
        ),
        const SizedBox(width: 14),
        _FooterIcon(
          faIcon: FontAwesomeIcons.github,
          onTap: () => _launch(AppData.github),
        ),
        const SizedBox(width: 14),
        _FooterIcon(
          faIcon: FontAwesomeIcons.linkedin,
          onTap: () => _launch(AppData.linkedin),
        ),
        const SizedBox(width: 14),
        _FooterIcon(
          icon: Icons.email_rounded,
          onTap: () => _launch('mailto:${AppData.email}'),
        ),
      ],
    );
  }
}

class _FooterIcon extends StatefulWidget {
  final FaIconData? faIcon;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? color;

  const _FooterIcon({
    this.faIcon,
    this.icon,
    required this.onTap,
    this.color,
  }) : assert(faIcon != null || icon != null);

  @override
  State<_FooterIcon> createState() => _FooterIconState();
}

class _FooterIconState extends State<_FooterIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.color ?? AppColors.secondary;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _hovered ? activeColor.withAlpha(30) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: widget.faIcon != null
              ? FaIcon(
                  widget.faIcon,
                  color: _hovered ? activeColor : AppColors.textMuted,
                  size: 15,
                )
              : Icon(
                  widget.icon,
                  color: _hovered ? activeColor : AppColors.textMuted,
                  size: 16,
                ),
        ),
      ),
    );
  }
}
