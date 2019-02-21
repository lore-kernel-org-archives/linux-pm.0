From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: Add a predict callback for the governors
Date: Thu, 21 Feb 2019 15:56:31 +0100
Message-ID: <20190221145631.26356-1-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Predicting the next event on the current CPU is implemented in the
idle state selection function, thus the selection logic and the
prediction are tied together and it is hard to decorrelate both.

The following change introduces the cpuidle function to give the
opportunity to the governor to store the guess estimate of the
different source of wakeup and then reuse them in the selection
process. Consequently we end up with two separate operations clearly
identified.

As the next events are stored in the cpuidle device structure it is
easy to propagate them in the different governor callbacks.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 16 ++++++++++++++++
 include/linux/cpuidle.h   | 16 +++++++++++++++-
 kernel/sched/idle.c       |  5 +++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7f108309e871..fc6976bd702b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -296,6 +296,22 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	return entered_state;
 }
 
+/**
+ * cpuidle_predict - guess estimate the next events on the current CPU
+ *
+ * @drv: the cpuidle driver
+ * @dev: the cpuidle device
+ *
+ * Returns 0 on success, < 0 in case of error. The error code depends on
+ * the governor.
+ */
+int cpuidle_predict(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+{
+	if (cpuidle_curr_governor->predict)
+		return cpuidle_curr_governor->predict(drv, dev);
+	return 0;
+}
+
 /**
  * cpuidle_select - ask the cpuidle framework to choose an idle state
  *
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3b39472324a3..8aba8b0a952d 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -77,6 +77,13 @@ struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
 struct cpuidle_driver_kobj;
 
+struct cpuidle_predict {
+	ktime_t next_hrtimer;
+	ktime_t next_timer;
+	ktime_t next_irq;
+	ktime_t next_resched;
+};
+
 struct cpuidle_device {
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
@@ -89,6 +96,7 @@ struct cpuidle_device {
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 	struct cpuidle_driver_kobj *kobj_driver;
 	struct cpuidle_device_kobj *kobj_dev;
+	struct cpuidle_predict predict;
 	struct list_head 	device_list;
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
@@ -124,7 +132,8 @@ struct cpuidle_driver {
 extern void disable_cpuidle(void);
 extern bool cpuidle_not_available(struct cpuidle_driver *drv,
 				  struct cpuidle_device *dev);
-
+extern int cpuidle_predict(struct cpuidle_driver *drv,
+			   struct cpuidle_device *dev);
 extern int cpuidle_select(struct cpuidle_driver *drv,
 			  struct cpuidle_device *dev,
 			  bool *stop_tick);
@@ -158,6 +167,9 @@ static inline void disable_cpuidle(void) { }
 static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
 					 struct cpuidle_device *dev)
 {return true; }
+static inline int cpuidle_predict(struct cpuidle_driver *drv,
+				  struct cpuidle_device *dev)
+{return 0; }
 static inline int cpuidle_select(struct cpuidle_driver *drv,
 				 struct cpuidle_device *dev, bool *stop_tick)
 {return -ENODEV; }
@@ -241,6 +253,8 @@ struct cpuidle_governor {
 	void (*disable)		(struct cpuidle_driver *drv,
 					struct cpuidle_device *dev);
 
+	int  (*predict)		(struct cpuidle_driver *drv,
+ 					struct cpuidle_device *dev);
 	int  (*select)		(struct cpuidle_driver *drv,
 					struct cpuidle_device *dev,
 					bool *stop_tick);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f5516bae0c1b..e0e9a81cfec3 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -185,6 +185,11 @@ static void cpuidle_idle_call(void)
 	} else {
 		bool stop_tick = true;
 
+		/*
+		 * Guess estimate the next events on the current CPU
+		 */
+		cpuidle_predict(drv, dev);
+
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
-- 
2.17.1
