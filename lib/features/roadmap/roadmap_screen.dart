import 'package:flutter/material.dart';
import '../../core/theme.dart';

enum NodeState { done, active, locked }

class _Node {
  final String title, desc;
  final NodeState state;
  final double? progress;
  const _Node(this.title, this.desc, this.state, {this.progress});
}

const _nodes = [
  _Node('분수와 소수',     '덧셈·뺄셈·곱셈 완료',             NodeState.done),
  _Node('분수 나눗셈',     '개념 이해 40% → 80% 목표',        NodeState.active, progress: 0.40),
  _Node('비율과 비례식',   '응용 문제 집중 훈련 필요',           NodeState.active),
  _Node('방정식 기초',     '비례식 완료 후 진입 가능',           NodeState.locked),
  _Node('함수와 그래프',   '방정식 완료 후 진입 가능',           NodeState.locked),
  _Node('중1 선행 완성',   '모든 단계 완료 시 달성',            NodeState.locked),
];

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('학습 로드맵')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const Text('구멍을 메우면 중학교 선행 속도가 안정됩니다.',
              style: TextStyle(fontSize: 13, color: AppColors.gray)),
          const SizedBox(height: 16),
          ...List.generate(_nodes.length, (i) {
            final node = _nodes[i];
            final isLast = i == _nodes.length - 1;
            return _NodeRow(node: node, isLast: isLast);
          }),
        ],
      ),
    );
  }
}

class _NodeRow extends StatelessWidget {
  final _Node node;
  final bool isLast;
  const _NodeRow({super.key, required this.node, required this.isLast});

  Color get _dotColor {
    switch (node.state) {
      case NodeState.done:   return AppColors.accent;
      case NodeState.active: return AppColors.orange;
      case NodeState.locked: return const Color(0xFFE8E8E8);
    }
  }

  String get _dotLabel {
    switch (node.state) {
      case NodeState.done:   return '✓';
      case NodeState.active: return '⚡';
      case NodeState.locked: return '🔒';
    }
  }

  String get _badgeText {
    switch (node.state) {
      case NodeState.done:   return '완료';
      case NodeState.active: return node.progress != null ? '진행 중' : '보완 필요';
      case NodeState.locked: return '잠김';
    }
  }

  Color get _badgeBg {
    switch (node.state) {
      case NodeState.done:   return AppColors.softGreen;
      case NodeState.active: return const Color(0xFFFFF0D6);
      case NodeState.locked: return const Color(0xFFEEEEEE);
    }
  }

  Color get _badgeText2 {
    switch (node.state) {
      case NodeState.done:   return AppColors.primary;
      case NodeState.active: return const Color(0xFF7A4500);
      case NodeState.locked: return const Color(0xFF666666);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDimmed = node.state == NodeState.locked;
    return Opacity(
      opacity: isDimmed ? 0.55 : 1.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Spine
          Column(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration:
                    BoxDecoration(color: _dotColor, shape: BoxShape.circle),
                child: Center(
                    child: Text(_dotLabel,
                        style: const TextStyle(fontSize: 16))),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 52,
                  color: node.state == NodeState.done
                      ? AppColors.progress
                      : const Color(0xFFE0E0E0),
                ),
            ],
          ),
          const SizedBox(width: 14),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(node.title,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDimmed
                              ? const Color(0xFFBBBBBB)
                              : AppColors.primary)),
                  const SizedBox(height: 2),
                  Text(node.desc,
                      style: TextStyle(
                          fontSize: 12,
                          color: isDimmed
                              ? const Color(0xFFCCCCCC)
                              : AppColors.gray)),
                  if (node.progress != null) ..[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: LinearProgressIndicator(
                        value: node.progress,
                        minHeight: 5,
                        backgroundColor: const Color(0xFFEEEEEE),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.orange),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                        '${(node.progress! * 100).round()}% 달성',
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.gray)),
                  ],
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: _badgeBg,
                        borderRadius: BorderRadius.circular(9)),
                    child: Text(_badgeText,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _badgeText2)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
