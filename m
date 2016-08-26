From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [RFC PATCH  3/4] devfreq_cooling: let the driver supply the dynamic power every time we need it
Date: Fri, 26 Aug 2016 14:18:04 +0100
Message-ID: <20160826131805.14820-4-lukasz.luba@arm.com>
References: <20160826131805.14820-1-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751686AbcHZNTY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Aug 2016 09:19:24 -0400
In-Reply-To: <20160826131805.14820-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, lukasz.luba@arm.com, javi.merino@arm.com, orjan.eide@arm.com

The devfreq cooling implementation uses precalculated power table for caching
power values for each device state. The power table is used everytime the
thermal subsystem asks for the dynamic power, power2state, etc. There is no
mechanism to provide the data in real-time from drivers' function registered as
'get_dynamic_power'. The power value can change in runtime, so the driver should
choose one of the options (during the registration) what the thermal framework
should do:
o Use pre-calculated power table
o Use direct call to driver's 'get_dynamic_power' and 'power2state'
registered functions

With this patch, the driver can choose if the precalculated power table should
be used or a direct call to registered functions 'get_dynamic_power' and
'power2state', to get more accurate values.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 186 ++++++++++++++++++++++++++++----------
 include/linux/devfreq_cooling.h   |  25 +++--
 2 files changed, 155 insertions(+), 56 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index c549d83..39f83ce 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -45,6 +45,12 @@ static DEFINE_IDR(devfreq_idr);
  * @freq_table_size:	Size of the @freq_table and @power_table
  * @power_ops:	Pointer to devfreq_cooling_power, used to generate the
  *		@power_table.
