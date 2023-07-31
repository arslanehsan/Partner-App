class Evaluation {
  String id;
  String answer, evaluationDate, name, userId, userPartnerId;
  int number_of_questions;

  Evaluation({
    required this.id,
    required this.answer,
    required this.evaluationDate,
    required this.name,
    required this.userId,
    required this.userPartnerId,
    required this.number_of_questions,
  });

  factory Evaluation.fromJson(Map<dynamic, dynamic> json) {
    print('user DATA GETTING $json');
    // print('user DATA GETTING ${json['uid']}');
    return Evaluation(
      id: json['id'],
      answer: json['answer'],
      evaluationDate: json['evaluationDate'],
      name: json['name'] ?? '',
      userId: json['userId'] ?? '',
      userPartnerId: json['userPartnerId'] ?? '',
      number_of_questions: json['number_of_questions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['answer'] = answer;
    data['evaluationDate'] = evaluationDate;
    data['name'] = name;
    data['userId'] = userId;
    data['userPartnerId'] = userPartnerId;
    data['number_of_questions'] = number_of_questions;
    return data;
  }
}
