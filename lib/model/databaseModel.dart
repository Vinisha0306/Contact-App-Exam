class Contact {
  int id;
  String name;
  String contact;

  Contact(this.id, this.name, this.contact);

  factory Contact.fromSQL({required Map data}) => Contact(
        data['id'],
        data['name'],
        data['contact'],
      );

  Map<String, dynamic> get getContact => {
        "id": id,
        "name": name,
        "contact": contact,
      };
}
