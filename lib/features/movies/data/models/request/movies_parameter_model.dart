class MoviesParameterModel {
  String? apiKey;
  String? id;
  String? title;
  String? type;
  String? phone;
  String? search;

  MoviesParameterModel({
    required this.apiKey,
    this.id,
    this.title,
    this.type,
    this.search,
  });

  MoviesParameterModel.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
    id = json['i'];
    title = json['t'];
    type = json['type'];
    phone = json['Phone'];
    search = json['s'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (apiKey != null) {
      data['apiKey'] = apiKey;
    }
    if (id != null) {
      data['i'] = id;
    }
    if (title != null) {
      data['t'] = title;
    }
    if (type != null) {
      data['type'] = type;
    }
    if (phone != null) {
      data['Phone'] = phone;
    }
    if (search != null) {
      data['s'] = search;
    }
    return data;
  }
}
