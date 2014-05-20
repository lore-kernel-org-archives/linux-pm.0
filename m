From: Javi Merino <javi.merino@arm.com>
Subject: [RFC PATCH v2 1/7] tracing: Add __bitmask() macro to trace events to cpumasks and other bitmasks
Date: Tue, 20 May 2014 15:10:51 +0100
Message-ID: <1400595057-8585-2-git-send-email-javi.merino@arm.com>
References: <1400595057-8585-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400595057-8585-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Punit.Agrawal@arm.com, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Being able to show a cpumask of events can be useful as some events
may affect only some CPUs. There is no standard way to record the
cpumask and converting it to a string is rather expensive during
the trace as traces happen in hotpaths. It would be better to record
the raw event mask and be able to parse it at print time.

The following macros were added for use with the TRACE_EVENT() macro:

  __bitmask()
  __assign_bitmask()
  __get_bitmask()

To test this, I added this to the sched_migrate_task event, which
looked like this:

TRACE_EVENT(sched_migrate_task,

=09TP_PROTO(struct task_struct *p, int dest_cpu, const struct cpumask *cpus=
),

=09TP_ARGS(p, dest_cpu, cpus),

=09TP_STRUCT__entry(
=09=09__array(=09char,=09comm,=09TASK_COMM_LEN=09)
=09=09__field(=09pid_t,=09pid=09=09=09)
=09=09__field(=09int,=09prio=09=09=09)
=09=09__field(=09int,=09orig_cpu=09=09)
=09=09__field(=09int,=09dest_cpu=09=09)
=09=09__bitmask(=09cpumask, num_possible_cpus()=09)
=09),

=09TP_fast_assign(
=09=09memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
=09=09__entry->pid=09=09=3D p->pid;
=09=09__entry->prio=09=09=3D p->prio;
=09=09__entry->orig_cpu=09=3D task_cpu(p);
=09=09__entry->dest_cpu=09=3D dest_cpu;
=09=09__assign_bitmask(cpumask, cpumask_bits(cpus), num_possible_cpus());
=09),

=09TP_printk("comm=3D%s pid=3D%d prio=3D%d orig_cpu=3D%d dest_cpu=3D%d cpum=
ask=3D%s",
=09=09  __entry->comm, __entry->pid, __entry->prio,
=09=09  __entry->orig_cpu, __entry->dest_cpu,
=09=09  __get_bitmask(cpumask))
);

With the output of:

        ksmtuned-3613  [003] d..2   485.220508: sched_migrate_task: comm=3D=
ksmtuned pid=3D3615 prio=3D120 orig_cpu=3D3 dest_cpu=3D2 cpumask=3D00000000=
,0000000f
     migration/1-13    [001] d..5   485.221202: sched_migrate_task: comm=3D=
ksmtuned pid=3D3614 prio=3D120 orig_cpu=3D1 dest_cpu=3D0 cpumask=3D00000000=
,0000000f
             awk-3615  [002] d.H5   485.221747: sched_migrate_task: comm=3D=
rcu_preempt pid=3D7 prio=3D120 orig_cpu=3D0 dest_cpu=3D1 cpumask=3D00000000=
,000000ff
     migration/2-18    [002] d..5   485.222062: sched_migrate_task: comm=3D=
ksmtuned pid=3D3615 prio=3D120 orig_cpu=3D2 dest_cpu=3D3 cpumask=3D00000000=
,0000000f

Link: http://lkml.kernel.org/r/1399377998-14870-6-git-send-email-javi.merin=
o@arm.com
Link: http://lkml.kernel.org/r/20140506132238.22e136d1@gandalf.local.home

Suggested-by: Javi Merino <javi.merino@arm.com>
Tested-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/ftrace_event.h |    3 +++
 include/linux/trace_seq.h    |   10 ++++++++
 include/trace/ftrace.h       |   57 ++++++++++++++++++++++++++++++++++++++=
+++-
 kernel/trace/trace_output.c  |   41 ++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace_event.h b/include/linux/ftrace_event.h
