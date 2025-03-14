class ProfileRequest {
  final String phone; // Add phone number
  final String whoYouAre;
  final String name;
  final String email;
  final String age;
  final String location;
  final String diagnosis;
  final String currentStage;
  final String loanNeed;

  ProfileRequest({
    required this.phone, // Include phone
    required this.whoYouAre,
    required this.name,
    required this.email,
    required this.age,
    required this.location,
    required this.diagnosis,
    required this.currentStage,
    required this.loanNeed,
  });

  Map<String, dynamic> toJson() {
    return {
      "phone": phone, // Include phone in the JSON request
      "whoYouAre": whoYouAre,
      "name": name,
      "email": email,
      "age": age,
      "location": location,
      "diagnosis": diagnosis,
      "currentStage": currentStage,
      "loanNeed": loanNeed,
    };
  }
}
