From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 2/3] thermal: devfreq_cooling: add new interface for direct power read
Date: Tue, 31 Jan 2017 16:11:46 +0000
Message-ID: <20170131161147.17002-3-lukasz.luba@arm.com>
References: <20170131161147.17002-1-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbdAaQNT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Jan 2017 11:13:19 -0500
In-Reply-To: <20170131161147.17002-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, orjan.eide@arm.com, lukasz.luba@arm.com, chris.diamand@arm.com, javi.merino@kernel.org

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
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 78 ++++++++++++++++++++++++++++++---------
 include/linux/devfreq_cooling.h   | 17 +++++++++
 2 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 7d55652..cba34bd 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -27,6 +27,8 @@
 
 #include <trace/events/thermal.h>
 
+#define SCALE_ERROR_MITIGATION 100
+
 static DEFINE_MUTEX(devfreq_lock);
 static DEFINE_IDR(devfreq_idr);
 
@@ -45,6 +47,12 @@ static DEFINE_IDR(devfreq_idr);
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
@@ -55,6 +63,7 @@ struct devfreq_cooling_device {
 	u32 *freq_table;
 	size_t freq_table_size;
 	struct devfreq_cooling_power *power_ops;
+	u32 res_util;
 };
 
 /**
@@ -292,27 +301,55 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 	struct devfreq_dev_status *status = &df->last_status;
 	unsigned long state;
 	unsigned long freq = status->current_frequency;
-	u32 dyn_power, static_power;
+	unsigned long voltage;
+	u32 dyn_power = 0;
+	u32 static_power = 0;
+	int res;
 
 	/* Get dynamic power for state */
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
@@ -345,23 +382,30 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
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
diff --git a/include/linux/devfreq_cooling.h b/include/linux/devfreq_cooling.h
index c35d0c0..2e07744 100644
--- a/include/linux/devfreq_cooling.h
+++ b/include/linux/devfreq_cooling.h
@@ -34,6 +34,21 @@
  *			If get_dynamic_power() is NULL, then the
  *			dynamic power is calculated as
  *			@dyn_power_coeff * frequency * voltage^2
+ * @get_real_power:	When this it is set, the framework uses it to ask the
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
  */
 struct devfreq_cooling_power {
 	unsigned long (*get_static_power)(struct devfreq *devfreq,
@@ -41,6 +56,8 @@ struct devfreq_cooling_power {
 	unsigned long (*get_dynamic_power)(struct devfreq *devfreq,
 					   unsigned long freq,
 					   unsigned long voltage);
+	int (*get_real_power)(struct devfreq *df, u32 *power,
+			      unsigned long freq, unsigned long voltage);
 	unsigned long dyn_power_coeff;
 };
 
-- 
2.9.2

