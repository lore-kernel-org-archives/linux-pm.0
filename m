From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] devfreq_cooling: pass a pointer to devfreq in the power model callbacks
Date: Fri,  4 Dec 2015 14:44:34 +0000
Message-ID: <1449240274-17544-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54767 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528AbbLDOom (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 09:44:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

It's useful for a driver to know which device it's referring to when
calculating its dynamic or static power.  Pass a pointer to devfreq
in the callbacks to let the driver know which device it refers to.

This is similar to what we do for the cpu cooling device power model.
For that, we pass a cpumask of the affected cpus.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 5 +++--
 include/linux/devfreq_cooling.h   | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 01f0015f80dc..c549d83a0c7d 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -238,7 +238,7 @@ get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 		return 0;
 	}
 
-	return dfc->power_ops->get_static_power(voltage);
+	return dfc->power_ops->get_static_power(df, voltage);
 }
 
 /**
@@ -262,7 +262,8 @@ get_dynamic_power(struct devfreq_cooling_device *dfc, unsigned long freq,
 	struct devfreq_cooling_power *dfc_power = dfc->power_ops;
 
 	if (dfc_power->get_dynamic_power)
-		return dfc_power->get_dynamic_power(freq, voltage);
+		return dfc_power->get_dynamic_power(dfc->devfreq, freq,
+						    voltage);
 
 	freq_mhz = freq / 1000000;
 	power = (u64)dfc_power->dyn_power_coeff * freq_mhz * voltage * voltage;
diff --git a/include/linux/devfreq_cooling.h b/include/linux/devfreq_cooling.h
index 7adf6cc4b305..959714e93e5b 100644
--- a/include/linux/devfreq_cooling.h
+++ b/include/linux/devfreq_cooling.h
@@ -37,8 +37,10 @@
  *			@dyn_power_coeff * frequency * voltage^2
  */
 struct devfreq_cooling_power {
-	unsigned long (*get_static_power)(unsigned long voltage);
-	unsigned long (*get_dynamic_power)(unsigned long freq,
+	unsigned long (*get_static_power)(struct devfreq *devfreq,
+					  unsigned long voltage);
+	unsigned long (*get_dynamic_power)(struct devfreq *devfreq,
+					   unsigned long freq,
 					   unsigned long voltage);
 	unsigned long dyn_power_coeff;
 };
-- 
1.9.1

