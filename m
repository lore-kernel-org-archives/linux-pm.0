From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v6 2/9] tools lib traceevent: Generalize numeric argument
Date: Fri,  5 Dec 2014 19:04:13 +0000
Message-ID: <1417806260-9264-3-git-send-email-javi.merino@arm.com>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: punit.agrawal@arm.com, broonie@kernel.org, Javi Merino <javi.merino@arm.com>, Steven Rostedt <srostedt@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-pm@vger.kernel.org

Numeric arguments can be in different bases, so rename it to num so
that they can be used for formats other than PRINT_HEX

Cc: Steven Rostedt <srostedt@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 tools/lib/traceevent/event-parse.c | 26 +++++++++++++-------------
 tools/lib/traceevent/event-parse.h |  4 ++--
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/even=
t-parse.c
index cf3a44bf1ec3..f12ea53cc83b 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -754,8 +754,8 @@ static void free_arg(struct print_arg *arg)
 =09=09free_flag_sym(arg->symbol.symbols);
 =09=09break;
 =09case PRINT_HEX:
-=09=09free_arg(arg->hex.field);
-=09=09free_arg(arg->hex.size);
+=09=09free_arg(arg->num.field);
+=09=09free_arg(arg->num.size);
 =09=09break;
 =09case PRINT_TYPE:
 =09=09free(arg->typecast.type);
@@ -2503,7 +2503,7 @@ process_hex(struct event_format *event, struct print_=
arg *arg, char **tok)
 =09if (test_type_token(type, token, EVENT_DELIM, ","))
 =09=09goto out_free;
=20
-=09arg->hex.field =3D field;
+=09arg->num.field =3D field;
=20
 =09free_token(token);
=20
@@ -2519,7 +2519,7 @@ process_hex(struct event_format *event, struct print_=
arg *arg, char **tok)
 =09if (test_type_token(type, token, EVENT_DELIM, ")"))
 =09=09goto out_free;
=20
-=09arg->hex.size =3D field;
+=09arg->num.size =3D field;
=20
 =09free_token(token);
 =09type =3D read_token_item(tok);
@@ -3740,24 +3740,24 @@ static void print_str_arg(struct trace_seq *s, void=
 *data, int size,
 =09=09}
 =09=09break;
 =09case PRINT_HEX:
-=09=09if (arg->hex.field->type =3D=3D PRINT_DYNAMIC_ARRAY) {
+=09=09if (arg->num.field->type =3D=3D PRINT_DYNAMIC_ARRAY) {
 =09=09=09unsigned long offset;
 =09=09=09offset =3D pevent_read_number(pevent,
-=09=09=09=09data + arg->hex.field->dynarray.field->offset,
-=09=09=09=09arg->hex.field->dynarray.field->size);
+=09=09=09=09data + arg->num.field->dynarray.field->offset,
+=09=09=09=09arg->num.field->dynarray.field->size);
 =09=09=09hex =3D data + (offset & 0xffff);
 =09=09} else {
-=09=09=09field =3D arg->hex.field->field.field;
+=09=09=09field =3D arg->num.field->field.field;
 =09=09=09if (!field) {
-=09=09=09=09str =3D arg->hex.field->field.name;
+=09=09=09=09str =3D arg->num.field->field.name;
 =09=09=09=09field =3D pevent_find_any_field(event, str);
 =09=09=09=09if (!field)
 =09=09=09=09=09goto out_warning_field;
-=09=09=09=09arg->hex.field->field.field =3D field;
+=09=09=09=09arg->num.field->field.field =3D field;
 =09=09=09}
 =09=09=09hex =3D data + field->offset;
 =09=09}
-=09=09len =3D eval_num_arg(data, size, event, arg->hex.size);
+=09=09len =3D eval_num_arg(data, size, event, arg->num.size);
 =09=09for (i =3D 0; i < len; i++) {
 =09=09=09if (i)
 =09=09=09=09trace_seq_putc(s, ' ');
@@ -4923,9 +4923,9 @@ static void print_args(struct print_arg *args)
 =09=09break;
 =09case PRINT_HEX:
 =09=09printf("__print_hex(");
-=09=09print_args(args->hex.field);
+=09=09print_args(args->num.field);
 =09=09printf(", ");
-=09=09print_args(args->hex.size);
+=09=09print_args(args->num.size);
 =09=09printf(")");
 =09=09break;
 =09case PRINT_STRING:
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/even=
t-parse.h
index 7a3873ff9a4f..2bf72e908a74 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -240,7 +240,7 @@ struct print_arg_symbol {
 =09struct print_flag_sym=09*symbols;
 };
=20
-struct print_arg_hex {
+struct print_arg_num {
 =09struct print_arg=09*field;
 =09struct print_arg=09*size;
 };
@@ -291,7 +291,7 @@ struct print_arg {
 =09=09struct print_arg_typecast=09typecast;
 =09=09struct print_arg_flags=09=09flags;
 =09=09struct print_arg_symbol=09=09symbol;
-=09=09struct print_arg_hex=09=09hex;
+=09=09struct print_arg_num=09=09num;
 =09=09struct print_arg_func=09=09func;
 =09=09struct print_arg_string=09=09string;
 =09=09struct print_arg_bitmask=09bitmask;
--=20
1.9.1
