import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Immutable model representing an interactive social or contact link.
/// Decouples data definitions from presentation rendering.
@immutable
class SocialLinkItem {
  final String label;
  final String url;
  final FaIconData? faIcon;
  final IconData? icon;
  final Color? activeColor;
  final String? semanticLabel;

  const SocialLinkItem({
    required this.label,
    required this.url,
    this.faIcon,
    this.icon,
    this.activeColor,
    this.semanticLabel,
  }) : assert(faIcon != null || icon != null, 'Either faIcon or icon must be provided');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialLinkItem &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          url == other.url &&
          faIcon == other.faIcon &&
          icon == other.icon &&
          activeColor == other.activeColor;

  @override
  int get hashCode => Object.hash(label, url, faIcon, icon, activeColor);
}

