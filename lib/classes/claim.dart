class Claim {
  int claimId;
  int itemId;
  int claimerId;
  String status;
  DateTime claimDate;

  Claim({
    required this.claimId,
    required this.itemId,
    required this.claimerId,
    required this.status,
  }) : claimDate = DateTime.now();
}
