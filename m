From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 17/92] cpufreq: loongson2: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:11 +0530
Message-ID: <8a7319649e8e366b6f96a772cb58f7adb8c8ca7d.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40150 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371Ab3JCPB2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:01:28 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so2723020pab.26
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:01:28 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, John Crispin <blogic@openwrt.org>

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: John Crispin <blogic@openwrt.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/loongson2_cpufreq.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index cec4e72..ed7fbe2 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -137,12 +137,6 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 					    &loongson2_clockmod_table[0]);
 }
 
-static int loongson2_cpufreq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy,
-					      &loongson2_clockmod_table[0]);
-}
-
 static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	cpufreq_frequency_table_put_attr(policy->cpu);
@@ -150,19 +144,14 @@ static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static struct freq_attr *loongson2_table_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver loongson2_cpufreq_driver = {
 	.name = "loongson2",
 	.init = loongson2_cpufreq_cpu_init,
-	.verify = loongson2_cpufreq_verify,
+	.verify = cpufreq_generic_frequency_table_verify,
 	.target = loongson2_cpufreq_target,
 	.get = loongson2_cpufreq_get,
 	.exit = loongson2_cpufreq_exit,
-	.attr = loongson2_table_attr,
+	.attr = cpufreq_generic_attr,
 };
 
 static struct platform_device_id platform_device_ids[] = {
-- 
1.7.12.rc2.18.g61b472e

