From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 06/10] intel_idle: Avoid a double free of the per-CPU data.
Date: Tue, 29 Mar 2016 15:15:58 +0200
Message-ID: <f99e3e5ea9cc8b2b18cb37e3ed10015833e257ec.1459257096.git.rcochran@linutronix.de>
References: <cover.1459257096.git.rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459257096.git.rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/idle/intel_idle.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5dd741f..0b56872 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1002,7 +1002,7 @@ static int __init intel_idle_probe(void)
 
 /*
  * intel_idle_cpuidle_devices_uninit()
- * unregister, free cpuidle_devices
+ * Unregisters the cpuidle devices.
  */
 static void intel_idle_cpuidle_devices_uninit(void)
 {
@@ -1013,9 +1013,6 @@ static void intel_idle_cpuidle_devices_uninit(void)
 		dev = per_cpu_ptr(intel_idle_cpuidle_devices, i);
 		cpuidle_unregister_device(dev);
 	}
-
-	free_percpu(intel_idle_cpuidle_devices);
-	return;
 }
 
 /*
@@ -1231,6 +1228,7 @@ static int __init intel_idle_init(void)
 		if (retval) {
 			cpu_notifier_register_done();
 			cpuidle_unregister_driver(&intel_idle_driver);
+			free_percpu(intel_idle_cpuidle_devices);
 			return retval;
 		}
 	}
@@ -1253,6 +1251,7 @@ static void __exit intel_idle_exit(void)
 	cpu_notifier_register_done();
 
 	cpuidle_unregister_driver(&intel_idle_driver);
+	free_percpu(intel_idle_cpuidle_devices);
 }
 
 module_init(intel_idle_init);
-- 
2.1.4
