From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 04/44] cpufreq: sparc: call cpufreq_frequency_table_get_attr()
Date: Mon, 16 Sep 2013 18:56:06 +0530
Message-ID: <4e98887bdfcf31caede9c185ec57e436882f2062.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:38202 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab3IPN1P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:27:15 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so5332554pab.24
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:27:15 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

This exposes frequency table of driver to cpufreq core and is required for core
to guess what the index for a target frequency is, when it calls
cpufreq_frequency_table_target(). And so this driver needs to expose it.

Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sparc-us2e-cpufreq.c | 10 ++++++++--
 drivers/cpufreq/sparc-us3-cpufreq.c  | 11 +++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index cf5bc2c..63b3eae 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -307,6 +307,7 @@ static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
 	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
 	struct cpufreq_frequency_table *table =
 		&us2e_freq_table[cpu].table[0];
+	int ret;
 
 	table[0].driver_data = 0;
 	table[0].frequency = clock_tick / 1;
@@ -324,13 +325,18 @@ static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 0;
 	policy->cur = clock_tick;
 
-	return cpufreq_frequency_table_cpuinfo(policy, table);
+	ret = cpufreq_frequency_table_cpuinfo(policy, table);
+	if (!ret)
+		cpufreq_frequency_table_get_attr(table, policy->cpu);
+	return ret;
 }
 
 static int us2e_freq_cpu_exit(struct cpufreq_policy *policy)
 {
-	if (cpufreq_us2e_driver)
+	if (cpufreq_us2e_driver) {
+		cpufreq_frequency_table_put_attr(policy->cpu);
 		us2e_set_cpu_divider_index(policy, 0);
+	}
 
 	return 0;
 }
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index ac76b48..985bc56 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -168,6 +168,7 @@ static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
 	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
 	struct cpufreq_frequency_table *table =
 		&us3_freq_table[cpu].table[0];
+	int ret;
 
 	table[0].driver_data = 0;
 	table[0].frequency = clock_tick / 1;
@@ -181,13 +182,19 @@ static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 0;
 	policy->cur = clock_tick;
 
-	return cpufreq_frequency_table_cpuinfo(policy, table);
+	ret = cpufreq_frequency_table_cpuinfo(policy, table);
+	if (!ret)
+		cpufreq_frequency_table_get_attr(table, policy->cpu);
+
+	return ret;
 }
 
 static int us3_freq_cpu_exit(struct cpufreq_policy *policy)
 {
-	if (cpufreq_us3_driver)
+	if (cpufreq_us3_driver) {
+		cpufreq_frequency_table_put_attr(policy->cpu);
 		us3_set_cpu_divider_index(policy, 0);
+	}
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e

