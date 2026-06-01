import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _Header(context: context)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _MissionCard(),
                const SizedBox(height: 12),
                _GapCard(onReport: () => context.go('/report')),
                const SizedBox(height: 12),
                _QuickGrid(context: context),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final BuildContext context;
  const _Header({required this.context});

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
        20, MediaQuery.of(context).padding.top + 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('안녕하세요 👋',
              style: TextStyle(fontSize: 12, color: Colors.white70)),
          const SizedBox(height: 4),
          const Text('유빈이 부모님',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          const Text('초등 5학년 · 중1 선행 준비 중',
              style: TextStyle(fontSize: 11, color: Colors.white60)),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('현재 수학 레벨',
                        style:
                            TextStyle(fontSize: 11, color: Colors.white70)),
                    Text('B+',
                        style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('중1 문자와 식 진입 가능',
                        style:
                            TextStyle(fontSize: 11, color: Colors.white90)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('⚠ 분수·비례식 보완 필요',
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFFFFD580),
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: AppColors.primary.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text('오늘의 미션',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                    color: AppColors.softGreen,
                    borderRadius: BorderRadius.circular(9)),
                child: const Text('2/3 완료',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _missionRow(done: true, text: '분수 나눗셈 진단 완료'),
          _missionRow(done: true, text: '복습지 1장 출력 완료'),
          _missionRow(done: false, text: '비례식 응용 5문제 풀기'),
        ],
      ),
    );
  }

  Widget _missionRow({required bool done, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: done ? AppColors.progress : AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              done ? Icons.check : Icons.arrow_forward,
              size: 11,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: done ? AppColors.gray : const Color(0xFF333333),
              decoration:
                  done ? TextDecoration.lineThrough : TextDecoration.none,
              decorationColor: AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}

class _GapCard extends StatelessWidget {
  final VoidCallback onReport;
  const _GapCard({required this.onReport});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cream,
        border: Border.all(color: const Color(0xFFF0DEC1), width: 1.5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🔍 AI 구멍 분석',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF5B3B17))),
          const SizedBox(height: 10),
          _gapRow(1, '분수 나눗셈 개념 부족 (40%)'),
          _gapRow(2, '비례식 응용 약함 (35%)'),
          _gapRow(3, '방정식 문장제 실수 빈번'),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onReport,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),
              ),
              child: const Text('상세 리포트 보기 →',
                  style: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gapRow(int n, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
                color: AppColors.orange, shape: BoxShape.circle),
            child: Center(
              child: Text('$n',
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF5B3B17))),
            ),
          ),
          const SizedBox(width: 8),
          Text(text,
              style: const TextStyle(
                  fontSize: 12, color: Color(0xFF7A6041))),
        ],
      ),
    );
  }
}

class _QuickGrid extends StatelessWidget {
  final BuildContext context;
  const _QuickGrid({required this.context});

  @override
  Widget build(BuildContext _) {
    final items = [
      _QItem('📝', '진단 테스트', '10분 · 20문제', AppColors.softGreen, AppColors.primary, '/diagnostic'),
      _QItem('📄', '맞춤 학습지', 'PDF · 프리미엄', AppColors.purple, const Color(0xFF3F315F), '/paywall'),
      _QItem('🗺️', '학습 로드맵', '스킬트리 확인', AppColors.blue, const Color(0xFF254A6B), '/roadmap'),
      _QItem('👤', 'MY 페이지', '구독 · 설정', AppColors.cream, const Color(0xFF5B3B17), '/my'),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.45,
      children: items
          .map((e) => GestureDetector(
                onTap: () => context.go(e.route),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: e.bg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.icon,
                          style: const TextStyle(fontSize: 22)),
                      const SizedBox(height: 8),
                      Text(e.title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: e.titleColor)),
                      const SizedBox(height: 2),
                      Text(e.sub,
                          style: const TextStyle(
                              fontSize: 11, color: AppColors.gray)),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class _QItem {
  final String icon, title, sub, route;
  final Color bg, titleColor;
  const _QItem(this.icon, this.title, this.sub, this.bg, this.titleColor, this.route);
}
