import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Lightweight state class with pre-calculated values
class HomeAnimationState {
  final bool isInitialized;
  final bool isAnimating;
  final double imageOpacity;
  final double imageSlide;
  final double headingOpacity;
  final double headingSlide;
  final double descriptionOpacity;
  final double descriptionSlide;
  final double buttonsOpacity;
  final double buttonsSlide;
  final double featuresOpacity;
  final double featuresSlide;

  const HomeAnimationState({
    this.isInitialized = false,
    this.isAnimating = false,
    this.imageOpacity = 0.0,
    this.imageSlide = 100.0,
    this.headingOpacity = 0.0,
    this.headingSlide = -50.0,
    this.descriptionOpacity = 0.0,
    this.descriptionSlide = -30.0,
    this.buttonsOpacity = 0.0,
    this.buttonsSlide = -30.0,
    this.featuresOpacity = 0.0,
    this.featuresSlide = -30.0,
  });

  HomeAnimationState copyWith({
    bool? isInitialized,
    bool? isAnimating,
    double? imageOpacity,
    double? imageSlide,
    double? headingOpacity,
    double? headingSlide,
    double? descriptionOpacity,
    double? descriptionSlide,
    double? buttonsOpacity,
    double? buttonsSlide,
    double? featuresOpacity,
    double? featuresSlide,
  }) {
    return HomeAnimationState(
      isInitialized: isInitialized ?? this.isInitialized,
      isAnimating: isAnimating ?? this.isAnimating,
      imageOpacity: imageOpacity ?? this.imageOpacity,
      imageSlide: imageSlide ?? this.imageSlide,
      headingOpacity: headingOpacity ?? this.headingOpacity,
      headingSlide: headingSlide ?? this.headingSlide,
      descriptionOpacity: descriptionOpacity ?? this.descriptionOpacity,
      descriptionSlide: descriptionSlide ?? this.descriptionSlide,
      buttonsOpacity: buttonsOpacity ?? this.buttonsOpacity,
      buttonsSlide: buttonsSlide ?? this.buttonsSlide,
      featuresOpacity: featuresOpacity ?? this.featuresOpacity,
      featuresSlide: featuresSlide ?? this.featuresSlide,
    );
  }
}

// Highly optimized ViewModel with single controller and pre-calculated curves
class HomeViewModel extends Notifier<HomeAnimationState> {
  AnimationController? _controller;

  // Pre-calculated curves for better performance
  static const _imageCurve = Interval(0.0, 0.4, curve: Curves.easeOutCubic);
  static const _headingCurve = Interval(0.1, 0.5, curve: Curves.easeOut);
  static const _descriptionCurve = Interval(0.2, 0.6, curve: Curves.easeOut);
  static const _buttonsCurve = Interval(0.3, 0.7, curve: Curves.easeOut);
  static const _featuresCurve = Interval(0.4, 0.8, curve: Curves.easeOut);

  @override
  HomeAnimationState build() {
    return const HomeAnimationState();
  }

  void initializeAnimations(TickerProvider tickerProvider) {
    if (state.isInitialized) return;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800), // Slightly faster
      vsync: tickerProvider,
    );

    // Single listener that updates all values efficiently
    _controller!.addListener(_updateAnimationValues);

    state = state.copyWith(isInitialized: true);
  }

  void _updateAnimationValues() {
    if (_controller == null) return;

    final progress = _controller!.value;

    // Calculate all animation values in one go using pre-calculated curves
    final imageProgress = _imageCurve.transform(progress);
    final headingProgress = _headingCurve.transform(progress);
    final descriptionProgress = _descriptionCurve.transform(progress);
    final buttonsProgress = _buttonsCurve.transform(progress);
    final featuresProgress = _featuresCurve.transform(progress);

    // Apply easing and update state once
    state = state.copyWith(
      isAnimating: _controller!.isAnimating,
      imageOpacity: imageProgress,
      imageSlide: 100.0 * (1 - imageProgress),
      headingOpacity: headingProgress,
      headingSlide: -50.0 * (1 - headingProgress),
      descriptionOpacity: descriptionProgress,
      descriptionSlide: -30.0 * (1 - descriptionProgress),
      buttonsOpacity: buttonsProgress,
      buttonsSlide: -30.0 * (1 - buttonsProgress),
      featuresOpacity: featuresProgress,
      featuresSlide: -30.0 * (1 - featuresProgress),
    );
  }

  void startAnimations() {
    if (!state.isInitialized || _controller == null) return;

    // Small delay for smoother start
    Future.delayed(const Duration(milliseconds: 50), () {
      _controller?.forward();
    });
  }

  void resetAnimations() {
    _controller?.reset();
  }

  void disposeControllers() {
    _controller?.removeListener(_updateAnimationValues);
    _controller?.dispose();
    _controller = null;
  }
}

// Provider
final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeAnimationState>(() {
  return HomeViewModel();
});

// Optimized animated widget that reduces rebuilds
class OptimizedAnimatedWidget extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double slideX;
  final double slideY;

  const OptimizedAnimatedWidget({
    super.key,
    required this.child,
    required this.opacity,
    this.slideX = 0.0,
    this.slideY = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    // Only apply transform if there's actual movement
    if (slideX == 0.0 && slideY == 0.0) {
      return Opacity(
        opacity: opacity.clamp(0.0, 1.0),
        child: child,
      );
    }

    return Transform.translate(
      offset: Offset(slideX, slideY),
      child: Opacity(
        opacity: opacity.clamp(0.0, 1.0),
        child: child,
      ),
    );
  }
}