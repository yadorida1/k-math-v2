import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';

final _qIndexProvider = StateProvider<int>((ref) => 0);
final _selectedProvider = StateProvider<int?>((ref) => null);

const _questions = [
  _Q('분수 나눗셈', '2¾ ÷ 1⅓ 를 계산하면?',       ['2 3/16', '2 1/16', '2 1/8', '2 1/4'],    1),
  _Q('비례식',    '3 : 4 = 9 : □  에서 □의 값은?', ['10', '11', '12', '13'],                  2),
  _Q('방정식',    'x + 7 = 15 일 때, x의 값은?',   ['6', '7', '8', '9'],                      2),
  _Q('분수',     '1½ ÷ ¾ 를 계산하면?',           ['1', '1½', '2', '2½'],                    2),
  _Q('비율',     '30명 중 18명이 수학을 좋아할 때 비율은?', ['3/5', '2/5', '3/10', '6/10'],   0),
];

class _Q {
  final String category, text;
  final List<String> options;
  final int answer;
  const _Q(this.category, this.text, this.options, this.answer);
}

class DiagnosticScreen extends ConsumerWidget {
  const DiagnosticScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qi = ref.watch(_qIndexProvider);
    final selected = ref.watch(_selectedProvider);
    final q = _questions[qi % _questions.length];
    final total = 20;
    final progress = (qi + 1) / total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('진단 테스트'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '⏱ 09:${(59 - qi * 7).clamp(0, 59).toString().padLeft(2, '0')}',
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gray),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('문제 ${qi + 1} / $total',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.gray)),
                Text(q.category,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.gray)),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: AppColors.progress,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primary.withOpacity(0.07),
                        blurRadius: 12,
                        offset: const Offset(0, 2))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.softGreen,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(q.category,
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary)),
                    ),
                    const SizedBox(height: 14),
                    Text(q.text,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                            height: 1.5)),
                    const SizedBox(height: 20),
                    ...List.generate(
                      q.options.length,
                      (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: GestureDetector(
                          onTap: () =>
                              ref.read(_selectedProvider.notifier).state = i,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 120),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 13),
                            decoration: BoxDecoration(
                              color: selected == i
                                  ? AppColors.softGreen
                                  : Colors.white,
                              border: Border.all(
                                color: selected == i
                                    ? AppColors.primary
                                    : const Color(0xFFEBF0EB),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: selected == i
                                        ? AppColors.primary
                                        : const Color(0xFFEEEEEE),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '①②③④'[i],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: selected == i
                                              ? Colors.white
                                              : const Color(0xFF666666)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  q.options[i],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: selected == i
                                          ? AppColors.primary
                                          : const Color(0xFF333333),
                                      fontWeight: selected == i
                                          ? FontWeight.w600
                                          : FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                if (qi > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ref.read(_qIndexProvider.notifier).state = qi - 1;
                        ref.read(_selectedProvider.notifier).state = null;
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.border, width: 1.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('← 이전',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700)),
                    ),
                  ),
                if (qi > 0) const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(_qIndexProvider.notifier).state = qi + 1;
                      ref.read(_selectedProvider.notifier).state = null;
                    },
                    child: Text(
                      qi >= total - 1 ? '결과 보기 →' : '다음 문제 →',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
