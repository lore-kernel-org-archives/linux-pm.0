From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 1/2] arm64: kernel: perf: add cpu hotplug notifier
Date: Tue, 10 Mar 2015 17:31:21 +0000
Message-ID: <1426008682-5680-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43632 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbbCJRbZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 Mar 2015 13:31:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>

When a CPU is taken offline, its PMU registers content is lost
and needs to be reset on power up, since for most of the PMU registers
content is UNKNOWN upon CPU reset. This patch implements a cpu hotplug
notifier and hooks the reset call in the respective notifier callback
function.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/perf_event.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 25a5308..83f21d8 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -21,6 +21,7 @@
 #define pr_fmt(fmt) "hw perfevents: " fmt
 
 #include <linux/bitmap.h>
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -1315,6 +1316,30 @@ static struct pmu_hw_events *armpmu_get_cpu_events(void)
 	return this_cpu_ptr(&cpu_hw_events);
 }
 
+/*
+ * PMU hardware loses all context when a CPU goes offline.
+ * When a CPU is hotplugged back in, since some hardware registers are
+ * UNKNOWN at reset, the PMU must be explicitly reset to avoid reading
+ * junk values out of them.
+ */
+static int cpu_pmu_notifier(struct notifier_block *b, unsigned long action,
+			    void *hcpu)
+{
+	if ((action & ~CPU_TASKS_FROZEN) != CPU_STARTING)
+		return NOTIFY_DONE;
+
+	if (cpu_pmu->reset)
+		cpu_pmu->reset(NULL);
+	else
+		return NOTIFY_DONE;
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpu_pmu_notifier_block = {
+	.notifier_call = cpu_pmu_notifier,
+};
+
 static void __init cpu_pmu_init(struct arm_pmu *armpmu)
 {
 	int cpu;
@@ -1325,6 +1350,8 @@ static void __init cpu_pmu_init(struct arm_pmu *armpmu)
 		raw_spin_lock_init(&events->pmu_lock);
 	}
 	armpmu->get_hw_events = armpmu_get_cpu_events;
+
+	register_cpu_notifier(&cpu_pmu_notifier_block);
 }
 
 static int __init init_hw_perf_events(void)
-- 
2.2.1

