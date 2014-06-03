From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v3 5/7] thermal: add a basic cpu power actor
Date: Tue,  3 Jun 2014 11:18:33 +0100
Message-ID: <1401790715-5630-6-git-send-email-javi.merino@arm.com>
References: <1401790715-5630-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401790715-5630-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: punit.agrawal@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Introduce a power actor for cpus.  It has a basic power model to get
the current power utilization and uses cpufreq cooling devices to set
the desired power.  It uses the current frequency (as reported by
cpufreq) as well as load and OPPs for the power calculations.  The
cpus must have registered their OPPs in the OPP library.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 Documentation/thermal/power_actor.txt     | 126 +++++++
 drivers/thermal/Kconfig                   |   5 +
 drivers/thermal/power_actor/Kconfig       |   9 +
 drivers/thermal/power_actor/Makefile      |   2 +
 drivers/thermal/power_actor/cpu_actor.c   | 601 ++++++++++++++++++++++++++=
++++
 drivers/thermal/power_actor/power_actor.h |  41 ++
 6 files changed, 784 insertions(+)
 create mode 100644 drivers/thermal/power_actor/Kconfig
 create mode 100644 drivers/thermal/power_actor/cpu_actor.c

diff --git a/Documentation/thermal/power_actor.txt b/Documentation/thermal/=
power_actor.txt
index 5a61f32ec143..fd51760615bf 100644
--- a/Documentation/thermal/power_actor.txt
+++ b/Documentation/thermal/power_actor.txt
@@ -36,3 +36,129 @@ temperature.
 milliwatts.
=20
 Returns 0 on success, -E* on error.
+
+CPU Power Actor API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A simple power model for CPUs.  The current power is calculated as
+dynamic + (optionally) static power.  This power model requires that
+the operating-points of the CPUs are registered using the kernel's opp
+library and the `cpufreq_frequency_table` is assigned to the `struct
+device` of the cpu.  If you are using the `cpufreq-cpu0.c` driver then
+the `cpufreq_frequency_table` should already be assigned to the cpu
+device.
+
+The `tz` and `plat_static_func` parameters of
+`power_cpu_actor_register()` are optional.  If you don't provide them,
+only dynamic power will be considered.
+
+Dynamic power
+-------------
+
+The dynamic power consumption of a processor depends
+on many factors.  For a given processor implementation the primary
+factors are:
+
+- The time the processor spends running, consuming dynamic power, as
+  compared to the time in idle states where dynamic consumption is
+  negligible.  Herein we refer to this as 'utilisation'.
+- The voltage and frequency levels as a result of DVFS.  The DVFS
+  level is a dominant factor governing power consumption.
+- In running time the 'execution' behaviour (instruction types, memory
+  access patterns and so forth) causes, in most cases, a second order
+  variation.  In pathological cases this variation can be significant,
+  but typically it is of a much lesser impact than the factors above.
+
+A high level dynamic power consumption model may then be represented as:
+
+Pdyn =3D f(run) * Voltage^2 * Frequency * Utilisation
+
+f(run) here represents the described execution behaviour and its
+result has a units of Watts/Hz/Volt^2 (this often expressed in
+mW/MHz/uVolt^2)
+
+The detailed behaviour for f(run) could be modelled on-line.  However,
+in practice, such an on-line model has dependencies on a number of
+implementation specific processor support and characterisation
+factors.  Therefore, in initial implementation that contribution is
+represented as a constant coefficient.  This is a simplification
+consistent with the relative contribution to overall power variation.
+
+In this simplified representation our model becomes:
+
+Pdyn =3D Kd * Voltage^2 * Frequency * Utilisation
+
+Where Kd (capacitance) represents an indicative running time dynamic
+power coefficient in fundamental units of mW/MHz/uVolt^2
+
+Static Power
+------------
+
+Static leakage power consumption depends on a number of factors.  For a
+given circuit implementation the primary factors are:
+
+- Time the circuit spends in each 'power state'
+- Temperature
+- Operating voltage
+- Process grade
+
+The time the circuit spends in each 'power state' for a given
+evaluation period at first order means OFF or ON.  However,
+'retention' states can also be supported that reduce power during
+inactive periods without loss of context.
+
+Note: The visibility of state entries to the OS can vary, according to
+platform specifics, and this can then impact the accuracy of a model
+based on OS state information alone.  It might be possible in some
+cases to extract more accurate information from system resources.
+
+The temperature, operating voltage and process 'grade' (slow to fast)
+of the circuit are all significant factors in static leakage power
+consumption.  All of these have complex relationships to static power.
+
+Circuit implementation specific factors include the chosen silicon
+process as well as the type, number and size of transistors in both
+the logic gates and any RAM elements included.
+
+The static power consumption modelling must take into account the
+power managed regions that are implemented.  Taking the example of an
+ARM processor cluster, the modelling would take into account whether
+each CPU can be powered OFF separately or if only a single power
+region is implemented for the complete cluster.
+
+In one view, there are others, a static power consumption model can
+then start from a set of reference values for each power managed
+region (e.g. CPU, Cluster/L2) in each state (e.g. ON, OFF) at an
+arbitrary process grade, voltage and temperature point.  These values
+are then scaled for all of the following: the time in each state, the
+process grade, the current temperature and the operating
+voltage.  However, since both implementation specific and complex
+relationships dominate the estimate, the appropriate interface to the
+model from the cpu power actor is to provide a function callback that
+calculates the static power in this platform.  When registering the
+power cpu actor, pass the thermal zone closest to the cpu (to get the
+temperature) and a function pointer that follows the `get_static_t`
+prototype:
+
+    u32 plat_get_static(cpumask_t *cpumask, unsigned long voltage,
+=09=09=09=09unsigned long temperature);
+
+with `cpumask` a cpumask of the cpus involved in the calculation,
+`voltage` the voltage at which they are opperating and `temperature`
+their current temperature.
+
+If both `tz` and `plat_static_func` are NULL when registering the
+power cpu actor, static power is considered to be negligible for this
+platform and only dynamic power is considered.
+
+The platform specific callback can then use any combination of tables
+and/or equations to permute the estimated value.  Process grade
+information is not passed to the model since access to such data, from
+on-chip measurement capability or manufacture time data, is platform
+specific.
+
+Note: the significance of static power for CPUs in comparison to
+dynamic power is highly dependent on implementation.  Given the
+potential complexity in implementation, the importance and accuracy of
+its inclusion when using cpu power actors should be assessed on a case by
+cases basis.
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 47e2f15537ca..1818c4fa60b8 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -92,6 +92,11 @@ config THERMAL_GOV_USER_SPACE
 config THERMAL_POWER_ACTOR
 =09bool
