import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _MyHeader(context: context)),
          const SliverToBoxAdapter(child: _StatsRow()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _SectionLabel(text: '구독'),
                _MenuCard(items: [
                  _MenuItem(
                    icon: '⭐',
                    iconBg: const Color(0xFFFFF0D6),
                    title: '프리미엄 업그레이드',
                    sub: '무제한 학습지 · AI 심층 분석',
                    onTap: () => context.go('/paywall'),
                  ),
                ]),
                const SizedBox(height: 12),
                _SectionLabel(text: '계정'),
                _MenuCard(items: [
                  _MenuItem(
                    icon: '👤',
                    iconBg: AppColors.softGreen,
                    title: '프로필 수정',
                    sub: '이름 · 학년 · 학습 목표',
                  ),
                  _MenuItem(
                    icon: '🔔',
                    iconBg: AppColors.blue,
                    title: '알림 설정',
                    sub: '오늘의 미션 · 주간 리포트',
                  ),
                  _MenuItem(
                    icon: '📊',
                    iconBg: AppColors.purple,
                    title: '학습 데이터',
                    sub: '내보내기 · 삭제',
                  ),
                ]),
                const SizedBox(height: 12),
                _SectionLabel(text: '앱 정보'),
                _MenuCard(items: [
                  _MenuItem(
                    icon: 'ℹ️',
                    iconBg: const Color(0xFFF5F5F5),
                    title: '버전 2.0.0',
                    sub: 'MathTree Studio',
                    showArrow: false,
                  ),
                ]),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyHeader extends StatelessWidget {
  final BuildContext context;
  const _MyHeader({required this.context});

  @override
  Widget build(BuildContext _) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3D2C), Color(0xFF2E6048)],
        ),
      ),
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 20, 20, 28),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
                color: AppColors.accent, shape: BoxShape.circle),
            child: const Center(
              child: Text('유',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(height: 10),
          const Text('유빈',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          const Text('초등 5학년 · 중1 선행 준비',
              style: TextStyle(fontSize: 12, color: Colors.white70)),
          const SizedBox(height: 10),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('⭐ 무료 플랜',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          _Stat(value: '12', label: '진단 횟수'),
          _Stat(value: '5장', label: '복습지'),
          _Stat(value: '+18%', label: '이달 성장', valueColor: AppColors.darkOrange),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  final Color? valueColor;
  const _Stat({required this.value, required this.label, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(color: Color(0xFFEEEEEE), width: 1),
          ),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: valueColor ?? AppColors.primary)),
            const SizedBox(height: 2),
            Text(label,
                style:
                    const TextStyle(fontSize: 11, color: AppColors.gray)),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.gray,
            letterSpacing: 0.4),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final List<_MenuItem> items;
  const _MenuCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: AppColors.primary.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: List.generate(
          items.length,
          (i) => Column(
            children: [
              items[i],
              if (i < items.length - 1)
                const Divider(height: 1, indent: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String icon, title, sub;
  final Color iconBg;
  final VoidCallback? onTap;
  final bool showArrow;

  const _MenuItem({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.sub,
    this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                  color: iconBg, borderRadius: BorderRadius.circular(9)),
              child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 15))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A))),
                  const SizedBox(height: 1),
                  Text(sub,
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.gray)),
                ],
              ),
            ),
            if (showArrow)
              const Icon(Icons.chevron_right,
                  color: Color(0xFFCCCCCC), size: 20),
          ],
        ),
      ),
    );
  }
}
