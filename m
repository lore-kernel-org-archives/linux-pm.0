From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v6 3/9] tools lib traceevent: Add support for __print_u{8,16,32,64}_array()
Date: Fri,  5 Dec 2014 19:04:14 +0000
Message-ID: <1417806260-9264-4-git-send-email-javi.merino@arm.com>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: punit.agrawal@arm.com, broonie@kernel.org, Javi Merino <javi.merino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Steven Rostedt <srostedt@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-pm@vger.kernel.org

Trace can now generate traces with u8, u16, u32 and u64 dynamic
arrays.  Add support to parse them.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Steven Rostedt <srostedt@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 tools/lib/traceevent/event-parse.c | 62 ++++++++++++++++++++++++++++++++++=
+---
 tools/lib/traceevent/event-parse.h |  4 +++
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/even=
t-parse.c
index f12ea53cc83b..f67260bddd65 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -753,6 +753,10 @@ static void free_arg(struct print_arg *arg)
 =09=09free_arg(arg->symbol.field);
 =09=09free_flag_sym(arg->symbol.symbols);
 =09=09break;
+=09case PRINT_U8:
+=09case PRINT_U16:
+=09case PRINT_U32:
+=09case PRINT_U64:
 =09case PRINT_HEX:
 =09=09free_arg(arg->num.field);
 =09=09free_arg(arg->num.size);
@@ -2827,6 +2831,22 @@ process_function(struct event_format *event, struct =
print_arg *arg,
 =09=09free_token(token);
 =09=09return process_hex(event, arg, tok);
 =09}
+=09if (strcmp(token, "__print_u8_array") =3D=3D 0) {
+=09=09free_token(token);
+=09=09return process_num(event, arg, tok, PRINT_U8);
+=09}
+=09if (strcmp(token, "__print_u16_array") =3D=3D 0) {
+=09=09free_token(token);
+=09=09return process_num(event, arg, tok, PRINT_U16);
+=09}
+=09if (strcmp(token, "__print_u32_array") =3D=3D 0) {
+=09=09free_token(token);
+=09=09return process_num(event, arg, tok, PRINT_U32);
+=09}
+=09if (strcmp(token, "__print_u64_array") =3D=3D 0) {
+=09=09free_token(token);
+=09=09return process_num(event, arg, tok, PRINT_U64);
+=09}
 =09if (strcmp(token, "__get_str") =3D=3D 0) {
 =09=09free_token(token);
 =09=09return process_str(event, arg, tok);
@@ -3355,6 +3375,10 @@ eval_num_arg(void *data, int size, struct event_form=
at *event, struct print_arg
 =09=09break;
 =09case PRINT_FLAGS:
 =09case PRINT_SYMBOL:
+=09case PRINT_U8:
+=09case PRINT_U16:
+=09case PRINT_U32:
+=09case PRINT_U64:
 =09case PRINT_HEX:
 =09=09break;
 =09case PRINT_TYPE:
@@ -3660,7 +3684,7 @@ static void print_str_arg(struct trace_seq *s, void *=
data, int size,
 =09unsigned long long val, fval;
 =09unsigned long addr;
 =09char *str;
-=09unsigned char *hex;
+=09void *num;
 =09int print;
 =09int i, len;
=20
@@ -3739,13 +3763,17 @@ static void print_str_arg(struct trace_seq *s, void=
 *data, int size,
 =09=09=09}
 =09=09}
 =09=09break;
+=09case PRINT_U8:
+=09case PRINT_U16:
+=09case PRINT_U32:
+=09case PRINT_U64:
 =09case PRINT_HEX:
 =09=09if (arg->num.field->type =3D=3D PRINT_DYNAMIC_ARRAY) {
 =09=09=09unsigned long offset;
 =09=09=09offset =3D pevent_read_number(pevent,
 =09=09=09=09data + arg->num.field->dynarray.field->offset,
 =09=09=09=09arg->num.field->dynarray.field->size);
-=09=09=09hex =3D data + (offset & 0xffff);
+=09=09=09num =3D data + (offset & 0xffff);
 =09=09} else {
 =09=09=09field =3D arg->num.field->field.field;
 =09=09=09if (!field) {
@@ -3755,13 +3783,24 @@ static void print_str_arg(struct trace_seq *s, void=
 *data, int size,
 =09=09=09=09=09goto out_warning_field;
 =09=09=09=09arg->num.field->field.field =3D field;
 =09=09=09}
-=09=09=09hex =3D data + field->offset;
+=09=09=09num =3D data + field->offset;
 =09=09}
 =09=09len =3D eval_num_arg(data, size, event, arg->num.size);
 =09=09for (i =3D 0; i < len; i++) {
 =09=09=09if (i)
 =09=09=09=09trace_seq_putc(s, ' ');
-=09=09=09trace_seq_printf(s, "%02x", hex[i]);
+=09=09=09if (arg->type =3D=3D PRINT_HEX)
+=09=09=09=09trace_seq_printf(s, "%02x",
+=09=09=09=09=09=09((uint8_t *)num)[i]);
+=09=09=09else if (arg->type =3D=3D PRINT_U8)
+=09=09=09=09trace_seq_printf(s, "%u", ((uint8_t *)num)[i]);
+=09=09=09else if (arg->type =3D=3D PRINT_U16)
+=09=09=09=09trace_seq_printf(s, "%u", ((uint16_t *)num)[i]);
+=09=09=09else if (arg->type =3D=3D PRINT_U32)
+=09=09=09=09trace_seq_printf(s, "%u", ((uint32_t *)num)[i]);
+=09=09=09else    /* PRINT_U64 */
+=09=09=09=09trace_seq_printf(s, "%lu",
+=09=09=09=09=09=09((uint64_t *)num)[i]);
 =09=09}
 =09=09break;
=20
@@ -4922,7 +4961,20 @@ static void print_args(struct print_arg *args)
 =09=09printf(")");
 =09=09break;
 =09case PRINT_HEX:
-=09=09printf("__print_hex(");
+=09case PRINT_U8:
+=09case PRINT_U16:
+=09case PRINT_U32:
+=09case PRINT_U64:
+=09=09if (args->type =3D=3D PRINT_HEX)
+=09=09=09printf("__print_hex(");
+=09=09else if (args->type =3D=3D PRINT_U8)
+=09=09=09printf("__print_u8_array(");
+=09=09else if (args->type =3D=3D PRINT_U16)
+=09=09=09printf("__print_u16_array(");
+=09=09else if (args->type =3D=3D PRINT_U32)
+=09=09=09printf("__print_u32_array(");
+=09=09else /* PRINT_U64 */
+=09=09=09printf("__print_u64_array(");
 =09=09print_args(args->num.field);
 =09=09printf(", ");
 =09=09print_args(args->num.size);
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/even=
t-parse.h
index 2bf72e908a74..51f1f0f0a3b5 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -272,6 +272,10 @@ enum print_arg_type {
 =09PRINT_FIELD,
 =09PRINT_FLAGS,
 =09PRINT_SYMBOL,
+=09PRINT_U8,
+=09PRINT_U16,
+=09PRINT_U32,
+=09PRINT_U64,
 =09PRINT_HEX,
 =09PRINT_TYPE,
 =09PRINT_STRING,
--=20
1.9.1