+ * @flags:	Flags which are used by the devfreq cooling framework
+ *		to use different features like:
+ *		- GET_DIRECT_DYNAMIC_POWER: direct call to drivers'
+ *		code to get dynamic power;
+ *		The flags are provided by the driver's code during
+ *		registration to the devfreq cooling subsystem.
  */
 struct devfreq_cooling_device {
 	int id;
@@ -55,6 +61,7 @@ struct devfreq_cooling_device {
 	u32 *freq_table;
 	size_t freq_table_size;
 	struct devfreq_cooling_power *power_ops;
+	unsigned long flags;
 };
 
 /**
@@ -200,27 +207,15 @@ freq_get_state(struct devfreq_cooling_device *dfc, unsigned long freq)
 	return THERMAL_CSTATE_INVALID;
 }
 
-/**
- * get_static_power() - calculate the static power
- * @dfc:	Pointer to devfreq cooling device
- * @freq:	Frequency in Hz
- *
- * Calculate the static power in milliwatts using the supplied
- * get_static_power().  The current voltage is calculated using the
- * OPP library.  If no get_static_power() was supplied, assume the
- * static power is negligible.
- */
 static unsigned long
-get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
+devfreq_cooling_freq2voltage(struct devfreq_cooling_device *dfc,
+			     unsigned long freq)
 {
 	struct devfreq *df = dfc->devfreq;
 	struct device *dev = df->dev.parent;
 	unsigned long voltage;
 	struct dev_pm_opp *opp;
 
-	if (!dfc->power_ops->get_static_power)
-		return 0;
-
 	rcu_read_lock();
 
 	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
@@ -235,32 +230,60 @@ get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 		dev_warn_ratelimited(dev,
 				     "Failed to get voltage for frequency %lu: %ld\n",
 				     freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
-		return 0;
 	}
 
+	return voltage;
+}
+
+/**
+ * get_static_power() - calculate the static power
+ * @dfc:	Pointer to devfreq cooling device
+ * @freq:	Frequency in Hz
+ *
+ * Calculate the static power in milliwatts using the supplied
+ * get_static_power(). The current voltage is calculated using the
+ * OPP library. If no get_static_power() was supplied, assume the
+ * static power is negligible.
+ */
+static unsigned long
+get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
+{
+	struct devfreq *df = dfc->devfreq;
+	unsigned long voltage;
+
+	if (!dfc->power_ops->get_static_power)
+		return 0;
+
+	voltage = devfreq_cooling_freq2voltage(dfc, freq);
+	if (!voltage)
+		return 0;
+
 	return dfc->power_ops->get_static_power(df, voltage);
 }
 
 /**
- * get_dynamic_power - calculate the dynamic power
+ * get_simple_dynamic_power - calculate the simple dynamic power
  * @dfc:	Pointer to devfreq cooling device
  * @freq:	Frequency in Hz
- * @voltage:	Voltage in millivolts
  *
  * Calculate the dynamic power in milliwatts consumed by the device at
- * frequency @freq and voltage @voltage.  If the get_dynamic_power()
- * was supplied as part of the devfreq_cooling_power struct, then that
- * function is used.  Otherwise, a simple power model (Pdyn = Coeff *
- * Voltage^2 * Frequency) is used.
+ * frequency @freq and voltage. A simple power model
+ * (pdyn = coeff * voltage^2 * frequency) is used. This function is used only
+ * during the registeration of a new driver, precisely - when the power table
+ * is calculated.
  */
 static unsigned long
-get_dynamic_power(struct devfreq_cooling_device *dfc, unsigned long freq,
-		  unsigned long voltage)
+get_simple_dynamic_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 {
 	u64 power;
 	u32 freq_mhz;
+	unsigned long voltage;
 	struct devfreq_cooling_power *dfc_power = dfc->power_ops;
 
+	voltage = devfreq_cooling_freq2voltage(dfc, freq);
+	if (!voltage)
+		return 0;
+
 	if (dfc_power->get_dynamic_power)
 		return dfc_power->get_dynamic_power(dfc->devfreq, freq,
 						    voltage);
@@ -272,6 +295,33 @@ get_dynamic_power(struct devfreq_cooling_device *dfc, unsigned long freq,
 	return power;
 }
 
+/**
+ * get_direct_dynamic_power - calculate the dynamic power
+ * @dfc:	pointer to devfreq cooling device
+ * @freq:	frequency in hz
+ *
+ * Calculate the dynamic power in milliwatts consumed by the device at
+ * frequency @freq and voltage. The driver's function registered
+ * to get_dynamic_power() is used to get more accurate value. The driver
+ * registered to the devfreq cooling interface has to provide the
+ * needed functions (get_dynamic_power() and power2state()),
+ * otherwise the registration fails when the GET_DIRECT_DYNAMIC_POWER flag
+ * is set.
+ */
+static unsigned long
+get_direct_dynamic_power(struct devfreq_cooling_device *dfc, unsigned long freq)
+{
+	unsigned long voltage;
+	struct devfreq_cooling_power *dfc_power = dfc->power_ops;
+
+	voltage = devfreq_cooling_freq2voltage(dfc, freq);
+	if (!voltage)
+		return 0;
+
+	return dfc_power->get_dynamic_power(dfc->devfreq, freq,
+						    voltage);
+}
+
 static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cdev,
 					       struct thermal_zone_device *tz,
 					       u32 *power)
@@ -288,7 +338,10 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 	if (state == THERMAL_CSTATE_INVALID)
 		return -EAGAIN;
 
-	dyn_power = dfc->power_table[state];
+	if (dfc->flags & GET_DIRECT_DYNAMIC_POWER)
+		dyn_power = get_direct_dynamic_power(dfc, freq);
+	else
+		dyn_power = dfc->power_table[state];
 
 	/* Scale dynamic power for utilization */
 	dyn_power = (dyn_power * status->busy_time) / status->total_time;
@@ -312,6 +365,7 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	unsigned long freq;
 	u32 static_power;
+	unsigned long dyn_power;
 
 	if (state < 0 || state >= dfc->freq_table_size)
 		return -EINVAL;
@@ -319,7 +373,12 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
 	freq = dfc->freq_table[state];
 	static_power = get_static_power(dfc, freq);
 
-	*power = dfc->power_table[state] + static_power;
+	if (dfc->flags & GET_DIRECT_DYNAMIC_POWER)
+		dyn_power = get_direct_dynamic_power(dfc, freq);
+	else
+		dyn_power = dfc->power_table[state];
+
+	*power = dyn_power + static_power;
 	return 0;
 }
 
@@ -336,24 +395,28 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	u32 static_power;
 	int i;
 
