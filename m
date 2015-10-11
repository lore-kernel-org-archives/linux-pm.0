From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/5] cpufreq: Use cpumask_copy instead of cpumask_or to copy a mask
Date: Sun, 11 Oct 2015 22:51:10 +0530
Message-ID: <b8dc587ec7767b89b1d24f1348acd1a341e54a4a.1444583718.git.viresh.kumar@linaro.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444583718.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444583718.git.viresh.kumar@linaro.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 25c4c15103a0..b32521432db4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1221,7 +1221,7 @@ static int cpufreq_online(unsigned int cpu)
 
 	if (new_policy) {
 		/* related_cpus should at least include policy->cpus. */
-		cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
+		cpumask_copy(policy->related_cpus, policy->cpus);
 		/* Remember CPUs present at the policy creation time. */
 		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
 	}
-- 
2.4.0
