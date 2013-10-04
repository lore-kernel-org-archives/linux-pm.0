From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH] Thermal: Tidy up error handling in powerclamp_init
Date: Fri,  4 Oct 2013 21:53:24 +0530
Message-ID: <1380903804-18913-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:20973 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431Ab3JDKze (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Oct 2013 06:55:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com, linux-pm@vger.kernel.org
Cc: jacob.jun.pan@linux.intel.com, Durgadoss R <durgadoss.r@intel.com>

This patch
 * adds missing kfree() for cpu_clamping_mask
 * adds return value checking for alloc_percpu()
 * unregister hotcpu notifier in exit path

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/intel_powerclamp.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index b40b37c..a7cd170 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -758,21 +758,39 @@ static int powerclamp_init(void)
 	/* probe cpu features and ids here */
 	retval = powerclamp_probe();
 	if (retval)
-		return retval;
+		goto exit_free;
+
 	/* set default limit, maybe adjusted during runtime based on feedback */
 	window_size = 2;
 	register_hotcpu_notifier(&powerclamp_cpu_notifier);
+
 	powerclamp_thread = alloc_percpu(struct task_struct *);
+	if (!powerclamp_thread) {
+		retval = -ENOMEM;
+		goto exit_unregister;
+	}
+
 	cooling_dev = thermal_cooling_device_register("intel_powerclamp", NULL,
 						&powerclamp_cooling_ops);
-	if (IS_ERR(cooling_dev))
-		return -ENODEV;
+	if (IS_ERR(cooling_dev)) {
+		retval = -ENODEV;
+		goto exit_free_thread;
+	}
 
 	if (!duration)
 		duration = jiffies_to_msecs(DEFAULT_DURATION_JIFFIES);
+
 	powerclamp_create_debug_files();
 
 	return 0;
+
+exit_free_thread:
+	free_percpu(powerclamp_thread);
+exit_unregister:
+	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
+exit_free:
+	kfree(cpu_clamping_mask);
+	return retval;
 }
 module_init(powerclamp_init);
 
-- 
1.7.9.5

