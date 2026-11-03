import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Production-ready service encapsulating all external URL, email, and social link launches.
/// Follows Clean Architecture by isolating third-party platform channels from presentation widgets.
class UrlLauncherService {
  const UrlLauncherService();

  static const Set<String> _allowedSchemes = {
    'https',
    'http',
    'mailto',
    'tel',
  };

  /// Safely launches a URL with scheme validation and error handling.
  /// Returns `true` if launched successfully, or `false` on failure.
  Future<bool> launch(
    String urlString, {
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    final trimmed = urlString.trim();
    if (trimmed.isEmpty) {
      debugPrint('[UrlLauncherService] Warning: Attempted to launch empty URL string.');
      return false;
    }

    try {
      final uri = Uri.parse(trimmed);

      // Security check: restrict to safe schemes to prevent XSS / malicious schemes
      if (!uri.hasScheme || !_allowedSchemes.contains(uri.scheme.toLowerCase())) {
        debugPrint('[UrlLauncherService] Blocked unsafe or invalid scheme: ${uri.scheme}');
        return false;
      }

      final canLaunch = await canLaunchUrl(uri);
      if (!canLaunch) {
        debugPrint('[UrlLauncherService] Device cannot open URI: $uri');
        return false;
      }

      return await launchUrl(uri, mode: mode);
    } catch (e, stackTrace) {
      debugPrint('[UrlLauncherService] Exception during launch: $e\n$stackTrace');
      return false;
    }
  }
}

