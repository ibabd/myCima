class MenuModel {
  String? name;
  String ?id;
  String ?type;
  List<Children> ?children;

  MenuModel({this.name, this.id, this.type, this.children});

  MenuModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    type = json['type'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add( Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['type'] = type;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String ?name;
  String? id;
  String ?type;

  Children({this.name, this.id, this.type});

  Children.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}

