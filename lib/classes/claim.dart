

class Claimer{
  int claimId;
  int itemId;
  int claimerId;
  String claimStatus;
  String claimerContact;
  DateTime claimDate = DateTime.now();
  

  Claimer({
    required this.claimId,
    required this.itemId,
    required this.claimerId,
    required this.claimStatus,
    required this.claimerContact
  });

  void makeClaim(){
    print("Claim created for item $itemId by user $claimerId.");
  }

  void updateClaimStatus(String newStatus){
    this.claimStatus = newStatus;
    print("Claim status for item $itemId updated to $newStatus.");
  }

  void viewClaim(){
    print("Viewing claim $claimId for item $itemId by user $claimerId.");
  }

  void deleteClaim(){
    print("Claim $claimId for item $itemId deleted.");
  }

  





}