From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 26/44] cpufreq: ppc: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:28 +0530
Message-ID: <b086a0c800c3bbd9b8945ac4fb6224847b0c0eab.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:58644 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab3IPN3S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:29:18 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so4137359pdj.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:29:17 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c | 3 +--
 drivers/cpufreq/ppc_cbe_cpufreq.c     | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 60e81d5..5716b44 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -202,7 +202,7 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	table[i].frequency = CPUFREQ_TABLE_END;
 
 	/* set the min and max frequency properly */
-	ret = cpufreq_frequency_table_cpuinfo(policy, table);
+	ret = cpufreq_table_validate_and_show(policy, table);
 	if (ret) {
 		pr_err("invalid frequency table: %d\n", ret);
 		goto err_nomem1;
@@ -219,7 +219,6 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	policy->cur = corenet_cpufreq_get_speed(policy->cpu);
 
-	cpufreq_frequency_table_get_attr(table, cpu);
 	of_node_put(np);
 
 	return 0;
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index 2e448f0..6c5be63 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -123,11 +123,9 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	cpumask_copy(policy->cpus, cpu_sibling_mask(policy->cpu));
 #endif
 
-	cpufreq_frequency_table_get_attr(cbe_freqs, policy->cpu);
-
 	/* this ensures that policy->cpuinfo_min
 	 * and policy->cpuinfo_max are set correctly */
-	return cpufreq_frequency_table_cpuinfo(policy, cbe_freqs);
+	return cpufreq_table_validate_and_show(policy, cbe_freqs);
 }
 
 static int cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
-- 
1.7.12.rc2.18.g61b472e

