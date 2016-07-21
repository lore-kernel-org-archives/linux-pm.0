From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] cpufreq: Disallow ->resolve_freq() for drivers providing ->target_index()
Date: Thu, 21 Jul 2016 14:39:26 -0700
Message-ID: <065301260510fbca81f5481b27b0de956073068a.1469137133.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Juri.Lelli@arm.com, patrick.bellasi@arm.com
List-Id: linux-pm@vger.kernel.org

The handlers provided by cpufreq core are sufficient for resolving the
frequency for drivers providing ->target_index(), as the core already
has the frequency table and so ->resolve_freq() isn't required for such
platforms.

This patch disallows drivers with ->target_index() callback to use the
->resolve_freq() callback.

Also, it fixes a potential kernel crash for drivers providing ->target()
but no ->resolve_freq().

Fixes: e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- s/UINT_MAX/target_freq

 drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b696baeb249d..3ef9be3965ff 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -507,12 +507,20 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 {
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 	policy->cached_target_freq = target_freq;
+
+	if (cpufreq_driver->target_index) {
+		int idx;
+
+		idx = cpufreq_frequency_table_target(policy, target_freq,
+						     CPUFREQ_RELATION_L);
+		policy->cached_resolved_idx = idx;
+		return policy->freq_table[idx].frequency;
+	}
+
 	if (cpufreq_driver->resolve_freq)
 		return cpufreq_driver->resolve_freq(policy, target_freq);
-	policy->cached_resolved_idx =
-		cpufreq_frequency_table_target(policy, target_freq,
-					       CPUFREQ_RELATION_L);
-	return policy->freq_table[policy->cached_resolved_idx].frequency;
+
+	return target_freq;
 }
 
 /*********************************************************************
-- 
2.7.4
