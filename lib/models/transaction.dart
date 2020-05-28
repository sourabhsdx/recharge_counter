class TransactionClass {
  String name;
  String operator;
  String time;
  bool paid;
  String number;
  double amount;

  TransactionClass(
      {this.name,
        this.operator,
        this.time,
        this.paid,
        this.number,
        this.amount});

  TransactionClass.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    operator = json['operator'];
    time = json['time'];
    paid = json['paid'];
    number = json['number'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['operator'] = this.operator;
    data['time'] = this.time;
    data['paid'] = this.paid;
    data['number'] = this.number;
    data['amount'] = this.amount;
    return data;
  }
}