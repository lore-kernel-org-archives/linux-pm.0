From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [RFC PATCH  2/4] devfreq_cooling: pass a pointer to devfreq in the power model callbacks
Date: Fri, 26 Aug 2016 14:18:03 +0100
Message-ID: <20160826131805.14820-3-lukasz.luba@arm.com>
References: <20160826131805.14820-1-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39229 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbcHZNTY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Aug 2016 09:19:24 -0400
In-Reply-To: <20160826131805.14820-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, lukasz.luba@arm.com, javi.merino@arm.com, orjan.eide@arm.com

From: Javi Merino <javi.merino@arm.com>

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
Reviewed-by: Ørjan Eide <orjan.eide@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 5 +++--
 include/linux/devfreq_cooling.h   | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 01f0015..c549d83 100644
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
index 3049f94..c35d0c0 100644
--- a/include/linux/devfreq_cooling.h
+++ b/include/linux/devfreq_cooling.h
@@ -36,8 +36,10 @@
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
2.9.2

