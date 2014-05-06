From: Javi Merino <javi.merino@arm.com>
Subject: [RFC PATCH 5/5] thermal: add trace events to the power allocator governor
Date: Tue,  6 May 2014 13:06:38 +0100
Message-ID: <1399377998-14870-6-git-send-email-javi.merino@arm.com>
References: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:35935 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934777AbaEFMH5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 May 2014 08:07:57 -0400
In-Reply-To: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Punit.Agrawal@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>

Add trace events for the power allocator governor and the power actor
interface of the cpu cooling device.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>

---
Hi trace maintainers,

We would like to add cpumask to a trace point.  We currently allocate
a string and print the mask there with cpumask_scnprintf() which is a
bit heavyweight.  Will it be possible to add this capability to ftrace
so that we can add the cpumask to the trace buffer and then trace-cmd
prints the mask when reporting?

 drivers/thermal/cpu_cooling.c           |    9 ++++++++
 drivers/thermal/power_allocator.c       |   12 ++++++++++-
 include/trace/events/thermal.h          |   34 +++++++++++++++++++++++++++=
+++
 include/trace/events/thermal_governor.h |   35 +++++++++++++++++++++++++++=
++++
 4 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/thermal.h
 create mode 100644 include/trace/events/thermal_governor.h

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 8052cd1f4a39..3520e7a6b5c3 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -29,6 +29,9 @@
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/thermal.h>
+
 /* Maximum number of opps we can track */
 #define MAX_NUM_OPPS 32
=20
@@ -565,6 +568,8 @@ static int cpufreq_get_cur(struct thermal_cooling_devic=
e *cdev,
 =09return 0;
 }
=20
+static char trace_cpus_str[DIV_ROUND_UP(NR_CPUS, 4) + 1];
+
 /**
  * cpufreq_set_cur - callback function to set the current cooling state/po=
wer.
  * @cdev: thermal cooling device pointer.
@@ -601,6 +606,10 @@ static int cpufreq_set_cur(struct thermal_cooling_devi=
ce *cdev,
 =09=09=09=09freq, cpu);
 =09=09=09return -EINVAL;
 =09=09}
+
+=09=09cpumask_scnprintf(trace_cpus_str, ARRAY_SIZE(trace_cpus_str),
+=09=09=09=09&cpufreq_device->allowed_cpus);
+=09=09trace_thermal_power_limit(trace_cpus_str, freq, state, val);
 =09} else if (unit =3D=3D THERMAL_UNIT_STATE) {
 =09=09state =3D val;
 =09} else {
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allo=
cator.c
index 39c425abf10a..cde1fa1bd58a 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -19,6 +19,9 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/thermal_governor.h>
+
 #include "thermal_core.h"
=20
 #define MAX_NUM_ACTORS 8
@@ -122,7 +125,14 @@ static u32 pi_controller(struct thermal_zone_device *t=
z,
 =09if (power_range > max_allocatable_power)
 =09=09power_range =3D max_allocatable_power;
=20
-=09return power_range >=3D 0 ? power_range : 0;
+=09power_range =3D power_range >=3D 0 ? power_range : 0;
+
+=09trace_thermal_power_allocator_pi(frac_to_int(err),
+=09=09=09=09=09frac_to_int(params->err_integral),
+=09=09=09=09=09frac_to_int(p), frac_to_int(i),
+=09=09=09=09=09power_range);
+
+=09return power_range;
 }
=20
 static void divvy_up_power(struct thermal_zone_device *tz,
diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.=
h
new file mode 100644
index 000000000000..9e2c2c65e81b
--- /dev/null
+++ b/include/trace/events/thermal.h
@@ -0,0 +1,34 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM thermal
+
+#if !defined(_TRACE_THERMAL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_THERMAL_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(thermal_power_limit,
+=09TP_PROTO(const char *cpus, unsigned int freq, unsigned long cdev_state,
+=09=09unsigned long power),
+=09TP_ARGS(cpus, freq, cdev_state, power),
+=09TP_STRUCT__entry(
+=09=09__string(cpus, cpus)
+=09=09__field(unsigned int,  freq      )
+=09=09__field(unsigned long, cdev_state)
+=09=09__field(unsigned long, power     )
+=09),
+=09TP_fast_assign(
+=09=09__assign_str(cpus, cpus);
+=09=09__entry->freq =3D freq;
+=09=09__entry->cdev_state =3D cdev_state;
+=09=09__entry->power =3D power;
+=09),
+
+=09TP_printk("cpus=3D%s freq=3D%u cdev_state=3D%lu power=3D%lu",
+=09=09__get_str(cpus), __entry->freq, __entry->cdev_state,
+=09=09__entry->power)
+);
+
+#endif /* _TRACE_THERMAL_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/include/trace/events/thermal_governor.h b/include/trace/events=
/thermal_governor.h
new file mode 100644
index 000000000000..1fbf5c91f659
--- /dev/null
+++ b/include/trace/events/thermal_governor.h
@@ -0,0 +1,35 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM thermal_governor
+
+#if !defined(_TRACE_THERMAL_GOVERNOR_H) || defined(TRACE_HEADER_MULTI_READ=
)
+#define _TRACE_THERMAL_GOVERNOR_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(thermal_power_allocator_pi,
+=09TP_PROTO(s32 err, s32 err_integral, s64 p, s64 i, s32 output),
+=09TP_ARGS(err, err_integral, p, i, output),
+=09TP_STRUCT__entry(
+=09=09__field(s32, err         )
+=09=09__field(s32, err_integral)
+=09=09__field(s64, p           )
+=09=09__field(s64, i           )
+=09=09__field(s32, output      )
+=09),
+=09TP_fast_assign(
+=09=09__entry->err =3D err;
+=09=09__entry->err_integral =3D err_integral;
+=09=09__entry->p =3D p;
+=09=09__entry->i =3D i;
+=09=09__entry->output =3D output;
+=09),
+
+=09TP_printk("err=3D%d err_integral=3D%d p=3D%lld i=3D%lld output=3D%d",
+=09=09__entry->err, __entry->err_integral,
+=09=09__entry->p, __entry->i, __entry->output)
+);
+
+#endif /* _TRACE_THERMAL_GOVERNOR_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
--=20
1.7.9.5


