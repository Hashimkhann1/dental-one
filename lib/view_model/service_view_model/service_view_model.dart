import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// State class for services animation
class ServicesAnimationState {
  final bool isHeaderVisible;
  final bool isGridVisible;
  final bool isFooterVisible;
  final List<bool> cardVisibilities;

  const ServicesAnimationState({
    this.isHeaderVisible = false,
    this.isGridVisible = false,
    this.isFooterVisible = false,
    this.cardVisibilities = const [],
  });

  ServicesAnimationState copyWith({
    bool? isHeaderVisible,
    bool? isGridVisible,
    bool? isFooterVisible,
    List<bool>? cardVisibilities,
  }) {
    return ServicesAnimationState(
      isHeaderVisible: isHeaderVisible ?? this.isHeaderVisible,
      isGridVisible: isGridVisible ?? this.isGridVisible,
      isFooterVisible: isFooterVisible ?? this.isFooterVisible,
      cardVisibilities: cardVisibilities ?? this.cardVisibilities,
    );
  }
}

// StateNotifier for managing services animations
class ServicesAnimationNotifier extends StateNotifier<ServicesAnimationState> {
  ServicesAnimationNotifier() : super(const ServicesAnimationState()) {
    _initializeCardVisibilities();
  }

  void _initializeCardVisibilities() {
    // Initialize 6 cards as not visible
    state = state.copyWith(
      cardVisibilities: List.generate(6, (index) => false),
    );
  }

  void triggerSectionVisible() {
    if (!state.isHeaderVisible) {
      _animateHeader();
    }
  }

  void _animateHeader() async {
    // Animate header first
    state = state.copyWith(isHeaderVisible: true);

    // Wait a bit, then animate grid
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(isGridVisible: true);

    // Animate cards one by one
    _animateCards();

    // Wait a bit more, then animate footer
    await Future.delayed(const Duration(milliseconds: 800));
    state = state.copyWith(isFooterVisible: true);
  }

  void _animateCards() async {
    final newCardVisibilities = List<bool>.from(state.cardVisibilities);

    for (int i = 0; i < newCardVisibilities.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      newCardVisibilities[i] = true;
      state = state.copyWith(cardVisibilities: newCardVisibilities);
    }
  }

  void resetAnimation() {
    state = const ServicesAnimationState();
    _initializeCardVisibilities();
  }
}

// Provider for the services animation
final servicesAnimationProvider = StateNotifierProvider<ServicesAnimationNotifier, ServicesAnimationState>(
      (ref) => ServicesAnimationNotifier(),
);