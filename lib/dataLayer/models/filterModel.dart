class FilterModel {
  String? taxonomy;
  List<Terms>? terms;

  FilterModel({this.taxonomy, this.terms});

  FilterModel.fromJson(Map<String, dynamic> json) {
    taxonomy = json['taxonomy'];
    if (json['terms'] != null) {
      terms = <Terms>[];
      json['terms'].forEach((v) {
        terms!.add(Terms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taxonomy'] = taxonomy;
    if (terms != null) {
      data['terms'] = terms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Terms {
  int? termId;
  String? slug;
  String? name;

  Terms({this.termId, this.slug, this.name});

  Terms.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    slug = json['slug'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['slug'] = slug;
    data['name'] = name;
    return data;
  }
}
