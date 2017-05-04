From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v3 2/3] thermal: devfreq_cooling: add new interface for direct power read
Date: Thu,  4 May 2017 12:34:32 +0100
Message-ID: <1493897673-1826-3-git-send-email-lukasz.luba@arm.com>
References: <1493897673-1826-1-git-send-email-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdEDLfE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 May 2017 07:35:04 -0400
In-Reply-To: <1493897673-1826-1-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, javi.merino@kernel.org, chris.diamand@arm.com, lukasz.luba@arm.com

This patch introduces a new interface for device drivers connected to
devfreq_cooling in the thermal framework: get_real_power().

Some devices have more sophisticated methods (like power counters)
to approximate the actual power that they use.
In the previous implementation we had a pre-calculated power
table which was then scaled by 'utilization'
('busy_time' and 'total_time' taken from devfreq 'last_status').

With this new interface the driver can provide more precise data
regarding actual power to the thermal governor every time the power
budget is calculated. We then use this value and calculate the real
resource utilization scaling factor.

Reviewed-by: Chris Diamand <chris.diamand@arm.com>
Acked-by: Javi Merino <javi.merino@kernel.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 105 +++++++++++++++++++++++++++++---------
 include/linux/devfreq_cooling.h   |  19 +++++++
 2 files changed, 101 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index af9d328..26c3157 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -28,6 +28,8 @@
 
 #include <trace/events/thermal.h>
 
+#define SCALE_ERROR_MITIGATION 100
+
 static DEFINE_IDA(devfreq_ida);
 
 /**
@@ -45,6 +47,12 @@
  * @freq_table_size:	Size of the @freq_table and @power_table
  * @power_ops:	Pointer to devfreq_cooling_power, used to generate the
  *		@power_table.
+ * @res_util:	Resource utilization scaling factor for the power.
+ *		It is multiplied by 100 to minimize the error. It is used
+ *		for estimation of the power budget instead of using
+ *		'utilization' (which is	'busy_time / 'total_time').
+ *		The 'res_util' range is from 100 to (power_table[state] * 100)
+ *		for the corresponding 'state'.
  */
 struct devfreq_cooling_device {
 	int id;
@@ -55,6 +63,8 @@ struct devfreq_cooling_device {
 	u32 *freq_table;
 	size_t freq_table_size;
 	struct devfreq_cooling_power *power_ops;
+	u32 res_util;
+	int capped_state;
 };
 
 /**
@@ -250,6 +260,16 @@ static unsigned long get_voltage(struct devfreq *df, unsigned long freq)
 	return power;
 }
 
+
+static inline unsigned long get_total_power(struct devfreq_cooling_device *dfc,
+					    unsigned long freq,
+					    unsigned long voltage)
+{
+	return get_static_power(dfc, freq) + get_dynamic_power(dfc, freq,
+							       voltage);
+}
+
+
 static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cdev,
 					       struct thermal_zone_device *tz,
 					       u32 *power)
@@ -259,27 +279,55 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 	struct devfreq_dev_status *status = &df->last_status;
 	unsigned long state;
 	unsigned long freq = status->current_frequency;
-	u32 dyn_power, static_power;
+	unsigned long voltage;
+	u32 dyn_power = 0;
+	u32 static_power = 0;
+	int res;
 
-	/* Get dynamic power for state */
 	state = freq_get_state(dfc, freq);
-	if (state == THERMAL_CSTATE_INVALID)
-		return -EAGAIN;
+	if (state == THERMAL_CSTATE_INVALID) {
+		res = -EAGAIN;
+		goto fail;
+	}
 
-	dyn_power = dfc->power_table[state];
+	if (dfc->power_ops->get_real_power) {
+		voltage = get_voltage(df, freq);
+		if (voltage == 0) {
+			res = -EINVAL;
+			goto fail;
+		}
 
-	/* Scale dynamic power for utilization */
-	dyn_power = (dyn_power * status->busy_time) / status->total_time;
+		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
+		if (!res) {
+			state = dfc->capped_state;
+			dfc->res_util = dfc->power_table[state];
+			dfc->res_util *= SCALE_ERROR_MITIGATION;
 
-	/* Get static power */
-	static_power = get_static_power(dfc, freq);
+			if (*power > 1)
+				dfc->res_util /= *power;
+		} else {
+			goto fail;
+		}
+	} else {
+		dyn_power = dfc->power_table[state];
+
+		/* Scale dynamic power for utilization */
+		dyn_power *= status->busy_time;
+		dyn_power /= status->total_time;
+		/* Get static power */
+		static_power = get_static_power(dfc, freq);
+
+		*power = dyn_power + static_power;
+	}
 
 	trace_thermal_power_devfreq_get_power(cdev, status, freq, dyn_power,
 					      static_power);
 
-	*power = dyn_power + static_power;
-
 	return 0;
+fail:
+	/* It is safe to set max in this case */
+	dfc->res_util = SCALE_ERROR_MITIGATION;
+	return res;
 }
 
 static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
