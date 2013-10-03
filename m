From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 08/92] cpufreq: davinci: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:02 +0530
Message-ID: <6a6959a87d1acdde8fec05aa1d41f0875852acbf.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:45622 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab3JCPAZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:00:25 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so2579148pdj.6
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:00:25 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Sekhar Nori <nsekhar@ti.com>

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index f67196e..33e9460 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -157,26 +157,15 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int davinci_cpu_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-static struct freq_attr *davinci_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver davinci_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= davinci_verify_speed,
 	.target		= davinci_target,
 	.get		= davinci_getspeed,
 	.init		= davinci_cpu_init,
-	.exit		= davinci_cpu_exit,
+	.exit		= cpufreq_generic_exit,
 	.name		= "davinci",
-	.attr		= davinci_cpufreq_attr,
+	.attr		= cpufreq_generic_attr,
 };
 
 static int __init davinci_cpufreq_probe(struct platform_device *pdev)
-- 
1.7.12.rc2.18.g61b472e

