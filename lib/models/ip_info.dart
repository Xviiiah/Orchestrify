class IPInfo {
  String ip;
  String id;

  IPInfo({required this.ip, required this.id});

  IPInfo toObject(Map<String, dynamic> data) =>
      IPInfo(ip: data['ip'], id: data['id']);
}
