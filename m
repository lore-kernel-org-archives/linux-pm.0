From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v6 6/9] thermal: cpu_cooling: implement the power cooling device API
Date: Fri,  5 Dec 2014 19:04:17 +0000
Message-ID: <1417806260-9264-7-git-send-email-javi.merino@arm.com>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: punit.agrawal@arm.com, broonie@kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Add a basic power model to the cpu cooling device to implement the
power cooling device API.  The power model uses the current frequency,
current load and OPPs for the power calculations.  The cpus must have
registered their OPPs using the OPP library.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 Documentation/thermal/cpu-cooling-api.txt | 144 +++++++++-
 drivers/thermal/cpu_cooling.c             | 431 ++++++++++++++++++++++++++=
+++-
 include/linux/cpu_cooling.h               |  49 +++-
 3 files changed, 611 insertions(+), 13 deletions(-)

diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/ther=
mal/cpu-cooling-api.txt
index fca24c931ec8..d438a900e374 100644
--- a/Documentation/thermal/cpu-cooling-api.txt
+++ b/Documentation/thermal/cpu-cooling-api.txt
@@ -25,8 +25,150 @@ the user. The registration APIs returns the cooling dev=
ice pointer.
=20
    clip_cpus: cpumask of cpus where the frequency constraints will happen.
=20
-1.1.2 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
+1.1.2 struct thermal_cooling_device *cpufreq_power_cooling_register(
+    const struct cpumask *clip_cpus, u32 capacitance,
+    get_static_t plat_static_func)
+
+Similar to cpufreq_cooling_register, this function registers a cpufreq
+cooling device.  Using this function, the cooling device will
+implement the power extensions by using a simple cpu power model.  The
+cpus must have registered their OPPs using the OPP library.
+
+The additional parameters are needed for the power model (See 2. Power
+models).  "capacitance" is the dynamic power coefficient (See 2.1
+Dynamic power).  "plat_static_func" is a function to calculate the
+static power consumed by these cpus (See 2.2 Static power).
+
+1.1.3 struct thermal_cooling_device *of_cpufreq_power_cooling_register(
+    struct device_node *np, const struct cpumask *clip_cpus, u32 capacitan=
ce,
+    get_static_t plat_static_func)
+
+Similar to cpufreq_power_cooling_register, this function register a
+cpufreq cooling device with power extensions using the device tree
+information supplied by the np parameter.
+
+1.1.4 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
=20
     This interface function unregisters the "thermal-cpufreq-%x" cooling d=
evice.
=20
     cdev: Cooling device pointer which has to be unregistered.
+
+2. Power models
+
+The power API registration functions provide a simple power model for
+CPUs.  The current power is calculated as dynamic + (optionally)
+static power.  This power model requires that the operating-points of
+the CPUs are registered using the kernel's opp library and the
+`cpufreq_frequency_table` is assigned to the `struct device` of the
+cpu.  If you are using the `cpufreq-cpu0.c` driver then the
+`cpufreq_frequency_table` should already be assigned to the cpu
+device.
+
+The `plat_static_func` parameter of `cpufreq_power_cooling_register()`
+and `of_cpufreq_power_cooling_register()` is optional.  If you don't
+provide it, only dynamic power will be considered.
+
+2.1 Dynamic power
+
+The dynamic power consumption of a processor depends on many factors.
+For a given processor implementation the primary factors are:
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
+2.2 Static power
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
+process grade, the current temperature and the operating voltage.
+However, since both implementation specific and complex relationships
+dominate the estimate, the appropriate interface to the model from the
+cpu cooling device is to provide a function callback that calculates
+the static power in this platform.  When registering the cpu cooling
+device pass a function pointer that follows the `get_static_t`
+prototype:
+
+    u32 plat_get_static(cpumask_t *cpumask, unsigned long voltage);
+
+with `cpumask` a cpumask of the cpus involved in the calculation and
+`voltage` the voltage at which they are operating.
+
+If `plat_static_func` is NULL, static power is considered to be
+negligible for this platform and only dynamic power is considered.
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
+its inclusion when using cpu cooling devices should be assessed on a
+case by cases basis.
+
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ad09e51ffae4..335d95dd7e5a 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -24,11 +24,25 @@
 #include <linux/thermal.h>
 #include <linux/cpufreq.h>
 #include <linux/err.h>
