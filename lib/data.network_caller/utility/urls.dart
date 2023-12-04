import 'package:task_manager_live_app/widgets/task_item_card.dart';

class Urls {
  static const _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const registration = "$_baseUrl/registration";
  static const login = "$_baseUrl/login";
  static const createNewTask = "$_baseUrl/createTask";
  static const getTaskSummeryCount = "$_baseUrl/taskStatusCount";
  static const updateProfile = "$_baseUrl/profileUpdate";
  static const resetPassword = "$_baseUrl/RecoverResetPass";

  static String recoverEmail(String email) => "$_baseUrl/RecoverVerifyEmail/${email}";
  static String pinVerification(String email, otp) => "$_baseUrl/RecoverVerifyOTP/${email}/${otp}";



  static String getNewTask = "$_baseUrl/ListTaskByStatus/${TaskStatus.New.name}";
  static String getProgressTask = "$_baseUrl/ListTaskByStatus/${TaskStatus.Progress.name}";
  static String getComplitedTask = "$_baseUrl/ListTaskByStatus/${TaskStatus.Completed.name}";
  static String getCancelledTask = "$_baseUrl/ListTaskByStatus/${TaskStatus.Cancelled.name}";



  static String UpdateTaskStatus(String taskId,String status) => "$_baseUrl/updateTaskStatus/$taskId/$status";



}