-	static_power = get_static_power(dfc, freq);
-
-	dyn_power = power - static_power;
-	dyn_power = dyn_power > 0 ? dyn_power : 0;
+	if (dfc->flags & GET_DIRECT_DYNAMIC_POWER)
+		*state = dfc->power_ops->power2state(df, power);
+	else {
+		static_power = get_static_power(dfc, freq);
+
+		dyn_power = power - static_power;
+		dyn_power = dyn_power > 0 ? dyn_power : 0;
+
+		/* Scale dynamic power for utilization */
+		busy_time = status->busy_time ?: 1;
+		dyn_power = (dyn_power * status->total_time) / busy_time;
+
+		/*
+		 * Find the first cooling state that is within the power
+		 * budget for dynamic power.
+		 */
+		for (i = 0; i < dfc->freq_table_size - 1; i++)
+			if (dyn_power >= dfc->power_table[i])
+				break;
+		*state = i;
+	}
 
-	/* Scale dynamic power for utilization */
-	busy_time = status->busy_time ?: 1;
-	dyn_power = (dyn_power * status->total_time) / busy_time;
-
-	/*
-	 * Find the first cooling state that is within the power
-	 * budget for dynamic power.
-	 */
-	for (i = 0; i < dfc->freq_table_size - 1; i++)
-		if (dyn_power >= dfc->power_table[i])
-			break;
-
-	*state = i;
 	trace_thermal_power_devfreq_limit(cdev, freq, *state, power);
 	return 0;
 }
@@ -391,10 +454,12 @@ static int devfreq_cooling_gen_tables(struct devfreq_cooling_device *dfc)
 	u32 *power_table = NULL;
 	u32 *freq_table;
 	int i;
+	bool generate_power_table = !(dfc->flags & GET_DIRECT_DYNAMIC_POWER) &&
+		dfc->power_ops;
 
 	num_opps = dev_pm_opp_get_opp_count(dev);
 