=20
+menu "Power actors"
+depends on THERMAL_POWER_ACTOR
+source "drivers/thermal/power_actor/Kconfig"
+endmenu
+
 config CPU_THERMAL
 =09bool "generic cpu cooling support"
 =09depends on CPU_FREQ
diff --git a/drivers/thermal/power_actor/Kconfig b/drivers/thermal/power_ac=
tor/Kconfig
new file mode 100644
index 000000000000..fa542ca99cdb
--- /dev/null
+++ b/drivers/thermal/power_actor/Kconfig
@@ -0,0 +1,9 @@
+#
+# Thermal power actor configuration
+#
+
+config THERMAL_POWER_ACTOR_CPU
+=09bool
+=09prompt "Simple power model for a CPU"
+=09help
+=09  A simple CPU power model
diff --git a/drivers/thermal/power_actor/Makefile b/drivers/thermal/power_a=
ctor/Makefile
index 46478f4928be..6f04b92997e6 100644
--- a/drivers/thermal/power_actor/Makefile
+++ b/drivers/thermal/power_actor/Makefile
@@ -3,3 +3,5 @@
 #
=20
 obj-y +=3D power_actor.o
+
+obj-$(CONFIG_THERMAL_POWER_ACTOR_CPU) +=3D cpu_actor.o
diff --git a/drivers/thermal/power_actor/cpu_actor.c b/drivers/thermal/powe=
r_actor/cpu_actor.c
new file mode 100644
index 000000000000..6eac80d119a5
--- /dev/null
+++ b/drivers/thermal/power_actor/cpu_actor.c
@@ -0,0 +1,601 @@
+/*
+ * A basic cpu actor
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) "CPU actor: " fmt
+
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_cooling.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/pm_opp.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+
+#include "power_actor.h"
+
+/**
+ * struct power_table - frequency to power conversion
+ * @frequency:=09frequency in KHz
+ * @power:=09power in mW
+ *
+ * This structure is built when the cooling device registers and helps
+ * in translating frequency to power and viceversa.
+ */
+struct power_table {
+=09u32 frequency;
+=09u32 power;
+};
+
+/**
+ * struct cpu_actor - information for each cpu actor
+ * @cpumask:=09cpus covered by this actor
+ * @freq:=09frequency in KHz of the cpus represented by the cooling device
+ * @last_load:=09load measured by the latest call to cpu_get_req_power()
+ * @time_in_idle:=09previous reading of the absolute time that this cpu wa=
s
+ *=09=09=09idle
+ * @time_in_idle_timestamp: wall time of the last invocation of
+ *=09=09=09    get_cpu_idle_time_us()
+ * @dyn_power_table:=09array of struct power_table for frequency to power
+ *=09=09=09conversion
+ * @dyn_power_table_entries: number of entries in the @dyn_power_table arr=
ay
+ * @cdev:=09cpufreq cooling device associated with this actor
+ * @tz:=09=09thermal zone for the sensor closest to the cpus
+ * @plat_get_static_power:=09callback to calculate the static power
+ */
+struct cpu_actor {
+=09cpumask_t cpumask;
+=09u32 freq;
+=09u32 last_load;
+=09u64 time_in_idle[NR_CPUS];
+=09u64 time_in_idle_timestamp[NR_CPUS];
+=09struct power_table *dyn_power_table;
+=09int dyn_power_table_entries;
+=09struct thermal_cooling_device *cdev;
+=09struct thermal_zone_device *tz;
+=09get_static_t plat_get_static_power;
+};
+
+static DEFINE_MUTEX(cpu_power_actor_lock);
+
+static unsigned int cpu_power_actors_registered;
+
+static u32 cpu_freq_to_power(struct cpu_actor *cpu_actor, u32 freq)
+{
+=09int i;
+=09struct power_table *pt =3D cpu_actor->dyn_power_table;
+
+=09for (i =3D 0; i < cpu_actor->dyn_power_table_entries - 1; i++)
+=09=09if (freq <=3D pt[i].frequency)
+=09=09=09break;
+
+=09return pt[i].power;
+}
+
+static u32 cpu_power_to_freq(struct cpu_actor *cpu_actor, u32 power)
+{
+=09int i;
+=09struct power_table *pt =3D cpu_actor->dyn_power_table;
+
+=09for (i =3D 0; i < cpu_actor->dyn_power_table_entries - 1; i++)
+=09=09if (power <=3D pt[i].power)
+=09=09=09break;
+
+=09return pt[i].frequency;
+}
+
+/**
+ * get_load - get load for a cpu since last updated
+ * @cpu_actor: struct cpu_actor for this actor
+ * @cpu: cpu number
+ *
+ * Return the average load of cpu @cpu in percentage since this
+ * function was last called.
+ */
+static u32 get_load(struct cpu_actor *cpu_actor, int cpu)
+{
+=09u32 load;
+=09u64 now, now_idle, delta_time, delta_idle;
+
+=09now_idle =3D get_cpu_idle_time(cpu, &now, 0);
+=09delta_idle =3D now_idle - cpu_actor->time_in_idle[cpu];
+=09delta_time =3D now - cpu_actor->time_in_idle_timestamp[cpu];
+
+=09if (delta_time <=3D delta_idle)
+=09=09load =3D 0;
+=09else
+=09=09load =3D div64_u64(100 * (delta_time - delta_idle), delta_time);
+
+=09cpu_actor->time_in_idle[cpu] =3D now_idle;
+=09cpu_actor->time_in_idle_timestamp[cpu] =3D now;
+
+=09return load;
+}
+
+/**
+ * __get_static_power() - calculate the static power consumed by the cpus
+ * @cpu_actor:=09&struct cpu_actor for this cpu
+ * @freq:=09frequency in KHz
+ *
+ * Calculate the static power consumed by the cpus described by
+ * @cpu_actor running at frequency @freq.  This function relies on a
+ * platform specific function that should have been provided when the
+ * actor was registered.  If it wasn't, the static power is assumed to
+ * be negligible.
+ *
+ * Return: The static power consumed by the cpus.  It returns 0 on
+ * error or if there is no plat_get_static_power().
+ */
+static u32 __get_static_power(struct cpu_actor *cpu_actor, unsigned long f=
req)
+{
+=09int err;
+=09struct device *cpu_dev;
+=09struct dev_pm_opp *opp;
+=09unsigned long voltage, temperature;
+=09cpumask_t *cpumask =3D &cpu_actor->cpumask;
+=09unsigned long freq_hz =3D freq * 1000;
+
+=09if (!cpu_actor->plat_get_static_power)
+=09=09return 0;
+
+=09if (freq =3D=3D 0)
+=09=09return 0;
+
+=09cpu_dev =3D get_cpu_device(cpumask_any(cpumask));
+
+=09rcu_read_lock();
+
+=09opp =3D dev_pm_opp_find_freq_exact(cpu_dev, freq_hz, true);
+=09voltage =3D dev_pm_opp_get_voltage(opp);
+
+=09rcu_read_unlock();
+
+=09if (voltage =3D=3D 0) {
+=09=09dev_warn_ratelimited(cpu_dev,
+=09=09=09=09"Failed to get voltage for frequency %lu: %ld\n",
+=09=09=09=09freq_hz, IS_ERR(opp) ? PTR_ERR(opp) : 0);
+=09=09return 0;
+=09}
+
+=09err =3D thermal_zone_get_temp(cpu_actor->tz, &temperature);
+=09if (err) {
+=09=09dev_warn(&cpu_actor->tz->device, "Unable to read temperature: %d\n",
+=09=09=09err);
+=09=09return 0;
+=09}
+
+=09return cpu_actor->plat_get_static_power(cpumask, voltage, temperature);
+}
+
+static u32 get_static_power(struct cpu_actor *cpu_actor)
+{
+=09return __get_static_power(cpu_actor, cpu_actor->freq);
+}
+
+/**
+ * get_dynamic_power - calculate the dynamic power
+ * @cpu_actor: cpu_actor pointer
+ *
+ * Return the dynamic power consumed by the cpus described by
+ * cpu_actor.
+ */
+static u32 get_dynamic_power(struct cpu_actor *cpu_actor)
+{
+=09int cpu;
+=09u32 power =3D 0, raw_cpu_power, total_load =3D 0;
+=09raw_cpu_power =3D cpu_freq_to_power(cpu_actor, cpu_actor->freq);
+
+=09for_each_cpu(cpu, &cpu_actor->cpumask) {
+=09=09u32 load;
+
+=09=09if (!cpu_online(cpu))
+=09=09=09continue;
+
+=09=09load =3D get_load(cpu_actor, cpu);
+=09=09power +=3D (raw_cpu_power * load) / 100;
+=09=09total_load +=3D load;
+=09}
+
+=09cpu_actor->last_load =3D total_load;
+
+=09return power;
+}
+
+/**
+ * cpu_get_req_power - get the current power
+ * @actor:=09power actor pointer
+ *
+ * Callback for the power actor to return the current power
+ * consumption in milliwatts.
+ */
+static u32 cpu_get_req_power(struct power_actor *actor)
+{
+=09u32 static_power, dynamic_power;
+=09struct cpu_actor *cpu_actor =3D actor->data;
+
+=09static_power =3D get_static_power(cpu_actor);
+=09dynamic_power =3D get_dynamic_power(cpu_actor);
+
+=09return static_power + dynamic_power;
+}
+
+/**
+ * cpu_get_max_power() - get the maximum power that the cpu could currentl=
y consume
+ * @actor:=09power actor pointer
+ *
+ * Callback for the power actor to return the maximum power
+ * consumption in milliwatts that the cpu could currently consume.
+ * The static power depends on temperature so the maximum power will
+ * vary over time.
+ */
+static u32 cpu_get_max_power(struct power_actor *actor)
+{
+=09u32 max_static_power, max_dyn_power;
+=09cpumask_t *cpumask;
+=09unsigned int max_freq, last_entry, num_cpus;
+=09struct cpu_actor *cpu_actor =3D actor->data;
+
+=09cpumask =3D &cpu_actor->cpumask;
+=09max_freq =3D cpufreq_quick_get_max(cpumask_any(cpumask));
+=09max_static_power =3D __get_static_power(cpu_actor, max_freq);
+
+=09last_entry =3D cpu_actor->dyn_power_table_entries - 1;
+=09num_cpus =3D cpumask_weight(cpumask);
+=09max_dyn_power =3D cpu_actor->dyn_power_table[last_entry].power * num_cp=
us;
+
+=09return max_static_power + max_dyn_power;
+}
+
+/**
+ * cpu_set_power - set cpufreq cooling device to consume a certain power
+ * @actor: power actor pointer
+ * @power: the power in milliwatts that should be set
+ *
+ * Callback for the power actor to configure the power consumption of
+ * the CPU to be @power milliwatts at most.  This function assumes
+ * that the load will remain constant.  The power is translated into a
+ * cooling state that the cpu cooling device then sets.
+ *
+ * Returns 0 on success, -EINVAL if it couldn't convert the frequency
+ * to a cpufreq cooling device state.
+ */
+static int cpu_set_power(struct power_actor *actor, u32 power)
+{
+=09unsigned int cpu, freq;
+=09unsigned long cdev_state;
+=09u32 dyn_power, normalised_power, last_load;
+=09struct thermal_cooling_device *cdev;
+=09struct cpu_actor *cpu_actor =3D actor->data;
+
+=09cdev =3D cpu_actor->cdev;
+
+=09dyn_power =3D power - get_static_power(cpu_actor);
+=09cpu =3D cpumask_any(&cpu_actor->cpumask);
+=09last_load =3D cpu_actor->last_load ? cpu_actor->last_load : 1;
+=09normalised_power =3D (dyn_power * 100) / last_load;
+=09freq =3D cpu_power_to_freq(cpu_actor, normalised_power);
+
+=09cdev_state =3D cpufreq_cooling_get_level(cpu, freq);
+=09if (cdev_state =3D=3D THERMAL_CSTATE_INVALID) {
+=09=09pr_err("Failed to convert %dKHz for cpu %d into a cdev state\n",
+=09=09=09freq, cpu);
+=09=09return -EINVAL;
+=09}
+
+=09return cdev->ops->set_cur_state(cdev, cdev_state);
+}
+
+static struct power_actor_ops cpu_actor_ops =3D {
+=09.get_req_power =3D cpu_get_req_power,
+=09.get_max_power =3D cpu_get_max_power,
+=09.set_power =3D cpu_set_power,
+};
+
+/**
+ * power_cpu_actor_add_static() - add static information to an existing cp=
u actor
+ * @cpu:=09a cpu represented by the cpu power actor
+ * @tz:=09=09pointer to the closest thermal zone to the cpu
+ * @plat_static_func:=09function to calculate the static power consumed by=
 these
+ *=09=09=09cpus
+ *
+ * A function to add static information to an actor after it has
+ * registered.  In order to calculate the static power, we need the to
+ * know the temperature of the cpu, which we get from its closest
+ * thermal zone.  It is possible that when registering the
+ * power_cpu_actor, the thermal zone hasn't been registered yet.  This
+ * function allows you to add that information when the thermal zone
+ * is registered.  @cpu should be one of the cpus represented by the
+ * cpu actor you want to modify
+ *
+ * Return: 0 on success.  -EINVAL if @tz or @plat_static_func are
+ * NULL.  -ENOENT if there's no cpu power actor for @cpu.
+ */
+int power_cpu_actor_add_static(unsigned int cpu, struct thermal_zone_devic=
e *tz,
+=09=09=09get_static_t plat_static_func)
+{
+=09struct power_actor *actor;
+
+=09if (!plat_static_func || !tz)
+=09=09return -EINVAL;
+
+=09list_for_each_entry(actor, &actor_list, actor_node) {
+=09=09struct cpu_actor *cpu_actor;
+
+=09=09if (actor->type !=3D POWER_ACTOR_CPU)
+=09=09=09continue;
+
+=09=09cpu_actor =3D actor->data;
+
+=09=09if (cpumask_test_cpu(cpu, &cpu_actor->cpumask)) {
+=09=09=09cpu_actor->tz =3D tz;
+=09=09=09cpu_actor->plat_get_static_power =3D plat_static_func;
+=09=09=09return 0;
+=09=09}
+=09}
+
+=09return -ENOENT;
+}
+
+/**
+ * cpufreq_frequency_change - notifier callback for cpufreq frequency chan=
ges
+ * @nb:=09=09struct notifier_block * with callback info
+ * @event:=09value showing cpufreq event for which this function invoked
+ * @data:=09callback-specific data
+ *
+ * Callback to get notifications of frequency changes.  In the
+ * CPUFREQ_POSTCHANGE @event we store the new frequency so that
+ * cpufreq_get_cur() knows the current frequency and can convert it
+ * into power.
+ */
+static int cpufreq_frequency_change(struct notifier_block *nb,
+=09=09=09=09unsigned long event, void *data)
+{
+=09struct power_actor *actor;
+=09struct cpufreq_freqs *freqs =3D data;
+
+=09/* Only update frequency on postchange */
+=09if (event !=3D CPUFREQ_POSTCHANGE)
+=09=09return NOTIFY_DONE;
+
+=09list_for_each_entry(actor, &actor_list, actor_node) {
+=09=09struct cpu_actor *cpu_actor;
+
+=09=09if (actor->type !=3D POWER_ACTOR_CPU)
+=09=09=09continue;
+
+=09=09cpu_actor =3D actor->data;
+
+=09=09if (cpumask_test_cpu(freqs->cpu, &cpu_actor->cpumask))
+=09=09=09cpu_actor->freq =3D freqs->new;
+=09}
+
+=09return NOTIFY_OK;
+}
+
+struct notifier_block cpufreq_transition_notifier =3D {
+=09.notifier_call =3D cpufreq_frequency_change,
+};
+
+/**
+ * build_dyn_power_table - create a dynamic power to frequency table
+ * @cpu_actor:=09the cpu_actor in which to store the table
+ * @capacitance: dynamic power coefficient for these cpus
+ *
+ * Build a dynamic power to frequency table for this cpu and store it
+ * in @cpu_actor.  This table will be used in cpu_power_to_freq() and
+ * cpu_freq_to_power() to convert between power and frequency
+ * efficiently.  Power is stored in mW, frequency in KHz.  The
+ * resulting table is in ascending order.
+ *
+ * Returns 0 on success, -E* on error.
+ */
+static int build_dyn_power_table(struct cpu_actor *cpu_actor, u32 capacita=
nce)
+{
+=09struct power_table *power_table;
+=09struct dev_pm_opp *opp;
+=09struct device *dev =3D NULL;
+=09int num_opps, cpu, i, ret =3D 0;
+=09unsigned long freq;
+
+=09num_opps =3D 0;
+
+=09rcu_read_lock();
+
+=09for_each_cpu(cpu, &cpu_actor->cpumask) {
+=09=09dev =3D get_cpu_device(cpu);
+=09=09if (!dev)
+=09=09=09continue;
+
+=09=09num_opps =3D dev_pm_opp_get_opp_count(dev);
+=09=09if (num_opps > 0) {
+=09=09=09break;
+=09=09} else if (num_opps < 0) {
+=09=09=09ret =3D num_opps;
+=09=09=09goto unlock;
+=09=09}
+=09}
+
+=09if (num_opps =3D=3D 0) {
+=09=09ret =3D -EINVAL;
+=09=09goto unlock;
+=09}
+
+=09power_table =3D kcalloc(num_opps, sizeof(*power_table), GFP_KERNEL);
+
+=09i =3D 0;
+=09for (freq =3D 0;
+=09     opp =3D dev_pm_opp_find_freq_ceil(dev, &freq), !IS_ERR(opp);
+=09     freq++) {
+=09=09u32 freq_mhz, voltage_mv;
+=09=09u64 power;
+
+=09=09freq_mhz =3D freq / 1000000;
+=09=09voltage_mv =3D dev_pm_opp_get_voltage(opp) / 1000;
+
+=09=09/*
+=09=09 * Do the multiplication with MHz and millivolt so as
+=09=09 * to not overflow.
+=09=09 */
+=09=09power =3D (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
+=09=09do_div(power, 1000000000);
+
+=09=09/* frequency is stored in power_table in KHz */
+=09=09power_table[i].frequency =3D freq / 1000;
+=09=09power_table[i].power =3D power;
+
+=09=09i++;
+=09}
+
+=09if (i =3D=3D 0) {
+=09=09ret =3D PTR_ERR(opp);
+=09=09goto unlock;
+=09}
+
+=09cpu_actor->dyn_power_table =3D power_table;
+=09cpu_actor->dyn_power_table_entries =3D i;
+
+unlock:
+=09rcu_read_unlock();
+=09return ret;
+}
+
+/**
+ * power_cpu_actor_register - register a cpu_actor within the power actor =
API
+ * @cpumask:=09cpumask of cpus covered by this power_actor
+ * @tz:=09=09thermal zone closest to the cpus (optional)
+ * @capacitance: dynamic power coefficient for these cpus
+ * @plat_static_func:=09function to calculate the static power consumed by=
 these
+ *=09=09=09cpus (optional)
+ *
+ * Create a cpufreq cooling device for the cpus in @cpumask and
+ * register it with the power actor API using a simple cpu power
+ * model.  The cpus must have registered their OPPs in the OPP
+ * library.
+ *
+ * An optional @plat_static_func may be provided to calculate the
+ * static power consumed by these cpus.  If the platform's static
+ * power consumption is unknown or negligible, make it NULL.  If
+ * @plat_static_fun is specified, @tz needs to be specified as well.
+ * @tz should be a pointer to the thermal_zone_device whose sensor is
+ * closer to the cpus in @cpumask.
+ *
+ * Return the power_actor created on success or the corresponding
+ * ERR_PTR() on failure.  This actor should be freed with
+ * power_cpu_actor_unregister() when it's no longer needed.
+ */
+struct power_actor *
+power_cpu_actor_register(cpumask_t *cpumask,
+=09=09=09struct thermal_zone_device *tz,
+=09=09=09u32 capacitance,
+=09=09=09get_static_t plat_static_func)
+{
+=09int ret;
+=09struct thermal_cooling_device *cdev;
+=09struct device *cpu_dev;
+=09struct power_actor *actor, *err_ret;
+=09struct cpu_actor *cpu_actor;
+
+=09if (plat_static_func && !tz) {
+=09=09pr_warn("plat_static_func provided without a thermal zone, ignoring =
it\n");
+=09=09plat_static_func =3D NULL;
+=09}
+
+=09cpu_dev =3D get_cpu_device(cpumask_any(cpumask));
+=09if (!cpu_dev || !cpu_dev->of_node)
+=09=09cdev =3D cpufreq_cooling_register(cpumask);
+=09else
+=09=09cdev =3D of_cpufreq_cooling_register(cpu_dev->of_node, cpumask);
+
+=09if (!cdev)
+=09=09return ERR_PTR(PTR_ERR(cdev));
+
+=09cpu_actor =3D kzalloc(sizeof(*cpu_actor), GFP_KERNEL);
+=09if (!cpu_actor) {
+=09=09err_ret =3D ERR_PTR(-ENOMEM);
+=09=09goto cdev_unregister;
+=09}
+
+=09cpumask_copy(&cpu_actor->cpumask, cpumask);
+=09cpu_actor->cdev =3D cdev;
+=09cpu_actor->tz =3D tz;
+=09cpu_actor->plat_get_static_power =3D plat_static_func;
+
+=09ret =3D build_dyn_power_table(cpu_actor, capacitance);
+=09if (ret) {
+=09=09err_ret =3D ERR_PTR(ret);
+=09=09goto kfree;
+=09}
+
+=09actor =3D power_actor_register(POWER_ACTOR_CPU, &cpu_actor_ops,
+=09=09=09=09cpu_actor);
+=09if (IS_ERR(actor)) {
+=09=09err_ret =3D actor;
+=09=09goto kfree;
+=09}
+
+=09mutex_lock(&cpu_power_actor_lock);
+
+=09/*
+=09 * You can't register multiple times the same notifier_block.
+=09 * The first power actor registered is the only one that
+=09 * registers the notifier.
+=09 */
+=09if (!cpu_power_actors_registered) {
+=09=09ret =3D cpufreq_register_notifier(&cpufreq_transition_notifier,
+=09=09=09=09=09=09CPUFREQ_TRANSITION_NOTIFIER);
+=09=09if (ret) {
+=09=09=09err_ret =3D ERR_PTR(ret);
+=09=09=09mutex_unlock(&cpu_power_actor_lock);
+=09=09=09goto power_actor_unregister;
+=09=09}
+=09}
+
+=09cpu_power_actors_registered++;
+=09mutex_unlock(&cpu_power_actor_lock);
+
+=09return actor;
+
+power_actor_unregister:
+=09power_actor_unregister(actor);
+kfree:
+=09kfree(cpu_actor);
+cdev_unregister:
+=09cpufreq_cooling_unregister(cdev);
+
+=09return err_ret;
+}
+
+void power_cpu_actor_unregister(struct power_actor *actor)
+{
+=09struct cpu_actor *cpu_actor =3D actor->data;
+
+=09kfree(cpu_actor->dyn_power_table);
+
+=09mutex_lock(&cpu_power_actor_lock);
+
+=09cpu_power_actors_registered--;
+
+=09if (!cpu_power_actors_registered)
+=09=09cpufreq_unregister_notifier(&cpufreq_transition_notifier,
+=09=09=09=09=09CPUFREQ_TRANSITION_NOTIFIER);
+
+=09mutex_unlock(&cpu_power_actor_lock);
+
+=09kfree(cpu_actor);
+=09power_actor_unregister(actor);
+}
diff --git a/drivers/thermal/power_actor/power_actor.h b/drivers/thermal/po=
wer_actor/power_actor.h
index 28098f43630b..230317c284b2 100644
--- a/drivers/thermal/power_actor/power_actor.h
+++ b/drivers/thermal/power_actor/power_actor.h
@@ -17,11 +17,16 @@
 #ifndef __POWER_ACTOR_H__
 #define __POWER_ACTOR_H__
=20
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/list.h>
+#include <linux/thermal.h>
=20
 #define MAX_NUM_ACTORS 8
=20
 enum power_actor_types {
+=09POWER_ACTOR_CPU,
 };
=20
 struct power_actor;
@@ -59,6 +64,42 @@ struct power_actor *power_actor_register(enum power_acto=
r_types type,
 =09=09=09=09=09void *privdata);
 void power_actor_unregister(struct power_actor *actor);
=20
+typedef u32 (*get_static_t)(cpumask_t *cpumask,
+=09=09=09=09unsigned long voltage,
+=09=09=09=09unsigned long temperature);
+
+#ifdef CONFIG_THERMAL_POWER_ACTOR_CPU
+int power_cpu_actor_add_static(unsigned int cpu,
+=09=09=09struct thermal_zone_device *tz,
+=09=09=09get_static_t plat_static_func);
+struct power_actor *
+power_cpu_actor_register(cpumask_t *cpumask,
+=09=09=09struct thermal_zone_device *tz,
+=09=09=09u32 capacitance,
+=09=09=09get_static_t plat_static_func);
+void power_cpu_actor_unregister(struct power_actor *actor);
+#else
+static inline
+int power_cpu_actor_add_static(unsigned int cpu,
+=09=09=09=09=09struct thermal_zone_device *tz,
+=09=09=09=09=09get_static_t plat_static_func)
+{
+=09return -ENOSYS;
+}
+static inline
+struct power_actor *
+power_cpu_actor_register(cpumask_t *cpumask,
+=09=09=09struct thermal_zone_device *tz,
+=09=09=09u32 capacitance,
+=09=09=09get_static_t plat_static_func)
+{
+=09return ERR_PTR(-ENOSYS);
+}
+static inline void power_cpu_actor_unregister(struct power_actor *actor)
+{
+}
+#endif
+
 extern struct list_head actor_list;
=20
 #endif /* __POWER_ACTOR_H__ */
--=20
1.9.1