index d16da3e53bc7..cff3106ffe2c 100644
--- a/include/linux/ftrace_event.h
+++ b/include/linux/ftrace_event.h
@@ -38,6 +38,9 @@ const char *ftrace_print_symbols_seq_u64(struct trace_seq=
 *p,
 =09=09=09=09=09=09=09=09 *symbol_array);
 #endif
=20
+const char *ftrace_print_bitmask_seq(struct trace_seq *p, void *bitmask_pt=
r,
+=09=09=09=09     unsigned int bitmask_size);
+
 const char *ftrace_print_hex_seq(struct trace_seq *p,
 =09=09=09=09 const unsigned char *buf, int len);
=20
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index a32d86ec8bf2..136116924d8d 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -46,6 +46,9 @@ extern int trace_seq_putmem_hex(struct trace_seq *s, cons=
t void *mem,
 extern void *trace_seq_reserve(struct trace_seq *s, size_t len);
 extern int trace_seq_path(struct trace_seq *s, const struct path *path);
=20
+extern int trace_seq_bitmask(struct trace_seq *s, const unsigned long *mas=
kp,
+=09=09=09     int nmaskbits);
+
 #else /* CONFIG_TRACING */
 static inline int trace_seq_printf(struct trace_seq *s, const char *fmt, .=
..)
 {
@@ -57,6 +60,13 @@ trace_seq_bprintf(struct trace_seq *s, const char *fmt, =
const u32 *binary)
 =09return 0;
 }
=20
+static inline int
+trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
+=09=09  int nmaskbits)
+{
+=09return 0;
+}
+
 static inline int trace_print_seq(struct seq_file *m, struct trace_seq *s)
 {
 =09return 0;
diff --git a/include/trace/ftrace.h b/include/trace/ftrace.h
index 0a1a4f7caf09..9b7a989dcbcc 100644
--- a/include/trace/ftrace.h
+++ b/include/trace/ftrace.h
@@ -53,6 +53,9 @@
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
=20
+#undef __bitmask
+#define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
+
 #undef TP_STRUCT__entry
 #define TP_STRUCT__entry(args...) args
=20
@@ -128,6 +131,9 @@
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
=20
+#undef __bitmask
+#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)=09\
 =09struct ftrace_data_offsets_##call {=09=09=09=09\
@@ -200,6 +206,15 @@
 #undef __get_str
 #define __get_str(field) (char *)__get_dynamic_array(field)
=20
+#undef __get_bitmask
+#define __get_bitmask(field)=09=09=09=09=09=09\
+=09({=09=09=09=09=09=09=09=09\
+=09=09void *__bitmask =3D __get_dynamic_array(field);=09=09\
+=09=09unsigned int __bitmask_size;=09=09=09=09\
+=09=09__bitmask_size =3D (__entry->__data_loc_##field >> 16) & 0xffff; \
+=09=09ftrace_print_bitmask_seq(p, __bitmask, __bitmask_size);=09\
+=09})
+
 #undef __print_flags
 #define __print_flags(flag, delim, flag_array...)=09=09=09\
 =09({=09=09=09=09=09=09=09=09\
@@ -322,6 +337,9 @@ static struct trace_event_functions ftrace_event_type_f=
uncs_##call =3D {=09\
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
=20
+#undef __bitmask
+#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)=09\
 static int notrace __init=09=09=09=09=09=09\
@@ -372,6 +390,29 @@ ftrace_define_fields_##call(struct ftrace_event_call *=
event_call)=09\
 #define __string(item, src) __dynamic_array(char, item,=09=09=09\
 =09=09    strlen((src) ? (const char *)(src) : "(null)") + 1)
=20
+/*
+ * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
+ * num_possible_cpus().
+ */
+#define __bitmask_size_in_bytes_raw(nr_bits)=09\
+=09(((nr_bits) + 7) / 8)
+
+#define __bitmask_size_in_longs(nr_bits)=09=09=09\
+=09((__bitmask_size_in_bytes_raw(nr_bits) +=09=09\
+=09  ((BITS_PER_LONG / 8) - 1)) / (BITS_PER_LONG / 8))
+
+/*
+ * __bitmask_size_in_bytes is the number of bytes needed to hold
+ * num_possible_cpus() padded out to the nearest long. This is what
+ * is saved in the buffer, just to be consistent.
+ */
+#define __bitmask_size_in_bytes(nr_bits)=09=09=09=09\
+=09(__bitmask_size_in_longs(nr_bits) * (BITS_PER_LONG / 8))
+
+#undef __bitmask
+#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item,=09\
+=09=09=09=09=09 __bitmask_size_in_longs(nr_bits))
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)=09\
 static inline notrace int ftrace_get_offsets_##call(=09=09=09\