@@ -312,26 +360,34 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	unsigned long busy_time;
 	s32 dyn_power;
 	u32 static_power;
+	s32 est_power;
 	int i;
 
-	static_power = get_static_power(dfc, freq);
+	if (dfc->power_ops->get_real_power) {
+		/* Scale for resource utilization */
+		est_power = power * dfc->res_util;
+		est_power /= SCALE_ERROR_MITIGATION;
+	} else {
+		static_power = get_static_power(dfc, freq);
 
-	dyn_power = power - static_power;
-	dyn_power = dyn_power > 0 ? dyn_power : 0;
+		dyn_power = power - static_power;
+		dyn_power = dyn_power > 0 ? dyn_power : 0;
 
-	/* Scale dynamic power for utilization */
-	busy_time = status->busy_time ?: 1;
-	dyn_power = (dyn_power * status->total_time) / busy_time;
+		/* Scale dynamic power for utilization */
+		busy_time = status->busy_time ?: 1;
+		est_power = (dyn_power * status->total_time) / busy_time;
+	}
 
 	/*
 	 * Find the first cooling state that is within the power
 	 * budget for dynamic power.
 	 */
 	for (i = 0; i < dfc->freq_table_size - 1; i++)
-		if (dyn_power >= dfc->power_table[i])
+		if (est_power >= dfc->power_table[i])
 			break;
 
 	*state = i;
+	dfc->capped_state = i;
 	trace_thermal_power_devfreq_limit(cdev, freq, *state, power);
 	return 0;
 }
@@ -387,7 +443,7 @@ static int devfreq_cooling_gen_tables(struct devfreq_cooling_device *dfc)
 	}
 
 	for (i = 0, freq = ULONG_MAX; i < num_opps; i++, freq--) {
-		unsigned long power_dyn, voltage;
+		unsigned long power, voltage;
 		struct dev_pm_opp *opp;
 
 		opp = dev_pm_opp_find_freq_floor(dev, &freq);
@@ -400,12 +456,15 @@ static int devfreq_cooling_gen_tables(struct devfreq_cooling_device *dfc)
 		dev_pm_opp_put(opp);
 
 		if (dfc->power_ops) {
-			power_dyn = get_dynamic_power(dfc, freq, voltage);
+			if (dfc->power_ops->get_real_power)
+				power = get_total_power(dfc, freq, voltage);
+			else
+				power = get_dynamic_power(dfc, freq, voltage);
 
-			dev_dbg(dev, "Dynamic power table: %lu MHz @ %lu mV: %lu = %lu mW\n",
-				freq / 1000000, voltage, power_dyn, power_dyn);
+			dev_dbg(dev, "Power table: %lu MHz @ %lu mV: %lu = %lu mW\n",
+				freq / 1000000, voltage, power, power);
 
-			power_table[i] = power_dyn;
+			power_table[i] = power;
 		}
 
 		freq_table[i] = freq;
diff --git a/include/linux/devfreq_cooling.h b/include/linux/devfreq_cooling.h
index c35d0c0..4635f95 100644
--- a/include/linux/devfreq_cooling.h
+++ b/include/linux/devfreq_cooling.h
@@ -34,6 +34,23 @@
  *			If get_dynamic_power() is NULL, then the
  *			dynamic power is calculated as
  *			@dyn_power_coeff * frequency * voltage^2
+ * @get_real_power:	When this is set, the framework uses it to ask the
+ *			device driver for the actual power.
+ *			Some devices have more sophisticated methods
+ *			(like power counters) to approximate the actual power
+ *			that they use.
+ *			This function provides more accurate data to the
+ *			thermal governor. When the driver does not provide
+ *			such function, framework just uses pre-calculated
+ *			table and scale the power by 'utilization'
+ *			(based on 'busy_time' and 'total_time' taken from
+ *			devfreq 'last_status').
+ *			The value returned by this function must be lower
+ *			or equal than the maximum power value
+ *			for the current	state
+ *			(which can be found in power_table[state]).
+ *			When this interface is used, the power_table holds
+ *			max total (static + dynamic) power value for each OPP.
  */
 struct devfreq_cooling_power {
 	unsigned long (*get_static_power)(struct devfreq *devfreq,
@@ -41,6 +58,8 @@ struct devfreq_cooling_power {
 	unsigned long (*get_dynamic_power)(struct devfreq *devfreq,
 					   unsigned long freq,
 					   unsigned long voltage);
+	int (*get_real_power)(struct devfreq *df, u32 *power,
+			      unsigned long freq, unsigned long voltage);
 	unsigned long dyn_power_coeff;
 };
 
-- 
1.9.1
