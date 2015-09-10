From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v6 3/5] thermal: Add devfreq cooling
Date: Thu, 10 Sep 2015 18:09:30 +0100
Message-ID: <1441904972-5809-4-git-send-email-javi.merino@arm.com>
References: <1441904972-5809-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441904972-5809-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com, edubezval@gmail.com, =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>
List-Id: linux-pm@vger.kernel.org

=46rom: =C3=98rjan Eide <orjan.eide@arm.com>

Add a generic thermal cooling device for devfreq, that is similar to
cpu_cooling.

The device must use devfreq.  In order to use the power extension of th=
e
cooling device, it must have registered its OPPs using the OPP library.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: =C3=98rjan Eide <orjan.eide@arm.com>
---
 drivers/thermal/Kconfig           |  14 +
 drivers/thermal/Makefile          |   3 +
 drivers/thermal/devfreq_cooling.c | 563 ++++++++++++++++++++++++++++++=
++++++++
 include/linux/devfreq_cooling.h   |  81 ++++++
 4 files changed, 661 insertions(+)
 create mode 100644 drivers/thermal/devfreq_cooling.c
 create mode 100644 include/linux/devfreq_cooling.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 118938ee8552..9f3e301ec6ee 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -147,6 +147,20 @@ config CLOCK_THERMAL
 	  device that is configured to use this cooling mechanism will be
 	  controlled to reduce clock frequency whenever temperature is high.
=20
+config DEVFREQ_THERMAL
+	bool "Generic device cooling support"
+	depends on PM_DEVFREQ
+	depends on PM_OPP
+	help
+	  This implements the generic devfreq cooling mechanism through
+	  frequency reduction for devices using devfreq.
+
+	  This will throttle the device by limiting the maximum allowed DVFS
+	  frequency corresponding to the cooling level.
+
+	  In order to use the power extensions of the cooling device,
+	  devfreq should use the simple_ondemand governor.
+
 	  If you want this support, you should say Y here.
=20
 config THERMAL_EMULATION
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 535dfee1496f..45f26978ff74 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -22,6 +22,9 @@ thermal_sys-$(CONFIG_CPU_THERMAL)	+=3D cpu_cooling.o
 # clock cooling
 thermal_sys-$(CONFIG_CLOCK_THERMAL)	+=3D clock_cooling.o
