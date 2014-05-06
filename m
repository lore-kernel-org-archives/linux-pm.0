From: Javi Merino <javi.merino@arm.com>
Subject: [RFC PATCH 3/5] thermal: add a basic cpu power actor
Date: Tue,  6 May 2014 13:06:36 +0100
Message-ID: <1399377998-14870-4-git-send-email-javi.merino@arm.com>
References: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34991 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934619AbaEFMHo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 May 2014 08:07:44 -0400
In-Reply-To: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Punit.Agrawal@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>

Introduce a new thermal_cooling_unit: THERMAL_UNIT_POWER and let
cpu_cooling device operate using it as well as "states".  This allows
governors that call cpufreq_get_max/cpufreq_get_cur/cpufreq_set_cur()
with THERMAL_UNIT_POWER to use cpufreq cooling devices.

If the cpu cooling device is registered using
{of_,}cpufreq_power_actor_register() instead of
{of_,}cpufreq_cooling_register() it uses the current frequency (as
reported by cpufreq) as well as load and OPPs for the power
calculations.  The cpus must have registered their OPPs in the OPP
library.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/cpu_cooling.c  |  430 ++++++++++++++++++++++++++++++++++++=
----
 drivers/thermal/thermal_core.c |    4 +-
 include/linux/cpu_cooling.h    |   28 +++
 include/linux/thermal.h        |    4 +
 4 files changed, 422 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index f3f4e6b5798e..8052cd1f4a39 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -24,10 +24,27 @@
 #include <linux/thermal.h>
 #include <linux/cpufreq.h>
 #include <linux/err.h>
+#include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
=20
+/* Maximum number of opps we can track */
+#define MAX_NUM_OPPS 32
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
 /**
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
  * @id: unique integer value corresponding to each cpufreq_cooling_device
@@ -39,6 +56,14 @@
  * @cpufreq_val: integer value representing the absolute value of the clip=
ped
  *=09frequency.
  * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
+ * @power_table: array of struct power_table for frequency to power conver=
sion
+ * @power_table_entries: number of entries in the @power_table array
+ * @time_in_idle: previous reading of the absolute time that this cpu was =
idle
+ * @time_in_idle_timestamp: wall time of the last invocation of
+ *=09get_cpu_idle_time_us()
+ * @last_load: load measured by the latest call to cpufreq_get_cur()
+ * @freq: frequency in KHz of the cpus represented by the cooling device
+ * @capacitance: the dynamic power coefficient of these cpus
  *
  * This structure is required for keeping information of each
  * cpufreq_cooling_device registered. In order to prevent corruption of th=
is a
@@ -50,11 +75,19 @@ struct cpufreq_cooling_device {
 =09unsigned int cpufreq_state;
 =09unsigned int cpufreq_val;
 =09struct cpumask allowed_cpus;
+=09struct power_table power_table[MAX_NUM_OPPS];
+=09int power_table_entries;
+=09u64 time_in_idle[NR_CPUS];
+=09u64 time_in_idle_timestamp[NR_CPUS];
+=09u32 last_load;
+=09u32 freq;
+=09u32 capacitance;
 };
 static DEFINE_IDR(cpufreq_idr);
 static DEFINE_MUTEX(cooling_cpufreq_lock);
=20
 static unsigned int cpufreq_dev_count;
+static bool power_actor_notifier_registered;
=20
 /* notify_table passes value to the CPUFREQ_ADJUST callback function. */
 #define NOTIFY_INVALID NULL
@@ -115,6 +148,59 @@ static int is_cpufreq_valid(int cpu)
 =09return !cpufreq_get_policy(&policy, cpu);
 }
