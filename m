From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH][V2] cpuidle: simplify multiple driver support
Date: Wed, 22 May 2013 15:05:04 +0200
Message-ID: <1369227904-16234-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:36813 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab3EVNFJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2013 09:05:09 -0400
Received: by mail-we0-f181.google.com with SMTP id u57so1205025wes.40
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2013 06:05:08 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, francescolavra.fl@gmail.com

Commit bf4d1b5ddb78f86078ac6ae0415802d5f0c68f92 brought the multiple driver
support. The code added a couple of new API to register the driver per cpu.
That led to some code complexity to handle the kernel config options when
the multiple driver support is enabled or not, which is not really necessary.
The code has to be compatible when the multiple driver support is not enabled,
and the multiple driver support has to be compatible with the old api.

This patch removes this API, which is not yet used by any driver but needed
for the HMP cpuidle drivers which will come soon, and replaces its usage
by a cpumask pointer in the cpuidle driver structure telling what cpus are
handled by the driver. That let the API cpuidle_[un]register_driver to be used
for the multipled driver support and also the cpuidle_[un]register functions,
added recently in the cpuidle framework.

The current code, a bit poor in comments, has been commented and simplified.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---

[V2]:
 - fixed bad refcount check
 - inverted clockevent notify off order at unregister time

 drivers/cpuidle/cpuidle.c |    4 +-
 drivers/cpuidle/driver.c  |  324 ++++++++++++++++++++++++++++-----------------
 include/linux/cpuidle.h   |   21 +--
 3 files changed, 213 insertions(+), 136 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c3a93fe..fdc432f 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -466,7 +466,7 @@ void cpuidle_unregister(struct cpuidle_driver *drv)
 	int cpu;
 	struct cpuidle_device *device;
 
