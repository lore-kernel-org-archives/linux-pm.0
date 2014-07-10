From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v5 09/10] thermal: add trace events to the power allocator governor
Date: Thu, 10 Jul 2014 15:18:47 +0100
Message-ID: <1405001928-12697-10-git-send-email-javi.merino@arm.com>
References: <1405001928-12697-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405001928-12697-1-git-send-email-javi.merino@arm.com>
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
 drivers/thermal/cpu_actor.c                    |  17 ++-
 drivers/thermal/power_allocator.c              |  22 +++-
 include/trace/events/thermal_power_allocator.h | 138 +++++++++++++++++++++=
++++
 3 files changed, 173 insertions(+), 4 deletions(-)
 create mode 100644 include/trace/events/thermal_power_allocator.h

diff --git a/drivers/thermal/cpu_actor.c b/drivers/thermal/cpu_actor.c
index 45ea4fa92ea0..b5ed2e80e288 100644
--- a/drivers/thermal/cpu_actor.c
+++ b/drivers/thermal/cpu_actor.c
@@ -28,6 +28,8 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
=20
+#include <trace/events/thermal_power_allocator.h>
+
 /**
  * struct power_table - frequency to power conversion
  * @frequency:=09frequency in KHz
@@ -184,11 +186,12 @@ static u32 get_static_power(struct cpu_actor *cpu_act=
or,
  */
 static u32 get_dynamic_power(struct cpu_actor *cpu_actor, unsigned long fr=
eq)
 {
-=09int cpu;
-=09u32 power =3D 0, raw_cpu_power, total_load =3D 0;
+=09int i, cpu;
+=09u32 power =3D 0, raw_cpu_power, total_load =3D 0, load_cpu[NR_CPUS];
=20
 =09raw_cpu_power =3D cpu_freq_to_power(cpu_actor, freq);
=20
+=09i =3D 0;
 =09for_each_cpu(cpu, &cpu_actor->cpumask) {
 =09=09u32 load;
=20
@@ -198,8 +201,15 @@ static u32 get_dynamic_power(struct cpu_actor *cpu_act=
or, unsigned long freq)
 =09=09load =3D get_load(cpu_actor, cpu);
 =09=09power +=3D (raw_cpu_power * load) / 100;
 =09=09total_load +=3D load;
+=09=09load_cpu[i] =3D load;
+
+=09=09i++;
 =09}
=20
+=09trace_thermal_power_actor_cpu_get_dyn_power(&cpu_actor->cpumask, freq,
+=09=09=09=09=09=09raw_cpu_power, load_cpu, i,
+=09=09=09=09=09=09power);
+
 =09cpu_actor->last_load =3D total_load;
=20
 =09return power;
@@ -296,6 +306,9 @@ static int cpu_set_power(struct power_actor *actor,
 =09=09return -EINVAL;
 =09}
=20
+=09trace_thermal_power_actor_cpu_limit(&cpu_actor->cpumask, target_freq,
+=09=09=09=09=09cdev_state, power);
+
 =09return cdev->ops->set_cur_state(cdev, cdev_state);
 }
=20
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allo=
cator.c
index eb1797cd859b..e6793d6d1288 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -20,6 +20,9 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/thermal_power_allocator.h>
+
 #include "thermal_core.h"
