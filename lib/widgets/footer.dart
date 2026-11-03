import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_data.dart';
import '../models/social_link_item.dart';
import '../services/url_launcher_service.dart';

/// Production-ready, modular Footer widget for Flutter Web.
/// Strictly adheres to Clean Architecture, Web UX standards, and performance isolation.
class Footer extends StatelessWidget {
  final UrlLauncherService _launcherService;
  final List<SocialLinkItem>? _customSocialItems;

  const Footer({
    super.key,
    UrlLauncherService? launcherService,
    List<SocialLinkItem>? socialItems,
  }) : _launcherService = launcherService ?? const UrlLauncherService(),
       _customSocialItems = socialItems;

  List<SocialLinkItem> get _defaultSocialItems => const [
    SocialLinkItem(
      label: 'WhatsApp',
      url: AppData.whatsappUrl,
      faIcon: FontAwesomeIcons.whatsapp,
      activeColor: AppColors.whatsapp,
      semanticLabel: 'Chat directly on WhatsApp at ${AppData.phone}',
    ),
    SocialLinkItem(
      label: 'GitHub',
      url: AppData.github,
      faIcon: FontAwesomeIcons.github,
      semanticLabel: 'Visit Sabin Dahal GitHub profile',
    ),
    SocialLinkItem(
      label: 'LinkedIn',
      url: AppData.linkedin,
      faIcon: FontAwesomeIcons.linkedin,
      semanticLabel: 'Connect on LinkedIn',
    ),
    SocialLinkItem(
      label: 'Email',
      url: 'mailto:${AppData.email}',
      icon: Icons.email_rounded,
      semanticLabel: 'Send email to ${AppData.email}',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;
    final items = _customSocialItems ?? _defaultSocialItems;

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
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 1, color: AppColors.border),
              const SizedBox(height: 32),
              if (isDesktop)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _FooterBrand(),
                    const _FooterCopyright(),
                    _FooterSocialRow(
                      items: items,
                      onItemTap: _launcherService.launch,
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    const _FooterBrand(),
                    const SizedBox(height: 18),
                    _FooterSocialRow(
                      items: items,
                      onItemTap: _launcherService.launch,
                    ),
                    const SizedBox(height: 18),
                    const _FooterCopyright(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Modular brand identifier widget with cached const styling
class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
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
          '— ${AppData.name}',
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Modular copyright notice widget
class _FooterCopyright extends StatelessWidget {
  const _FooterCopyright();

  @override
  Widget build(BuildContext context) {
    return Text(
      '© 2026 ${AppData.name} • Built with Flutter Web',
      style: GoogleFonts.inter(color: AppColors.textMuted, fontSize: 12),
    );
  }
}

/// Modular collection of social icons delegating action via callback
class _FooterSocialRow extends StatelessWidget {
  final List<SocialLinkItem> items;
  final ValueChanged<String> onItemTap;

  const _FooterSocialRow({required this.items, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items
          .map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: _FooterIconButton(
                item: item,
                onTap: () => onItemTap(item.url),
              ),
            );
          })
          .toList(growable: false),
    );
  }
}

/// Performance-isolated micro-widget managing localized hover state.
/// Ensures that cursor hover animations re-render only this 36x36 pixel area.
class _FooterIconButton extends StatefulWidget {
  final SocialLinkItem item;
  final VoidCallback onTap;

  const _FooterIconButton({required this.item, required this.onTap});

  @override
  State<_FooterIconButton> createState() => _FooterIconButtonState();
}

class _FooterIconButtonState extends State<_FooterIconButton> {
  bool _hovered = false;

  void _setHovered(bool value) {
    if (_hovered != value) {
      setState(() => _hovered = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.item.activeColor ?? AppColors.secondary;
    final item = widget.item;

    return Semantics(
      button: true,
      enabled: true,
      label: item.semanticLabel ?? 'Open ${item.label}',
      child: Tooltip(
        message: item.label,
        child: MouseRegion(
          cursor: SystemMouseCursors.click, // Web pointer affordance
          onEnter: (_) => _setHovered(true),
          onExit: (_) => _setHovered(false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _hovered
                    ? activeColor.withAlpha(35)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _hovered
                      ? activeColor.withAlpha(100)
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: item.faIcon != null
                  ? FaIcon(
                      item.faIcon,
                      color: _hovered ? activeColor : AppColors.textMuted,
                      size: 15,
                    )
                  : Icon(
                      item.icon,
                      color: _hovered ? activeColor : AppColors.textMuted,
                      size: 16,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
