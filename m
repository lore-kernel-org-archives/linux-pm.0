From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: [PATCH RESEND] smp: make wake up idle cpus more generic
Date: Thu, 31 Mar 2016 22:50:19 -0700
Message-ID: <1459489819-20435-1-git-send-email-lianwei.wang@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36662 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbcDAFuf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 01:50:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mingo@kernel.org
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lianwei.wang@gmail.com, kbuild-all@01.org

The wake_up_all_idle_cpus API always wake up all the online
cpus, but sometimes we only want to wake up a set of cpus.

Use a generic function to wake up a group of cpus that is
specified by the cpumask parameter. This generic API can
benefit to the cases that only need to wake up a set of
cpus.

Signed-off-by: Lianwei Wang <lianwei.wang@gmail.com>
---
 drivers/cpuidle/cpuidle.c |  4 ++--
 include/linux/smp.h       |  4 ++--
 kernel/power/suspend.c    |  2 +-
 kernel/smp.c              | 12 +++++++-----
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index f996efc56605..c2a85c89e276 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -301,7 +301,7 @@ void cpuidle_uninstall_idle_handler(void)
 {
 	if (enabled_devices) {
 		initialized = 0;
-		wake_up_all_idle_cpus();
+		wake_up_idle_cpus(cpu_online_mask);
 	}
 
 	/*
@@ -620,7 +620,7 @@ EXPORT_SYMBOL_GPL(cpuidle_register);
 static int cpuidle_latency_notify(struct notifier_block *b,
 		unsigned long l, void *v)
 {
-	wake_up_all_idle_cpus();
+	wake_up_idle_cpus(cpu_online_mask);
 	return NOTIFY_OK;
 }
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index c4414074bd88..ee9d087c4c9a 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -100,7 +100,7 @@ int smp_call_function_any(const struct cpumask *mask,
 			  smp_call_func_t func, void *info, int wait);
 
 void kick_all_cpus_sync(void);
-void wake_up_all_idle_cpus(void);
+void wake_up_idle_cpus(const struct cpumask *mask);
 
 /*
  * Generic and arch helpers
@@ -149,7 +149,7 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
 }
 
 static inline void kick_all_cpus_sync(void) {  }
-static inline void wake_up_all_idle_cpus(void) {  }
+static inline void wake_up_idle_cpus(const struct cpumask *mask) {  }
 
 #ifdef CONFIG_UP_LATE_INIT
 extern void __init up_late_init(void);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 5b70d64b871e..a4176ab96b36 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -70,7 +70,7 @@ static void freeze_enter(void)
 	cpuidle_resume();
 
 	/* Push all the CPUs into the idle loop. */
-	wake_up_all_idle_cpus();
+	wake_up_idle_cpus(cpu_online_mask);
 	pr_debug("PM: suspend-to-idle\n");
 	/* Make the current CPU wait so it can enter the idle loop too. */
 	wait_event(suspend_freeze_wait_head,
diff --git a/kernel/smp.c b/kernel/smp.c
index 74165443c240..c2beecb5ef01 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -720,17 +720,19 @@ void kick_all_cpus_sync(void)
 EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
 
 /**
- * wake_up_all_idle_cpus - break all cpus out of idle
- * wake_up_all_idle_cpus try to break all cpus which is in idle state even
+ * wake_up_idle_cpus - break a set of cpus out of idle
+ * @mask: The set of cpus to break out of idle
+ *
+ * wake_up_idle_cpus try to break a set of cpus which is in idle state even
  * including idle polling cpus, for non-idle cpus, we will do nothing
  * for them.
  */
-void wake_up_all_idle_cpus(void)
+void wake_up_idle_cpus(const struct cpumask *mask)
 {
 	int cpu;
 
 	preempt_disable();
-	for_each_online_cpu(cpu) {
+	for_each_cpu_and(cpu, mask, cpu_online_mask) {
 		if (cpu == smp_processor_id())
 			continue;
 
@@ -738,4 +740,4 @@ void wake_up_all_idle_cpus(void)
 	}
 	preempt_enable();
 }
-EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
+EXPORT_SYMBOL_GPL(wake_up_idle_cpus);
-- 
1.9.1

