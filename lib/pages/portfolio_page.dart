import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/projects_section.dart';
import '../sections/experience_section.dart';
import '../sections/contact_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  // Keys for each section:
  // 0: About
  // 1: Skills
  // 2: Projects
  // 3: Experience
  // 4: Contact
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(int index) {
    if (index >= _sectionKeys.length) return;
    final key = _sectionKeys[index];
    final targetContext = key.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Top spacing for sticky navbar
                const SizedBox(height: 72),

                // Hero Section
                HeroSection(
                  onExploreWork: () => _scrollTo(2), // Scrolls to Projects
                ),

                // About Section
                KeyedSubtree(
                  key: _sectionKeys[0],
                  child: const AboutSection(),
                ),

                // Skills Section
                KeyedSubtree(
                  key: _sectionKeys[1],
                  child: const SkillsSection(),
                ),

                // Projects Section (Roshesh Futsal Showcase)
                KeyedSubtree(
                  key: _sectionKeys[2],
                  child: const ProjectsSection(),
                ),

                // Experience Section
                KeyedSubtree(
                  key: _sectionKeys[3],
                  child: const ExperienceSection(),
                ),

                // Contact Section
                KeyedSubtree(
                  key: _sectionKeys[4],
                  child: const ContactSection(),
                ),

                // Footer
                const Footer(),
              ],
            ),
          ),

          // Sticky Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
            ),
          ),
        ],
      ),
    );
  }
}
