import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Animation state class
class AboutAnimationState {
  final bool isTitleVisible;
  final bool isDescriptionVisible;
  final List<bool> featuresVisible;
  final bool isMissionVisible;
  final List<bool> statsVisible;
  final bool isInitialized;

  const AboutAnimationState({
    this.isTitleVisible = false,
    this.isDescriptionVisible = false,
    this.featuresVisible = const [false, false, false, false],
    this.isMissionVisible = false,
    this.statsVisible = const [false, false, false, false],
    this.isInitialized = false,
  });

  AboutAnimationState copyWith({
    bool? isTitleVisible,
    bool? isDescriptionVisible,
    List<bool>? featuresVisible,
    bool? isMissionVisible,
    List<bool>? statsVisible,
    bool? isInitialized,
  }) {
    return AboutAnimationState(
      isTitleVisible: isTitleVisible ?? this.isTitleVisible,
      isDescriptionVisible: isDescriptionVisible ?? this.isDescriptionVisible,
      featuresVisible: featuresVisible ?? this.featuresVisible,
      isMissionVisible: isMissionVisible ?? this.isMissionVisible,
      statsVisible: statsVisible ?? this.statsVisible,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

// Animation notifier
class AboutAnimationNotifier extends StateNotifier<AboutAnimationState> {
  AboutAnimationNotifier() : super(const AboutAnimationState());

  // Trigger animations when section becomes visible
  void triggerAnimations() {
    if (state.isInitialized) return;

    state = state.copyWith(isInitialized: true);

    // Staggered animation sequence
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        state = state.copyWith(isTitleVisible: true);
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        state = state.copyWith(isDescriptionVisible: true);
      }
    });

    // Animate features with stagger
    _animateFeatures();

    // Animate mission section
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        state = state.copyWith(isMissionVisible: true);
      }
    });

    // Animate stats with stagger
    Future.delayed(const Duration(milliseconds: 1400), () {
      _animateStats();
    });
  }

  // Initialize animations with staggered timing (kept for backwards compatibility)
  void initializeAnimations() => triggerAnimations();

  void _animateFeatures() {
    for (int i = 0; i < 4; i++) {
      Future.delayed(Duration(milliseconds: 600 + (i * 150)), () {
        if (mounted) {
          final newFeaturesVisible = List<bool>.from(state.featuresVisible);
          newFeaturesVisible[i] = true;
          state = state.copyWith(featuresVisible: newFeaturesVisible);
        }
      });
    }
  }

  void _animateStats() {
    for (int i = 0; i < 4; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) {
          final newStatsVisible = List<bool>.from(state.statsVisible);
          newStatsVisible[i] = true;
          state = state.copyWith(statsVisible: newStatsVisible);
        }
      });
    }
  }

  // Reset animations (useful for testing or re-triggering)
  void resetAnimations() {
    state = const AboutAnimationState();
  }
}

// Provider
final aboutAnimationProvider = StateNotifierProvider<AboutAnimationNotifier, AboutAnimationState>((ref) {
  return AboutAnimationNotifier();
});

// Custom animated widgets for reusability
class FadeInSlideUp extends StatelessWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final Duration delay;
  final double slideDistance;

  const FadeInSlideUp({
    super.key,
    required this.child,
    required this.isVisible,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.slideDistance = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0.0,
        end: isVisible ? 1.0 : 0.0,
      ),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, slideDistance * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class ScaleIn extends StatelessWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final double initialScale;

  const ScaleIn({
    super.key,
    required this.child,
    required this.isVisible,
    this.duration = const Duration(milliseconds: 500),
    this.initialScale = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: initialScale,
        end: isVisible ? 1.0 : initialScale,
      ),
      duration: duration,
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: isVisible ? 1.0 : 0.0,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class SlideInFromLeft extends StatelessWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final double slideDistance;

  const SlideInFromLeft({
    super.key,
    required this.child,
    required this.isVisible,
    this.duration = const Duration(milliseconds: 700),
    this.slideDistance = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0.0,
        end: isVisible ? 1.0 : 0.0,
      ),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(-slideDistance * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class CountUpAnimation extends StatelessWidget {
  final String endValue;
  final String label;
  final bool isVisible;
  final Duration duration;
  final TextStyle? numberStyle;
  final TextStyle? labelStyle;

  const CountUpAnimation({
    super.key,
    required this.endValue,
    required this.label,
    required this.isVisible,
    this.duration = const Duration(milliseconds: 1500),
    this.numberStyle,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0.0,
        end: isVisible ? 1.0 : 0.0,
      ),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Column(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: isVisible ? 1.0 : 0.0),
                  duration: Duration(milliseconds: (duration.inMilliseconds * 0.8).round()),
                  curve: Curves.easeOut,
                  builder: (context, animValue, _) {
                    return Text(
                      _getAnimatedValue(animValue),
                      style: numberStyle,
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: labelStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getAnimatedValue(double progress) {
    if (endValue.contains('+')) {
      // Handle cases like "10+", "5000+"
      final baseValue = endValue.replaceAll('+', '');
      if (int.tryParse(baseValue) != null) {
        final target = int.parse(baseValue);
        final current = (target * progress).round();
        return '$current+';
      }
    } else if (endValue.contains('/')) {
      // Handle cases like "24/7"
      return progress > 0.5 ? endValue : '';
    } else if (int.tryParse(endValue) != null) {
      // Handle pure numbers
      final target = int.parse(endValue);
      final current = (target * progress).round();
      return current.toString();
    }

    // Fallback for any other format
    return progress > 0.5 ? endValue : '';
  }
}