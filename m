From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [RFC PATCH 1/2] cpuidle: Add idle enter/exit time stamp for notifying
 current idle state.
Date: Mon, 01 Apr 2013 17:24:16 +0900
Message-ID: <1364804657-16590-2-git-send-email-jonghwa3.lee@samsung.com>
References: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, sw0312.kim@samsung.com, m.szyprowski@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds idle state time stamp to cpuidle device structure to
notify its current idle state. If last enter time is newer than last
exit time, then it means that the core is in idle now.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 drivers/cpuidle/cpuidle.c |    8 ++++----
 include/linux/cpuidle.h   |    4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index eba6929..1e830cc 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -233,18 +233,18 @@ int cpuidle_wrap_enter(struct cpuidle_device *dev,
 				int (*enter)(struct cpuidle_device *dev,
 					struct cpuidle_driver *drv, int index))
 {
-	ktime_t time_start, time_end;
 	s64 diff;
 
-	time_start = ktime_get();
+	dev->last_idle_start = ktime_get();
 
 	index = enter(dev, drv, index);
 
-	time_end = ktime_get();
+	dev->last_idle_end = ktime_get();
 
 	local_irq_enable();
 
-	diff = ktime_to_us(ktime_sub(time_end, time_start));
+	diff = ktime_to_us(ktime_sub(dev->last_idle_end,
+				dev->last_idle_start));
 	if (diff > INT_MAX)
 		diff = INT_MAX;
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 480c14d..d1af05f 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -16,6 +16,7 @@
 #include <linux/kobject.h>
 #include <linux/completion.h>
 #include <linux/hrtimer.h>
+#include <linux/ktime.h>
 
 #define CPUIDLE_STATE_MAX	8
 #define CPUIDLE_NAME_LEN	16
@@ -74,6 +75,9 @@ struct cpuidle_device {
 	struct kobject		kobj;
 	struct completion	kobj_unregister;
 
+	ktime_t			last_idle_start;
+	ktime_t			last_idle_end;
+
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 	int			safe_state_index;
 	cpumask_t		coupled_cpus;
-- 
1.7.9.5

