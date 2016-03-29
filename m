From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 10/10] intel_idle: Clean up all registered devices on exit.
Date: Tue, 29 Mar 2016 15:16:02 +0200
Message-ID: <533dcd7cc5c914a1632e539d901c89bccb296ad4.1459257096.git.rcochran@linutronix.de>
References: <cover.1459257096.git.rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459257096.git.rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This driver registers cpuidle devices when a CPU comes online, but it
leaves the registrations in place when a CPU goes offline.  The module
exit code only unregisters the currently online CPUs, leaving the
devices for offline CPUs dangling.

This patch changes the driver to clean up all registrations on exit,
even those from CPUs that are offline.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/idle/intel_idle.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 8420ba1..862346b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1245,12 +1245,19 @@ static int __init intel_idle_init(void)
 
 static void __exit intel_idle_exit(void)
 {
+	struct cpuidle_device *dev;
+	int i;
+
 	cpu_notifier_register_begin();
 
 	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
 		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
 	__unregister_cpu_notifier(&cpu_hotplug_notifier);
-	intel_idle_cpuidle_devices_uninit();
+
+	for_each_possible_cpu(i) {
+		dev = per_cpu_ptr(intel_idle_cpuidle_devices, i);
+		cpuidle_unregister_device(dev);
+	}
 
 	cpu_notifier_register_done();
 
-- 
2.1.4
