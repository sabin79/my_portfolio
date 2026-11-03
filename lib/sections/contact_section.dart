import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_data.dart';
import '../widgets/common_widgets.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(uri);
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = Uri.encodeComponent(_nameController.text.trim());
      final body = Uri.encodeComponent(
          'Hi Sabin,\n\n${_messageController.text.trim()}\n\nBest,\n${_nameController.text.trim()}\n(${_emailController.text.trim()})');
      final mailtoUri =
          'mailto:${AppData.email}?subject=Portfolio%20Inquiry%20from%20$name&body=$body';

      setState(() => _submitted = true);
      _launch(mailtoUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 960;
    final isTablet = size.width > 600 && size.width <= 960;

    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 36 : 20),
        vertical: 100,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(
                title: 'Get In Touch',
                subtitle:
                    'Let\'s build your next high-impact mobile product together',
              ),
              const SizedBox(height: 64),
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: _buildContactInfo()),
                        const SizedBox(width: 60),
                        Expanded(flex: 6, child: _buildForm()),
                      ],
                    )
                  : Column(
                      children: [
                        _buildContactInfo(),
                        const SizedBox(height: 48),
                        _buildForm(),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          "Let's Build Something Exceptional",
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1.25,
            letterSpacing: -0.5,
          ),
        ).animate().fadeIn(duration: 600.ms),

        const SizedBox(height: 16),

        Text(
          "Whether you need an architect for a new mobile product, need to ship to Google Play Store & Apple App Store, or have questions about Clean Architecture and Flutter, I'd love to connect.",
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.7,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 150.ms),

        const SizedBox(height: 32),

        // WhatsApp direct action box (Highlight)
        InkWell(
          onTap: () => _launch(AppData.whatsappUrl),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF132A1C), Color(0xFF101F18)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.whatsapp.withAlpha(120),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.whatsapp.withAlpha(30),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: AppColors.whatsapp,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Direct WhatsApp',
                        style: GoogleFonts.inter(
                          color: AppColors.whatsapp,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppData.phone,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.whatsapp,
                  size: 16,
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 250.ms),

        const SizedBox(height: 20),

        // Email Item (dsabin729@gmail.com)
        _ContactItem(
          icon: Icons.email_rounded,
          label: 'Email',
          value: AppData.email,
          onTap: () => _launch('mailto:${AppData.email}'),
        ).animate().fadeIn(duration: 500.ms, delay: 350.ms),

        const SizedBox(height: 16),

        // GitHub Item (sabin79)
        _ContactItem(
          faIcon: FontAwesomeIcons.github,
          label: 'GitHub',
          value: 'github.com/sabin79',
          onTap: () => _launch(AppData.github),
        ).animate().fadeIn(duration: 500.ms, delay: 450.ms),

        const SizedBox(height: 16),

        // LinkedIn Item (sabin79)
        _ContactItem(
          faIcon: FontAwesomeIcons.linkedin,
          label: 'LinkedIn',
          value: 'linkedin.com/in/sabin79',
          onTap: () => _launch(AppData.linkedin),
        ).animate().fadeIn(duration: 500.ms, delay: 550.ms),

        const SizedBox(height: 28),

        // Social Icons Row (WhatsApp, GitHub, LinkedIn, Email)
        Row(
          children: [
            _SocialBtn(
              faIcon: FontAwesomeIcons.whatsapp,
              color: AppColors.whatsapp,
              onTap: () => _launch(AppData.whatsappUrl),
            ),
            const SizedBox(width: 12),
            _SocialBtn(
              faIcon: FontAwesomeIcons.github,
              onTap: () => _launch(AppData.github),
            ),
            const SizedBox(width: 12),
            _SocialBtn(
              faIcon: FontAwesomeIcons.linkedin,
              onTap: () => _launch(AppData.linkedin),
            ),
            const SizedBox(width: 12),
            _SocialBtn(
              icon: Icons.email_rounded,
              onTap: () => _launch('mailto:${AppData.email}'),
            ),
          ],
        ).animate().fadeIn(duration: 500.ms, delay: 650.ms),
      ],
    );
  }

  Widget _buildForm() {
    if (_submitted) {
      return Container(
        padding: const EdgeInsets.all(44),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF22C55E),
              size: 64,
            ).animate().scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                  curve: Curves.elasticOut,
                ),
            const SizedBox(height: 20),
            GradientText(
              'Thank You!',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            Text(
              "Your email client was opened. You can also message me directly on WhatsApp at ${AppData.phone} for the quickest response.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 28),
            GradientButton(
              label: 'Send Another Note',
              onPressed: () {
                _nameController.clear();
                _emailController.clear();
                _messageController.clear();
                setState(() => _submitted = false);
              },
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Send a Message',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),

            _FormField(
              controller: _nameController,
              label: 'Your Name',
              hint: 'e.g. Alex Johnson',
              icon: Icons.person_outline_rounded,
              validator: (v) =>
                  v?.trim().isEmpty == true ? 'Please enter your name' : null,
            ),

            const SizedBox(height: 18),

            _FormField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'alex@example.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v?.trim().isEmpty == true) return 'Please enter your email';
                if (!v!.contains('@')) return 'Please enter a valid email';
                return null;
              },
            ),

            const SizedBox(height: 18),

            _FormField(
              controller: _messageController,
              label: 'Message',
              hint: 'Tell me about your mobile project, goals, and timeline...',
              icon: Icons.chat_bubble_outline_rounded,
              maxLines: 4,
              validator: (v) =>
                  v?.trim().isEmpty == true ? 'Please enter a message' : null,
            ),

            const SizedBox(height: 26),

            GradientButton(
              label: 'Send Message',
              icon: Icons.send_rounded,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: 0.1, end: 0);
  }
}

