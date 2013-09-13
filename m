From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 014/228] cpufreq: arm_big_little: use cpufreq_table_validate_and_show()
Date: Fri, 13 Sep 2013 18:29:20 +0530
Message-ID: <d134bc34c0dba1eb624efd760ab96f11f798a1d9.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 768aa9c..8cb6dbc 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -165,7 +165,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	if (ret)
 		return ret;
 
-	ret = cpufreq_frequency_table_cpuinfo(policy, freq_table[cur_cluster]);
+	ret = cpufreq_table_validate_and_show(policy, freq_table[cur_cluster]);
 	if (ret) {
 		dev_err(cpu_dev, "CPU %d, cluster: %d invalid freq table\n",
 				policy->cpu, cur_cluster);
@@ -173,8 +173,6 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	cpufreq_frequency_table_get_attr(freq_table[cur_cluster], policy->cpu);
-
 	if (arm_bL_ops->get_transition_latency)
 		policy->cpuinfo.transition_latency =
 			arm_bL_ops->get_transition_latency(cpu_dev);
-- 
1.7.12.rc2.18.g61b472e