=20
+static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_device=
,
+=09=09=09u32 freq)
+{
+=09int i;
+=09struct power_table *pt =3D cpufreq_device->power_table;
+
+=09for (i =3D 0; i < cpufreq_device->power_table_entries - 1; i++)
+=09=09if (freq <=3D pt[i].frequency)
+=09=09=09break;
+
+=09return pt[i].power;
+}
+
+static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_device=
,
+=09=09=09u32 power)
+{
+=09int i;
+=09struct power_table *pt =3D cpufreq_device->power_table;
+
+=09for (i =3D 0; i < cpufreq_device->power_table_entries - 1; i++)
+=09=09if (power <=3D pt[i].power)
+=09=09=09break;
+
+=09return pt[i].frequency;
+}
+
+/**
+ * get_load - get load for a cpu since last updated
+ * @cpufreq_device: struct cpufreq_cooling_device for this cooling device
+ * @cpu: cpu number
+ *
+ * Return the average load of cpu @cpu in percentage since this
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
+=09return load;
+}
+
 enum cpufreq_cooling_property {
 =09GET_LEVEL,
 =09GET_FREQ,
@@ -342,98 +428,193 @@ static int cpufreq_thermal_notifier(struct notifier_=
block *nb,
 =09return 0;
 }
=20
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
+=09struct thermal_cooling_device *cdev;
+=09struct cpufreq_freqs *freqs =3D data;
+
+=09/* Only update frequency on postchange */
+=09if (event !=3D CPUFREQ_POSTCHANGE)
+=09=09return NOTIFY_DONE;
+
+=09mutex_lock(&thermal_list_lock);
+
+=09list_for_each_entry(cdev, &thermal_cdev_list, node) {
+=09=09struct cpufreq_cooling_device *cpufreq_device;
+
+=09=09if (strncmp(cdev->type, "thermal-cpufreq", THERMAL_NAME_LENGTH))
+=09=09=09continue;
+
+=09=09cpufreq_device =3D cdev->devdata;
+
+=09=09if (cpumask_test_cpu(freqs->cpu, &cpufreq_device->allowed_cpus))
+=09=09=09cpufreq_device->freq =3D freqs->new;
+=09}
+
+=09mutex_unlock(&thermal_list_lock);
+
+=09return NOTIFY_OK;
+}
+
 /* cpufreq cooling device callback functions are defined below */
=20
 /**
- * cpufreq_get_max_state - callback function to get the max cooling state.
+ * cpufreq_get_max - callback function to get the max cooling state/power.
  * @cdev: thermal cooling device pointer.
- * @state: fill this variable with the max cooling state.
- * @unit: the units in which @state should be in.
+ * @val: fill this variable with the max cooling state/power.
+ * @unit: whether to put state or power in @val.
  *
  * Callback for the thermal cooling device to return the cpufreq max
- * cooling state.  Currently only THERMAL_UNIT_STATE is valid for
- * @unit.
+ * cooling state/power.  If @unit is THERMAL_UNIT_STATE, @val contains
+ * the maximum cooling state; if @unit is THERMAL_UNIT_POWER, @val
+ * maximum is power in milliwatts.
  *
  * Return: 0 on success, an error code otherwise.
  */
-static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
-=09=09=09=09unsigned long *state,
-=09=09=09=09enum thermal_cooling_unit unit)
+static int cpufreq_get_max(struct thermal_cooling_device *cdev,
+=09=09=09   unsigned long *val, enum thermal_cooling_unit unit)
 {
 =09struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
 =09struct cpumask *mask =3D &cpufreq_device->allowed_cpus;
 =09unsigned int cpu;
 =09unsigned int count =3D 0;
-=09int ret;
-
-=09if (unit !=3D THERMAL_UNIT_STATE)
-=09=09return -EINVAL;
+=09int ret =3D 0;
=20
 =09cpu =3D cpumask_any(mask);
=20
-=09ret =3D get_property(cpu, 0, &count, GET_MAXL);
+=09if ((unit =3D=3D THERMAL_UNIT_POWER) &&
+=09=09(cpufreq_device->power_table_entries)) {
+=09=09unsigned int num_cpus;
+=09=09unsigned long max_freq;
+
+=09=09max_freq =3D get_cpu_frequency(cpu, 0);
+=09=09if (!max_freq)
+=09=09=09return -EINVAL;
=20
-=09if (count > 0)
-=09=09*state =3D count;
+=09=09num_cpus =3D cpumask_weight(mask);
+=09=09*val =3D cpu_freq_to_power(cdev->devdata, max_freq) * num_cpus;
+=09} else if (unit =3D=3D THERMAL_UNIT_STATE) {
+=09=09ret =3D get_property(cpu, 0, &count, GET_MAXL);
+
+=09=09if (count > 0)
+=09=09=09*val =3D count;
+=09} else {
+=09=09ret =3D -EINVAL;
+=09}
=20
 =09return ret;
 }
