From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v3 1/3] thermal: devfreq_cooling: refactor code and add get_voltage function
Date: Tue, 14 Mar 2017 13:06:14 +0000
Message-ID: <20170314130616.7711-2-lukasz.luba@arm.com>
References: <20170314130616.7711-1-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbdCNNGw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Mar 2017 09:06:52 -0400
In-Reply-To: <20170314130616.7711-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: chris.diamand@arm.com, lukasz.luba@arm.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com

Move the code which gets the voltage for a given frequency.
This code will be resused in few places.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 7743a78..bc4c78d 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -164,6 +164,28 @@ freq_get_state(struct devfreq_cooling_device *dfc, unsigned long freq)
 	return THERMAL_CSTATE_INVALID;
 }
 
+static unsigned long get_voltage(struct devfreq *df, unsigned long freq)
+{
+	struct device *dev = df->dev.parent;
+	unsigned long voltage;
+	struct dev_pm_opp *opp;
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
+	if (IS_ERR(opp) && (PTR_ERR(opp) == -ERANGE))
+		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
+
+	voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
+	dev_pm_opp_put(opp);
+
+	if (voltage == 0) {
+		dev_warn_ratelimited(dev,
+				     "Failed to get voltage for frequency %lu: %ld\n",
+				     freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
+	}
+
+	return voltage;
+}
+
 /**
  * get_static_power() - calculate the static power
  * @dfc:	Pointer to devfreq cooling device
@@ -178,26 +200,15 @@ static unsigned long
 get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 {
 	struct devfreq *df = dfc->devfreq;
-	struct device *dev = df->dev.parent;
 	unsigned long voltage;
-	struct dev_pm_opp *opp;
 
 	if (!dfc->power_ops->get_static_power)
 		return 0;
 
-	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
-	if (IS_ERR(opp) && (PTR_ERR(opp) == -ERANGE))
-		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
-
-	voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
-	dev_pm_opp_put(opp);
+	voltage = get_voltage(df, freq);
 
-	if (voltage == 0) {
-		dev_warn_ratelimited(dev,
-				     "Failed to get voltage for frequency %lu: %ld\n",
-				     freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
+	if (voltage == 0)
 		return 0;
-	}
 
 	return dfc->power_ops->get_static_power(df, voltage);
 }
-- 
2.9.2
