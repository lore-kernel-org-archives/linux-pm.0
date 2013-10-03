From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 90/92] cpufreq: sa11x0: use cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:42:09 +0530
Message-ID: <854d6e8fa69d7d7d6dcd3c5461deaeed8d0f9b5b.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sa1100-cpufreq.c | 6 +-----
 drivers/cpufreq/sa1110-cpufreq.c | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/sa1100-cpufreq.c b/drivers/cpufreq/sa1100-cpufreq.c
index a1d1bb7..b282cea 100644
--- a/drivers/cpufreq/sa1100-cpufreq.c
+++ b/drivers/cpufreq/sa1100-cpufreq.c
@@ -218,11 +218,7 @@ static int sa1100_target(struct cpufreq_policy *policy,
 
 static int __init sa1100_cpu_init(struct cpufreq_policy *policy)
 {
-	if (policy->cpu != 0)
-		return -EINVAL;
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-
-	return cpufreq_table_validate_and_show(policy, sa11x0_freq_table);
+	return cpufreq_generic_init(policy, sa11x0_freq_table, CPUFREQ_ETERNAL);
 }
 
 static struct cpufreq_driver sa1100_driver __refdata = {
diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index 9da940e..bca04c0 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -332,11 +332,7 @@ static int sa1110_target(struct cpufreq_policy *policy,
 
 static int __init sa1110_cpu_init(struct cpufreq_policy *policy)
 {
-	if (policy->cpu != 0)
-		return -EINVAL;
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-
-	return cpufreq_table_validate_and_show(policy, sa11x0_freq_table);
+	return cpufreq_generic_init(policy, sa11x0_freq_table, CPUFREQ_ETERNAL);
 }
 
 /* sa1110_driver needs __refdata because it must remain after init registers
-- 
1.7.12.rc2.18.g61b472e