=20
 /**
- * cpufreq_get_cur_state - callback function to get the current cooling st=
ate.
+ * cpufreq_get_cur - callback function to get the current cooling state/po=
wer.
  * @cdev: thermal cooling device pointer.
- * @state: fill this variable with the current cooling state.
- * @unit: the units in which state should be in
+ * @val: fill this variable with the current cooling state/power.
+ * @unit: whether to put state or power in @val.
  *
  * Callback for the thermal cooling device to return the cpufreq
- * current cooling state.  Currently only THERMAL_UNIT_STATE is valid
- * for @unit.
+ * current cooling state/power.  If @unit is THERMAL_UNIT_STATE, @val
+ * contains the current cooling state; if @unit is THERMAL_UNIT_POWER,
+ * @val is current power consumption in milliwatts.
  *
  * Return: 0 on success, an error code otherwise.
  */
-static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
-=09=09=09=09 unsigned long *state,
-=09=09=09=09 enum thermal_cooling_unit unit)
+static int cpufreq_get_cur(struct thermal_cooling_device *cdev,
+=09=09=09   unsigned long *val, enum thermal_cooling_unit unit)
 {
 =09struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
=20
-=09if (unit !=3D THERMAL_UNIT_STATE)
-=09=09return -EINVAL;
+=09if ((unit =3D=3D THERMAL_UNIT_POWER) &&
+=09=09(cpufreq_device->power_table_entries)) {
+=09=09int cpu;
+=09=09u32 total_load =3D 0, raw_cpu_power, power =3D 0;
+
+=09=09raw_cpu_power =3D cpu_freq_to_power(cpufreq_device,
+=09=09=09=09=09=09cpufreq_device->freq);
+
+=09=09for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
+=09=09=09u32 load;
=20
-=09*state =3D cpufreq_device->cpufreq_state;
+=09=09=09if (!cpu_online(cpu))
+=09=09=09=09continue;
+
+=09=09=09load =3D get_load(cpufreq_device, cpu);
+=09=09=09power +=3D (raw_cpu_power * load) / 100;
+=09=09=09total_load +=3D load;
+=09=09}
+
+=09=09cpufreq_device->last_load =3D total_load;
+=09=09*val =3D power;
+=09} else if (unit =3D=3D THERMAL_UNIT_STATE) {
+=09=09*val =3D cpufreq_device->cpufreq_state;
+=09} else {
+=09=09return -EINVAL;
+=09}
=20
 =09return 0;
 }
=20
 /**
- * cpufreq_set_cur_state - callback function to set the current cooling st=
ate.
+ * cpufreq_set_cur - callback function to set the current cooling state/po=
wer.
  * @cdev: thermal cooling device pointer.
- * @state: set this variable to the current cooling state.
- * @unit: the units in which @state should be in.
+ * @val: set this variable to the current cooling state/power.
+ * @unit: whether @val is a cooling state or power.
  *
  * Callback for the thermal cooling device to change the cpufreq
- * current cooling state.  Currently only THERMAL_UNIT_STATE is valid for
- * @unit.
+ * current cooling state/power.  If @unit is THERMAL_UNIT_STATE, @val
+ * is a cooling state; if @unit is THERMAL_UNIT_POWER, @val is the target
+ * power consumption in milliwatts.
  *
  * Return: 0 on success, an error code otherwise.
  */
