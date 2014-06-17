From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v4 6/7] thermal: add trace events to the power allocator governor
Date: Tue, 17 Jun 2014 10:14:52 +0100
Message-ID: <1402996493-3578-7-git-send-email-javi.merino@arm.com>
References: <1402996493-3578-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402996493-3578-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: punit.agrawal@arm.com, broonie@kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

Add trace events for the power allocator governor and the power actor
interface of the cpu cooling device.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>

---

trace-cmd needs the patched attached in
http://article.gmane.org/gmane.linux.kernel/1704423 for this to work.

 drivers/thermal/cpu_actor.c          |  5 +++
 drivers/thermal/power_allocator.c    | 12 ++++++-
 include/trace/events/thermal_power.h | 62 ++++++++++++++++++++++++++++++++=
++++
 3 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/thermal_power.h

diff --git a/drivers/thermal/cpu_actor.c b/drivers/thermal/cpu_actor.c
index 67897b1ded62..4ef715dea87f 100644
--- a/drivers/thermal/cpu_actor.c
+++ b/drivers/thermal/cpu_actor.c
@@ -27,6 +27,8 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
=20
+#include <trace/events/thermal_power.h>
+
 #include "power_actor.h"
=20
 /**
@@ -297,6 +299,9 @@ static int cpu_set_power(struct power_actor *actor,
 =09=09return -EINVAL;
 =09}
=20
+=09trace_thermal_power_limit(&cpu_actor->cpumask, target_freq, cdev_state,
+=09=09=09=09power);
+
 =09return cdev->ops->set_cur_state(cdev, cdev_state);
 }
=20
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allo=
cator.c
index dd781eb29568..a10c5ed26820 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -19,6 +19,9 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/thermal_power.h>
+
 #include "power_actor.h"
 #include "thermal_core.h"
=20
@@ -133,7 +136,14 @@ static u32 pid_controller(struct thermal_zone_device *=
tz,
 =09/* feed-forward the known sustainable dissipatable power */
 =09power_range =3D tz->tzp->sustainable_power + frac_to_int(power_range);
=20
-=09return clamp(power_range, (s64)0, (s64)max_allocatable_power);
+=09power_range =3D clamp(power_range, (s64)0, (s64)max_allocatable_power);
+
+=09trace_thermal_power_allocator_pid(frac_to_int(err),
+=09=09=09=09=09frac_to_int(params->err_integral),
+=09=09=09=09=09frac_to_int(p), frac_to_int(i),
+=09=09=09=09=09frac_to_int(d), power_range);
+
+=09return power_range;
 }
=20
 /**
diff --git a/include/trace/events/thermal_power.h b/include/trace/events/th=
ermal_power.h
new file mode 100644
index 000000000000..6629f8b4ca9f
--- /dev/null
+++ b/include/trace/events/thermal_power.h
@@ -0,0 +1,62 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM thermal_power
+
+#if !defined(_TRACE_THERMAL_GOVERNOR_H) || defined(TRACE_HEADER_MULTI_READ=
)
+#define _TRACE_THERMAL_POWER_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(thermal_power_allocator_pid,
+=09TP_PROTO(s32 err, s32 err_integral, s64 p, s64 i, s64 d, s32 output),
+=09TP_ARGS(err, err_integral, p, i, d, output),
+=09TP_STRUCT__entry(
+=09=09__field(s32, err         )
+=09=09__field(s32, err_integral)
+=09=09__field(s64, p           )
+=09=09__field(s64, i           )
+=09=09__field(s64, d           )
+=09=09__field(s32, output      )
+=09),
+=09TP_fast_assign(
+=09=09__entry->err =3D err;
+=09=09__entry->err_integral =3D err_integral;
+=09=09__entry->p =3D p;
+=09=09__entry->i =3D i;
+=09=09__entry->d =3D d;
+=09=09__entry->output =3D output;
+=09),
+
+=09TP_printk("err=3D%d err_integral=3D%d p=3D%lld i=3D%lld d=3D%lld output=
=3D%d",
+=09=09__entry->err, __entry->err_integral,
+=09=09__entry->p, __entry->i, __entry->d, __entry->output)
+);
+
+TRACE_EVENT(thermal_power_limit,
+=09TP_PROTO(const struct cpumask *cpus, unsigned int freq,
+=09=09unsigned long cdev_state, u32 power),
+
+=09TP_ARGS(cpus, freq, cdev_state, power),
+
+=09TP_STRUCT__entry(
+=09=09__bitmask(cpumask, num_possible_cpus())
+=09=09__field(unsigned int,  freq      )
+=09=09__field(unsigned long, cdev_state)
+=09=09__field(u32,           power     )
+=09),
+
+=09TP_fast_assign(
+=09=09__assign_bitmask(cpumask, cpumask_bits(cpus),
+=09=09=09=09num_possible_cpus());
+=09=09__entry->freq =3D freq;
+=09=09__entry->cdev_state =3D cdev_state;
+=09=09__entry->power =3D power;
+=09),
+
+=09TP_printk("cpus=3D%s freq=3D%u cdev_state=3D%lu power=3D%u",
+=09=09__get_bitmask(cpumask), __entry->freq, __entry->cdev_state,
+=09=09__entry->power)
+);
+#endif /* _TRACE_THERMAL_POWER_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
--=20
1.9.1