+#include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
=20
 /**
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
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
  * @id: unique integer value corresponding to each cpufreq_cooling_device
  *=09registered.
@@ -39,6 +53,14 @@
  * @cpufreq_val: integer value representing the absolute value of the clip=
ped
  *=09frequency.
  * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
+ * @last_load: load measured by the latest call to cpufreq_get_actual_powe=
r()
+ * @time_in_idle: previous reading of the absolute time that this cpu was =
idle
+ * @time_in_idle_timestamp: wall time of the last invocation of
+ *=09get_cpu_idle_time_us()
+ * @dyn_power_table: array of struct power_table for frequency to power
+ *=09conversion
+ * @dyn_power_table_entries: number of entries in the @dyn_power_table arr=
ay
+ * @plat_get_static_power: callback to calculate the static power
  *
  * This structure is required for keeping information of each
  * cpufreq_cooling_device registered. In order to prevent corruption of th=
is a
@@ -51,6 +73,12 @@ struct cpufreq_cooling_device {
 =09unsigned int cpufreq_val;
 =09struct cpumask allowed_cpus;
 =09struct list_head node;
+=09u32 last_load;
+=09u64 time_in_idle[NR_CPUS];
+=09u64 time_in_idle_timestamp[NR_CPUS];
+=09struct power_table *dyn_power_table;
+=09int dyn_power_table_entries;
+=09get_static_t plat_get_static_power;
 };
 static DEFINE_IDR(cpufreq_idr);
 static DEFINE_MUTEX(cooling_cpufreq_lock);
@@ -338,6 +366,206 @@ static int cpufreq_thermal_notifier(struct notifier_b=
lock *nb,
 =09return 0;
 }
=20
+/**
+ * build_dyn_power_table() - create a dynamic power to frequency table
+ * @cpufreq_device:=09the cpufreq cooling device in which to store the tab=
le
+ * @capacitance: dynamic power coefficient for these cpus
+ *
+ * Build a dynamic power to frequency table for this cpu and store it
+ * in @cpufreq_device.  This table will be used in cpu_power_to_freq() and
+ * cpu_freq_to_power() to convert between power and frequency
+ * efficiently.  Power is stored in mW, frequency in KHz.  The
+ * resulting table is in ascending order.
+ *
+ * Return: 0 on success, -E* on error.
+ */
+static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_de=
vice,
+=09=09=09=09u32 capacitance)
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
+=09for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
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
+=09cpufreq_device->dyn_power_table =3D power_table;
+=09cpufreq_device->dyn_power_table_entries =3D i;
+
+unlock:
+=09rcu_read_unlock();
+=09return ret;
+}
+
+static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_device=
,
+=09=09=09u32 freq)
+{
+=09int i;
+=09struct power_table *pt =3D cpufreq_device->dyn_power_table;
+
+=09for (i =3D 1; i < cpufreq_device->dyn_power_table_entries; i++)
+=09=09if (freq < pt[i].frequency)
+=09=09=09break;
+
+=09return pt[i - 1].power;
+}
+
+static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_device=
,
+=09=09=09u32 power)
+{
+=09int i;
+=09struct power_table *pt =3D cpufreq_device->dyn_power_table;
+
+=09for (i =3D 1; i < cpufreq_device->dyn_power_table_entries; i++)
+=09=09if (power < pt[i].power)
+=09=09=09break;
+
+=09return pt[i - 1].frequency;
+}
+
+/**
+ * get_load() - get load for a cpu since last updated
+ * @cpufreq_device:=09&struct cpufreq_cooling_device for this cpu
+ * @cpu:=09cpu number
+ *
+ * Return: The average load of cpu @cpu in percentage since this
+ * function was last called.
+ */
+static u32 get_load(struct cpufreq_cooling_device *cpufreq_device, int cpu=
)
+{
+=09u32 load;
+=09u64 now, now_idle, delta_time, delta_idle;
+
+=09now_idle =3D get_cpu_idle_time(cpu, &now, 0);
+=09delta_idle =3D now_idle - cpufreq_device->time_in_idle[cpu];
+=09delta_time =3D now - cpufreq_device->time_in_idle_timestamp[cpu];
+
+=09if (delta_time <=3D delta_idle)
+=09=09load =3D 0;
+=09else
+=09=09load =3D div64_u64(100 * (delta_time - delta_idle), delta_time);
+
+=09cpufreq_device->time_in_idle[cpu] =3D now_idle;
+=09cpufreq_device->time_in_idle_timestamp[cpu] =3D now;
+
+=09return load;
+}
+
+/**
+ * get_static_power() - calculate the static power consumed by the cpus
+ * @cpufreq_device:=09struct &cpufreq_cooling_device for this cpu cdev
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
+static u32 get_static_power(struct cpufreq_cooling_device *cpufreq_device,
+=09=09=09unsigned long freq)
+{
+=09struct device *cpu_dev;
+=09struct dev_pm_opp *opp;
+=09unsigned long voltage;
+=09struct cpumask *cpumask =3D &cpufreq_device->allowed_cpus;
+=09unsigned long freq_hz =3D freq * 1000;
+
+=09if (!cpufreq_device->plat_get_static_power)
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
+=09return cpufreq_device->plat_get_static_power(cpumask, voltage);
+}
+
+/**
+ * get_dynamic_power() - calculate the dynamic power
+ * @cpufreq_device:=09&cpufreq_cooling_device for this cdev
+ * @freq:=09current frequency
+ *
+ * Return: the dynamic power consumed by the cpus described by
+ * @cpufreq_device.
+ */
+static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_device=
,
+=09=09=09unsigned long freq)
+{
+=09u32 raw_cpu_power;
+
+=09raw_cpu_power =3D cpu_freq_to_power(cpufreq_device, freq);
+=09return (raw_cpu_power * cpufreq_device->last_load) / 100;
+}
+
 /* cpufreq cooling device callback functions are defined below */