@@ -513,12 +554,22 @@ static inline notrace int ftrace_get_offsets_##call(=
=09=09=09\
 =09__entry->__data_loc_##item =3D __data_offsets.item;
=20
 #undef __string
-#define __string(item, src) __dynamic_array(char, item, -1)       =09\
+#define __string(item, src) __dynamic_array(char, item, -1)
=20
 #undef __assign_str
 #define __assign_str(dst, src)=09=09=09=09=09=09\
 =09strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
=20
+#undef __bitmask
+#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+
+#undef __get_bitmask
+#define __get_bitmask(field) (char *)__get_dynamic_array(field)
+
+#undef __assign_bitmask
+#define __assign_bitmask(dst, src, nr_bits)=09=09=09=09=09\
+=09memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
+
 #undef TP_fast_assign
 #define TP_fast_assign(args...) args
=20
@@ -586,6 +637,7 @@ static inline void ftrace_test_probe_##call(void)=09=09=
=09\
 #undef __print_hex
 #undef __get_dynamic_array
 #undef __get_str
+#undef __get_bitmask
=20
 #undef TP_printk
 #define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
@@ -651,6 +703,9 @@ __attribute__((section("_ftrace_events"))) *__event_##c=
all =3D &event_##call
 #undef __get_str
 #define __get_str(field) (char *)__get_dynamic_array(field)
=20
+#undef __get_bitmask
+#define __get_bitmask(field) (char *)__get_dynamic_array(field)
+
 #undef __perf_addr
 #define __perf_addr(a)=09(__addr =3D (a))
=20
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a436de18aa99..f3dad80c20b2 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -126,6 +126,34 @@ trace_seq_printf(struct trace_seq *s, const char *fmt,=
 ...)
 EXPORT_SYMBOL_GPL(trace_seq_printf);
=20
 /**
+ * trace_seq_bitmask - put a list of longs as a bitmask print output
+ * @s:=09=09trace sequence descriptor
+ * @maskp:=09points to an array of unsigned longs that represent a bitmask
+ * @nmaskbits:=09The number of bits that are valid in @maskp
+ *
+ * It returns 0 if the trace oversizes the buffer's free
+ * space, 1 otherwise.
+ *
+ * Writes a ASCII representation of a bitmask string into @s.
+ */
+int
+trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
+=09=09  int nmaskbits)
+{
+=09int len =3D (PAGE_SIZE - 1) - s->len;
+=09int ret;
+
+=09if (s->full || !len)
+=09=09return 0;
+
+=09ret =3D bitmap_scnprintf(s->buffer, len, maskp, nmaskbits);
+=09s->len +=3D ret;
+
+=09return 1;
+}
+EXPORT_SYMBOL_GPL(trace_seq_bitmask);
+
+/**
  * trace_seq_vprintf - sequence printing of trace information
  * @s: trace sequence descriptor
  * @fmt: printf format string
@@ -399,6 +427,19 @@ EXPORT_SYMBOL(ftrace_print_symbols_seq_u64);
 #endif
=20
 const char *
+ftrace_print_bitmask_seq(struct trace_seq *p, void *bitmask_ptr,
+=09=09=09 unsigned int bitmask_size)
+{
+=09const char *ret =3D p->buffer + p->len;
+
+=09trace_seq_bitmask(p, bitmask_ptr, bitmask_size * 8);
+=09trace_seq_putc(p, 0);
+
+=09return ret;
+}
+EXPORT_SYMBOL_GPL(ftrace_print_bitmask_seq);
+
+const char *
 ftrace_print_hex_seq(struct trace_seq *p, const unsigned char *buf, int bu=
f_len)
 {
 =09int i;
--=20
1.7.9.5
