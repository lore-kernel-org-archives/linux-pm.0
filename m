From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 06/14] cpufreq: Remove (now) unused 'last_cpu' from struct cpufreq_policy
Date: Fri,  2 Jan 2015 11:16:43 +0530
Message-ID: <40ee1c730bd00fd8159bf61ce16a807d000e257b.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:49310 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbABFrY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 00:47:24 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so23134514pde.15
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 21:47:24 -0800 (PST)
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

'last_cpu' was used only from cpufreq-stats and isn't used anymore. Get rid of
it.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 ---
 include/linux/cpufreq.h   | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a09a29c312a9..b88894578fd1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1091,10 +1091,7 @@ static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
 	}
 
 	down_write(&policy->rwsem);
-
-	policy->last_cpu = policy->cpu;
 	policy->cpu = cpu;
-
 	up_write(&policy->rwsem);
 
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 3cb097b86d20..2d99f12e4199 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -66,8 +66,6 @@ struct cpufreq_policy {
 	unsigned int		shared_type; /* ACPI: ANY or ALL affected CPUs
 						should set cpufreq */
 	unsigned int		cpu;    /* cpu nr of CPU managing this policy */
-	unsigned int		last_cpu; /* cpu nr of previous CPU that managed
-					   * this policy */
 	struct clk		*clk;
 	struct cpufreq_cpuinfo	cpuinfo;/* see above */
 
-- 
2.2.0