=20
 /**
@@ -407,8 +635,106 @@ static int cpufreq_set_cur_state(struct thermal_cooli=
ng_device *cdev,
 =09return cpufreq_apply_cooling(cpufreq_device, state);
 }
=20
+/**
+ * cpufreq_get_actual_power() - get the current power
+ * @cdev:=09&thermal_cooling_device pointer
+ *
+ * Return the current power consumption of the cpus in milliwatts.
+ */
+static u32 cpufreq_get_actual_power(struct thermal_cooling_device *cdev)
+{
+=09unsigned long freq;
+=09int cpu;
+=09u32 static_power, dynamic_power, total_load =3D 0;
+=09struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
+
+=09freq =3D cpufreq_quick_get(cpumask_any(&cpufreq_device->allowed_cpus));
+
+=09for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
+=09=09u32 load;
+
+=09=09if (cpu_online(cpu))
+=09=09=09load =3D get_load(cpufreq_device, cpu);
+=09=09else
+=09=09=09load =3D 0;
+
+=09=09total_load +=3D load;
+=09}
+
+=09cpufreq_device->last_load =3D total_load;
+
+=09static_power =3D get_static_power(cpufreq_device, freq);
+=09dynamic_power =3D get_dynamic_power(cpufreq_device, freq);
+
+=09return static_power + dynamic_power;
+}
+
+/**
+ * cpufreq_state2power() - convert a cpu cdev state to power consumed
+ * @cdev:=09&thermal_cooling_device pointer
+ * @state:=09cooling device state to be converted
+ *
+ * Convert cooling device state @state into power consumption in milliwatt=
s.
+ */
+static u32 cpufreq_state2power(struct thermal_cooling_device *cdev,
+=09=09=09unsigned long state)
+{
+=09unsigned int freq, num_cpus;
+=09cpumask_t cpumask;
+=09u32 static_power, dynamic_power;
+=09struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
+
+=09cpumask_and(&cpumask, &cpufreq_device->allowed_cpus, cpu_online_mask);
+=09num_cpus =3D cpumask_weight(&cpumask);
+
+=09freq =3D get_cpu_frequency(cpumask_any(&cpumask), state);
+=09if (!freq)
+=09=09return 0;
+
+=09static_power =3D get_static_power(cpufreq_device, freq);
+=09dynamic_power =3D cpu_freq_to_power(cpufreq_device, freq) * num_cpus;
+
+=09return static_power + dynamic_power;
+}
+
+/**
+ * cpufreq_power2state() - convert power to a cooling device state
+ * @cdev:=09&thermal_cooling_device pointer
+ * @power:=09power in milliwatts to be converted
+ *
+ * Calculate a cooling device state for the cpus described by @cdev
+ * that would allow them to consume at most @power mW.
+ */
+static unsigned long cpufreq_power2state(struct thermal_cooling_device *cd=
ev,
+=09=09=09=09=09u32 power)
+{
+=09unsigned int cpu, cur_freq, target_freq;
+=09s32 dyn_power;
+=09u32 last_load, normalised_power;
+=09unsigned long cdev_state;
+=09struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
+
+=09cpu =3D cpumask_any_and(&cpufreq_device->allowed_cpus, cpu_online_mask)=
;
+
+=09cur_freq =3D cpufreq_quick_get(cpu);
+=09dyn_power =3D power - get_static_power(cpufreq_device, cur_freq);
+=09dyn_power =3D dyn_power > 0 ? dyn_power : 0;
+=09last_load =3D cpufreq_device->last_load ?: 1;
+=09normalised_power =3D (dyn_power * 100) / last_load;
+=09target_freq =3D cpu_power_to_freq(cpufreq_device, normalised_power);
+
+=09cdev_state =3D cpufreq_cooling_get_level(cpu, target_freq);
+=09if (cdev_state =3D=3D THERMAL_CSTATE_INVALID) {
+=09=09pr_err_ratelimited("Failed to convert %dKHz for cpu %d into a cdev s=
tate\n",
+=09=09=09=09target_freq, cpu);
+=09=09return 0;
+=09}
+
+=09return cdev_state;
+}
+
 /* Bind cpufreq callbacks to thermal cooling device ops */
