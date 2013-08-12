From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/31] cpufreq: dbx500: Covert to light weight ->target() routine
Date: Mon, 12 Aug 2013 23:18:45 +0530
Message-ID: <e0c5392750876a08efea5db45eb13ece144fab55.1376329128.git.viresh.kumar@linaro.org>
References: <cover.1376329128.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34464 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab3HLRuh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2013 13:50:37 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so7849118pab.15
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2013 10:50:37 -0700 (PDT)
In-Reply-To: <cover.1376329128.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376329128.git.viresh.kumar@linaro.org>
References: <cover.1376329128.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

This patch converts existing .target_old() to newly defined light weight
.target() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index bae4fe9..1943a03 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -20,23 +20,13 @@ static struct cpufreq_frequency_table *freq_table;
 static struct clk *armss_clk;
 
 static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
-				unsigned int target_freq,
-				unsigned int relation)
+				unsigned int index)
 {
 	struct cpufreq_freqs freqs;
-	unsigned int idx;
 	int ret;
 
-	/* Lookup the next frequency */
-	if (cpufreq_frequency_table_target(policy, freq_table, target_freq,
-					relation, &idx))
-		return -EINVAL;
-
 	freqs.old = policy->cur;
-	freqs.new = freq_table[idx].frequency;
-
-	if (freqs.old == freqs.new)
-		return 0;
+	freqs.new = freq_table[index].frequency;
 
 	/* pre-change notification */
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
@@ -104,7 +94,7 @@ static int dbx500_cpufreq_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver dbx500_cpufreq_driver = {
 	.flags  = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS,
 	.verify = cpufreq_generic_frequency_table_verify,
-	.target_old = dbx500_cpufreq_target,
+	.target = dbx500_cpufreq_target,
 	.get    = dbx500_cpufreq_getspeed,
 	.init   = dbx500_cpufreq_init,
 	.name   = "DBX500",
-- 
1.7.12.rc2.18.g61b472e