class _ContactItem extends StatefulWidget {
  final FaIconData? faIcon;
  final IconData? icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactItem({
  
    this.faIcon,
    this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  }) : assert(faIcon != null || icon != null);

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.surfaceLight : AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered ? AppColors.secondary : AppColors.borderLight,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _hovered ? AppColors.secondary : AppColors.border,
                  ),
                ),
                child: Center(
                  child: widget.faIcon != null
                      ? FaIcon(
                          widget.faIcon,
                          color: _hovered ? AppColors.secondary : Colors.white,
                          size: 18,
                        )
                      : Icon(
                          widget.icon,
                          color: _hovered ? AppColors.secondary : Colors.white,
                          size: 20,
                        ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: GoogleFonts.inter(
                        color: AppColors.textMuted,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.value,
                      style: GoogleFonts.inter(
                        color: _hovered ? AppColors.secondary : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_outward_rounded,
                color: _hovered ? AppColors.secondary : AppColors.textMuted,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.textMuted, size: 20),
        labelStyle: GoogleFonts.inter(color: AppColors.textSecondary),
        hintStyle:
            GoogleFonts.inter(color: AppColors.textMuted, fontSize: 13),
        filled: true,
        fillColor: AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.secondary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}

class _SocialBtn extends StatefulWidget {
  final FaIconData? faIcon;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? color;

  const _SocialBtn({
    this.faIcon,
    this.icon,
    required this.onTap,
    this.color,
  }) : assert(faIcon != null || icon != null);

  @override
  State<_SocialBtn> createState() => _SocialBtnState();
}

class _SocialBtnState extends State<_SocialBtn> {
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
          duration: const Duration(milliseconds: 200),
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _hovered ? activeColor.withAlpha(35) : AppColors.surfaceLight,
            border: Border.all(
              color: _hovered ? activeColor : AppColors.borderLight,
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
                    color: _hovered ? activeColor : Colors.white,
                    size: 18,
                  )
                : Icon(
                    widget.icon,
                    color: _hovered ? activeColor : Colors.white,
                    size: 18,
                  ),
          ),
        ),
      ),
    );
  }
}
