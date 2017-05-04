From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v3 1/3] thermal: devfreq_cooling: refactor code and add get_voltage function
Date: Thu,  4 May 2017 12:34:31 +0100
Message-ID: <1493897673-1826-2-git-send-email-lukasz.luba@arm.com>
References: <1493897673-1826-1-git-send-email-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdEDLfC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 May 2017 07:35:02 -0400
In-Reply-To: <1493897673-1826-1-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, javi.merino@kernel.org, chris.diamand@arm.com, lukasz.luba@arm.com

Move the code which gets the voltage for a given frequency.
This code will be resused in few places.

Acked-by: Javi Merino <javi.merino@kernel.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 45 ++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 4bf4ad5..af9d328 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -164,27 +164,12 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
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
-static unsigned long
-get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
+static unsigned long get_voltage(struct devfreq *df, unsigned long freq)
 {
-	struct devfreq *df = dfc->devfreq;
 	struct device *dev = df->dev.parent;
 	unsigned long voltage;
 	struct dev_pm_opp *opp;
 
-	if (!dfc->power_ops->get_static_power)
-		return 0;
-
 	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
 	if (PTR_ERR(opp) == -ERANGE)
 		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
@@ -202,9 +187,35 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 		dev_err_ratelimited(dev,
 				    "Failed to get voltage for frequency %lu\n",
 				    freq);
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
+ * get_static_power().  The current voltage is calculated using the
+ * OPP library.  If no get_static_power() was supplied, assume the
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
+	voltage = get_voltage(df, freq);
+
+	if (voltage == 0)
+		return 0;
+
 	return dfc->power_ops->get_static_power(df, voltage);
 }
 
-- 
1.9.1
