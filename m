From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/8] cpufreq: powerenv: Fix memory leak
Date: Wed,  1 Jun 2016 16:04:17 +0530
Message-ID: <f67b4b395c777a3e933ab51eafcd76b1299bf1fb.1464776797.git.viresh.kumar@linaro.org>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464776797.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464776797.git.viresh.kumar@linaro.org>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The policy is copied (unnecessarily) and is never freed. Fix it by just
getting a reference to the existing policy structure and putting it
back.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 54c45368e3f1..96bb4acd366e 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -756,15 +756,18 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 
 	chip->restore = false;
 	for_each_cpu(cpu, &mask) {
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu)
 		int index;
-		struct cpufreq_policy policy;
 
-		cpufreq_get_policy(&policy, cpu);
-		cpufreq_frequency_table_target(&policy, policy.freq_table,
-					       policy.cur,
+		if (!policy)
+			continue;
+
+		cpufreq_frequency_table_target(policy, policy->freq_table,
+					       policy->cur,
 					       CPUFREQ_RELATION_C, &index);
-		powernv_cpufreq_target_index(&policy, index);
-		cpumask_andnot(&mask, &mask, policy.cpus);
+		powernv_cpufreq_target_index(policy, index);
+		cpumask_andnot(&mask, &mask, policy->cpus);
+		cpufreq_cpu_put(policy);
 	}
 out:
 	put_online_cpus();
-- 
2.7.1.410.g6faf27b