=20
+# devfreq cooling
+thermal_sys-$(CONFIG_DEVFREQ_THERMAL) +=3D devfreq_cooling.o
+
 # platform thermal drivers
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+=3D qcom-spmi-temp-alarm.o
 obj-$(CONFIG_SPEAR_THERMAL)	+=3D spear_thermal.o
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfre=
q_cooling.c
new file mode 100644
index 000000000000..a032c5d5c374
--- /dev/null
+++ b/drivers/thermal/devfreq_cooling.c
@@ -0,0 +1,563 @@
+/*
+ * devfreq_cooling: Thermal cooling device implementation for devices =
using
+ *                  devfreq
+ *
+ * Copyright (C) 2014-2015 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * TODO:
+ *    - If OPPs are added or removed after devfreq cooling has
+ *      registered, the devfreq cooling won't react to it.
+ */
+
+#include <linux/devfreq.h>
+#include <linux/devfreq_cooling.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/pm_opp.h>
+#include <linux/thermal.h>
+
+static DEFINE_MUTEX(devfreq_lock);
+static DEFINE_IDR(devfreq_idr);
+
+/**
+ * struct devfreq_cooling_device - Devfreq cooling device
+ * @id:		unique integer value corresponding to each
+ *		devfreq_cooling_device registered.
+ * @cdev:	Pointer to associated thermal cooling device.
+ * @devfreq:	Pointer to associated devfreq device.
+ * @cooling_state:	Current cooling state.
+ * @power_table:	Pointer to table with maximum power draw for each
+ *			cooling state. State is the index into the table, and
+ *			the power is in mW.
+ * @freq_table:	Pointer to a table with the frequencies sorted in desc=
ending
+ *		order.  You can index the table by cooling device state
+ * @freq_table_size:	Size of the @freq_table and @power_table
+ * @power_ops:	Pointer to devfreq_cooling_power, used to generate the
+ *		@power_table.
+ */
+struct devfreq_cooling_device {
+	int id;
+	struct thermal_cooling_device *cdev;
+	struct devfreq *devfreq;
+	unsigned long cooling_state;
+	u32 *power_table;
+	u32 *freq_table;
+	size_t freq_table_size;
+	struct devfreq_cooling_power *power_ops;
+};
+
+/**
+ * get_idr - function to get a unique id.
+ * @idr: struct idr * handle used to create a id.
+ * @id: int * value generated by this function.
+ *
+ * This function will populate @id with an unique
+ * id, using the idr API.
+ *
+ * Return: 0 on success, an error code on failure.
+ */
+static int get_idr(struct idr *idr, int *id)
+{
+	int ret;
+
+	mutex_lock(&devfreq_lock);
+	ret =3D idr_alloc(idr, NULL, 0, 0, GFP_KERNEL);
+	mutex_unlock(&devfreq_lock);
+	if (unlikely(ret < 0))
+		return ret;
+	*id =3D ret;
+
+	return 0;
+}
+
+/**
+ * release_idr - function to free the unique id.
+ * @idr: struct idr * handle used for creating the id.
+ * @id: int value representing the unique id.
+ */
+static void release_idr(struct idr *idr, int id)
+{
+	mutex_lock(&devfreq_lock);
+	idr_remove(idr, id);
+	mutex_unlock(&devfreq_lock);
+}
+
+/**
+ * partition_enable_opps() - disable all opps above a given state
+ * @dfc:	Pointer to devfreq we are operating on
+ * @cdev_state:	cooling device state we're setting
+ *
+ * Go through the OPPs of the device, enabling all OPPs until
+ * @cdev_state and disabling those frequencies above it.
+ */
+static int partition_enable_opps(struct devfreq_cooling_device *dfc,
+				 unsigned long cdev_state)
+{
+	int i;
+	struct device *dev =3D dfc->devfreq->dev.parent;
+
+	for (i =3D 0; i < dfc->freq_table_size; i++) {
+		struct dev_pm_opp *opp;
+		int ret =3D 0;
+		unsigned int freq =3D dfc->freq_table[i];
+		bool want_enable =3D i >=3D cdev_state ? true : false;
+
+		rcu_read_lock();
+		opp =3D dev_pm_opp_find_freq_exact(dev, freq, !want_enable);
+		rcu_read_unlock();
+
+		if (PTR_ERR(opp) =3D=3D -ERANGE)
+			continue;
+		else if (IS_ERR(opp))
+			return PTR_ERR(opp);
+
+		if (want_enable)
+			ret =3D dev_pm_opp_enable(dev, freq);
+		else
+			ret =3D dev_pm_opp_disable(dev, freq);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int devfreq_cooling_get_max_state(struct thermal_cooling_device=
 *cdev,
+					 unsigned long *state)
+{
+	struct devfreq_cooling_device *dfc =3D cdev->devdata;
+
+	*state =3D dfc->freq_table_size - 1;
+
+	return 0;
+}
+
+static int devfreq_cooling_get_cur_state(struct thermal_cooling_device=
 *cdev,
+					 unsigned long *state)
+{
+	struct devfreq_cooling_device *dfc =3D cdev->devdata;
+
+	*state =3D dfc->cooling_state;
+
+	return 0;
+}
+
+static int devfreq_cooling_set_cur_state(struct thermal_cooling_device=
 *cdev,
+					 unsigned long state)
+{
+	struct devfreq_cooling_device *dfc =3D cdev->devdata;
+	struct devfreq *df =3D dfc->devfreq;
+	struct device *dev =3D df->dev.parent;
+	int ret;
+
+	if (state =3D=3D dfc->cooling_state)
+		return 0;
+
+	dev_dbg(dev, "Setting cooling state %lu\n", state);
+
+	if (state >=3D dfc->freq_table_size)
+		return -EINVAL;
+
+	ret =3D partition_enable_opps(dfc, state);
+	if (ret)
+		return ret;
+
+	dfc->cooling_state =3D state;
+
+	return 0;
+}
+
+/**
+ * freq_get_state() - get the cooling state corresponding to a frequen=
cy
+ * @dfc:	Pointer to devfreq cooling device
+ * @freq:	frequency in Hz
+ *
+ * Return: the cooling state associated with the @freq, or
+ * THERMAL_CSTATE_INVALID if it wasn't found.
+ */
+static unsigned long
+freq_get_state(struct devfreq_cooling_device *dfc, unsigned long freq)
+{
+	int i;
+
+	for (i =3D 0; i < dfc->freq_table_size; i++) {
+		if (dfc->freq_table[i] =3D=3D freq)
+			return i;
+	}
+
+	return THERMAL_CSTATE_INVALID;
+}
+
+/**
+ * get_static_power() - calculate the static power
+ * @dfc:	Pointer to devfreq cooling device
+ * @freq:	Frequency in Hz
+ *
+ * Calculate the static power in milliwatts using the supplied
+ * get_static_power().  The current voltage is calculated using the
+ * OPP library.  If no get_static_power() was supplied, assume the
+ * static power is negligible.
+ */
+static unsigned long
+get_static_power(struct devfreq_cooling_device *dfc, unsigned long fre=
q)
+{
+	struct devfreq *df =3D dfc->devfreq;
+	struct device *dev =3D df->dev.parent;
+	unsigned long voltage;
+	struct dev_pm_opp *opp;
+
+	if (!dfc->power_ops->get_static_power)
+		return 0;
+
+	rcu_read_lock();
+
+	opp =3D dev_pm_opp_find_freq_exact(dev, freq, true);
+	if (IS_ERR(opp) && (PTR_ERR(opp) =3D=3D -ERANGE))
+		opp =3D dev_pm_opp_find_freq_exact(dev, freq, false);
+
+	voltage =3D dev_pm_opp_get_voltage(opp) / 1000; /* mV */
+
+	rcu_read_unlock();
+
+	if (voltage =3D=3D 0) {
+		dev_warn_ratelimited(dev,
+				     "Failed to get voltage for frequency %lu: %ld\n",
+				     freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
+		return 0;
+	}
+
+	return dfc->power_ops->get_static_power(voltage);
+}
+
+/**
+ * get_dynamic_power - calculate the dynamic power
+ * @dfc:	Pointer to devfreq cooling device
+ * @freq:	Frequency in Hz
+ * @voltage:	Voltage in millivolts
+ *
+ * Calculate the dynamic power in milliwatts consumed by the device at
+ * frequency @freq and voltage @voltage.  If the get_dynamic_power()
+ * was supplied as part of the devfreq_cooling_power struct, then that
+ * function is used.  Otherwise, a simple power model (Pdyn =3D Coeff =
*
+ * Voltage^2 * Frequency) is used.
+ */
+static unsigned long
+get_dynamic_power(struct devfreq_cooling_device *dfc, unsigned long fr=
eq,
+		  unsigned long voltage)
+{
+	unsigned long power;
+	u32 freq_mhz;
+	struct devfreq_cooling_power *dfc_power =3D dfc->power_ops;
+
+	if (dfc_power->get_dynamic_power)
+		return dfc_power->get_dynamic_power(freq, voltage);
+
+	freq_mhz =3D freq / 1000000;
+	power =3D (u64)dfc_power->dyn_power_coeff * freq_mhz * voltage * volt=
age;
+	do_div(power, 1000000000);
+
+	return power;
+}
+
+static int devfreq_cooling_get_requested_power(struct thermal_cooling_=
device *cdev,
+					       struct thermal_zone_device *tz,
+					       u32 *power)
+{
+	struct devfreq_cooling_device *dfc =3D cdev->devdata;
+	struct devfreq *df =3D dfc->devfreq;
+	struct devfreq_dev_status *status =3D &df->last_status;
+	unsigned long state;
+	unsigned long freq =3D status->current_frequency;
+	u32 dyn_power, static_power;
+
+	/* Get dynamic power for state */
+	state =3D freq_get_state(dfc, freq);
+	if (state =3D=3D THERMAL_CSTATE_INVALID)
+		return -EAGAIN;
+
+	dyn_power =3D dfc->power_table[state];
+
+	/* Scale dynamic power for utilization */
+	dyn_power =3D (dyn_power * status->busy_time) / status->total_time;
+
+	/* Get static power */
+	static_power =3D get_static_power(dfc, freq);
+
+	*power =3D dyn_power + static_power;
+
+	return 0;
+}
+
+static int devfreq_cooling_state2power(struct thermal_cooling_device *=
cdev,
+				       struct thermal_zone_device *tz,
+				       unsigned long state,
+				       u32 *power)
+{
+	struct devfreq_cooling_device *dfc =3D cdev->devdata;
+	unsigned long freq;
+	u32 static_power;
+
+	if (state < 0 || state >=3D dfc->freq_table_size)
+		return -EINVAL;
+
+	freq =3D dfc->freq_table[state];
+	static_power =3D get_static_power(dfc, freq);
+
+	*power =3D dfc->power_table[state] + static_power;
+	return 0;
+}
+
+static int devfreq_cooling_power2state(struct thermal_cooling_device *=
cdev,
+				       struct thermal_zone_device *tz,
+				       u32 power, unsigned long *state)
+{
+	struct devfreq_cooling_device *dfc =3D cdev->devdata;
+	struct devfreq *df =3D dfc->devfreq;
+	struct devfreq_dev_status *status =3D &df->last_status;
+	unsigned long freq =3D status->current_frequency;
+	unsigned long busy_time;
+	s32 dyn_power;
+	u32 static_power;
+	int i;
+
+	static_power =3D get_static_power(dfc, freq);
+
+	dyn_power =3D power - static_power;
+	dyn_power =3D dyn_power > 0 ? dyn_power : 0;
+
+	/* Scale dynamic power for utilization */
+	busy_time =3D status->busy_time ?: 1;
+	dyn_power =3D (dyn_power * status->total_time) / busy_time;
+
+	/*
+	 * Find the first cooling state that is within the power
+	 * budget for dynamic power.
+	 */
+	for (i =3D 0; i < dfc->freq_table_size - 1; i++)
+		if (dyn_power >=3D dfc->power_table[i])
+			break;
+
+	*state =3D i;
+	return 0;
+}
+
+static struct thermal_cooling_device_ops devfreq_cooling_ops =3D {
+	.get_max_state =3D devfreq_cooling_get_max_state,
+	.get_cur_state =3D devfreq_cooling_get_cur_state,
+	.set_cur_state =3D devfreq_cooling_set_cur_state,
+};
+
+/**
+ * devfreq_cooling_gen_tables() - Generate power and freq tables.
+ * @dfc: Pointer to devfreq cooling device.
+ *
+ * Generate power and frequency tables: the power table hold the
+ * device's maximum power usage at each cooling state (OPP).  The
+ * static and dynamic power using the appropriate voltage and
+ * frequency for the state, is acquired from the struct
+ * devfreq_cooling_power, and summed to make the maximum power draw.
+ *
+ * The frequency table holds the frequencies in descending order.
+ * That way its indexed by cooling device state.
+ *
+ * The tables are malloced, and pointers put in dfc.  They must be
+ * freed when unregistering the devfreq cooling device.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int devfreq_cooling_gen_tables(struct devfreq_cooling_device *d=
fc)
+{
+	struct devfreq *df =3D dfc->devfreq;
+	struct device *dev =3D df->dev.parent;
+	int ret, num_opps;
+	unsigned long freq;
+	u32 *power_table =3D NULL;
+	u32 *freq_table;
+	int i;
+
+	num_opps =3D dev_pm_opp_get_opp_count(dev);
+
+	if (dfc->power_ops) {
+		power_table =3D kcalloc(num_opps, sizeof(*power_table),
+				      GFP_KERNEL);
+		if (!power_table)
+			ret =3D -ENOMEM;
+	}
+
+	freq_table =3D kcalloc(num_opps, sizeof(*freq_table),
+			     GFP_KERNEL);
+	if (!freq_table) {
+		ret =3D -ENOMEM;
+		goto free_power_table;
+	}
+
+	for (i =3D 0, freq =3D ULONG_MAX; i < num_opps; i++, freq--) {
+		unsigned long power_dyn, voltage;
+		struct dev_pm_opp *opp;
+
+		rcu_read_lock();
+
+		opp =3D dev_pm_opp_find_freq_floor(dev, &freq);
+		if (IS_ERR(opp)) {
+			rcu_read_unlock();
+			ret =3D PTR_ERR(opp);
+			goto free_tables;
+		}
+
+		voltage =3D dev_pm_opp_get_voltage(opp) / 1000; /* mV */
+
+		rcu_read_unlock();
+
+		if (dfc->power_ops) {
+			power_dyn =3D get_dynamic_power(dfc, freq, voltage);
+
+			dev_dbg(dev, "Dynamic power table: %lu MHz @ %lu mV: %lu =3D %lu mW=
\n",
+				freq / 1000000, voltage, power_dyn, power_dyn);
+
+			power_table[i] =3D power_dyn;
+		}
+
+		freq_table[i] =3D freq;
+	}
+
+	if (dfc->power_ops)
+		dfc->power_table =3D power_table;
+
+	dfc->freq_table =3D freq_table;
+	dfc->freq_table_size =3D num_opps;
+
+	return 0;
+
+free_tables:
+	kfree(freq_table);
+free_power_table:
+	kfree(power_table);
+
+	return ret;
+}
+
+/**
+ * of_devfreq_cooling_register_power() - Register devfreq cooling devi=
ce,
+ *                                      with OF and power information.
+ * @np:	Pointer to OF device_node.
+ * @df:	Pointer to devfreq device.
+ * @dfc_power:	Pointer to devfreq_cooling_power.
+ *
+ * Register a devfreq cooling device.  The available OPPs must be
+ * registered on the device.
+ *
+ * If @dfc_power is provided, the cooling device is registered with th=
e
+ * power extensions.  For the power extensions to work correctly,
+ * devfreq should use the simple_ondemand governor, other governors
+ * are not currently supported.
+ */
+struct devfreq_cooling_device *
+of_devfreq_cooling_register_power(struct device_node *np, struct devfr=
eq *df,
+				  struct devfreq_cooling_power *dfc_power)
+{
+	struct thermal_cooling_device *cdev;
+	struct devfreq_cooling_device *dfc;
+	char dev_name[THERMAL_NAME_LENGTH];
+	int err;
+
+	dfc =3D kzalloc(sizeof(*dfc), GFP_KERNEL);
+	if (!dfc)
+		return ERR_PTR(-ENOMEM);
+
+	dfc->devfreq =3D df;
+
+	if (dfc_power) {
+		dfc->power_ops =3D dfc_power;
+
+		devfreq_cooling_ops.get_requested_power =3D
+			devfreq_cooling_get_requested_power;
+		devfreq_cooling_ops.state2power =3D devfreq_cooling_state2power;
+		devfreq_cooling_ops.power2state =3D devfreq_cooling_power2state;
+	}
+
+	err =3D devfreq_cooling_gen_tables(dfc);
+	if (err)
+		goto free_dfc;
+
+	err =3D get_idr(&devfreq_idr, &dfc->id);
+	if (err)
+		goto free_tables;
+
+	snprintf(dev_name, sizeof(dev_name), "thermal-devfreq-%d", dfc->id);
+
+	cdev =3D thermal_of_cooling_device_register(np, dev_name, dfc,
+						  &devfreq_cooling_ops);
+	if (IS_ERR(cdev)) {
+		err =3D PTR_ERR(cdev);
+		dev_err(df->dev.parent,
+			"Failed to register devfreq cooling device (%d)\n",
+			err);
+		goto release_idr;
+	}
+
+	dfc->cdev =3D cdev;
+
+	return dfc;
+
+release_idr:
+	release_idr(&devfreq_idr, dfc->id);
+free_tables:
+	kfree(dfc->power_table);
+	kfree(dfc->freq_table);
+free_dfc:
+	kfree(dfc);
+
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(of_devfreq_cooling_register_power);
+
+/**
+ * of_devfreq_cooling_register() - Register devfreq cooling device,
+ *                                with OF information.
+ * @np: Pointer to OF device_node.
+ * @df: Pointer to devfreq device.
+ */
+struct devfreq_cooling_device *
+of_devfreq_cooling_register(struct device_node *np, struct devfreq *df=
)
+{
+	return of_devfreq_cooling_register_power(np, df, NULL);
+}
+EXPORT_SYMBOL_GPL(of_devfreq_cooling_register);
+
+/**
+ * devfreq_cooling_register() - Register devfreq cooling device.
+ * @df: Pointer to devfreq device.
+ */
+struct devfreq_cooling_device *devfreq_cooling_register(struct devfreq=
 *df)
+{
+	return of_devfreq_cooling_register(NULL, df);
+}
+EXPORT_SYMBOL_GPL(devfreq_cooling_register);
+
+/**
+ * devfreq_cooling_unregister() - Unregister devfreq cooling device.
+ * @dfc: Pointer to devfreq cooling device to unregister.
+ */
+void devfreq_cooling_unregister(struct devfreq_cooling_device *dfc)
+{
+	if (!dfc)
+		return;
+
+	thermal_cooling_device_unregister(dfc->cdev);
+	release_idr(&devfreq_idr, dfc->id);
+	kfree(dfc->power_table);
+	kfree(dfc->freq_table);
+
+	kfree(dfc);
+}
+EXPORT_SYMBOL_GPL(devfreq_cooling_unregister);
diff --git a/include/linux/devfreq_cooling.h b/include/linux/devfreq_co=
oling.h
new file mode 100644
index 000000000000..ee5f0ec9290b
--- /dev/null
+++ b/include/linux/devfreq_cooling.h
@@ -0,0 +1,81 @@
+/*
+ * devfreq_cooling: Thermal cooling device implementation for devices =
using
+ *                  devfreq
+ *
+ * Copyright (C) 2014-2015 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __DEVFREQ_COOLING_H__
+#define __DEVFREQ_COOLING_H__
+
+#include <linux/devfreq.h>
+#include <linux/thermal.h>
+
+#ifdef CONFIG_DEVFREQ_THERMAL
+
+/**
+ * struct devfreq_cooling_power - Devfreq cooling power ops
+ * @get_static_power:	Take voltage, in mV, and return the static power
+ *			in mW.  If NULL, the static power is assumed
+ *			to be 0.
+ * @get_dynamic_power:	Take voltage, in mV, and frequency, in HZ, and
+ *			return the dynamic power draw in mW.  If NULL,
+ *			a simple power model is used.
+ * @dyn_power_coeff:	Coefficient for the simple dynamic power model in
+ *			mW/(MHz mV mV).
+ *			If get_dynamic_power() is NULL, then the
+ *			dynamic power is calculated as
+ *			@dyn_power_coeff * frequency * voltage^2
+ */
+struct devfreq_cooling_power {
+	unsigned long (*get_static_power)(unsigned long voltage);
+	unsigned long (*get_dynamic_power)(unsigned long freq,
+					   unsigned long voltage);
+	unsigned long dyn_power_coeff;
+};
+
+struct devfreq_cooling_device *
+of_devfreq_cooling_register_power(struct device_node *np, struct devfr=
eq *df,
+				  struct devfreq_cooling_power *dfc_power);
+struct devfreq_cooling_device *
+of_devfreq_cooling_register(struct device_node *np, struct devfreq *df=
);
+struct devfreq_cooling_device *devfreq_cooling_register(struct devfreq=
 *df);
+void devfreq_cooling_unregister(struct devfreq_cooling_device *dfc);
+
+#else /* !CONFIG_DEVFREQ_THERMAL */
+
+struct devfreq_cooling_device *
+of_devfreq_cooling_register_power(struct device_node *np, struct devfr=
eq *df,
+				  struct devfreq_cooling_power *dfc_power)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline struct devfreq_cooling_device *
+of_devfreq_cooling_register(struct device_node *np, struct devfreq *df=
)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline struct devfreq_cooling_device *
+devfreq_cooling_register(struct devfreq *df)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline void
+devfreq_cooling_unregister(struct devfreq_cooling_device *dfc)
+{
+}
+
+#endif /* CONFIG_DEVFREQ_THERMAL */
+#endif /* __DEVFREQ_COOLING_H__ */
--=20
1.9.1
