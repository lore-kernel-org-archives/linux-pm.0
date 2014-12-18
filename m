From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/13] cpufreq: remove CPUFREQ_UPDATE_POLICY_CPU notifications
Date: Thu, 18 Dec 2014 17:30:25 +0530
Message-ID: <349dfaedd56ecf36976707ee057229ee338f4123.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38351 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaLRMBe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:34 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so1281833pab.32
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:34 -0800 (PST)
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

CPUFREQ_UPDATE_POLICY_CPU notifications were used only from cpufreq-stats which
doesn't use it anymore. Remove them.

This also fixes the value of other notification macros, hopefully all users are
using macro's instead of direct values and nothing will break :)

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 ---
 include/linux/cpufreq.h   | 5 ++---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b88894578fd1..6d97dffeaaf7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1094,9 +1094,6 @@ static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
 	policy->cpu = cpu;
 	up_write(&policy->rwsem);
 
-	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-			CPUFREQ_UPDATE_POLICY_CPU, policy);
-
 	return 0;
 }
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 2d99f12e4199..43013eac26fd 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -368,9 +368,8 @@ static inline void cpufreq_resume(void) {}
 #define CPUFREQ_INCOMPATIBLE		(1)
 #define CPUFREQ_NOTIFY			(2)
 #define CPUFREQ_START			(3)
-#define CPUFREQ_UPDATE_POLICY_CPU	(4)
-#define CPUFREQ_CREATE_POLICY		(5)
-#define CPUFREQ_REMOVE_POLICY		(6)
+#define CPUFREQ_CREATE_POLICY		(4)
+#define CPUFREQ_REMOVE_POLICY		(5)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
-- 
2.2.0

