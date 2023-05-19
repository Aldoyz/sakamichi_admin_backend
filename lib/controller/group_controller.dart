import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:sakamichi_admin/models/general_response.dart';
import 'package:sakamichi_admin/models/group_model.dart';
import 'package:sakamichi_admin/services/group_service.dart';

class GroupController {
  static Future<Response> addGroup(RequestContext context) async {
    final groupService = context.read<GroupService>();
    final group = Group.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    await groupService.insert(group);
    return Response.json(
      statusCode: HttpStatus.created,
      body: GeneralResponse(
        status: true,
        message: 'New Group Successfully Added',
      ),
    );
  }

  static Future<Response> updateGroup(RequestContext context, int id) async {
    final groupService = context.read<GroupService>();
    final updatedGroup = Group.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    await groupService.update(id, updatedGroup);
    return Response.json(
      body: GeneralResponse(
        status: true,
        message: 'Chosen Group Has Been Updated',
      ),
    );
  }

  static Future<Response> deleteGroup(RequestContext context, int id) async {
    final groupService = context.read<GroupService>();
    await groupService.delete(id);
    return Response.json(
      body: GeneralResponse(
        status: true,
        message: 'Chosen Group Has Been Deleted',
      ),
    );
  }

  static Future<Response> getGroup(RequestContext context, int id) async {
    final groupService = context.read<GroupService>();
    final data = await groupService.selectOne(id);
    return Response.json(
      body: GeneralResponse(
        status: true,
        message: 'Chosen Group Has Been Shown',
        data: data,
      ),
    );
  }

  static Future<Response> listAllGroup(RequestContext context) async {
    final groupService = context.read<GroupService>();
    final data = await groupService.listAll();
    return Response.json(
      body: GeneralResponse(
        status: true,
        message: 'All Group Has Been Listed',
        data: data,
      ),
    );
  }
}
