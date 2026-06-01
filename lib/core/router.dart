import 'package:go_router/go_router.dart';
import '../features/home/home_screen.dart';
import '../features/diagnostic/diagnostic_screen.dart';
import '../features/report/report_screen.dart';
import '../features/roadmap/roadmap_screen.dart';
import '../features/my/my_screen.dart';
import '../features/paywall/paywall_screen.dart';
import '../shared/widgets/main_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(path: '/',           builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/diagnostic', builder: (_, __) => const DiagnosticScreen()),
        GoRoute(path: '/report',     builder: (_, __) => const ReportScreen()),
        GoRoute(path: '/roadmap',    builder: (_, __) => const RoadmapScreen()),
        GoRoute(path: '/my',         builder: (_, __) => const MyScreen()),
      ],
    ),
    GoRoute(
      path: '/paywall',
      builder: (_, __) => const PaywallScreen(),
    ),
  ],
);
