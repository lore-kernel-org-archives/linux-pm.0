From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv5 PATCH 19/46] sched: Compute cpu capacity available at current frequency
Date: Tue,  7 Jul 2015 19:24:02 +0100
Message-ID: <1436293469-25707-20-git-send-email-morten.rasmussen@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37502 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932830AbbGGSWu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 14:22:50 -0400
In-Reply-To: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

capacity_orig_of() returns the max available compute capacity of a cpu.
For scale-invariant utilization tracking and energy-aware scheduling
decisions it is useful to know the compute capacity available at the
current OPP of a cpu.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a95dad9..70f81fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4791,6 +4791,17 @@ static long effective_load(struct task_group *tg, int cpu, long wl, long wg)
 
 #endif
 
+/*
+ * Returns the current capacity of cpu after applying both
+ * cpu and freq scaling.
+ */
+static unsigned long capacity_curr_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_orig *
+	       arch_scale_freq_capacity(NULL, cpu)
+	       >> SCHED_CAPACITY_SHIFT;
+}
+
 static inline bool energy_aware(void)
 {
 	return sched_feat(ENERGY_AWARE);
-- 
1.9.1

