import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';

final _planProvider = StateProvider<String>((ref) => 'month');

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(_planProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _Hero(
              onClose: () => Navigator.of(context).pop(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Monthly / Yearly toggle
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6EEE7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      _PlanTab(
                        label: '월간',
                        active: plan == 'month',
                        onTap: () => ref
                            .read(_planProvider.notifier)
                            .state = 'month',
                      ),
                      _PlanTab(
                        label: '연간 (33% 절약)',
                        active: plan == 'year',
                        onTap: () => ref
                            .read(_planProvider.notifier)
                            .state = 'year',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                // Free plan
                _PlanCard(
                  name: '무료',
                  price: '₩0',
                  period: '/월',
                  featured: false,
                  features: const [
                    (true,  '기본 진단 3회/월'),
                    (true,  '수학 구멍 기본 분석'),
                    (false, '무제한 학습지 출력'),
                    (false, 'AI 심층 분석'),
                    (false, '부모 주간 리포트'),
                  ],
                ),
                const SizedBox(height: 10),
                // Premium plan
                _PlanCard(
                  name: '프리미엄',
                  price: plan == 'month' ? '₩9,900' : '₩6,600',
                  period: plan == 'month' ? '/월' : '/월 (연 ₩79,200)',
                  badge: plan == 'month' ? '인기' : '33% 절약',
                  featured: true,
                  features: const [
                    (true, '무제한 진단 테스트'),
                    (true, 'AI 심층 구멍 분석'),
                    (true, '무제한 학습지 출력'),
                    (true, '오답 복습지 자동 생성'),
                    (true, '부모 주간 리포트'),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // TODO: RevenueCat.purchasePackage()
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('7일 무료 체험 시작',
                      style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    '언제든지 취소 가능 · 체험 종료 후 자동 결제\nApp Store / Google Play 결제 처리 (RevenueCat)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: AppColors.gray, height: 1.6),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final VoidCallback onClose;
  const _Hero({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E3D2C), Color(0xFF2E6048)],
            ),
          ),
          padding: EdgeInsets.fromLTRB(
              22, MediaQuery.of(context).padding.top + 44, 22, 32),
          width: double.infinity,
          child: const Column(
            children: [
              Text('🌟', style: TextStyle(fontSize: 46)),
              SizedBox(height: 10),
              Text('K-Math 프리미엄',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              SizedBox(height: 6),
              Text(
                'AI 심층 분석 · 무제한 학습지\n부모 주간 리포트 · 오답 복습지',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                    height: 1.6),
              ),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 12,
          right: 16,
          child: GestureDetector(
            onTap: onClose,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlanTab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _PlanTab({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: active
                ? [const BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 1))]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: active ? AppColors.primary : AppColors.gray,
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String name, price, period;
  final String? badge;
  final bool featured;
  final List<(bool, String)> features;

  const _PlanCard({
    required this.name,
    required this.price,
    required this.period,
    this.badge,
    required this.featured,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: featured ? AppColors.primary : const Color(0xFFE5EEE6),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(price,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary)),
                      Text(period,
                          style: const TextStyle(
                              fontSize: 10, color: AppColors.gray)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...features.map(
                (f) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Text(
                        f.$1 ? '✓' : '✕',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: f.$1 ? AppColors.accent : const Color(0xFFCCCCCC),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        f.$2,
                        style: TextStyle(
                          fontSize: 13,
                          color: f.$1 ? const Color(0xFF333333) : const Color(0xFFBBBBBB),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (badge != null)
          Positioned(
            top: -9,
            left: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(badge!,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
      ],
    );
  }
}
