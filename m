From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 164/228] cpufreq: maple: Convert to light weight ->target_index() routine
Date: Fri, 13 Sep 2013 18:31:50 +0530
Message-ID: <9bd91be388c26d887c6e5ba7974d77602a72cead.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:57812 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170Ab3IMNWW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:22:22 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so1242653pdj.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:22:22 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

This patch converts existing .target() to newly defined light weight
.target_index() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/maple-cpufreq.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index eb1e176..4e2da08 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -131,26 +131,18 @@ static int maple_scom_query_freq(void)
  */
 
 static int maple_cpufreq_target(struct cpufreq_policy *policy,
-	unsigned int target_freq, unsigned int relation)
+	unsigned int index)
 {
-	unsigned int newstate = 0;
 	struct cpufreq_freqs freqs;
 	int rc;
 
-	if (cpufreq_frequency_table_target(policy, maple_cpu_freqs,
-			target_freq, relation, &newstate))
-		return -EINVAL;
-
-	if (maple_pmode_cur == newstate)
-		return 0;
-
 	mutex_lock(&maple_switch_mutex);
 
 	freqs.old = maple_cpu_freqs[maple_pmode_cur].frequency;
-	freqs.new = maple_cpu_freqs[newstate].frequency;
+	freqs.new = maple_cpu_freqs[index].frequency;
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-	rc = maple_scom_switch_freq(newstate);
+	rc = maple_scom_switch_freq(index);
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	mutex_unlock(&maple_switch_mutex);
@@ -173,7 +165,7 @@ static struct cpufreq_driver maple_cpufreq_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.init		= maple_cpufreq_cpu_init,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= maple_cpufreq_target,
+	.target_index	= maple_cpufreq_target,
 	.get		= maple_cpufreq_get_speed,
 	.attr		= cpufreq_generic_attr,
 };
-- 
1.7.12.rc2.18.g61b472e

