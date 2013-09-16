From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 02/44] cpufreq: pxa: call cpufreq_frequency_table_get_attr()
Date: Mon, 16 Sep 2013 18:56:04 +0530
Message-ID: <7d0a46b946fb2800f9d4eaa4fc7a65a237a7e44c.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This exposes frequency table of driver to cpufreq core and is required for core
to guess what the index for a target frequency is, when it calls
cpufreq_frequency_table_target(). And so this driver needs to expose it.

Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pxa2xx-cpufreq.c | 13 ++++++++++++-
 drivers/cpufreq/pxa3xx-cpufreq.c | 15 +++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index 8749eaf18..b004cf1 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -453,20 +453,31 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
 		find_freq_tables(&pxa255_freq_table, &pxa255_freqs);
 		pr_info("PXA255 cpufreq using %s frequency table\n",
 			pxa255_turbo_table ? "turbo" : "run");
+
 		cpufreq_frequency_table_cpuinfo(policy, pxa255_freq_table);
+		cpufreq_frequency_table_get_attr(pxa255_freq_table, policy->cpu);
 	}
-	else if (cpu_is_pxa27x())
+	else if (cpu_is_pxa27x()) {
 		cpufreq_frequency_table_cpuinfo(policy, pxa27x_freq_table);
+		cpufreq_frequency_table_get_attr(pxa27x_freq_table, policy->cpu);
+	}
 
 	printk(KERN_INFO "PXA CPU frequency change support initialized\n");
 
 	return 0;
 }
 
+static int pxa_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
 static struct cpufreq_driver pxa_cpufreq_driver = {
 	.verify	= pxa_verify_policy,
 	.target	= pxa_set_target,
 	.init	= pxa_cpufreq_init,
+	.exit	= pxa_cpufreq_exit,
 	.get	= pxa_cpufreq_get,
 	.name	= "PXA2xx",
 };
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index d26306f..cebbed1 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -91,7 +91,7 @@ static int setup_freqs_table(struct cpufreq_policy *policy,
 			     struct pxa3xx_freq_info *freqs, int num)
 {
 	struct cpufreq_frequency_table *table;
-	int i;
+	int i, ret;
 
 	table = kzalloc((num + 1) * sizeof(*table), GFP_KERNEL);
 	if (table == NULL)
@@ -108,7 +108,11 @@ static int setup_freqs_table(struct cpufreq_policy *policy,
 	pxa3xx_freqs_num = num;
 	pxa3xx_freqs_table = table;
 
-	return cpufreq_frequency_table_cpuinfo(policy, table);
+	ret = cpufreq_frequency_table_cpuinfo(policy, table);
+	if (!ret)
+		cpufreq_frequency_table_get_attr(table, policy->cpu);
+
+	return ret;
 }
 
 static void __update_core_freq(struct pxa3xx_freq_info *info)
@@ -229,10 +233,17 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int pxa3xx_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
 static struct cpufreq_driver pxa3xx_cpufreq_driver = {
 	.verify		= pxa3xx_cpufreq_verify,
 	.target		= pxa3xx_cpufreq_set,
 	.init		= pxa3xx_cpufreq_init,
+	.exit		= pxa3xx_cpufreq_exit,
 	.get		= pxa3xx_cpufreq_get,
 	.name		= "pxa3xx-cpufreq",
 };
-- 
1.7.12.rc2.18.g61b472e

