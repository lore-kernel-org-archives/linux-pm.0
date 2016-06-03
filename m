From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] devfreq_cooling: pass a pointer to devfreq in the power model callbacks
Date: Fri,  3 Jun 2016 10:25:31 +0100
Message-ID: <1464945931-5200-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50792 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbcFCJ0E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 Jun 2016 05:26:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lukasz.luba@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

When the devfreq cooling device was designed, it was an oversight not to
pass a pointer to the struct devfreq as the first parameters of the
callbacks.  The design patterns of the kernel suggest it for a good
reason.

By passing a pointer to struct devfreq, the driver can register one
function that works with multiple devices.  With the current
implementation, a driver that can work with multiple devices has to
create multiple copies of the same function with different parameters so
that each devfreq_cooling_device can use the appropriate one.  By
passing a pointer to struct devfreq, the driver can identify which
device it's referring to.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
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

