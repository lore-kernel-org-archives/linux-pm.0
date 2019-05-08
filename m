From: douglas.raillard@arm.com
Subject: [RFC PATCH 3/7] sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()
Date: Wed,  8 May 2019 18:42:57 +0100
Message-ID: <20190508174301.4828-4-douglas.raillard@arm.com>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508174301.4828-1-douglas.raillard@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, quentin.perret@arm.com, douglas.raillard@arm.com, patrick.bellasi@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

From: Douglas RAILLARD <douglas.raillard@arm.com>

Choose the highest OPP for a given energy cost, allowing to skip lower
frequencies that would not be cheaper in terms of consumed power. These
frequencies can still be interesting to keep in the energy model to give
more freedom to thermal throttling, but should not be selected under
normal circumstances.

This also prepares the ground for energy-aware frequency boosting.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 82dbacf83649..f4173a7c0f01 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -10,6 +10,7 @@
 
 #include "sched.h"
 
+#include <linux/energy_model.h>
 #include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
@@ -200,9 +201,19 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
+	struct em_perf_domain *pd = sugov_policy_get_pd(sg_policy);
+
+	/* Maximum power we are ready to spend. */
+	unsigned int cost_margin = 0;
 
 	freq = map_util_freq(util, freq, max);
 
+	/*
+	 * Try to get a higher frequency if one is available, given the extra
+	 * power we are ready to spend.
+	 */
+	freq = em_pd_get_higher_freq(pd, freq, cost_margin);
+
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
 
-- 
2.21.0
