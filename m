From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 024/228] cpufreq: imx6q: use cpufreq_table_validate_and_show()
Date: Fri, 13 Sep 2013 18:29:30 +0530
Message-ID: <96dc59aaf8ee2057813782806a8a0c2b0d9b3770.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 3e39654..cd9489f 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -160,7 +160,7 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	ret = cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	ret = cpufreq_table_validate_and_show(policy, freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "invalid frequency table: %d\n", ret);
 		return ret;
@@ -169,7 +169,6 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = transition_latency;
 	policy->cur = clk_get_rate(arm_clk) / 1000;
 	cpumask_setall(policy->cpus);
-	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e
