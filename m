From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH v2 1/2] cpuidle: Add new macro to enter a retention idle state
Date: Wed,  8 Nov 2017 17:38:41 -0700
Message-ID: <1510187922-8218-2-git-send-email-pprakash@codeaurora.org>
References: <1510187922-8218-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40286 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbdKIAiz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2017 19:38:55 -0500
In-Reply-To: <1510187922-8218-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org, will.deacon@arm.com, catalin.marinas@arm.com, Prashanth Prakash <pprakash@codeaurora.org>

If a CPU is entering a low power idle state where it doesn't lose any
context, then there is no need to call cpu_pm_enter()/cpu_pm_exit().
Add a new macro(CPU_PM_CPU_IDLE_ENTER_RETENTION) to be used by cpuidle
drivers when they are entering retention state. By not calling
cpu_pm_enter and cpu_pm_exit we reduce the latency involved in
entering and exiting the retention idle states.

On ARM64 based Qualcomm Server Platform we measured below overhead for
for calling cpu_pm_enter and cpu_pm_exit for retention states.

workload: stress --hdd #CPUs --hdd-bytes 32M  -t 30
        Average overhead of cpu_pm_enter - 1.2us
        Average overhead of cpu_pm_exit  - 3.1us

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 include/linux/cpuidle.h | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 8f7788d..871f9e2 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -257,22 +257,30 @@ static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
 {return 0;}
 #endif
 
-#define CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx)	\
-({								\
-	int __ret;						\
-								\
-	if (!idx) {						\
-		cpu_do_idle();					\
-		return idx;					\
-	}							\
-								\
-	__ret = cpu_pm_enter();					\
-	if (!__ret) {						\
-		__ret = low_level_idle_enter(idx);		\
-		cpu_pm_exit();					\
-	}							\
-								\
-	__ret ? -1 : idx;					\
+#define __CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, is_retention) \
+({									\
+	int __ret = 0;							\
+									\
+	if (!idx) {							\
+		cpu_do_idle();						\
+		return idx;						\
+	}								\
+									\
+	if (!is_retention)						\
+		__ret =  cpu_pm_enter();				\
+	if (!__ret) {							\
+		__ret = low_level_idle_enter(idx);			\
+		if (!is_retention)					\
+			cpu_pm_exit();					\
+	}								\
+									\
+	__ret ? -1 : idx;						\
 })
 
+#define CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx)	\
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, 0)
+
+#define CPU_PM_CPU_IDLE_ENTER_RETENTION(low_level_idle_enter, idx)	\
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, 1)
+
 #endif /* _LINUX_CPUIDLE_H */
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