-static struct thermal_cooling_device_ops const cpufreq_cooling_ops =3D {
+static struct thermal_cooling_device_ops cpufreq_cooling_ops =3D {
 =09.get_max_state =3D cpufreq_get_max_state,
 =09.get_cur_state =3D cpufreq_get_cur_state,
 =09.set_cur_state =3D cpufreq_set_cur_state,
@@ -434,7 +760,8 @@ static struct notifier_block thermal_cpufreq_notifier_b=
lock =3D {
  */
 static struct thermal_cooling_device *
 __cpufreq_cooling_register(struct device_node *np,
-=09=09=09   const struct cpumask *clip_cpus)
+=09=09=09const struct cpumask *clip_cpus, u32 capacitance,
+=09=09=09get_static_t plat_static_func)
 {
 =09struct thermal_cooling_device *cool_dev;
 =09struct cpufreq_cooling_device *cpufreq_dev =3D NULL;
@@ -464,10 +791,23 @@ __cpufreq_cooling_register(struct device_node *np,
=20
 =09cpumask_copy(&cpufreq_dev->allowed_cpus, clip_cpus);
=20
+=09if (capacitance) {
+=09=09cpufreq_cooling_ops.get_actual_power =3D cpufreq_get_actual_power;
+=09=09cpufreq_cooling_ops.state2power =3D cpufreq_state2power;
+=09=09cpufreq_cooling_ops.power2state =3D cpufreq_power2state;
+=09=09cpufreq_dev->plat_get_static_power =3D plat_static_func;
+
+=09=09ret =3D build_dyn_power_table(cpufreq_dev, capacitance);
+=09=09if (ret) {
+=09=09=09cool_dev =3D ERR_PTR(ret);
+=09=09=09goto free;
+=09=09}
+=09}
+
 =09ret =3D get_idr(&cpufreq_idr, &cpufreq_dev->id);
 =09if (ret) {
-=09=09kfree(cpufreq_dev);
-=09=09return ERR_PTR(-EINVAL);
+=09=09cool_dev =3D ERR_PTR(-EINVAL);
+=09=09goto free;
 =09}
=20
 =09snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
@@ -475,11 +815,8 @@ __cpufreq_cooling_register(struct device_node *np,
=20
 =09cool_dev =3D thermal_of_cooling_device_register(np, dev_name, cpufreq_d=
ev,
 =09=09=09=09=09=09      &cpufreq_cooling_ops);
-=09if (IS_ERR(cool_dev)) {
-=09=09release_idr(&cpufreq_idr, cpufreq_dev->id);
-=09=09kfree(cpufreq_dev);
-=09=09return cool_dev;
-=09}
+=09if (IS_ERR(cool_dev))
+=09=09goto release_idr;
 =09cpufreq_dev->cool_dev =3D cool_dev;
 =09cpufreq_dev->cpufreq_state =3D 0;
 =09mutex_lock(&cooling_cpufreq_lock);
@@ -494,6 +831,12 @@ __cpufreq_cooling_register(struct device_node *np,
 =09mutex_unlock(&cooling_cpufreq_lock);
=20
 =09return cool_dev;
+
+release_idr:
+=09release_idr(&cpufreq_idr, cpufreq_dev->id);
+free:
+=09kfree(cpufreq_dev);
+=09return cool_dev;
 }
=20
 /**
@@ -510,7 +853,7 @@ __cpufreq_cooling_register(struct device_node *np,
 struct thermal_cooling_device *
 cpufreq_cooling_register(const struct cpumask *clip_cpus)
 {
-=09return __cpufreq_cooling_register(NULL, clip_cpus);
+=09return __cpufreq_cooling_register(NULL, clip_cpus, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
=20
@@ -534,11 +877,77 @@ of_cpufreq_cooling_register(struct device_node *np,
 =09if (!np)
 =09=09return ERR_PTR(-EINVAL);
=20
-=09return __cpufreq_cooling_register(np, clip_cpus);
+=09return __cpufreq_cooling_register(np, clip_cpus, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
=20
 /**
+ * cpufreq_power_cooling_register() - create cpufreq cooling device with p=
ower extensions
+ * @clip_cpus:=09cpumask of cpus where the frequency constraints will happ=
en
+ * @capacitance:=09dynamic power coefficient for these cpus
+ * @plat_static_func:=09function to calculate the static power consumed by=
 these
+ *=09=09=09cpus (optional)
+ *
+ * This interface function registers the cpufreq cooling device with
+ * the name "thermal-cpufreq-%x".  This api can support multiple
+ * instances of cpufreq cooling devices.  Using this function, the
+ * cooling device will implement the power extensions by using a
+ * simple cpu power model.  The cpus must have registered their OPPs
+ * using the OPP library.
+ *
+ * An optional @plat_static_func may be provided to calculate the
+ * static power consumed by these cpus.  If the platform's static
+ * power consumption is unknown or negligible, make it NULL.
+ *
+ * Return: a valid struct thermal_cooling_device pointer on success,
+ * on failure, it returns a corresponding ERR_PTR().
+ */
+struct thermal_cooling_device *
+cpufreq_power_cooling_register(const struct cpumask *clip_cpus, u32 capaci=
tance,
+=09=09=09get_static_t plat_static_func)
+{
+=09return __cpufreq_cooling_register(NULL, clip_cpus, capacitance,
+=09=09=09=09plat_static_func);
+}
+EXPORT_SYMBOL(cpufreq_power_cooling_register);
+
+/**
+ * of_cpufreq_power_cooling_register() - create cpufreq cooling device wit=
h power extensions
+ * @np:=09a valid struct device_node to the cooling device device tree nod=
e
+ * @clip_cpus:=09cpumask of cpus where the frequency constraints will happ=
en
+ * @capacitance:=09dynamic power coefficient for these cpus
+ * @plat_static_func:=09function to calculate the static power consumed by=
 these
+ *=09=09=09cpus (optional)
+ *
+ * This interface function registers the cpufreq cooling device with
+ * the name "thermal-cpufreq-%x".  This api can support multiple
+ * instances of cpufreq cooling devices.  Using this API, the cpufreq
+ * cooling device will be linked to the device tree node provided.
+ * Using this function, the cooling device will implement the power
+ * extensions by using a simple cpu power model.  The cpus must have
+ * registered their OPPs using the OPP library.
+ *
+ * An optional @plat_static_func may be provided to calculate the
+ * static power consumed by these cpus.  If the platform's static
+ * power consumption is unknown or negligible, make it NULL.
+ *
+ * Return: a valid struct thermal_cooling_device pointer on success,
+ * on failure, it returns a corresponding ERR_PTR().
+ */
+struct thermal_cooling_device *
+of_cpufreq_power_cooling_register(struct device_node *np,
+=09=09=09const struct cpumask *clip_cpus, u32 capacitance,
+=09=09=09get_static_t plat_static_func)
+{
+=09if (!np)
+=09=09return ERR_PTR(-EINVAL);
+
+=09return __cpufreq_cooling_register(np, clip_cpus, capacitance,
+=09=09=09=09plat_static_func);
+}
+EXPORT_SYMBOL(of_cpufreq_power_cooling_register);
+
+/**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
  * @cdev: thermal cooling device pointer.
  *
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index c303d383def1..5c4f4567acf0 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -28,6 +28,8 @@
 #include <linux/thermal.h>
 #include <linux/cpumask.h>
=20
+typedef u32 (*get_static_t)(cpumask_t *cpumask, unsigned long voltage);
+
 #ifdef CONFIG_CPU_THERMAL
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
@@ -37,14 +39,38 @@ struct thermal_cooling_device *
 cpufreq_cooling_register(const struct cpumask *clip_cpus);
=20
 /**
+ * cpufreq_power_cooling_register() - create cpufreq cooling device with p=
ower extensions
+ * @clip_cpus: cpumask of cpus where the frequency constraints will happen
+ * @capacitance:=09dynamic power coefficient for these cpus
+ * @plat_static_func:=09function to calculate the static power consumed by=
 these
+ *=09=09=09cpus (optional)
+ */
+struct thermal_cooling_device *
+cpufreq_power_cooling_register(const struct cpumask *clip_cpus,
+=09=09=09u32 capacitance, get_static_t plat_static_func);
+
+#ifdef CONFIG_THERMAL_OF
+/**
  * of_cpufreq_cooling_register - create cpufreq cooling device based on DT=
.
  * @np: a valid struct device_node to the cooling device device tree node.
  * @clip_cpus: cpumask of cpus where the frequency constraints will happen
  */
-#ifdef CONFIG_THERMAL_OF
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
 =09=09=09    const struct cpumask *clip_cpus);
+
+/**
+ * of_cpufreq_power_cooling_register() - create cpufreq cooling device wit=
h power extensions
+ * @np:=09a valid struct device_node to the cooling device device tree nod=
e
+ * @clip_cpus:=09cpumask of cpus where the frequency constraints will happ=
en
+ * @capacitance:=09dynamic power coefficient for these cpus
+ * @plat_static_func:=09function to calculate the static power consumed by=
 these
+ *=09=09=09cpus (optional)
+ */
+struct thermal_cooling_device *
+of_cpufreq_power_cooling_register(struct device_node *np,
+=09=09=09=09const struct cpumask *clip_cpus,
+=09=09=09=09u32 capacitance, get_static_t plat_static_func);
 #else
 static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
@@ -52,6 +78,14 @@ of_cpufreq_cooling_register(struct device_node *np,
 {
 =09return NULL;
 }
+
+struct thermal_cooling_device *
+of_cpufreq_power_cooling_register(struct device_node *np,
+=09=09=09=09const struct cpumask *clip_cpus,
+=09=09=09=09u32 capacitance, get_static_t plat_static_func)
+{
+=09return NULL;
+}
 #endif
=20
 /**
@@ -68,11 +102,24 @@ cpufreq_cooling_register(const struct cpumask *clip_cp=
us)
 =09return NULL;
 }
 static inline struct thermal_cooling_device *
+cpufreq_power_cooling_register(const struct cpumask *clip_cpus,
+=09=09=09u32 capacitance, get_static_t plat_static_func)
+{
+=09return NULL;
+}
+static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
 =09=09=09    const struct cpumask *clip_cpus)
 {
 =09return NULL;
 }
+static inline struct thermal_cooling_device *
+of_cpufreq_power_cooling_register(struct device_node *np,
+=09=09=09=09const struct cpumask *clip_cpus,
+=09=09=09=09u32 capacitance, get_static_t plat_static_func)
+{
+=09return NULL;
+}
 static inline
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
--=20
1.9.1