-	for_each_possible_cpu(cpu) {
+	for_each_cpu(cpu, drv->cpumask) {
 		device = &per_cpu(cpuidle_dev, cpu);
 		cpuidle_unregister_device(device);
 	}
@@ -498,7 +498,7 @@ int cpuidle_register(struct cpuidle_driver *drv,
 		return ret;
 	}
 
-	for_each_possible_cpu(cpu) {
+	for_each_cpu(cpu, drv->cpumask) {
 		device = &per_cpu(cpuidle_dev, cpu);
 		device->cpu = cpu;
 
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 8dfaaae..0268346 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -18,206 +18,266 @@
 
 DEFINE_SPINLOCK(cpuidle_driver_lock);
 
-static void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu);
-static struct cpuidle_driver * __cpuidle_get_cpu_driver(int cpu);
+#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
 
-static void cpuidle_setup_broadcast_timer(void *arg)
+static DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
+
+/**
+ * __cpuidle_get_cpu_driver: returns the cpuidle driver tied with the specified
+ * cpu.
+ *
+ * @cpu: an integer specifying the cpu number
+ *
+ * Returns a pointer to struct cpuidle_driver, NULL if no driver has been
+ * registered for this driver
+ */
+static struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
 {
-	int cpu = smp_processor_id();
-	clockevents_notify((long)(arg), &cpu);
+	return per_cpu(cpuidle_drivers, cpu);
 }
 
-static void __cpuidle_driver_init(struct cpuidle_driver *drv, int cpu)
+/**
+ * __cpuidle_set_driver: assign to the per cpu variable the driver pointer for
+ * each cpu the driver is assigned to with the cpumask.
+ *
+ * @drv: a pointer to a struct cpuidle_driver
+ *
+ * Returns 0 on success, < 0 otherwise
+ */
+static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
 {
-	int i;
+	int cpu;
 
-	drv->refcnt = 0;
+	for_each_cpu(cpu, drv->cpumask) {
 
-	for (i = drv->state_count - 1; i >= 0 ; i--) {
+		if (__cpuidle_get_cpu_driver(cpu))
+			return -EBUSY;
 
-		if (!(drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP))
-			continue;
-
-		drv->bctimer = 1;
-		on_each_cpu_mask(get_cpu_mask(cpu), cpuidle_setup_broadcast_timer,
-				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON, 1);
-		break;
+		per_cpu(cpuidle_drivers, cpu) = drv;
 	}
+
+	return 0;
 }
 
-static int __cpuidle_register_driver(struct cpuidle_driver *drv, int cpu)
+/**
+ * __cpuidle_unset_driver: for each cpu the driver is handling, set the per cpu
+ * variable driver to NULL.
+ *
+ * @drv: a pointer to a struct cpuidle_driver
+ */
+static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
 {
-	if (!drv || !drv->state_count)
-		return -EINVAL;
-
-	if (cpuidle_disabled())
-		return -ENODEV;
-
-	if (__cpuidle_get_cpu_driver(cpu))
-		return -EBUSY;
+	int cpu;
 
-	__cpuidle_driver_init(drv, cpu);
+	for_each_cpu(cpu, drv->cpumask) {
 
-	__cpuidle_set_cpu_driver(drv, cpu);
+		if (drv != __cpuidle_get_cpu_driver(cpu))
+			continue;
 
-	return 0;
+		per_cpu(cpuidle_drivers, cpu) = NULL;
+	}
 }
 
-static void __cpuidle_unregister_driver(struct cpuidle_driver *drv, int cpu)
-{
-	if (drv != __cpuidle_get_cpu_driver(cpu))
-		return;
+#else
 
-	if (!WARN_ON(drv->refcnt > 0))
-		__cpuidle_set_cpu_driver(NULL, cpu);
+static struct cpuidle_driver *cpuidle_curr_driver;
 
-	if (drv->bctimer) {
-		drv->bctimer = 0;
-		on_each_cpu_mask(get_cpu_mask(cpu), cpuidle_setup_broadcast_timer,
-				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
-	}
+/**
+ * __cpuidle_get_cpu_driver: returns the global cpuidle driver pointer.
+ *
+ * @cpu: an integer specifying the cpu number, this parameter is ignored
+ *
+ * Returns a pointer to a struct cpuidle_driver, NULL if no driver was
+ * previously registered
+ */
+static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
+{
+	return cpuidle_curr_driver;
 }
 
-#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
+/**
+ * __cpuidle_set_driver: assign the cpuidle driver pointer to the global cpuidle
+ * driver variable.
+ *
+ * @drv: a pointer to a struct cpuidle_driver
+ *
+ * Returns 0 on success, < 0 otherwise
+ */
+static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
+{
+	if (cpuidle_curr_driver)
+		return -EBUSY;
 
-static DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
+	cpuidle_curr_driver = drv;
 
-static void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu)
-{
-	per_cpu(cpuidle_drivers, cpu) = drv;
+	return 0;
 }
 
-static struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
+/**
+ * __cpuidle_unset_driver: reset the global cpuidle driver variable if the
+ * cpuidle driver pointer match it.
+ *
+ * @drv: a pointer to a struct cpuidle_driver
+ */
+static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
 {
-	return per_cpu(cpuidle_drivers, cpu);
+	if (drv == cpuidle_curr_driver)
+		cpuidle_curr_driver = NULL;
 }
 
-static void __cpuidle_unregister_all_cpu_driver(struct cpuidle_driver *drv)
+#endif
+
+/**
+ * cpuidle_setup_broadcast_timer: set the broadcast timer notification for the
+ * current cpu. This function is called per cpu context invoked by a smp cross
+ * call. It is not supposed to be called directly.
+ *
+ * @arg: a void pointer, actually used to match the smp cross call api but used
+ * as a long with two values:
+ * - CLOCK_EVT_NOTIFY_BROADCAST_ON
+ * - CLOCK_EVT_NOTIFY_BROADCAST_OFF
+ */
+static void cpuidle_setup_broadcast_timer(void *arg)
 {
-	int cpu;
-	for_each_present_cpu(cpu)
-		__cpuidle_unregister_driver(drv, cpu);
+	int cpu = smp_processor_id();
+	clockevents_notify((long)(arg), &cpu);
 }
 
-static int __cpuidle_register_all_cpu_driver(struct cpuidle_driver *drv)
+/**
+ * __cpuidle_driver_init: initialize the driver internal data.
+ *
+ * @drv: a valid pointer to a struct cpuidle_driver
+ *
+ * Returns 0 on success, < 0 otherwise
+ */
+static int __cpuidle_driver_init(struct cpuidle_driver *drv)
 {
-	int ret = 0;
-	int i, cpu;
+	int i;
 
-	for_each_present_cpu(cpu) {
-		ret = __cpuidle_register_driver(drv, cpu);
-		if (ret)
-			break;
-	}
+	drv->refcnt = 0;
 
-	if (ret)
-		for_each_present_cpu(i) {
-			if (i == cpu)
-				break;
-			__cpuidle_unregister_driver(drv, i);
-		}
+	/*
+	 * we default here to all cpu possible because if the kernel
+	 * boots with some cpus offline and then we online one of them
+	 * the cpu notifier won't know which driver to assign
+	 */
+	if (!drv->cpumask)
+		drv->cpumask = (struct cpumask *)cpu_possible_mask;
+
+	/*
+	 * we look for the timer stop flag in the different states,
+	 * so know we have to setup the broadcast timer. The loop is
+	 * in reverse order, because usually the deeper state has this
+	 * flag set
+	 */
+	for (i = drv->state_count - 1; i >= 0 ; i--) {
 
+		if (!(drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP))
+			continue;
 
-	return ret;
+		drv->bctimer = 1;
+		break;
+	}
+
+	return 0;
 }
 
-int cpuidle_register_cpu_driver(struct cpuidle_driver *drv, int cpu)
+/**
+ * __cpuidle_register_driver: do some sanity checks, initializes the driver,
+ * assign the driver to the global cpuidle driver variable(s) and setup the
+ * broadcast timer if the cpuidle driver has some states which shutdown the
+ * local timer.
+ *
+ * @drv: a valid pointer to a struct cpuidle_driver
+ *
+ * Returns 0 on success, < 0 otherwise
+ */
+static int __cpuidle_register_driver(struct cpuidle_driver *drv)
 {
 	int ret;
 
-	spin_lock(&cpuidle_driver_lock);
-	ret = __cpuidle_register_driver(drv, cpu);
-	spin_unlock(&cpuidle_driver_lock);
+	if (!drv || !drv->state_count)
+		return -EINVAL;
 
-	return ret;
-}
+	if (cpuidle_disabled())
+		return -ENODEV;
 
-void cpuidle_unregister_cpu_driver(struct cpuidle_driver *drv, int cpu)
-{
-	spin_lock(&cpuidle_driver_lock);
-	__cpuidle_unregister_driver(drv, cpu);
-	spin_unlock(&cpuidle_driver_lock);
-}
+	ret = __cpuidle_driver_init(drv);
+	if (ret)
+		return ret;
 
-/**
- * cpuidle_register_driver - registers a driver
- * @drv: the driver
- */
-int cpuidle_register_driver(struct cpuidle_driver *drv)
-{
-	int ret;
+	ret = __cpuidle_set_driver(drv);
+	if (ret)
+		return ret;
 
-	spin_lock(&cpuidle_driver_lock);
-	ret = __cpuidle_register_all_cpu_driver(drv);
-	spin_unlock(&cpuidle_driver_lock);
+	if (drv->bctimer)
+		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
+				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON, 1);
 
-	return ret;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(cpuidle_register_driver);
 
 /**
- * cpuidle_unregister_driver - unregisters a driver
- * @drv: the driver
+ * __cpuidle_unregister_driver: checks the driver is no longer in use, reset the
+ * global cpuidle driver variable(s) and disable the timer broadcast
+ * notification mechanism if it was in use.
+ *
+ * @drv: a valid pointer to a struct cpuidle_driver
+ *
  */
-void cpuidle_unregister_driver(struct cpuidle_driver *drv)
+static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
-	spin_lock(&cpuidle_driver_lock);
-	__cpuidle_unregister_all_cpu_driver(drv);
-	spin_unlock(&cpuidle_driver_lock);
-}
-EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
-
-#else
-
-static struct cpuidle_driver *cpuidle_curr_driver;
+	if (WARN_ON(drv->refcnt > 0))
+		return;
 
-static inline void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu)
-{
-	cpuidle_curr_driver = drv;
-}
+	if (drv->bctimer) {
+		drv->bctimer = 0;
+		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
+				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
+	}
 
-static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
-{
-	return cpuidle_curr_driver;
+	__cpuidle_unset_driver(drv);
 }
 
 /**
- * cpuidle_register_driver - registers a driver
- * @drv: the driver
+ * cpuidle_register_driver: registers a driver by taking a lock to prevent
+ * multiple callers to [un]register a driver at the same time.
+ *
+ * @drv: a pointer to a valid struct cpuidle_driver
+ *
+ * Returns 0 on success, < 0 otherwise
  */
 int cpuidle_register_driver(struct cpuidle_driver *drv)
 {
-	int ret, cpu;
+	int ret;
 
-	cpu = get_cpu();
 	spin_lock(&cpuidle_driver_lock);
-	ret = __cpuidle_register_driver(drv, cpu);
+	ret = __cpuidle_register_driver(drv);
 	spin_unlock(&cpuidle_driver_lock);
-	put_cpu();
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpuidle_register_driver);
 
 /**
- * cpuidle_unregister_driver - unregisters a driver
- * @drv: the driver
+ * cpuidle_unregister_driver: unregisters a driver by taking a lock to prevent
+ * multiple callers to [un]register a driver at the same time. The specified
+ * driver must match the driver currently registered.
+ *
+ * @drv: a pointer to a valid struct cpuidle_driver
  */
 void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
-	int cpu;
-
-	cpu = get_cpu();
 	spin_lock(&cpuidle_driver_lock);
-	__cpuidle_unregister_driver(drv, cpu);
+	__cpuidle_unregister_driver(drv);
 	spin_unlock(&cpuidle_driver_lock);
-	put_cpu();
 }
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
-#endif
 
 /**
- * cpuidle_get_driver - return the current driver
+ * cpuidle_get_driver: returns the driver tied with the current cpu.
+ *
+ * Returns a struct cpuidle_driver pointer, or NULL if no driver is registered
  */
 struct cpuidle_driver *cpuidle_get_driver(void)
 {
@@ -233,7 +293,12 @@ struct cpuidle_driver *cpuidle_get_driver(void)
 EXPORT_SYMBOL_GPL(cpuidle_get_driver);
 
 /**
- * cpuidle_get_cpu_driver - return the driver tied with a cpu
+ * cpuidle_get_cpu_driver: returns the driver registered with a cpu.
+ *
+ * @dev: a valid pointer to a struct cpuidle_device
+ *
+ * Returns a struct cpuidle_driver pointer, or NULL if no driver is registered
+ * for the specified cpu
  */
 struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
 {
@@ -244,6 +309,13 @@ struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
 }
 EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver);
 
+/**
+ * cpuidle_driver_ref: gets a refcount for the driver. Note this function takes
+ * a refcount for the driver assigned to the current cpu.
+ *
+ * Returns a struct cpuidle_driver pointer, or NULL if no driver is registered
+ * for the current cpu
+ */
 struct cpuidle_driver *cpuidle_driver_ref(void)
 {
 	struct cpuidle_driver *drv;
@@ -257,6 +329,10 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
 	return drv;
 }
 
+/**
+ * cpuidle_driver_unref: puts down the refcount for the driver. Note this
+ * function decrement the refcount for the driver assigned to the current cpu.
+ */
 void cpuidle_driver_unref(void)
 {
 	struct cpuidle_driver *drv = cpuidle_get_driver();
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 8f04062..63d78b1 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -101,16 +101,20 @@ static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
  ****************************/
 
 struct cpuidle_driver {
-	const char		*name;
-	struct module 		*owner;
-	int                     refcnt;
+	const char	     *name;
+	struct module 	     *owner;
+	int                  refcnt;
 
         /* used by the cpuidle framework to setup the broadcast timer */
-	unsigned int            bctimer:1;
+	unsigned int         bctimer:1;
+
 	/* states array must be ordered in decreasing power consumption */
-	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
-	int			state_count;
-	int			safe_state_index;
+	struct cpuidle_state states[CPUIDLE_STATE_MAX];
+	int		     state_count;
+	int		     safe_state_index;
+
+	/* the driver handles the cpus in cpumask */
+	struct cpumask       *cpumask;
 };
 
 #ifdef CONFIG_CPU_IDLE
@@ -135,9 +139,6 @@ extern void cpuidle_disable_device(struct cpuidle_device *dev);
 extern int cpuidle_play_dead(void);
 
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
-extern int cpuidle_register_cpu_driver(struct cpuidle_driver *drv, int cpu);
-extern void cpuidle_unregister_cpu_driver(struct cpuidle_driver *drv, int cpu);
-
 #else
 static inline void disable_cpuidle(void) { }
 static inline int cpuidle_idle_call(void) { return -ENODEV; }
-- 
1.7.9.5

