From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT] [PATCH 08/10] cpufreq: intel_pstate: Dyanmically update busy pct
Date: Tue, 15 May 2018 21:49:09 -0700
Message-ID: <20180516044911.28797-9-srinivas.pandruvada@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Calculate hwp_boost_threshold_busy_pct (task busy percent, which is
worth boosting) and hwp_boost_pstate_threshold (Don't boost if
CPU already has some performance) based on platform, min, max and
turbo frequencies.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ec455af..c43edce 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1463,6 +1463,42 @@ static inline int intel_pstate_get_sched_util(struct cpudata *cpu)
 	return util * 100 / max;
 }
 
+
+static inline void intel_pstate_update_busy_threshold(struct cpudata *cpu)
+{
+	if (!hwp_boost_threshold_busy_pct) {
+		int min_freq, max_freq;
+
+		min_freq  = cpu->pstate.min_pstate * cpu->pstate.scaling;
+		update_turbo_state();
+		max_freq =  global.turbo_disabled || global.no_turbo ?
+				cpu->pstate.max_freq : cpu->pstate.turbo_freq;
+
+		/*
+		 * We are guranteed to get atleast min P-state. If we assume
+		 * P-state is proportional to load (such that 10% load
+		 * increase will result in 10% P-state increase), we will
+		 * get at least min P-state till we have atleast
+		 * (min * 100/max) percent cpu load. So any load less than
+		 * than this this we shouldn't do any boost. Then boosting
+		 * is not free, we will add atleast 20% offset.
+		 */
+		hwp_boost_threshold_busy_pct = min_freq * 100 / max_freq;
+		hwp_boost_threshold_busy_pct += 20;
+		pr_debug("hwp_boost_threshold_busy_pct = %d\n",
+			 hwp_boost_threshold_busy_pct);
+	}
+
+	/* P1 percent out of total range of P-states */
+	if (cpu->pstate.max_freq != cpu->pstate.turbo_freq) {
+		hwp_boost_pstate_threshold =
+			cpu->pstate.max_freq * SCHED_CAPACITY_SCALE / cpu->pstate.turbo_freq;
+		pr_debug("hwp_boost_pstate_threshold = %d\n",
+			 hwp_boost_pstate_threshold);
+	}
+
+}
+
 static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
 						u64 time, unsigned int flags)
 {
@@ -2061,8 +2097,10 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->fast_switch_possible = true;
 
-	if (hwp_active)
+	if (hwp_active) {
 		csd_init(cpu);
+		intel_pstate_update_busy_threshold(cpu);
+	}
 
 	return 0;
 }
-- 
2.9.5
