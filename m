From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 04/10] intel_idle: Fix deallocation order on the driver exit path.
Date: Tue, 29 Mar 2016 15:15:56 +0200
Message-ID: <c0de96b298895b9cb54f51f3f112626f60525842.1459257096.git.rcochran@linutronix.de>
References: <cover.1459257096.git.rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459257096.git.rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In the module_exit() method, this driver first frees its per-CPU
pointer, then unregisters a callback making use of the pointer.
Furthermore, the function, intel_idle_cpuidle_devices_uninit, is racy
against CPU hot plugging as it calls for_each_online_cpu().

This patch corrects the issues by unregistering first on the exit path
while holding the hot plug lock.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/idle/intel_idle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index cb85c4c..4a1de3d 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1242,16 +1242,16 @@ static int __init intel_idle_init(void)
 
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
2.1.4
