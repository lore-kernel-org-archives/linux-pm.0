From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/13] cpufreq: Remove (now) unused 'last_cpu' from struct cpufreq_policy
Date: Thu, 18 Dec 2014 17:30:23 +0530
Message-ID: <82b5546aafebb43a3b87ec86a6dcf4c8d75d6e2b.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:46995 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbaLRMBZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:25 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so1315189pdi.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:25 -0800 (PST)
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

'last_cpu' was used only from cpufreq-stats and isn't used anymore. Get rid of
it.

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

