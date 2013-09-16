From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 27/44] cpufreq: pxa: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:29 +0530
Message-ID: <c7c2276a74c370f5bf0e5112a3c98e17984f3136.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:55383 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab3IPN3X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:29:23 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so4069233pbc.30
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:29:22 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pxa2xx-cpufreq.c | 6 ++----
 drivers/cpufreq/pxa3xx-cpufreq.c | 8 ++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index b004cf1..236531a 100644
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
index cebbed1..65fd01e 100644
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