=20
 #define FRAC_BITS 8
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
@@ -214,7 +224,7 @@ static int allocate_power(struct thermal_zone_device *t=
z,
 =09struct power_actor *actor;
 =09u32 *req_power, *max_power, *granted_power;
 =09u32 total_req_power, max_allocatable_power;
-=09u32 power_range;
+=09u32 total_granted_power, power_range;
 =09int i, num_actors, ret =3D 0;
=20
 =09mutex_lock(&tz->lock);
@@ -265,12 +275,20 @@ static int allocate_power(struct thermal_zone_device =
*tz,
 =09divvy_up_power(req_power, max_power, num_actors, total_req_power,
 =09=09power_range, granted_power);
=20
+=09total_granted_power =3D 0;
 =09i =3D 0;
 =09list_for_each_entry_rcu(actor, &actor_list, actor_node) {
 =09=09actor->ops->set_power(actor, tz, granted_power[i]);
+=09=09total_granted_power +=3D granted_power[i];
+
 =09=09i++;
 =09}
=20
+=09trace_thermal_power_allocator(req_power, total_req_power, granted_power=
,
+=09=09=09=09total_granted_power, num_actors, power_range,
+=09=09=09=09max_allocatable_power, current_temp,
+=09=09=09=09(s32)control_temp - (s32)current_temp);
+
 =09devm_kfree(&tz->device, granted_power);
 free_max_power:
 =09devm_kfree(&tz->device, max_power);
diff --git a/include/trace/events/thermal_power_allocator.h b/include/trace=
/events/thermal_power_allocator.h
new file mode 100644
index 000000000000..9140cec55c63
--- /dev/null
+++ b/include/trace/events/thermal_power_allocator.h
@@ -0,0 +1,138 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM thermal_power_allocator
+
+#if !defined(_TRACE_THERMAL_POWER_ALLOCATOR_H) || defined(TRACE_HEADER_MUL=
TI_READ)
+#define _TRACE_THERMAL_POWER_ALLOCATOR_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(thermal_power_allocator,
+=09TP_PROTO(u32 *req_power, u32 total_req_power, u32 *granted_power,
+=09=09u32 total_granted_power, size_t num_actors, u32 power_range,
+=09=09u32 max_allocatable_power, unsigned long current_temp,
+=09=09s32 delta_temp),
+=09TP_ARGS(req_power, total_req_power, granted_power, total_granted_power,
+=09=09num_actors, power_range, max_allocatable_power, current_temp,
+=09=09delta_temp),
+=09TP_STRUCT__entry(
+=09=09__dynamic_array(u32,   req_power, num_actors    )
+=09=09__field(u32,           total_req_power          )
+=09=09__dynamic_array(u32,   granted_power, num_actors)
+=09=09__field(u32,           total_granted_power      )
+=09=09__field(size_t,        num_actors               )
+=09=09__field(u32,           power_range              )
+=09=09__field(u32,           max_allocatable_power    )
+=09=09__field(unsigned long, current_temp             )
+=09=09__field(s32,           delta_temp               )
+=09),
+=09TP_fast_assign(
+=09=09memcpy(__get_dynamic_array(req_power), req_power,
+=09=09=09num_actors * sizeof(*req_power));
+=09=09__entry->total_req_power =3D total_req_power;
+=09=09memcpy(__get_dynamic_array(granted_power), granted_power,
+=09=09=09num_actors * sizeof(*granted_power));
+=09=09__entry->total_granted_power =3D total_granted_power;
+=09=09__entry->num_actors =3D num_actors;
+=09=09__entry->power_range =3D power_range;
+=09=09__entry->max_allocatable_power =3D max_allocatable_power;
+=09=09__entry->current_temp =3D current_temp;
+=09=09__entry->delta_temp =3D delta_temp;
+=09),
+
+=09TP_printk("req_power=3D{%s} total_req_power=3D%u granted_power=3D{%s} t=
otal_granted_power=3D%u power_range=3D%u max_allocatable_power=3D%u current=
_temperature=3D%lu delta_temperature=3D%d",
+=09=09__print_u32_array(__get_dynamic_array(req_power),
+=09=09=09=09__entry->num_actors),
+=09=09__entry->total_req_power,
+=09=09__print_u32_array(__get_dynamic_array(granted_power),
+=09=09=09=09__entry->num_actors),
+=09=09__entry->total_granted_power, __entry->power_range,
+=09=09__entry->max_allocatable_power, __entry->current_temp,
+=09=09__entry->delta_temp)
+);
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
+TRACE_EVENT(thermal_power_actor_cpu_get_dyn_power,
+=09TP_PROTO(const struct cpumask *cpus, unsigned long freq,
+=09=09u32 raw_cpu_power, u32 *load, size_t load_len, u32 power),
+
+=09TP_ARGS(cpus, freq, raw_cpu_power, load, load_len, power),
+
+=09TP_STRUCT__entry(
+=09=09__bitmask(cpumask, num_possible_cpus())
+=09=09__field(unsigned long, freq          )
+=09=09__field(u32,           raw_cpu_power )
+=09=09__dynamic_array(u32,   load, load_len)
+=09=09__field(size_t,        load_len      )
+=09=09__field(u32,           power         )
+=09),
+
+=09TP_fast_assign(
+=09=09__assign_bitmask(cpumask, cpumask_bits(cpus),
+=09=09=09=09num_possible_cpus());
+=09=09__entry->freq =3D freq;
+=09=09__entry->raw_cpu_power =3D raw_cpu_power;
+=09=09memcpy(__get_dynamic_array(load), load,
+=09=09=09load_len * sizeof(*load));
+=09=09__entry->load_len =3D load_len;
+=09=09__entry->power =3D power;
+=09),
+
+=09TP_printk("cpus=3D%s freq=3D%lu raw_cpu_power=3D%d load=3D{%s} power=3D=
%d",
+=09=09__get_bitmask(cpumask), __entry->freq, __entry->raw_cpu_power,
+=09=09__print_u32_array(__get_dynamic_array(load), __entry->load_len),
+=09=09__entry->power)
+);
+
+TRACE_EVENT(thermal_power_actor_cpu_limit,
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
+#endif /* _TRACE_THERMAL_POWER_ALLOCATOR_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
--=20
1.9.1
