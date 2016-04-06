From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/13] intel_idle: Clean up all registered devices on exit.
Date: Wed,  6 Apr 2016 17:00:57 -0400
Message-ID: <61e55da835d4d205e413f5b00a4fb689a22bb2ed.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36429 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbcDFVBs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:01:48 -0400
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Richard Cochran <rcochran@linutronix.de>, Len Brown <len.brown@intel.com>

From: Richard Cochran <rcochran@linutronix.de>

This driver registers cpuidle devices when a CPU comes online, but it
leaves the registrations in place when a CPU goes offline.  The module
exit code only unregisters the currently online CPUs, leaving the
devices for offline CPUs dangling.

This patch changes the driver to clean up all registrations on exit,
even those from CPUs that are offline.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 45e93f4..7575699 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1382,12 +1382,19 @@ static int __init intel_idle_init(void)
 
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
2.8.0.rc4.16.g56331f8

