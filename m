From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/13] intel_idle: Setup the timer broadcast only on successful driver load.
Date: Wed,  6 Apr 2016 17:00:54 -0400
Message-ID: <93e7663285d2b319dcd051b2b337e0c00d6e0127.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36404 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbcDFVBp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:01:45 -0400
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Richard Cochran <rcochran@linutronix.de>, Len Brown <len.brown@intel.com>

From: Richard Cochran <rcochran@linutronix.de>

This driver sets the broadcast tick quite early on during probe and does
not clean up again in cast of failure.  This patch moves the setup call
after the registration, placing the on_each_cpu() calls within the global
CPU lock region.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 04fe4df..b5e92dd 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1054,16 +1054,9 @@ static int __init intel_idle_probe(void)
 	icpu = (const struct idle_cpu *)id->driver_data;
 	cpuidle_state_table = icpu->state_table;
 
-	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
-		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
-	else
-		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
-
 	pr_debug(PREFIX "v" INTEL_IDLE_VERSION
 		" model 0x%X\n", boot_cpu_data.x86_model);
 
-	pr_debug(PREFIX "lapic_timer_reliable_states 0x%x\n",
-		lapic_timer_reliable_states);
 	return 0;
 }
 
@@ -1371,8 +1364,16 @@ static int __init intel_idle_init(void)
 	}
 	__register_cpu_notifier(&cpu_hotplug_notifier);
 
+	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
+		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
+	else
+		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
+
 	cpu_notifier_register_done();
 
+	pr_debug(PREFIX "lapic_timer_reliable_states 0x%x\n",
+		lapic_timer_reliable_states);
+
 	return 0;
 }
 
-- 
2.8.0.rc4.16.g56331f8

