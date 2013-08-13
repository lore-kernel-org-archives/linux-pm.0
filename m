From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] cpufreq: sa11x0: let cpufreq core initialize struct policy fields
Date: Tue, 13 Aug 2013 19:01:06 +0530
Message-ID: <9c509bf4efcc6c6f1c5fafcc1f62004f6a745554.1376392060.git.viresh.kumar@linaro.org>
References: <cover.1376392060.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376392060.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376392060.git.viresh.kumar@linaro.org>
References: <cover.1376392060.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Many fields of struct policy are filled by cpufreq core when we call
cpufreq_table_validate_and_show() and so cpufreq driver doesn't need to set them
anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sa1100-cpufreq.c | 4 +---
 drivers/cpufreq/sa1110-cpufreq.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/sa1100-cpufreq.c b/drivers/cpufreq/sa1100-cpufreq.c
index 1323a69..235500c 100644
--- a/drivers/cpufreq/sa1100-cpufreq.c
+++ b/drivers/cpufreq/sa1100-cpufreq.c
@@ -220,9 +220,7 @@ static int __init sa1100_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -EINVAL;
-	policy->cur = policy->min = policy->max = sa11x0_getspeed(0);
-	policy->cpuinfo.min_freq = 59000;
-	policy->cpuinfo.max_freq = 287000;
+	policy->cur = a11x0_getspeed(0);
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	return cpufreq_table_validate_and_show(policy, sa11x0_freq_table);
diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index adb0524..13760fc 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -334,9 +334,7 @@ static int __init sa1110_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -EINVAL;
-	policy->cur = policy->min = policy->max = sa11x0_getspeed(0);
-	policy->cpuinfo.min_freq = 59000;
-	policy->cpuinfo.max_freq = 287000;
+	policy->cur = sa11x0_getspeed(0);
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	return cpufreq_table_validate_and_show(policy, sa11x0_freq_table);
-- 
1.7.12.rc2.18.g61b472e
