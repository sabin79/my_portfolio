import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/app_colors.dart';
import 'pages/portfolio_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 768;
        return ScreenUtilInit(
          // Adaptive dual design size: 1440x900 for desktop/wide, 390x844 for mobile/narrow
          designSize: isDesktop ? const Size(1440, 900) : const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Sabin Dahal — Flutter Developer',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.primary,
                  secondary: AppColors.secondary,
                  surface: AppColors.surface,
                ),
                scaffoldBackgroundColor: AppColors.background,
                textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
                useMaterial3: true,
              ),
              home: const PortfolioPage(),
            );
          },
        );
      },
    );
  }
}
