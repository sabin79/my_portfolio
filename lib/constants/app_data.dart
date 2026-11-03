class AppData {
  static const String name = 'Sabin Dahal';
  static const String title = 'Flutter Developer';
  static const String subtitle = 'Mobile Application Engineer';
  static const String email = 'dsabin729@gmail.com';
  static const String phone = '+977 9861393634';
  static const String whatsappNumber = '9861393634';
  static const String whatsappUrl = 'https://wa.me/9779861393634';
  static const String github = 'https://github.com/sabin79';
  static const String linkedin = 'https://linkedin.com/in/sabin79';
  static const String location = 'Lalitpur, Nepal';

  static const String avatarImage = 'assets/images/my_avatar.png';
  static const String futsalQrImage = 'assets/images/futsal.png';
  static const String futsalApkUrl =
      'https://github.com/sabin79/Roshesh-futsal-apk-download-/releases/download/v1.0/roshesfutsal.apk';
  static const String futsalGithubUrl =
      'https://github.com/sabin79/Roshesh-futsal-apk-download-';

  static const String summary =
      'Flutter developer with over 3 years of experience building high-performance mobile apps for iOS and Android. '
      'I have built and managed large-scale applications from architecture to deployment on both Google Play Store and Apple App Store. '
      'Deployed 4 apps on Google Play Store, and 2 of those same apps are live on Apple App Store. '
      'Specialized in Feature-First Clean Architecture, BLoC/Cubit, WebSockets, JWT token rotation, and hardware platform integrations.';

  static const String about = '''
I am a dedicated Flutter developer with over 3 years of hands-on experience crafting robust, scalable mobile applications for iOS and Android. I have built and managed large production applications independently—from foundational Clean Architecture to releasing and maintaining apps on both the Google Play Store and Apple App Store.

I have deployed 4 production applications on Google Play Store, with 2 of them simultaneously published and live on the Apple App Store. My engineering expertise centers around Clean Architecture, BLoC state management, resilient offline-first caching, JWT token rotation, and deep platform integrations including NFC, ML Kit OCR, and Apple/Google Wallet pass generation.
''';

  static const List<Map<String, String>> education = [
    {
      'institution': 'Madan Bhandari Memorial College',
      'degree': "Bachelor's Degree",
      'period': '10/2019 – 07/2024',
      'location': 'Kathmandu, Nepal',
    },
    {
      'institution': 'Caspian Valley College',
      'degree': '+2 Education (Science)',
      'period': '07/2017 – 05/2019',
      'location': 'Lalitpur, Nepal',
    },
  ];

  static const List<Map<String, dynamic>> stats = [
    {'value': '3+', 'label': 'Years Experience'},
    {'value': '4', 'label': 'Play Store Apps'},
    {'value': '2', 'label': 'App Store Apps'},
    {'value': '100%', 'label': 'Clean Architecture'},
  ];

  // Curated skills based on CV & instructions:
  // - No frontend
  // - In mobile: no React Native
  // - In backend: no node.js, no REST APIs, no GraphQL
  // - No database section
  static const List<Map<String, dynamic>> skills = [
    {
      'category': 'Mobile & Languages',
      'icon': '📱',
      'items': [
        'Flutter',
        'Dart',
        'Kotlin',
        'Android SDK',
        'iOS',
        'Python',
      ],
    },
    {
      'category': 'State Management',
      'icon': '⚡',
      'items': [
        'BLoC / Cubit',
        'bloc_concurrency',
        'Riverpod',
        'GetX',
        'Provider',
      ],
    },
    {
      'category': 'Architecture & Design',
      'icon': '🏛️',
      'items': [
        'Clean Architecture',
        'Feature-First Modular',
        'Dependency Injection (get_it)',
        'Repository Pattern',
        'Offline-First Caching',
      ],
    },
    {
      'category': 'Networking & Auth',
      'icon': '🔒',
      'items': [
        'WebSockets',
        'JWT Token Rotation',
        'OAuth 2.0',
        'Google Sign-In',
        'Apple Sign-In',
        'GitHub Auth',
      ],
    },
    {
      'category': 'Platform & Hardware',
      'icon': '🧩',
      'items': [
        'Deep Linking (App/Universal Links)',
        'Apple PassKit',
        'Google Wallet',
        'ML Kit (OCR)',
        'NFC (Read/Write)',
      ],
    },
    {
      'category': 'Cloud & Tools',
      'icon': '🛠️',
      'items': [
        'Firebase Auth',
        'Cloud Firestore',
        'Cloud Messaging (FCM)',
        'Git & GitHub',
        'Figma',
      ],
    },
  ];

  // Projects: Only Roshesh Futsal as requested, with full details and QR code download
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'Roshesh Futsal – Futsal Booking App',
      'subtitle': 'Freelance Client Project',
      'description':
          'Architected and engineered a comprehensive, production-grade futsal booking and arena management mobile application from scratch. '
          'Features real-time court scheduling, live tournament engine, role-based access control, in-app OTA APK updater, and high-performance offline resilience.',
      'highlights': [
        'Architected using Feature-First Clean Architecture and BLoC (Cubit) with get_it dependency injection to strictly isolate UI from business logic and data layers.',
        'Engineered a real-time booking engine and tournament management system using Firestore streams and Firebase Cloud Messaging (FCM) to handle complex time-slot validations and deliver instant alerts.',
        'Built an automated in-app OTA update system utilizing Dio and GitHub API to seamlessly manage background APK downloads and local installations.',
        'Developed a role-based access control system via Firebase Auth to dynamically route users and administrators to customized, secure dashboards.',
        'Designed a fully responsive, pixel-perfect UI architecture using flutter_screenutil to ensure flawless adaptability across all device dimensions.',
      ],
      'tags': [
        'Flutter',
        'BLoC / Cubit',
        'Clean Architecture',
        'Firebase',
        'Firestore Streams',
        'FCM Alerts',
        'OTA Updates',
        'flutter_screenutil',
      ],
      'qrImage': futsalQrImage,
      'apkUrl': futsalApkUrl,
      'github': futsalGithubUrl,
      'featured': true,
    },
  ];

  // Work Experience: All 4 experiences from the CV
  static const List<Map<String, dynamic>> experience = [
    {
      'role': 'Junior Flutter Developer',
      'company': 'Ora Technologies',
      'location': 'Kathmandu, Nepal',
      'period': '04/2025 – 08/2026',
      'isCurrent': true,
      'description':
          'Junior developer on the company\'s main flagship application, handling architecture, development, and release lifecycle from start to finish, including publishing to Google Play Store and Apple App Store.',
      'achievements': [
        'Deployed 4 apps on the Google Play Store, 2 of which are also live on the Apple App Store.',
        'Built the app using Clean Architecture with a feature-first, modular structure.',
        'Used BLOC and Cubit for state management, with a coordinator BLoC that manages other BLoCs together.',
        'Built a JWT refresh system that handles race conditions, ensuring only one refresh call is made during simultaneous failures instead of sending duplicate requests.',
        'Added login with email/password, Google, GitHub, and Apple Sign In, unifying into one seamless login flow.',
        'Set up deep linking for Android and iOS to ensure correct screen routing after login or from closed states.',
        'Worked with NFC, building a feature to read and write data by tapping an NFC-enabled card or device.',
        'Integrated real-time notifications via WebSockets with auto-reconnect logic for dropped connections.',
        'Built realtime chat with instant rendering and deduplication against cache, fixing inflated unread counts.',
        'Developed an offline scanner to read card QR codes and utilized on-device ML Kit OCR for contact extraction.',
        'Added Apple Wallet and Google Wallet pass support, alongside QR code sharing for contacts.',
      ],
    },
    {
      'role': 'Junior Flutter Developer',
      'company': 'Medipro',
      'location': 'Kathmandu, Nepal',
      'period': '01/2025 – 04/2025',
      'isCurrent': false,
      'description':
          'Engineered a task management application from scratch for a private server environment, enabling clients to post issues and track resolution timelines with employees in real time.',
      'achievements': [
        'Built a task management app from scratch for a private server, where clients can post tasks to employees based on issues.',
        'Used GET and POST APIs to send and fetch data between the app and server, with tasks shown in order and re-posted once fixed.',
        'Iteratively refined UI responsiveness and fixed edge cases based on continuous QA feedback.',
      ],
    },
    {
      'role': 'Flutter Developer Intern',
      'company': 'EverestWalk Groups',
      'location': 'Kathmandu, Nepal',
      'period': '03/2024 – 07/2024',
      'isCurrent': false,
      'description':
          'Contributed to live commercial client projects (Castin.io), collaborating closely with senior software engineers on component architecture and API integration.',
      'achievements': [
        'Worked on real client projects (Castin.io) and mastered production Flutter development with mentorship from senior developers.',
        'Built responsive UI components and app features, connecting REST APIs to fetch and display external data.',
        'Assisted in writing project technical documentation, conducted unit testing, and participated in active code reviews.',
      ],
    },
    {
      'role': 'Flutter Developer Intern',
      'company': 'NepaTronix',
      'location': 'Kathmandu, Nepal',
      'period': '04/2023 – 06/2023',
      'isCurrent': false,
      'description':
          'Collaborated on Internet-of-Things (IoT) initiatives, building Flutter mobile interfaces to interface with hardware sensors and display live telemetry.',
      'achievements': [
        'Worked with IoT devices and sensors to collect data, and built a simple Flutter app to display telemetry in real time.',
        'Assisted in designing components of IoT devices and integrated IoT device APIs to fetch app data.',
      ],
    },
  ];
}
