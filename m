From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 27/35] cpufreq: pxa: use cpufreq_table_validate_and_show()
Date: Thu,  8 Aug 2013 19:18:29 +0530
Message-ID: <abd1fc91a2709d8ad7879163b8f96f1d5be47057.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Eric Miao <eric.y.miao@gmail.com>
List-Id: linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pxa2xx-cpufreq.c | 6 ++----
 drivers/cpufreq/pxa3xx-cpufreq.c | 8 ++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index c7ea005..a429d7c 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -454,12 +454,10 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
 		pr_info("PXA255 cpufreq using %s frequency table\n",
 			pxa255_turbo_table ? "turbo" : "run");
 
-		cpufreq_frequency_table_cpuinfo(policy, pxa255_freq_table);
-		cpufreq_frequency_table_get_attr(pxa255_freq_table, policy->cpu);
+		cpufreq_table_validate_and_show(policy, pxa255_freq_table);
 	}
 	else if (cpu_is_pxa27x()) {
-		cpufreq_frequency_table_cpuinfo(policy, pxa27x_freq_table);
-		cpufreq_frequency_table_get_attr(pxa27x_freq_table, policy->cpu);
+		cpufreq_table_validate_and_show(policy, pxa27x_freq_table);
 	}
 
 	printk(KERN_INFO "PXA CPU frequency change support initialized\n");
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index f53f28d6..89841f5 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -91,7 +91,7 @@ static int setup_freqs_table(struct cpufreq_policy *policy,
 			     struct pxa3xx_freq_info *freqs, int num)
 {
 	struct cpufreq_frequency_table *table;
-	int i, ret;
+	int i;
 
 	table = kzalloc((num + 1) * sizeof(*table), GFP_KERNEL);
 	if (table == NULL)
@@ -108,11 +108,7 @@ static int setup_freqs_table(struct cpufreq_policy *policy,
 	pxa3xx_freqs_num = num;
 	pxa3xx_freqs_table = table;
 
-	ret = cpufreq_frequency_table_cpuinfo(policy, table);
-	if (!ret)
-		cpufreq_frequency_table_get_attr(table, policy->cpu);
-
-	return ret;
+	return cpufreq_table_validate_and_show(policy, table);
 }
 
 static void __update_core_freq(struct pxa3xx_freq_info *info)
-- 
1.7.12.rc2.18.g61b472e
