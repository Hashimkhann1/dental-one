import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// State class for our expert section animation
class OurExpertAnimationState {
  final bool isHeaderVisible;
  final bool isTeamSectionVisible;
  final bool isWhyChooseSectionVisible;
  final List<bool> teamMemberVisibilities;
  final List<bool> featureVisibilities;

  const OurExpertAnimationState({
    this.isHeaderVisible = false,
    this.isTeamSectionVisible = false,
    this.isWhyChooseSectionVisible = false,
    this.teamMemberVisibilities = const [],
    this.featureVisibilities = const [],
  });

  OurExpertAnimationState copyWith({
    bool? isHeaderVisible,
    bool? isTeamSectionVisible,
    bool? isWhyChooseSectionVisible,
    List<bool>? teamMemberVisibilities,
    List<bool>? featureVisibilities,
  }) {
    return OurExpertAnimationState(
      isHeaderVisible: isHeaderVisible ?? this.isHeaderVisible,
      isTeamSectionVisible: isTeamSectionVisible ?? this.isTeamSectionVisible,
      isWhyChooseSectionVisible: isWhyChooseSectionVisible ?? this.isWhyChooseSectionVisible,
      teamMemberVisibilities: teamMemberVisibilities ?? this.teamMemberVisibilities,
      featureVisibilities: featureVisibilities ?? this.featureVisibilities,
    );
  }
}

// StateNotifier for managing our expert section animations
class OurExpertAnimationNotifier extends StateNotifier<OurExpertAnimationState> {
  OurExpertAnimationNotifier() : super(const OurExpertAnimationState()) {
    _initializeVisibilities();
  }

  void _initializeVisibilities() {
    // Initialize 3 team members and 3 features as not visible
    state = state.copyWith(
      teamMemberVisibilities: List.generate(3, (index) => false),
      featureVisibilities: List.generate(3, (index) => false),
    );
  }

  void triggerSectionVisible() {
    if (!state.isHeaderVisible) {
      _animateSection();
    }
  }

  void _animateSection() async {
    // Animate header first
    state = state.copyWith(isHeaderVisible: true);

    // Wait a bit, then animate team section
    await Future.delayed(const Duration(milliseconds: 400));
    state = state.copyWith(isTeamSectionVisible: true);

    // Animate team members one by one
    _animateTeamMembers();

    // Wait for team members, then animate why choose section
    await Future.delayed(const Duration(milliseconds: 1000));
    state = state.copyWith(isWhyChooseSectionVisible: true);

    // Animate features
    _animateFeatures();
  }

  void _animateTeamMembers() async {
    final newTeamVisibilities = List<bool>.from(state.teamMemberVisibilities);

    for (int i = 0; i < newTeamVisibilities.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      newTeamVisibilities[i] = true;
      state = state.copyWith(teamMemberVisibilities: newTeamVisibilities);
    }
  }

  void _animateFeatures() async {
    final newFeatureVisibilities = List<bool>.from(state.featureVisibilities);

    for (int i = 0; i < newFeatureVisibilities.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      newFeatureVisibilities[i] = true;
      state = state.copyWith(featureVisibilities: newFeatureVisibilities);
    }
  }

  void resetAnimation() {
    state = const OurExpertAnimationState();
    _initializeVisibilities();
  }
}

// Provider for the our expert section animation
final ourExpertAnimationProvider = StateNotifierProvider<OurExpertAnimationNotifier, OurExpertAnimationState>(
      (ref) => OurExpertAnimationNotifier(),
);