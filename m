From: Xunlei Pang <xlpang@126.com>
Subject: [PATCH v2 2/3] cpuidle/coupled: Remove redundant 'dev' argument of cpuidle_state_is_coupled()
Date: Tue,  4 Aug 2015 13:48:56 +0800
Message-ID: <1438667337-16903-2-git-send-email-xlpang@126.com>
References: <1438667337-16903-1-git-send-email-xlpang@126.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438667337-16903-1-git-send-email-xlpang@126.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Xunlei Pang <pang.xunlei@linaro.org>

For cpuidle_state_is_coupled(), 'dev' is not used, so remove it.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/cpuidle/coupled.c | 4 +---
 drivers/cpuidle/cpuidle.c | 4 ++--
 drivers/cpuidle/cpuidle.h | 7 +++----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 6493e40..1523e2d 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -176,14 +176,12 @@ void cpuidle_coupled_parallel_barrier(struct cpuidle_device *dev, atomic_t *a)
 
 /**
  * cpuidle_state_is_coupled - check if a state is part of a coupled set
- * @dev: struct cpuidle_device for the current cpu
  * @drv: struct cpuidle_driver for the platform
  * @state: index of the target state in drv->states
  *
  * Returns true if the target state is coupled with cpus besides this one
  */
-bool cpuidle_state_is_coupled(struct cpuidle_device *dev,
-	struct cpuidle_driver *drv, int state)
+bool cpuidle_state_is_coupled(struct cpuidle_driver *drv, int state)
 {
 	return drv->states[state].flags & CPUIDLE_FLAG_COUPLED;
 }
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 3325393..17a6dc0 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -214,7 +214,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 		tick_broadcast_exit();
 	}
 
-	if (!cpuidle_state_is_coupled(dev, drv, entered_state))
+	if (!cpuidle_state_is_coupled(drv, entered_state))
 		local_irq_enable();
 
 	diff = ktime_to_us(ktime_sub(time_end, time_start));
@@ -263,7 +263,7 @@ int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 int cpuidle_enter(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		  int index)
 {
-	if (cpuidle_state_is_coupled(dev, drv, index))
+	if (cpuidle_state_is_coupled(drv, index))
 		return cpuidle_enter_state_coupled(dev, drv, index);
 	return cpuidle_enter_state(dev, drv, index);
 }
diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
index ee97e96..178c5ad 100644
--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -34,15 +34,14 @@ extern int cpuidle_add_sysfs(struct cpuidle_device *dev);
 extern void cpuidle_remove_sysfs(struct cpuidle_device *dev);
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
-bool cpuidle_state_is_coupled(struct cpuidle_device *dev,
-		struct cpuidle_driver *drv, int state);
+bool cpuidle_state_is_coupled(struct cpuidle_driver *drv, int state);
 int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int next_state);
 int cpuidle_coupled_register_device(struct cpuidle_device *dev);
 void cpuidle_coupled_unregister_device(struct cpuidle_device *dev);
 #else
-static inline bool cpuidle_state_is_coupled(struct cpuidle_device *dev,
-		struct cpuidle_driver *drv, int state)
+static inline
+bool cpuidle_state_is_coupled(struct cpuidle_driver *drv, int state)
 {
 	return false;
 }
-- 
1.9.1
