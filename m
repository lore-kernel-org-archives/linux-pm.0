From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 11/16] cpufreq: remove CPUFREQ_UPDATE_POLICY_CPU notifications
Date: Tue,  6 Jan 2015 21:09:10 +0530
Message-ID: <0eabc86c71bd22bea10ea2565329b4e550cf1aff.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35243 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbbAFPkK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:40:10 -0500
Received: by mail-pd0-f174.google.com with SMTP id fp1so30432997pdb.5
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:40:09 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

CPUFREQ_UPDATE_POLICY_CPU notifications were used only from cpufreq-stats which
doesn't use it anymore. Remove them.

This also decrements values of other notification macros defined after
CPUFREQ_UPDATE_POLICY_CPU by 1 to remove gaps. Hopefully all users are using
macro's instead of direct numbers and so they wouldn't break as macro values are
changed now.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
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
index 7e1a389b4e92..2ee4888c1f47 100644
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

