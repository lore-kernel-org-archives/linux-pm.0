From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 061/228] cpufreq: cris: Use generic cpufreq routines
Date: Fri, 13 Sep 2013 18:30:07 +0530
Message-ID: <d5f36a652c8fed4bb90bb711f520c964131a0d61.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62800 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073Ab3IMNKQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:10:16 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1214426pbb.5
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:10:16 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel@axis.com

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: linux-cris-kernel@axis.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cris-artpec3-cpufreq.c | 23 +++--------------------
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 22 +++-------------------
 2 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
index 444fd96..d26f4e4 100644
--- a/drivers/cpufreq/cris-artpec3-cpufreq.c
+++ b/drivers/cpufreq/cris-artpec3-cpufreq.c
@@ -54,11 +54,6 @@ static void cris_freq_set_cpu_state(struct cpufreq_policy *policy,
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 };
 
-static int cris_freq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, &cris_freq_table[0]);
-}
-
 static int cris_freq_target(struct cpufreq_policy *policy,
 			    unsigned int target_freq,
 			    unsigned int relation)
@@ -84,26 +79,14 @@ static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 }
 
 
-static int cris_freq_cpu_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-
-static struct freq_attr *cris_freq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver cris_freq_driver = {
 	.get	= cris_freq_get_cpu_frequency,
-	.verify	= cris_freq_verify,
+	.verify	= cpufreq_generic_frequency_table_verify,
 	.target	= cris_freq_target,
 	.init	= cris_freq_cpu_init,
-	.exit	= cris_freq_cpu_exit,
+	.exit	= cpufreq_generic_exit,
 	.name	= "cris_freq",
-	.attr	= cris_freq_attr,
+	.attr	= cpufreq_generic_attr,
 };
 
 static int __init cris_freq_init(void)
diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
index 428395e..d384e63 100644
--- a/drivers/cpufreq/cris-etraxfs-cpufreq.c
+++ b/drivers/cpufreq/cris-etraxfs-cpufreq.c
@@ -54,11 +54,6 @@ static void cris_freq_set_cpu_state(struct cpufreq_policy *policy,
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 };
 
-static int cris_freq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, &cris_freq_table[0]);
-}
-
 static int cris_freq_target(struct cpufreq_policy *policy,
 			    unsigned int target_freq, unsigned int relation)
 {
@@ -82,25 +77,14 @@ static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_table_validate_and_show(policy, cris_freq_table);
 }
 
-static int cris_freq_cpu_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-static struct freq_attr *cris_freq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver cris_freq_driver = {
 	.get = cris_freq_get_cpu_frequency,
-	.verify = cris_freq_verify,
+	.verify = cpufreq_generic_frequency_table_verify,
 	.target = cris_freq_target,
 	.init = cris_freq_cpu_init,
-	.exit = cris_freq_cpu_exit,
+	.exit = cpufreq_generic_exit,
 	.name = "cris_freq",
-	.attr = cris_freq_attr,
+	.attr = cpufreq_generic_attr,
 };
 
 static int __init cris_freq_init(void)
-- 
1.7.12.rc2.18.g61b472e

