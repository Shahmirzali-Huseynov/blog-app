class StatusModels {
  final int maximumValue;
  final int minumumValue;

  StatusModels({
    required this.maximumValue,
    required this.minumumValue,
  }) : assert(maximumValue > minumumValue);
}
