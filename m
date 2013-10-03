From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 11/92] cpufreq: elanfreq: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:05 +0530
Message-ID: <20cbb7c70b1768eabec111b0687b58ecead9718f.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:58443 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab3JCPAz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:00:55 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so2589236pdj.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:00:55 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/elanfreq.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 4000c34..fe7053c 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -165,19 +165,6 @@ static void elanfreq_set_cpu_state(struct cpufreq_policy *policy,
 };
 
 
-/**
- *	elanfreq_validatespeed: test if frequency range is valid
- *	@policy: the policy to validate
- *
- *	This function checks if a given frequency range in kHz is valid
- *	for the hardware supported by the driver.
- */
-
-static int elanfreq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, &elanfreq_table[0]);
-}
-
 static int elanfreq_target(struct cpufreq_policy *policy,
 			    unsigned int target_freq,
 			    unsigned int relation)
@@ -226,13 +213,6 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
 }
 
 
-static int elanfreq_cpu_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-
 #ifndef MODULE
 /**
  * elanfreq_setup - elanfreq command line parameter parsing
@@ -255,20 +235,14 @@ __setup("elanfreq=", elanfreq_setup);
 #endif
 
 
-static struct freq_attr *elanfreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
-
 static struct cpufreq_driver elanfreq_driver = {
 	.get		= elanfreq_get_cpu_frequency,
-	.verify		= elanfreq_verify,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= elanfreq_target,
 	.init		= elanfreq_cpu_init,
-	.exit		= elanfreq_cpu_exit,
+	.exit		= cpufreq_generic_exit,
 	.name		= "elanfreq",
-	.attr		= elanfreq_attr,
+	.attr		= cpufreq_generic_attr,
 };
 
 static const struct x86_cpu_id elan_id[] = {
-- 
1.7.12.rc2.18.g61b472e

