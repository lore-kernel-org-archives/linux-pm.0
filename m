From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 1/3] thermal: devfreq_cooling: refactor code and add get_voltage function
Date: Tue, 31 Jan 2017 16:11:45 +0000
Message-ID: <20170131161147.17002-2-lukasz.luba@arm.com>
References: <20170131161147.17002-1-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751057AbdAaQNT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Jan 2017 11:13:19 -0500
In-Reply-To: <20170131161147.17002-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, orjan.eide@arm.com, lukasz.luba@arm.com, chris.diamand@arm.com, javi.merino@kernel.org

Move the code which gets the voltage for a given frequency.
This code will be resused in another place.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 5a737fd..7d55652 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -200,6 +200,31 @@ freq_get_state(struct devfreq_cooling_device *dfc, unsigned long freq)
 	return THERMAL_CSTATE_INVALID;
 }
 
+static unsigned long get_voltage(struct devfreq *df, unsigned long freq)
+{
+	struct device *dev = df->dev.parent;
+	unsigned long voltage;
+	struct dev_pm_opp *opp;
+
+	rcu_read_lock();
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
+	if (IS_ERR(opp) && (PTR_ERR(opp) == -ERANGE))
+		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
+
+	voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
+
+	rcu_read_unlock();
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
@@ -214,29 +239,15 @@ static unsigned long
 get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 {
 	struct devfreq *df = dfc->devfreq;
-	struct device *dev = df->dev.parent;
 	unsigned long voltage;
-	struct dev_pm_opp *opp;
 
 	if (!dfc->power_ops->get_static_power)
 		return 0;
 
-	rcu_read_lock();
-
-	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
-	if (IS_ERR(opp) && (PTR_ERR(opp) == -ERANGE))
-		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
+	voltage = get_voltage(df, freq);
 
-	voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
-
-	rcu_read_unlock();
-
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

