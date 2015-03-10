From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 2/2] arm64: kernel: perf: add pmu CPU PM notifier
Date: Tue, 10 Mar 2015 17:31:22 +0000
Message-ID: <1426008682-5680-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1426008682-5680-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43635 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178AbbCJRb1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 Mar 2015 13:31:27 -0400
In-Reply-To: <1426008682-5680-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Kevin Hilman <khilman@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mark Rutland <mark.rutland@arm.com>

When a CPU is being profiled through PMU events and it enters suspend
or idle states, the PMU registers content can be lost, which means that
counters that were relied upon on power down entry are reset on power
up to values that are incosistent with the profile session.

This patch adds a CPU PM notifier to arm64 perf code, that detects
on entry if events are being monitored, and if so, it returns
failure to the CPU PM notification chain, causing the suspend
thread or the idle thread to abort power down, therefore preventing
registers content loss.

By triggering CPU PM notification failure this patch prevents
suspending a system if the suspend thread is being profiled and
it also prevents entering idle deep states on cores that have profile
events in use, somehow limiting power management capabilities when
there are active perf sessions.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/perf_event.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 83f21d8..4809fca 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -22,6 +22,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
+#include <linux/cpu_pm.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -1316,6 +1317,53 @@ static struct pmu_hw_events *armpmu_get_cpu_events(void)
 	return this_cpu_ptr(&cpu_hw_events);
 }
 
+#ifdef CONFIG_CPU_PM
+static int cpu_pm_pmu_notifier(struct notifier_block *self,
+			       unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_PM_ENTER: {
+		/*
+		 * Check events in use and fail if events are being monitored.
+		 * On failure, system suspend and idle entry will consequently
+		 * abort power down operations, preventing CPU reset on power
+		 * down, that would cause PMU registers reset in turn.
+		 * The obvious drawback is that we can't enter idle
+		 * states if a cpu is being profiled, and we can't
+		 * profile the suspend thread (ie profiling it has the side
+		 * effect of disabling system suspend), but that's the price
+		 * to pay to keep the PMU registers powered up.
+		 */
+		struct pmu_hw_events *hw_events = cpu_pmu->get_hw_events();
+		int enabled = bitmap_weight(hw_events->used_mask,
+					    cpu_pmu->num_events);
+		return enabled ? NOTIFY_BAD : NOTIFY_OK;
+	}
+	case CPU_PM_EXIT:
+		if (cpu_pmu->reset)
+			cpu_pmu->reset(NULL);
+		return NOTIFY_OK;
+	case CPU_PM_ENTER_FAILED:
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block cpu_pm_pmu_notifier_block = {
+	.notifier_call = cpu_pm_pmu_notifier,
+};
+
+static void cpu_pm_pmu_init(void)
+{
+	cpu_pm_register_notifier(&cpu_pm_pmu_notifier_block);
+}
+
+#else
+static inline void cpu_pm_pmu_init(void) { }
+#endif /* CONFIG_CPU_PM */
+
 /*
  * PMU hardware loses all context when a CPU goes offline.
  * When a CPU is hotplugged back in, since some hardware registers are
@@ -1352,6 +1400,8 @@ static void __init cpu_pmu_init(struct arm_pmu *armpmu)
 	armpmu->get_hw_events = armpmu_get_cpu_events;
 
 	register_cpu_notifier(&cpu_pmu_notifier_block);
+
+	cpu_pm_pmu_init();
 }
 
 static int __init init_hw_perf_events(void)
-- 
2.2.1

