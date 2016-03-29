From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 07/10] intel_idle: Setup the timer broadcast only on successful driver load.
Date: Tue, 29 Mar 2016 15:15:59 +0200
Message-ID: <9b83c07a9a0bf153f1d82cfbea1be93d9267bbb5.1459257096.git.rcochran@linutronix.de>
References: <cover.1459257096.git.rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459257096.git.rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This driver sets the broadcast tick quite early on during probe and does
not clean up again in cast of failure.  This patch moves the setup call
after the registration, placing the on_each_cpu() calls within the global
CPU lock region.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/idle/intel_idle.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 0b56872..ab34cd8 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -987,16 +987,9 @@ static int __init intel_idle_probe(void)
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
 
@@ -1234,8 +1227,16 @@ static int __init intel_idle_init(void)
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
2.1.4
