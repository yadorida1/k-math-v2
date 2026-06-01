import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../shared/widgets/app_card.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _ReportHeader(context: context)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _SubjectCard(
                  title: '분수 나눗셈',
                  score: '40%',
                  scoreColor: AppColors.red,
                  bars: const [
                    ('개념 이해', 0.40),
                    ('계산 정확도', 0.80),
                    ('실수 빈도', 0.45),
                  ],
                  alert: '개념 이해 보완 시급',
                ),
                const SizedBox(height: 12),
                _SubjectCard(
                  title: '비율과 비례',
                  score: '45%',
                  scoreColor: AppColors.darkOrange,
                  bars: const [
                    ('개념 이해', 0.55),
                    ('응용 문제', 0.35),
                  ],
                  alert: '응용 적용 능력 부족',
                ),
                const SizedBox(height: 12),
                _SubjectCard(
                  title: '방정식 문장제',
                  score: '60%',
                  scoreColor: AppColors.darkOrange,
                  bars: const [
                    ('문제 이해', 0.70),
                    ('식 세우기', 0.48),
                    ('계산 완료', 0.62),
                  ],
                  alert: '언어→식 변환에서 자주 막힘',
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () => context.go('/paywall'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('📄 맞춤 복습지 생성 (프리미엄)',
                      style: TextStyle(fontSize: 15)),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportHeader extends StatelessWidget {
  final BuildContext context;
  const _ReportHeader({required this.context});

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
          20, MediaQuery.of(context).padding.top + 16, 20, 28),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('전체 수학 레벨',
              style: TextStyle(fontSize: 12, color: Colors.white70)),
          SizedBox(height: 4),
          Text('B+',
              style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.1)),
          SizedBox(height: 6),
          Text('중1 문자와 식 진입 가능',
              style: TextStyle(fontSize: 13, color: Colors.white90)),
          SizedBox(height: 3),
          Text('⚠ 분수·비례식 보완 필요',
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFFFFD580),
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final String title, score, alert;
  final Color scoreColor;
  final List<(String, double)> bars;

  const _SubjectCard({
    required this.title,
    required this.score,
    required this.scoreColor,
    required this.bars,
    required this.alert,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary)),
              Text(score,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: scoreColor)),
            ],
          ),
          const SizedBox(height: 12),
          ...bars.map((b) => BarRow(label: b.$1, value: b.$2)),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Text('⚠ ',
                    style: TextStyle(fontSize: 13)),
                Text(alert,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFC04040))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
