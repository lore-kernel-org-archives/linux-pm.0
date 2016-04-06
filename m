From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/13] intel_idle: Avoid a double free of the per-CPU data.
Date: Wed,  6 Apr 2016 17:00:53 -0400
Message-ID: <6c03f13a6f0a7af13deb27fd268a18946cca1ede.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Richard Cochran <rcochran@linutronix.de>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Richard Cochran <rcochran@linutronix.de>

The helper function, intel_idle_cpuidle_devices_uninit, frees the
globally allocated per-CPU data.  However, this function is invoked
from the hot plug notifier callback at a time when freeing that data
is not safe.

If the call to cpuidle_register_driver() should fail (say, due to lack
of memory), then the driver will free its per-CPU region.  On the
*next* CPU_ONLINE event, the driver will happily use the region again
and even free it again if the failure repeats.

This patch fixes the issue by moving the call to free_percpu() outside
of the helper function at the two call sites that actually need to
free the per-CPU data.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 085538a..04fe4df 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1069,7 +1069,7 @@ static int __init intel_idle_probe(void)
 
 /*
  * intel_idle_cpuidle_devices_uninit()
- * unregister, free cpuidle_devices
+ * Unregisters the cpuidle devices.
  */
 static void intel_idle_cpuidle_devices_uninit(void)
 {
@@ -1080,9 +1080,6 @@ static void intel_idle_cpuidle_devices_uninit(void)
 		dev = per_cpu_ptr(intel_idle_cpuidle_devices, i);
 		cpuidle_unregister_device(dev);
 	}
-
-	free_percpu(intel_idle_cpuidle_devices);
-	return;
 }
 
 /*
@@ -1368,6 +1365,7 @@ static int __init intel_idle_init(void)
 		if (retval) {
 			cpu_notifier_register_done();
 			cpuidle_unregister_driver(&intel_idle_driver);
+			free_percpu(intel_idle_cpuidle_devices);
 			return retval;
 		}
 	}
@@ -1390,6 +1388,7 @@ static void __exit intel_idle_exit(void)
 	cpu_notifier_register_done();
 
 	cpuidle_unregister_driver(&intel_idle_driver);
+	free_percpu(intel_idle_cpuidle_devices);
 }
 
 module_init(intel_idle_init);
-- 
2.8.0.rc4.16.g56331f8
