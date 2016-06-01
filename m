From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] sched, cpuidle: Do not access cpuidle_devices when !CONFIG_CPU_IDLE
Date: Wed,  1 Jun 2016 18:52:16 +0100
Message-ID: <1464803536-19929-1-git-send-email-catalin.marinas@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39330 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbcFARwX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Jun 2016 13:52:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>

The cpuidle_devices per-CPU variable is only defined when CPU_IDLE is
enabled. Commit c8cc7d4de7a4 ("sched/idle: Reorganize the idle loop")
removed the #ifdef CONFIG_CPU_IDLE around cpuidle_idle_call() with the
compiler optimising away __this_cpu_read(cpuidle_devices). However, with
CONFIG_UBSAN && !CONFIG_CPU_IDLE, this optimisation no longer happens
and the kernel fails to link since cpuidle_devices is not defined.

This patch introduces an accessor function for the current CPU cpuidle
device (returning NULL when !CONFIG_CPU_IDLE) and uses it in
cpuidle_idle_call().

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

This fixes a build failure on arm64 with UBSAN && !CPU_IDLE and gcc
5.3.1 (probably other compiler versions would behave in the same way).

I tried to keep close to the existing coding style in cpuidle.h.

 include/linux/cpuidle.h | 3 +++
 kernel/sched/idle.c     | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 786ad32631a6..07b83d32f66c 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -152,6 +152,8 @@ extern void cpuidle_disable_device(struct cpuidle_device *dev);
 extern int cpuidle_play_dead(void);
 
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
+static inline struct cpuidle_device *cpuidle_get_device(void)
+{return __this_cpu_read(cpuidle_devices); }
 #else
 static inline void disable_cpuidle(void) { }
 static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
@@ -187,6 +189,7 @@ static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
 static inline int cpuidle_play_dead(void) {return -ENODEV; }
 static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
 	struct cpuidle_device *dev) {return NULL; }
+static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
 #endif
 
 #if defined(CONFIG_CPU_IDLE) && defined(CONFIG_SUSPEND)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index bd12c6c714ec..c5aeedf4e93a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -127,7 +127,7 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
  */
 static void cpuidle_idle_call(void)
 {
-	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
+	struct cpuidle_device *dev = cpuidle_get_device();
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int next_state, entered_state;
 
