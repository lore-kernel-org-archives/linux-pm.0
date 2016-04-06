From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/13] intel_idle: Fix deallocation order on the driver exit path.
Date: Wed,  6 Apr 2016 17:00:51 -0400
Message-ID: <6baa6b86d4fa30b117145f78459cbedbe96d7e6b.1459975717.git.len.brown@intel.com>
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

In the module_exit() method, this driver first frees its per-CPU
pointer, then unregisters a callback making use of the pointer.
Furthermore, the function, intel_idle_cpuidle_devices_uninit, is racy
against CPU hot plugging as it calls for_each_online_cpu().

This patch corrects the issues by unregistering first on the exit path
while holding the hot plug lock.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c50859d..5b309e5 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1379,16 +1379,16 @@ static int __init intel_idle_init(void)
 
 static void __exit intel_idle_exit(void)
 {
-	intel_idle_cpuidle_devices_uninit();
-	cpuidle_unregister_driver(&intel_idle_driver);
-
 	cpu_notifier_register_begin();
 
 	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
 		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
 	__unregister_cpu_notifier(&cpu_hotplug_notifier);
+	intel_idle_cpuidle_devices_uninit();
 
 	cpu_notifier_register_done();
+
+	cpuidle_unregister_driver(&intel_idle_driver);
 }
 
 module_init(intel_idle_init);
-- 
2.8.0.rc4.16.g56331f8
