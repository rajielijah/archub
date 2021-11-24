class User {
  List<dynamic> followers, following, skills, socialLinks;
  String id, fullName, email, password, pictureUrl,phone, city, country, location, bio,role;
  
  User({
    this.id,
    this.email,
    this.phone,
    this.password,
    this.fullName,
    this.pictureUrl,
    this.city,
    this.country,
    this.location,
    this.followers,
    this.following,
    this.skills,
    this.socialLinks,
    this.bio,
    this.role
  });
}
