class PostData {
  String id, description, title, attachmentName, attachmentSize, createdAt, updatedAt;
  List<dynamic> reactions, postFiles;
  bool isActive;
  int numberOfComments;
  Map<String, dynamic> sourceId;
  
  PostData({
    this.id,
    this.attachmentName,
    this.attachmentSize,
    this.createdAt,
    this.description,
    this.isActive,
    this.reactions,
    this.sourceId,
    this.updatedAt,
    this.title,
    this.numberOfComments,
    this.postFiles
  });

}