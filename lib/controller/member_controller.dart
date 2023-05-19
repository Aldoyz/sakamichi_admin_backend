import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:sakamichi_admin/models/general_response.dart';
import 'package:sakamichi_admin/models/member_model.dart';
import 'package:sakamichi_admin/services/member_service.dart';

class MemberController {
  static Future<Response> addMember(RequestContext context) async {
    final memberService = context.read<MemberService>();
    final member = Member.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    await memberService.insert(member);
    return Response.json(
      statusCode: HttpStatus.created,
      body: GeneralResponse(
        status: true,
        message: 'New Member Successfully Added',
      ),
    );
  }

  static Future<Response> updateMember(RequestContext context, int id) async {
    final memberService = context.read<MemberService>();
    final updatedMember = Member.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    await memberService.update(id, updatedMember);
    return Response.json(
      body: GeneralResponse(
        status: true,
        message: 'Chosen Member Has Been Updated',
      ),
    );
  }

  static Future<Response> deleteMember(RequestContext context, int id) async {
    final memberService = context.read<MemberService>();
    await memberService.delete(id);
    return Response.json(
      body: GeneralResponse(
        status: true,
        message: 'Chosen Member Has Been Deleted',
      ),
    );
  }

  static Future<Response> listAll(RequestContext context) async {
    final memberService = context.read<MemberService>();
    final data = await memberService.listAll();
    return Response.json(
      body: GeneralResponse(
        status: true,
        message: 'All Member Has Been Listed',
        data: data,
      ),
    );
  }

  static Future<Response> listByGroup(RequestContext context, int id) async {
    final memberService = context.read<MemberService>();
    final data = await memberService.listByGroup(id);
    return Response.json(
      body: GeneralResponse(
        status: true,
        message: 'Member From The Group Has Been Listed',
        data: data,
      ),
    );
  }

  static Future<Response> selectOne(RequestContext context, int id) async {
    final memberService = context.read<MemberService>();
    final data = await memberService.selectOne(id);
    return Response.json(
      body: GeneralResponse(
        status: true,
        message: 'Chosen Member Has Been Shown',
        data: data,
      ),
    );
  }

  static Future<Response> searchByName(
      RequestContext context, String name) async {
    final memberService = context.read<MemberService>();
    final data = await memberService.searchByName(name);
    return Response.json(
      body: GeneralResponse(
        status: true,
        message: 'Search Result Has Been Shown',
        data: data,
      ),
    );
  }
}