-static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
-=09=09=09=09 unsigned long state,
-=09=09=09=09 enum thermal_cooling_unit unit)
+static int cpufreq_set_cur(struct thermal_cooling_device *cdev,
+=09=09=09   unsigned long val, enum thermal_cooling_unit unit)
 {
 =09struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
-
-=09if (unit !=3D THERMAL_UNIT_STATE)
+=09unsigned long state;
+
+=09if ((unit =3D=3D THERMAL_UNIT_POWER) &&
+=09=09(cpufreq_device->power_table_entries)) {
+=09=09unsigned int cpu, freq;
+=09=09u32 normalised_power, last_load;
+
+=09=09cpu =3D cpumask_any(&cpufreq_device->allowed_cpus);
+=09=09last_load =3D cpufreq_device->last_load ?
+=09=09=09cpufreq_device->last_load : 1;
+=09=09normalised_power =3D (val * 100) / last_load;
+=09=09freq =3D cpu_power_to_freq(cpufreq_device, normalised_power);
+
+=09=09state =3D cpufreq_cooling_get_level(cpu, freq);
+=09=09if (state =3D=3D THERMAL_CSTATE_INVALID) {
+=09=09=09pr_err("Failed to convert %dKHz for cpu %d into a cdev state\n",
+=09=09=09=09freq, cpu);
+=09=09=09return -EINVAL;
+=09=09}
+=09} else if (unit =3D=3D THERMAL_UNIT_STATE) {
+=09=09state =3D val;
+=09} else {
 =09=09return -EINVAL;
+=09}
=20
 =09return cpufreq_apply_cooling(cpufreq_device, state);
 }
=20
 /* Bind cpufreq callbacks to thermal cooling device ops */
 static struct thermal_cooling_device_ops const cpufreq_cooling_ops =3D {
-=09.get_max =3D cpufreq_get_max_state,
-=09.get_cur =3D cpufreq_get_cur_state,
-=09.set_cur =3D cpufreq_set_cur_state,
+=09.get_max =3D cpufreq_get_max,
+=09.get_cur =3D cpufreq_get_cur,
+=09.set_cur =3D cpufreq_set_cur,
 };
=20
 /* Notifier for cpufreq policy change */
@@ -441,10 +622,95 @@ static struct notifier_block thermal_cpufreq_notifier=
_block =3D {
 =09.notifier_call =3D cpufreq_thermal_notifier,
 };
