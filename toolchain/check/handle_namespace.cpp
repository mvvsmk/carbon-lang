// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "toolchain/check/context.h"
#include "toolchain/check/decl_state.h"
#include "toolchain/check/modifiers.h"
#include "toolchain/sem_ir/ids.h"
#include "toolchain/sem_ir/inst.h"

namespace Carbon::Check {

auto HandleNamespaceStart(Context& context, Parse::NodeId /*parse_node*/)
    -> bool {
  // Optional modifiers and the name follow.
  context.decl_state_stack().Push(DeclState::Namespace);
  context.decl_name_stack().PushScopeAndStartName();
  return true;
}

auto HandleNamespace(Context& context, Parse::NodeId parse_node) -> bool {
  auto name_context = context.decl_name_stack().FinishName();
  LimitModifiersOnDecl(context, KeywordModifierSet::None,
                       Lex::TokenKind::Namespace);
  auto namespace_inst = SemIR::Namespace{
      parse_node, context.GetBuiltinType(SemIR::BuiltinKind::NamespaceType),
      SemIR::NameScopeId::Invalid};
  auto namespace_id = context.AddInst(namespace_inst);
  namespace_inst.name_scope_id = context.name_scopes().Add(namespace_id);
  context.insts().Set(namespace_id, namespace_inst);
  context.decl_name_stack().AddNameToLookup(name_context, namespace_id);

  context.decl_name_stack().PopScope();
  context.decl_state_stack().Pop(DeclState::Namespace);
  return true;
}

}  // namespace Carbon::Check