-	if (dfc->power_ops) {
+	if (generate_power_table) {
 		power_table = kcalloc(num_opps, sizeof(*power_table),
 				      GFP_KERNEL);
 		if (!power_table)
@@ -421,12 +486,10 @@ static int devfreq_cooling_gen_tables(struct devfreq_cooling_device *dfc)
 			goto free_tables;
 		}
 
-		voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
-
 		rcu_read_unlock();
 
-		if (dfc->power_ops) {
-			power_dyn = get_dynamic_power(dfc, freq, voltage);
+		if (generate_power_table) {
+			power_dyn = get_simple_dynamic_power(dfc, freq);
 
 			dev_dbg(dev, "Dynamic power table: %lu MHz @ %lu mV: %lu = %lu mW\n",
 				freq / 1000000, voltage, power_dyn, power_dyn);
@@ -437,7 +500,7 @@ static int devfreq_cooling_gen_tables(struct devfreq_cooling_device *dfc)
 		freq_table[i] = freq;
 	}
 
-	if (dfc->power_ops)
+	if (generate_power_table)
 		dfc->power_table = power_table;
 
 	dfc->freq_table = freq_table;
@@ -459,6 +522,15 @@ free_power_table:
  * @np:	Pointer to OF device_node.
  * @df:	Pointer to devfreq device.
  * @dfc_power:	Pointer to devfreq_cooling_power.
+ * @flags:	Flags which are used by the devfreq cooling framework
+ *		to use different features. Flags:
+ *		- GET_DIRECT_DYNAMIC_POWER: direct call to drivers'
+ *		code to get dynamic power. If this flag is set, the driver
+ *		should implement and provide functions: get_dynamic_power() and
+ *		power2state(). If there are no such functions, while the flag is
+ *		set, the registration will fail.
+ *		The flags are provided by the driver's code during
+ *		registration to the devfreq cooling subsystem.
  *
  * Register a devfreq cooling device.  The available OPPs must be
  * registered on the device.
@@ -470,7 +542,8 @@ free_power_table:
  */
 struct thermal_cooling_device *
 of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
-				  struct devfreq_cooling_power *dfc_power)
+				  struct devfreq_cooling_power *dfc_power,
+				  unsigned long flags)
 {
 	struct thermal_cooling_device *cdev;
 	struct devfreq_cooling_device *dfc;
@@ -482,10 +555,23 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 		return ERR_PTR(-ENOMEM);
 
 	dfc->devfreq = df;
+	dfc->flags = flags;
+
+	if ((flags & GET_DIRECT_DYNAMIC_POWER) && !dfc_power) {
+		err = -EINVAL;
+		goto free_dfc;
+	}
 
 	if (dfc_power) {
 		dfc->power_ops = dfc_power;
 
+		if ((flags & GET_DIRECT_DYNAMIC_POWER) &&
+		    (!dfc_power->get_dynamic_power ||
+		     !dfc_power->power2state)) {
+			err = -EINVAL;
+			goto free_dfc;
+		}
+
 		devfreq_cooling_ops.get_requested_power =
 			devfreq_cooling_get_requested_power;
 		devfreq_cooling_ops.state2power = devfreq_cooling_state2power;
@@ -537,7 +623,7 @@ EXPORT_SYMBOL_GPL(of_devfreq_cooling_register_power);
 struct thermal_cooling_device *
 of_devfreq_cooling_register(struct device_node *np, struct devfreq *df)
 {
-	return of_devfreq_cooling_register_power(np, df, NULL);
+	return of_devfreq_cooling_register_power(np, df, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(of_devfreq_cooling_register);
 
diff --git a/include/linux/devfreq_cooling.h b/include/linux/devfreq_cooling.h
index c35d0c0..e271d1ec 100644
--- a/include/linux/devfreq_cooling.h
+++ b/include/linux/devfreq_cooling.h
@@ -19,16 +19,26 @@
 
 #include <linux/devfreq.h>
 #include <linux/thermal.h>
+#include <linux/bitops.h>
 
+/* Flags for the devfreq cooling interface. */
+#define GET_DIRECT_DYNAMIC_POWER BIT(0)
 
 /**
  * struct devfreq_cooling_power - Devfreq cooling power ops
  * @get_static_power:	Take voltage, in mV, and return the static power
  *			in mW.  If NULL, the static power is assumed
  *			to be 0.
- * @get_dynamic_power:	Take voltage, in mV, and frequency, in HZ, and
- *			return the dynamic power draw in mW.  If NULL,
- *			a simple power model is used.
+ * @get_dynamic_power:	Take voltage, in mV, and frequency, in HZ, and return
+ *			the dynamic power draw in mW. This function is called
+ *			every time when the GET_DIRECT_DYNAMIC_POWER flag is
+ *			set and the thermal framework calculates the current
+ *			power for this device. If the flag is not set and this
+ *			is NULL, a simple power model is used.
+ * @power2state:	It receives the maximum power that the device should
+ *			consume and it should return the needed 'state'.
+ *			This function should be registered when the flag
+ *			GET_DIRECT_DYNAMIC_POWER is set.
  * @dyn_power_coeff:	Coefficient for the simple dynamic power model in
  *			mW/(MHz mV mV).
  *			If get_dynamic_power() is NULL, then the
@@ -41,6 +51,7 @@ struct devfreq_cooling_power {
 	unsigned long (*get_dynamic_power)(struct devfreq *devfreq,
 					   unsigned long freq,
 					   unsigned long voltage);
+	unsigned long (*power2state)(struct devfreq *devfreq, u32 power);
 	unsigned long dyn_power_coeff;
 };
 
@@ -48,7 +59,8 @@ struct devfreq_cooling_power {
 
 struct thermal_cooling_device *
 of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
-				  struct devfreq_cooling_power *dfc_power);
+				  struct devfreq_cooling_power *dfc_power,
+				  unsigned long flags);
 struct thermal_cooling_device *
 of_devfreq_cooling_register(struct device_node *np, struct devfreq *df);
 struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df);
@@ -56,9 +68,10 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *dfc);
 
 #else /* !CONFIG_DEVFREQ_THERMAL */
 
-struct thermal_cooling_device *
+struct inline thermal_cooling_device *
 of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
-				  struct devfreq_cooling_power *dfc_power)
+				  struct devfreq_cooling_power *dfc_power,
+				  unsigned long flags)
 {
 	return ERR_PTR(-EINVAL);
 }
-- 
2.9.2

