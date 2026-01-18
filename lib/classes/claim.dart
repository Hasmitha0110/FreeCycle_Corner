import 'package:cloud_firestore/cloud_firestore.dart';

class Claim {
  String claimId;
  String itemId;
  String claimerId;
  String status;
  DateTime claimDate;

  Claim({
    required this.claimId,
    required this.itemId,
    required this.claimerId,
    required this.status,
    DateTime? claimDate,
  }) : claimDate = claimDate ?? DateTime.now();

  factory Claim.fromMap(String id, Map<String, dynamic> data) {
    return Claim(
      claimId: id,
      itemId: data['itemId'] ?? '',
      claimerId: data['claimerId'] ?? '',
      status: data['status'] ?? '',
      claimDate: (data['claimDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'claimerId': claimerId,
      'status': status,
      'claimDate': Timestamp.fromDate(claimDate),
    };
  }
}