From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/14] cpufreq: sa11x0: use cpufreq_generic_init() routine
Date: Wed, 21 Aug 2013 20:12:31 +0530
Message-ID: <d7f068a850aa335ad8041f977373cfcdf1d109f7.1377093938.git.viresh.kumar@linaro.org>
References: <cover.1377093938.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1377093938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1377093938.git.viresh.kumar@linaro.org>
References: <cover.1377093938.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sa1100-cpufreq.c | 6 +-----
 drivers/cpufreq/sa1110-cpufreq.c | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/sa1100-cpufreq.c b/drivers/cpufreq/sa1100-cpufreq.c
index a89c47b..623da74 100644
--- a/drivers/cpufreq/sa1100-cpufreq.c
+++ b/drivers/cpufreq/sa1100-cpufreq.c
@@ -197,11 +197,7 @@ static int sa1100_target(struct cpufreq_policy *policy, unsigned int ppcr)
 
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
index 0e52e80..2c2b2e6 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -306,11 +306,7 @@ static int sa1110_target(struct cpufreq_policy *policy, unsigned int ppcr)
 
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
