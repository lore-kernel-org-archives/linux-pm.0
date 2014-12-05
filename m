From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v6 8/9] thermal: add trace events to the power allocator governor
Date: Fri,  5 Dec 2014 19:04:19 +0000
Message-ID: <1417806260-9264-9-git-send-email-javi.merino@arm.com>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
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
 drivers/thermal/cpu_cooling.c                  |  26 ++++-
 drivers/thermal/power_allocator.c              |  21 +++-
 include/trace/events/thermal_power_allocator.h | 138 +++++++++++++++++++++=
++++
 3 files changed, 182 insertions(+), 3 deletions(-)
 create mode 100644 include/trace/events/thermal_power_allocator.h

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 335d95dd7e5a..f4d453429742 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -29,6 +29,8 @@
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
=20
+#include <trace/events/thermal_power_allocator.h>
+
 /**
  * struct power_table - frequency to power conversion
  * @frequency:=09frequency in KHz
@@ -644,12 +646,20 @@ static int cpufreq_set_cur_state(struct thermal_cooli=
ng_device *cdev,
 static u32 cpufreq_get_actual_power(struct thermal_cooling_device *cdev)
 {
 =09unsigned long freq;
-=09int cpu;
+=09int i =3D 0, cpu;
 =09u32 static_power, dynamic_power, total_load =3D 0;
 =09struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
+=09u32 *load_cpu =3D NULL;
=20
 =09freq =3D cpufreq_quick_get(cpumask_any(&cpufreq_device->allowed_cpus));
=20
+=09if (trace_thermal_power_cpu_get_power_enabled()) {
+=09=09u32 ncpus =3D cpumask_weight(&cpufreq_device->allowed_cpus);
+
+=09=09load_cpu =3D devm_kcalloc(&cdev->device, ncpus, sizeof(*load_cpu),
+=09=09=09=09=09GFP_KERNEL);
+=09}
+
 =09for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
 =09=09u32 load;
=20
@@ -659,6 +669,10 @@ static u32 cpufreq_get_actual_power(struct thermal_coo=
ling_device *cdev)
 =09=09=09load =3D 0;
=20
 =09=09total_load +=3D load;
+=09=09if (trace_thermal_power_cpu_limit_enabled() && load_cpu)
+=09=09=09load_cpu[i] =3D load;
+
+=09=09i++;
 =09}
=20
 =09cpufreq_device->last_load =3D total_load;
@@ -666,6 +680,14 @@ static u32 cpufreq_get_actual_power(struct thermal_coo=
ling_device *cdev)
 =09static_power =3D get_static_power(cpufreq_device, freq);
 =09dynamic_power =3D get_dynamic_power(cpufreq_device, freq);
=20
+=09if (trace_thermal_power_cpu_limit_enabled() && load_cpu) {
+=09=09trace_thermal_power_cpu_get_power(
+=09=09=09&cpufreq_device->allowed_cpus,
+=09=09=09freq, load_cpu, i, dynamic_power, static_power);
+
+=09=09devm_kfree(&cdev->device, load_cpu);
+=09}
+
 =09return static_power + dynamic_power;
 }
=20
@@ -730,6 +752,8 @@ static unsigned long cpufreq_power2state(struct thermal=
_cooling_device *cdev,
 =09=09return 0;
 =09}
=20
+=09trace_thermal_power_cpu_limit(&cpufreq_device->allowed_cpus,
+=09=09=09=09=09target_freq, cdev_state, power);
 =09return cdev_state;
 }
=20
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allo=
cator.c
index 09e98991efbb..fa725a36872e 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -19,6 +19,9 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/thermal_power_allocator.h>
+
 #include "thermal_core.h"
=20
 #define FRAC_BITS 10
@@ -157,7 +160,14 @@ static u32 pid_controller(struct thermal_zone_device *=
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
@@ -238,7 +248,7 @@ static int allocate_power(struct thermal_zone_device *t=
z,
 =09struct thermal_instance *instance;
 =09u32 *req_power, *max_power, *granted_power;
 =09u32 total_req_power, max_allocatable_power;
-=09u32 power_range;
+=09u32 total_granted_power, power_range;
 =09int i, num_actors, ret =3D 0;
=20
 =09mutex_lock(&tz->lock);
@@ -301,6 +311,7 @@ static int allocate_power(struct thermal_zone_device *t=
z,
 =09divvy_up_power(req_power, max_power, num_actors, total_req_power,
 =09=09power_range, granted_power);
=20
+=09total_granted_power =3D 0;
 =09i =3D 0;
 =09list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 =09=09if (instance->trip !=3D TRIP_MAX_DESIRED_TEMPERATURE)
@@ -310,10 +321,16 @@ static int allocate_power(struct thermal_zone_device =
*tz,
 =09=09=09continue;
=20
 =09=09power_actor_set_power(instance->cdev, granted_power[i]);
+=09=09total_granted_power +=3D granted_power[i];
=20
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
index 000000000000..6760ec31de29
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
+TRACE_EVENT(thermal_power_cpu_get_power,
+=09TP_PROTO(const struct cpumask *cpus, unsigned long freq, u32 *load,
+=09=09size_t load_len, u32 dynamic_power, u32 static_power),
+
+=09TP_ARGS(cpus, freq, load, load_len, dynamic_power, static_power),
+
+=09TP_STRUCT__entry(
+=09=09__bitmask(cpumask, num_possible_cpus())
+=09=09__field(unsigned long, freq          )
+=09=09__dynamic_array(u32,   load, load_len)
+=09=09__field(size_t,        load_len      )
+=09=09__field(u32,           dynamic_power )
+=09=09__field(u32,           static_power  )
+=09),
+
+=09TP_fast_assign(
+=09=09__assign_bitmask(cpumask, cpumask_bits(cpus),
+=09=09=09=09num_possible_cpus());
+=09=09__entry->freq =3D freq;
+=09=09memcpy(__get_dynamic_array(load), load,
+=09=09=09load_len * sizeof(*load));
+=09=09__entry->load_len =3D load_len;
+=09=09__entry->dynamic_power =3D dynamic_power;
+=09=09__entry->static_power =3D static_power;
+=09),
+
+=09TP_printk("cpus=3D%s freq=3D%lu load=3D{%s} dynamic_power=3D%d static_p=
ower=3D%d",
+=09=09__get_bitmask(cpumask), __entry->freq,
+=09=09__print_u32_array(__get_dynamic_array(load), __entry->load_len),
+=09=09__entry->dynamic_power, __entry->static_power)
+);
+
+TRACE_EVENT(thermal_power_cpu_limit,
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
