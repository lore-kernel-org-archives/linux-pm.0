From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 120/228] cpufreq: sa11x0: don't initialize part of policy that is set by core too
Date: Fri, 13 Sep 2013 18:31:06 +0530
Message-ID: <8e8853f66fadd4816a5d0fc5284c0c1b6a7816ba.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:61938 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933374Ab3IMNRO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:17:14 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so1240898pdj.15
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:17:14 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sa1100-cpufreq.c | 1 -
 drivers/cpufreq/sa1110-cpufreq.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/sa1100-cpufreq.c b/drivers/cpufreq/sa1100-cpufreq.c
index 80a4fde..a1d1bb7 100644
--- a/drivers/cpufreq/sa1100-cpufreq.c
+++ b/drivers/cpufreq/sa1100-cpufreq.c
@@ -220,7 +220,6 @@ static int __init sa1100_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -EINVAL;
-	policy->cur = sa11x0_getspeed(0);
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	return cpufreq_table_validate_and_show(policy, sa11x0_freq_table);
diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index a38d904..9da940e 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -334,7 +334,6 @@ static int __init sa1110_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -EINVAL;
-	policy->cur = sa11x0_getspeed(0);
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	return cpufreq_table_validate_and_show(policy, sa11x0_freq_table);
-- 
1.7.12.rc2.18.g61b472e