=20
+/* Notifier for cpufreq frequency changes */
+struct notifier_block cpufreq_transition_notifier =3D {
+=09.notifier_call =3D cpufreq_frequency_change,
+};
+
+/**
+ * build_cpu_power_table - create a power to frequency table
+ * @cpufreq_dev:=09the cpufreq_cooling_device in which to store the table
+ *
+ * Build a power to frequency table for this cpu and store it in
+ * @cpufreq_dev.  This table will be used in cpu_power_to_freq() and
+ * cpu_freq_to_power() to convert between power and frequency
+ * efficiently.  Power is stored in mW, frequency in KHz.  The
+ * resulting table is in ascending order.
+ *
+ * Returns 0 on success, -E* on error.
+ */
+static int build_cpu_power_table(struct cpufreq_cooling_device *cpufreq_de=
v)
+{
+=09struct dev_pm_opp *opp;
+=09struct device *dev =3D NULL;
+=09int num_opps, cpu, i, ret =3D 0;
+=09unsigned long freq;
+
+=09num_opps =3D 0;
+
+=09rcu_read_lock();
+
+=09for_each_cpu(cpu, &cpufreq_dev->allowed_cpus) {
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
+=09if ((num_opps =3D=3D 0) || (num_opps > MAX_NUM_OPPS)) {
+=09=09ret =3D -EINVAL;
+=09=09goto unlock;
+=09}
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
+=09=09power =3D (u64)cpufreq_dev->capacitance * freq_mhz *
+=09=09=09voltage_mv * voltage_mv;
+=09=09do_div(power, 1000000000);
+
+=09=09/* frequency is stored in power_table in KHz */
+=09=09cpufreq_dev->power_table[i].frequency =3D freq / 1000;
+=09=09cpufreq_dev->power_table[i].power =3D power;
+
+=09=09i++;
+=09}
+
+=09if (i =3D=3D 0) {
+=09=09ret =3D PTR_ERR(opp);
+=09=09goto unlock;
+=09}
+
+=09cpufreq_dev->power_table_entries =3D i;
+
+unlock:
+=09rcu_read_unlock();
+=09return ret;
+}
+
 /**
  * __cpufreq_cooling_register - helper function to create cpufreq cooling =
device
  * @np: a valid struct device_node to the cooling device device tree node
  * @clip_cpus: cpumask of cpus where the frequency constraints will happen=
.
+ * @capacitance: dynamic power coefficient for these cpus
  *
  * This interface function registers the cpufreq cooling device with the n=
ame
  * "thermal-cpufreq-%x". This api can support multiple instances of cpufre=
q
@@ -456,7 +722,7 @@ static struct notifier_block thermal_cpufreq_notifier_b=
lock =3D {
  */
 static struct thermal_cooling_device *
 __cpufreq_cooling_register(struct device_node *np,
-=09=09=09   const struct cpumask *clip_cpus)
+=09=09=09const struct cpumask *clip_cpus, u32 capacitance)
 {
 =09struct thermal_cooling_device *cool_dev;
 =09struct cpufreq_cooling_device *cpufreq_dev =3D NULL;
@@ -485,6 +751,7 @@ __cpufreq_cooling_register(struct device_node *np,
 =09=09return ERR_PTR(-ENOMEM);
=20
 =09cpumask_copy(&cpufreq_dev->allowed_cpus, clip_cpus);
+=09cpufreq_dev->capacitance =3D capacitance;
=20
 =09ret =3D get_idr(&cpufreq_idr, &cpufreq_dev->id);
 =09if (ret) {
@@ -531,7 +798,7 @@ __cpufreq_cooling_register(struct device_node *np,
 struct thermal_cooling_device *
 cpufreq_cooling_register(const struct cpumask *clip_cpus)
 {
-=09return __cpufreq_cooling_register(NULL, clip_cpus);
+=09return __cpufreq_cooling_register(NULL, clip_cpus, 0);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
=20
@@ -555,11 +822,90 @@ of_cpufreq_cooling_register(struct device_node *np,
 =09if (!np)
 =09=09return ERR_PTR(-EINVAL);
=20
-=09return __cpufreq_cooling_register(np, clip_cpus);
+=09return __cpufreq_cooling_register(np, clip_cpus, 0);
 }
 EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
=20
 /**
+ * of_cpufreq_power_actor_register - function to create a cpu cooling devi=
ce with power capabilities
+ * @np:=09=09a valid struct device_node to the cooling device tree node
+ * @clip_cpus:=09cpumask of cpus where the frequency constraints will happ=
en
+ * @capacitance:=09the dynamic power coefficient for these cpus
+ *
+ * Similar to of_cpufreq_cooling_register() this function registers a
+ * cooling device linked to the device tree node provided.  It has a
+ * simple power model so that get_cur/get_max/set_cur can operate with
+ * THERMAL_UNIT_POWER
+ *
+ * The cpus must have registered their OPPs in the OPP library.
+ *
+ * Return: a valid struct thermal_cooling_device pointer on success,
+ * on failure, it returns a corresponding ERR_PTR().
+ */
+struct thermal_cooling_device *
+of_cpufreq_power_actor_register(struct device_node *np,
+=09=09=09=09const struct cpumask *clip_cpus,
+=09=09=09=09u32 capacitance)
+{
+=09struct thermal_cooling_device *cdev, *err_ret;
+=09int ret;
+
+=09cdev =3D __cpufreq_cooling_register(np, clip_cpus, capacitance);
+=09if (IS_ERR(cdev))
+=09=09return cdev;
+
+=09ret =3D build_cpu_power_table(cdev->devdata);
+=09if (ret) {
+=09=09err_ret =3D ERR_PTR(ret);
+=09=09goto unregister;
+=09}
+
+=09/*
+=09 * You can't register multiple times the same notifier_block.
+=09 * The first power actor registered is the only one that
+=09 * registers the notifier.
+=09 */
+=09if (!power_actor_notifier_registered) {
+=09=09ret =3D cpufreq_register_notifier(&cpufreq_transition_notifier,
+=09=09=09=09=09=09CPUFREQ_TRANSITION_NOTIFIER);
+=09=09if (ret) {
+=09=09=09err_ret =3D ERR_PTR(ret);
+=09=09=09goto unregister;
+=09=09}
+=09=09power_actor_notifier_registered =3D true;
+=09}
+
+=09return cdev;
+
+unregister:
+=09cpufreq_cooling_unregister(cdev);
+=09return err_ret;
+}
+EXPORT_SYMBOL_GPL(of_cpufreq_power_actor_register);
+
+/**
+ * cpufreq_power_actor_register - function to create a cpu cooling device =
with power capabilities
+ * @clip_cpus:=09cpumask of cpus where the frequency constraints will happ=
en
+ * @capacitance:=09the dynamic power coefficient for these cpus
+ *
+ * Similar to cpufreq_cooling_register() this function registers a
+ * cpufreq cooling device that has a simple power model so that
+ * get_cur/get_max/set_cur can operate with THERMAL_UNIT_POWER.
+ *
+ * See of_cpufreq_power_actor_register() for notes about the
+ * requisites for this to work.
+ *
+ * Return: a valid struct thermal_cooling_device pointer on success,
+ * on failure, it returns a corresponding ERR_PTR().
+ */
+struct thermal_cooling_device *
+cpufreq_power_actor_register(const struct cpumask *clip_cpus, u32 capacita=
nce)
+{
+=09return of_cpufreq_power_actor_register(NULL, clip_cpus, capacitance);
+}
+EXPORT_SYMBOL_GPL(cpufreq_power_actor_register);
+
+/**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
  * @cdev: thermal cooling device pointer.
  *
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.=
c
index 5b46603cc7cd..1efaadf436fa 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -50,10 +50,10 @@ static DEFINE_IDR(thermal_cdev_idr);
 static DEFINE_MUTEX(thermal_idr_lock);
=20
 static LIST_HEAD(thermal_tz_list);
-static LIST_HEAD(thermal_cdev_list);
+LIST_HEAD(thermal_cdev_list);
 static LIST_HEAD(thermal_governor_list);
=20
-static DEFINE_MUTEX(thermal_list_lock);
+DEFINE_MUTEX(thermal_list_lock);
 static DEFINE_MUTEX(thermal_governor_lock);
=20
 static struct thermal_governor *def_governor;
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index c303d383def1..b8d92ac4266b 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -36,6 +36,9 @@
 struct thermal_cooling_device *
 cpufreq_cooling_register(const struct cpumask *clip_cpus);
=20
+struct thermal_cooling_device *
+cpufreq_power_actor_register(const struct cpumask *clip_cpus, u32 capacita=
nce);
+
 /**
  * of_cpufreq_cooling_register - create cpufreq cooling device based on DT=
.
  * @np: a valid struct device_node to the cooling device device tree node.
@@ -45,6 +48,11 @@ cpufreq_cooling_register(const struct cpumask *clip_cpus=
);
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
 =09=09=09    const struct cpumask *clip_cpus);
+
+struct thermal_cooling_device *
+of_cpufreq_power_actor_register(struct device_node *np,
+=09=09=09=09const struct cpumask *clip_cpus,
+=09=09=09=09u32 capacitance);
 #else
 static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
@@ -52,6 +60,14 @@ of_cpufreq_cooling_register(struct device_node *np,
 {
 =09return NULL;
 }
+
+static inline struct thermal_cooling_device *
+of_cpufreq_power_actor_register(struct device_node *np,
+=09=09=09=09const struct cpumask *clip_cpus,
+=09=09=09=09u32 capacitance);
+{
+=09return ERR_PTR(-ENOSYS);
+}
 #endif
=20
 /**
@@ -73,6 +89,18 @@ of_cpufreq_cooling_register(struct device_node *np,
 {
 =09return NULL;
 }
+static inline struct thermal_cooling_device *
+cpufreq_power_actor_register(const struct cpumask *clip_cpus, u32 capacita=
nce)
+{
+=09return ERR_PTR(-ENOSYS);
+}
+static inline struct thermal_cooling_device *
+of_cpufreq_power_actor_register(struct device_node *np,
+=09=09=09=09const struct cpumask *clip_cpus,
+=09=09=09=09u32 capacitance)
+{
+=09return ERR_PTR(-ENOSYS);
+}
 static inline
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8d183b8255eb..5986f546ca98 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -59,6 +59,9 @@
 #define DEFAULT_THERMAL_GOVERNOR       "user_space"
 #endif
=20
+extern struct list_head thermal_cdev_list;
+extern struct mutex thermal_list_lock;
+
 struct thermal_zone_device;
 struct thermal_cooling_device;
=20
@@ -108,6 +111,7 @@ enum {
=20
 enum thermal_cooling_unit {
 =09THERMAL_UNIT_STATE,
+=09THERMAL_UNIT_POWER,
 };
=20
 struct thermal_zone_device_ops {
--=20
1.7.9.5


