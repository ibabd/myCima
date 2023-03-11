class CategoryModel {
  String? id;
  String ?termId;
  String? title;
  String? year;
  int? author;
  String? thumbnailUrl;

  CategoryModel(
      {this.id,this.termId, this.title, this.year, this.author, this.thumbnailUrl});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    termId = json['termID'];
    title = json['title'];
    year = json['year'];
    author = json['author'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['termID'] = termId;
    data['title'] = title;
    data['year'] = year;
    data['author'] = author;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }
}