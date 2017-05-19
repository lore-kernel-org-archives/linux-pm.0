From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH v2 1/2] cpufreq: Make iowait boost a policy option
Date: Thu, 18 May 2017 23:23:43 -0700
Message-ID: <20170519062344.27692-2-joelaf@google.com>
References: <20170519062344.27692-1-joelaf@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519062344.27692-1-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

Make iowait boost a cpufreq policy option and enable it for intel_pstate
cpufreq driver. Governors like schedutil can use it to determine if
boosting for tasks that wake up with p->in_iowait set is needed.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 include/linux/cpufreq.h        | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b7de5bd76a31..5dddc21da4f6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2239,6 +2239,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
 	policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
+	policy->iowait_boost_enable = true;
 	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
 	policy->cur = policy->cpuinfo.min_freq;
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a5ce0bbeadb5..0783d8b52ec8 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -127,6 +127,9 @@ struct cpufreq_policy {
 	 */
 	unsigned int		transition_delay_us;
 
+	/* Boost switch for tasks with p->in_iowait set */
+	bool iowait_boost_enable;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	int cached_resolved_idx;
-- 
2.13.0.303.g4ebf302169-goog
