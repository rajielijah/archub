class JobModel {
  String id, userId, companyName, staffCapacity, contactEmail, inEquiryPhoneNumber, 
  country, city, jobTitle, salary, jobDescription, applicationShouldBeSentTo, submitResume, logo, createdAt;
  
  JobModel({
    this.id,
    this.userId,
    this.country,
    this.city,
    this.applicationShouldBeSentTo,
    this.companyName,
    this.contactEmail,
    this.createdAt,
    this.inEquiryPhoneNumber,
    this.jobDescription,
    this.jobTitle,
    this.logo,
    this.salary,
    this.staffCapacity,
    this.submitResume
  });
}