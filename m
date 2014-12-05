From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v6 1/9] tracing: Add array printing helpers
Date: Fri,  5 Dec 2014 19:04:12 +0000
Message-ID: <1417806260-9264-2-git-send-email-javi.merino@arm.com>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33408 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbaLETFG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Dec 2014 14:05:06 -0500
In-Reply-To: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: punit.agrawal@arm.com, broonie@kernel.org, Dave Martin <Dave.Martin@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>

From: Dave Martin <Dave.Martin@arm.com>

If a trace event contains an array, there is currently no standard
way to format this for text output.  Drivers are currently hacking
around this by a) local hacks that use the trace_seq functionailty
directly, or b) just not printing that information.  For fixed size
arrays, formatting of the elements can be open-coded, but this gets
cumbersome for arrays of non-trivial size.

These approaches result in non-standard content of the event format
description delivered to userspace, so userland tools needs to be
taught to understand and parse each array printing method
individually.

This patch implements common __print_<type>_array() helpers that
tracepoint implementations can use instead of reinventing them.  A
simple C-style syntax is used to delimit the array and its elements
{like,this}.

So that the helpers can be used with large static arrays as well as
dynamic arrays, they take a pointer and element count: they can be
used with __get_dynamic_array() for use with dynamic arrays.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 include/linux/ftrace_event.h |  9 ++++++++
 include/trace/ftrace.h       | 17 +++++++++++++++
 kernel/trace/trace_output.c  | 51 ++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 77 insertions(+)

diff --git a/include/linux/ftrace_event.h b/include/linux/ftrace_event.h
index 28672e87e910..415afc53fa51 100644
--- a/include/linux/ftrace_event.h
+++ b/include/linux/ftrace_event.h
@@ -44,6 +44,15 @@ const char *ftrace_print_bitmask_seq(struct trace_seq *p=
, void *bitmask_ptr,
 const char *ftrace_print_hex_seq(struct trace_seq *p,
 =09=09=09=09 const unsigned char *buf, int len);
=20
+const char *ftrace_print_u8_array_seq(struct trace_seq *p,
+=09=09=09=09      const u8 *buf, int count);
+const char *ftrace_print_u16_array_seq(struct trace_seq *p,
+=09=09=09=09       const u16 *buf, int count);
+const char *ftrace_print_u32_array_seq(struct trace_seq *p,
+=09=09=09=09       const u32 *buf, int count);
+const char *ftrace_print_u64_array_seq(struct trace_seq *p,
+=09=09=09=09       const u64 *buf, int count);
+
 struct trace_iterator;
 struct trace_event;
=20
diff --git a/include/trace/ftrace.h b/include/trace/ftrace.h
index 26b4f2e13275..15bc5d417aea 100644
--- a/include/trace/ftrace.h
+++ b/include/trace/ftrace.h
@@ -263,6 +263,19 @@
 #undef __print_hex
 #define __print_hex(buf, buf_len) ftrace_print_hex_seq(p, buf, buf_len)
=20
+#undef __print_u8_array
+#define __print_u8_array(array, count)=09=09=09\
+=09ftrace_print_u8_array_seq(p, array, count)
+#undef __print_u16_array
+#define __print_u16_array(array, count)=09=09=09\
+=09ftrace_print_u16_array_seq(p, array, count)
+#undef __print_u32_array
+#define __print_u32_array(array, count)=09=09=09\
+=09ftrace_print_u32_array_seq(p, array, count)
+#undef __print_u64_array
+#define __print_u64_array(array, count)=09=09=09\
+=09ftrace_print_u64_array_seq(p, array, count)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)=09\
 static notrace enum print_line_t=09=09=09=09=09\
@@ -676,6 +689,10 @@ static inline void ftrace_test_probe_##call(void)=09=
=09=09\
 #undef __get_dynamic_array_len
 #undef __get_str
 #undef __get_bitmask
+#undef __print_u8_array
+#undef __print_u16_array
+#undef __print_u32_array
+#undef __print_u64_array
=20
 #undef TP_printk
 #define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index c6977d5a9b12..4a6ee61f30b3 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -186,6 +186,57 @@ ftrace_print_hex_seq(struct trace_seq *p, const unsign=
ed char *buf, int buf_len)
 }
 EXPORT_SYMBOL(ftrace_print_hex_seq);
=20
+static const char *
+ftrace_print_array_seq(struct trace_seq *p, const void *buf, int buf_len,
+=09=09       bool (*iterator)(struct trace_seq *p, const char *prefix,
+=09=09=09=09=09const void **buf, int *buf_len))
+{
+=09const char *ret =3D trace_seq_buffer_ptr(p);
+=09const char *prefix =3D "";
+
+=09trace_seq_putc(p, '{');
+
+=09while (iterator(p, prefix, &buf, &buf_len))
+=09=09prefix =3D ",";
+
+=09trace_seq_putc(p, '}');
+=09trace_seq_putc(p, 0);
+
+=09return ret;
+}
+
+#define DEFINE_PRINT_ARRAY(type, printk_type, format)=09=09=09\
+static bool=09=09=09=09=09=09=09=09\
+ftrace_print_array_iterator_##type(struct trace_seq *p, const char *prefix=
, \
+=09=09=09=09   const void **buf, int *buf_len)=09\
+{=09=09=09=09=09=09=09=09=09\
+=09const type *__src =3D *buf;=09=09=09=09=09\
+=09=09=09=09=09=09=09=09=09\
+=09if (*buf_len < sizeof(*__src))=09=09=09=09=09\
+=09=09return false;=09=09=09=09=09=09\
+=09=09=09=09=09=09=09=09=09\
+=09trace_seq_printf(p, "%s" format, prefix, (printk_type)*__src++); \
+=09=09=09=09=09=09=09=09=09\
+=09*buf =3D __src;=09=09=09=09=09=09=09\
+=09*buf_len -=3D sizeof(*__src);=09=09=09=09=09\
+=09=09=09=09=09=09=09=09=09\
+=09return true;=09=09=09=09=09=09=09\
+}=09=09=09=09=09=09=09=09=09\
+=09=09=09=09=09=09=09=09=09\
+const char *ftrace_print_##type##_array_seq(=09=09=09=09\
+=09struct trace_seq *p, const type *buf, int count)=09=09\
+{=09=09=09=09=09=09=09=09=09\
+=09return ftrace_print_array_seq(p, buf, (count) * sizeof(type),=09\
+=09=09=09=09      ftrace_print_array_iterator_##type); \
+}=09=09=09=09=09=09=09=09=09\
+=09=09=09=09=09=09=09=09=09\
+EXPORT_SYMBOL(ftrace_print_##type##_array_seq)
+
+DEFINE_PRINT_ARRAY(u8, unsigned int, "0x%x");
+DEFINE_PRINT_ARRAY(u16, unsigned int, "0x%x");
+DEFINE_PRINT_ARRAY(u32, unsigned int, "0x%x");
+DEFINE_PRINT_ARRAY(u64, unsigned long long, "0x%llx");
+
 int ftrace_raw_output_prep(struct trace_iterator *iter,
 =09=09=09   struct trace_event *trace_event)
 {
--=20
1.9.1


