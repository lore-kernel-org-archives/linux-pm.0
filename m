From: ahaslam@baylibre.com
Subject: [PATCH] [RFC] PM / Domains: multiple states
Date: Thu,  2 Apr 2015 10:34:59 +0200
Message-ID: <1427963699-2638-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38427 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbbDBIfW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 04:35:22 -0400
Received: by wibgn9 with SMTP id gn9so96529773wib.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2015 01:35:20 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

Some architectures may have intermediate
power levels between on and off. each state in
between may have its own set of registers to
save and restore, and procedures to put the power
domain into that state.

This patch adds the ability to declare multiple
states for a given generic power domain, the
idea is that the deepest state will be entered which
does not violate any of the device or sub-domain
latency constraints.

for this purpose, the device save and restore callbacks
take in a new parameter "state" which is the state
the domain is trying to go to. The implementation
of these callbacks can use this to save and restore
the appropriate registers. Also the power on and off
callbacks and latencies are now tied to a particular
state.

States should be declared in ascending order from shallowest
to deepest, deepest meaning the state which takes longer
to enter and exit. The declaration would look something like:

	struct genpd_power_state states[3] = {
		{
			.name= "LOW_POWER_1",
			.power_off = arch_callback_lp1,
			.power_on = arch_callback_lp1,
			.power_off_latency_ns = 1000000,
			.power_on_latency_ns = 1000000,

		},
		{
			.name= "LOW_POWER_2",
			.power_off = arch_callback_lp2,
			.power_on = arch_callback_lp2,
			.power_off_latency_ns = 2000000,
			.power_on_latency_ns = 2000000,

		},
		{
			.name= "OFF",
			.power_off = arch_callback_off,
			.power_on = arch_callback_off,
			.power_off_latency_ns = 4000000,
			.power_on_latency_ns = 4000000,

		},
	};

	struct generic_pm_domain pd1 = {
		.name = "pd1",
		.states = states,
		.state_count = 3,
		[...]
	}

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/base/power/domain.c          | 120 ++++++++++++++++++++++++++++-------
 drivers/base/power/domain_governor.c |  63 +++++++++++++++---
 include/linux/pm_domain.h            |  37 ++++++++---
 3 files changed, 176 insertions(+), 44 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ef54f98..3c73a68 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -46,6 +46,36 @@
 	}									\
 	__retval;								\
 })
+#define GENPD_DEV_CALLBACK_STATE(genpd, type, callback, dev, state)	\
+({									\
+	type (*__routine)(struct device *__d, int __s);			\
+	type __ret = (type)0;						\
+									\
+	__routine = genpd->dev_ops.callback;				\
+	if (__routine) {						\
+		__ret = __routine(dev, state);				\
+	}								\
+	__ret;								\
+})
+
+#define GENPD_DEV_TIMED_CALLBACK_STATE(genpd, type, callback, dev,	\
+					field, name, state)		\
+({									\
+	ktime_t __start = ktime_get();					\
+	type __retval = GENPD_DEV_CALLBACK_STATE(genpd, type, callback,	\
+						 dev, state);		\
+	s64 __elapsed = ktime_to_ns(ktime_sub(ktime_get(), __start));	\
+	struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;		\
+	if (!__retval && __elapsed > __td->field[state]) {		\
+		__td->field[state] = __elapsed;				\
+		dev_dbg(dev, name					\
+		"State %d latency exceeded, new value %lld ns\n",	\
+			state, __elapsed);				\
+		genpd->max_off_time_changed = true;			\
+		__td->constraint_changed = true;			\
+	}								\
+	__retval;							\
+})
 
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
@@ -141,12 +171,13 @@ static void genpd_set_active(struct generic_pm_domain *genpd)
 
 static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 {
+	int selected_state = genpd->selected_state;
 	s64 usecs64;
 
 	if (!genpd->cpuidle_data)
 		return;
 
-	usecs64 = genpd->power_on_latency_ns;
+	usecs64 = genpd->states[selected_state].power_on_latency_ns;
 	do_div(usecs64, NSEC_PER_USEC);
 	usecs64 += genpd->cpuidle_data->saved_exit_latency;
 	genpd->cpuidle_data->idle_state->exit_latency = usecs64;
@@ -154,23 +185,24 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 
 static int genpd_power_on(struct generic_pm_domain *genpd)
 {
+	int selected_state = genpd->selected_state;
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
 
-	if (!genpd->power_on)
+	if (!genpd->states[selected_state].power_on)
 		return 0;
 
 	time_start = ktime_get();
-	ret = genpd->power_on(genpd);
+	ret = genpd->states[selected_state].power_on(genpd);
 	if (ret)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (elapsed_ns <= genpd->power_on_latency_ns)
+	if (elapsed_ns <= genpd->states[selected_state].power_on_latency_ns)
 		return ret;
 
-	genpd->power_on_latency_ns = elapsed_ns;
+	genpd->states[selected_state].power_on_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	genpd_recalc_cpu_exit_latency(genpd);
 	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
@@ -181,23 +213,24 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 
 static int genpd_power_off(struct generic_pm_domain *genpd)
 {
+	int selected_state = genpd->selected_state;
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
 
-	if (!genpd->power_off)
+	if (!genpd->states[selected_state].power_off)
 		return 0;
 
 	time_start = ktime_get();
-	ret = genpd->power_off(genpd);
+	ret = genpd->states[selected_state].power_off(genpd);
 	if (ret == -EBUSY)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (elapsed_ns <= genpd->power_off_latency_ns)
+	if (elapsed_ns <= genpd->states[selected_state].power_off_latency_ns)
 		return ret;
 
-	genpd->power_off_latency_ns = elapsed_ns;
+	genpd->states[selected_state].power_off_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
 		genpd->name, "off", elapsed_ns);
@@ -326,15 +359,17 @@ static int genpd_start_dev_no_timing(struct generic_pm_domain *genpd,
 
 static int genpd_save_dev(struct generic_pm_domain *genpd, struct device *dev)
 {
-	return GENPD_DEV_TIMED_CALLBACK(genpd, int, save_state, dev,
-					save_state_latency_ns, "state save");
+	return GENPD_DEV_TIMED_CALLBACK_STATE(genpd, int, save_state, dev,
+					save_state_latency_ns, "state save",
+					genpd->selected_state);
 }
 
 static int genpd_restore_dev(struct generic_pm_domain *genpd, struct device *dev)
 {
-	return GENPD_DEV_TIMED_CALLBACK(genpd, int, restore_state, dev,
+	return GENPD_DEV_TIMED_CALLBACK_STATE(genpd, int, restore_state, dev,
 					restore_state_latency_ns,
-					"state restore");
+					"state restore",
+					genpd->selected_state);
 }
 
 static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
@@ -486,6 +521,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
 	unsigned int not_suspended;
+	int selected_state;
 	int ret = 0;
 
  start:
@@ -572,7 +608,9 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		goto out;
 	}
 
-	if (genpd->power_off) {
+	selected_state = genpd->selected_state;
+
+	if (genpd->states[selected_state].power_off) {
 		if (atomic_read(&genpd->sd_count) > 0) {
 			ret = -EBUSY;
 			goto out;
@@ -1396,7 +1434,25 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 
 	if (td)
 		gpd_data->td = *td;
-
+	else {
+		/* Allocate one save and restore latency value per state */
+		gpd_data->td.save_state_latency_ns =
+			kzalloc(sizeof(gpd_data->td.save_state_latency_ns) *
+					genpd->state_count,
+					GFP_KERNEL);
+		if (!gpd_data->td.save_state_latency_ns) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+		gpd_data->td.restore_state_latency_ns =
+			kzalloc(sizeof(gpd_data->td.save_state_latency_ns) *
+					genpd->state_count,
+					GFP_KERNEL);
+		if (!gpd_data->td.restore_state_latency_ns) {
+			ret = -ENOMEM;
+			goto err_free1;
+		}
+	}
 	gpd_data->base.dev = dev;
 	gpd_data->need_restore = -1;
 	gpd_data->td.constraint_changed = true;
@@ -1407,7 +1463,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 
 	if (dev->power.subsys_data->domain_data) {
 		ret = -EINVAL;
-		goto err_free;
+		goto err_free2;
 	}
 
 	dev->power.subsys_data->domain_data = &gpd_data->base;
@@ -1416,9 +1472,12 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 	spin_unlock_irq(&dev->power.lock);
 
 	return gpd_data;
-
- err_free:
+ err_free2:
 	spin_unlock_irq(&dev->power.lock);
+	kfree(gpd_data->td.restore_state_latency_ns);
+ err_free1:
+	kfree(gpd_data->td.save_state_latency_ns);
+ err_free:
 	kfree(gpd_data);
  err_put:
 	dev_pm_put_subsys_data(dev);
@@ -1434,7 +1493,8 @@ static void genpd_free_dev_data(struct device *dev,
 	dev->power.subsys_data->domain_data = NULL;
 
 	spin_unlock_irq(&dev->power.lock);
-
+	kfree(gpd_data->td.save_state_latency_ns);
+	kfree(gpd_data->td.save_state_latency_ns);
 	kfree(gpd_data);
 	dev_pm_put_subsys_data(dev);
 }
@@ -1809,7 +1869,7 @@ int pm_genpd_name_detach_cpuidle(const char *name)
  * pm_genpd_default_save_state - Default "save device state" for PM domains.
  * @dev: Device to handle.
  */
-static int pm_genpd_default_save_state(struct device *dev)
+static int pm_genpd_default_save_state(struct device *dev, int state)
 {
 	int (*cb)(struct device *__dev);
 
@@ -1832,7 +1892,7 @@ static int pm_genpd_default_save_state(struct device *dev)
  * pm_genpd_default_restore_state - Default PM domains "restore device state".
  * @dev: Device to handle.
  */
-static int pm_genpd_default_restore_state(struct device *dev)
+static int pm_genpd_default_restore_state(struct device *dev, int state)
 {
 	int (*cb)(struct device *__dev);
 
@@ -1860,6 +1920,8 @@ static int pm_genpd_default_restore_state(struct device *dev)
 void pm_genpd_init(struct generic_pm_domain *genpd,
 		   struct dev_power_governor *gov, bool is_off)
 {
+	int i;
+
 	if (IS_ERR_OR_NULL(genpd))
 		return;
 
@@ -1876,7 +1938,12 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->poweroff_task = NULL;
 	genpd->resume_count = 0;
 	genpd->device_count = 0;
-	genpd->max_off_time_ns = -1;
+	for (i = 0; i < genpd->state_count; i++) {
+		genpd->states[i].cached_power_down_ok = GPD_CACHED_UNKNOWN;
+		genpd->max_off_time_ns = -1;
+	}
+
+	genpd->selected_state = 0;
 	genpd->max_off_time_changed = true;
 	genpd->domain.ops.runtime_suspend = pm_genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = pm_genpd_runtime_resume;
@@ -2249,12 +2316,13 @@ static int pm_genpd_summary_one(struct seq_file *s,
 		[GPD_STATE_WAIT_MASTER] = "wait-master",
 		[GPD_STATE_BUSY] = "busy",
 		[GPD_STATE_REPEAT] = "off-in-progress",
-		[GPD_STATE_POWER_OFF] = "off"
+		[GPD_STATE_POWER_OFF] = "off:"
 	};
 	struct pm_domain_data *pm_data;
 	const char *kobj_path;
 	struct gpd_link *link;
 	int ret;
+	int selected_state = genpd->selected_state;
 
 	ret = mutex_lock_interruptible(&genpd->lock);
 	if (ret)
@@ -2262,7 +2330,11 @@ static int pm_genpd_summary_one(struct seq_file *s,
 
 	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
 		goto exit;
-	seq_printf(s, "%-30s  %-15s  ", genpd->name, status_lookup[genpd->status]);
+
+	seq_printf(s, "%-30s  %s%-15s  ", genpd->name,
+		status_lookup[genpd->status],
+		(genpd->status == GPD_STATE_POWER_OFF) ?
+			genpd->states[selected_state].name : "");
 
 	/*
 	 * Modifications on the list require holding locks on both
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 2a4154a..9f88fde 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -97,13 +97,15 @@ static bool default_stop_ok(struct device *dev)
  *
  * This routine must be executed under the PM domain's lock.
  */
-static bool default_power_down_ok(struct dev_pm_domain *pd)
+static bool default_power_down_ok_state(struct dev_pm_domain *pd, int state)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	struct generic_pm_domain_data *gpd_data;
 	struct gpd_link *link;
 	struct pm_domain_data *pdd;
 	s64 min_off_time_ns;
 	s64 off_on_time_ns;
+	int i;
 
 	if (genpd->max_off_time_changed) {
 		struct gpd_link *link;
@@ -118,14 +120,33 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 			link->master->max_off_time_changed = true;
 
 		genpd->max_off_time_changed = false;
-		genpd->cached_power_down_ok = false;
-		genpd->max_off_time_ns = -1;
+		/*
+		 * invalidate the cached values for every state
+		 */
+		for (i = 0; i < genpd->state_count; i++) {
+			genpd->states[i].cached_power_down_ok =
+				GPD_CACHED_UNKNOWN;
+			genpd->max_off_time_ns = -1;
+		}
+
 	} else {
-		return genpd->cached_power_down_ok;
+		if (genpd->states[state].cached_power_down_ok ==
+		    GPD_CACHED_OK)
+			return true;
+
+		if (genpd->states[state].cached_power_down_ok ==
+		    GPD_CACHED_NOT_OK)
+			return false;
 	}
 
-	off_on_time_ns = genpd->power_off_latency_ns +
-				genpd->power_on_latency_ns;
+	/*
+	 * The cached power down was not yet calculated for this state
+	 * start assuming it is not ok.
+	 */
+	genpd->states[state].cached_power_down_ok = GPD_CACHED_NOT_OK;
+
+	off_on_time_ns = genpd->states[state].power_off_latency_ns +
+			genpd->states[state].power_on_latency_ns;
 	/*
 	 * It doesn't make sense to remove power from the domain if saving
 	 * the state of all devices in it and the power off/power on operations
@@ -134,9 +155,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	 * All devices in this domain have been stopped already at this point.
 	 */
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		gpd_data = to_gpd_data(pdd);
 		if (pdd->dev->driver)
 			off_on_time_ns +=
-				to_gpd_data(pdd)->td.save_state_latency_ns;
+				gpd_data->td.save_state_latency_ns[state];
 	}
 
 	min_off_time_ns = -1;
@@ -193,7 +215,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		 * constraint_ns cannot be negative here, because the device has
 		 * been suspended.
 		 */
-		constraint_ns -= td->restore_state_latency_ns;
+		constraint_ns -= td->restore_state_latency_ns[state];
 		if (constraint_ns <= off_on_time_ns)
 			return false;
 
@@ -201,7 +223,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 			min_off_time_ns = constraint_ns;
 	}
 
-	genpd->cached_power_down_ok = true;
+	genpd->states[state].cached_power_down_ok = GPD_CACHED_OK;
 
 	/*
 	 * If the computed minimum device off time is negative, there are no
@@ -216,10 +238,31 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	 * time and the time needed to turn the domain on is the maximum
 	 * theoretical time this domain can spend in the "off" state.
 	 */
-	genpd->max_off_time_ns = min_off_time_ns - genpd->power_on_latency_ns;
+	genpd->max_off_time_ns = min_off_time_ns -
+			genpd->states[state].power_on_latency_ns;
 	return true;
 }
 
+static bool default_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	int last_state_idx = genpd->state_count - 1;
+	int i;
+
+	/* find a state to power down to, starting from the deepest */
+	for (i = 0; i < genpd->state_count; i++) {
+		if (default_power_down_ok_state(pd, last_state_idx - i)) {
+			genpd->selected_state = last_state_idx - i;
+			return true;
+		}
+	}
+
+	/* No state respects power down constraints */
+	genpd->selected_state = 0;
+
+	return false;
+}
+
 static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 {
 	return false;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 3082247..1c84f90 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -27,6 +27,11 @@ enum gpd_status {
 	GPD_STATE_REPEAT,	/* Power off in progress, to be repeated */
 	GPD_STATE_POWER_OFF,	/* PM domain is off */
 };
+enum gpd_cached_status {
+	GPD_CACHED_OK,
+	GPD_CACHED_NOT_OK,
+	GPD_CACHED_UNKNOWN,
+};
 
 struct dev_power_governor {
 	bool (*power_down_ok)(struct dev_pm_domain *domain);
@@ -36,8 +41,8 @@ struct dev_power_governor {
 struct gpd_dev_ops {
 	int (*start)(struct device *dev);
 	int (*stop)(struct device *dev);
-	int (*save_state)(struct device *dev);
-	int (*restore_state)(struct device *dev);
+	int (*save_state)(struct device *dev, int state);
+	int (*restore_state)(struct device *dev, int state);
 	bool (*active_wakeup)(struct device *dev);
 };
 
@@ -46,6 +51,20 @@ struct gpd_cpuidle_data {
 	struct cpuidle_state *idle_state;
 };
 
+struct generic_pm_domain;
+
+struct genpd_power_state {
+	int flag;
+	char *name;
+	s64 latency_ns;
+	s64 power_off_latency_ns;
+	s64 power_on_latency_ns;
+	int (*power_off)(struct generic_pm_domain *domain);
+	int (*power_on)(struct generic_pm_domain *domain);
+	int cached_power_down_ok;
+
+};
+
 struct generic_pm_domain {
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
@@ -66,14 +85,12 @@ struct generic_pm_domain {
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	bool suspend_power_off;	/* Power status before system suspend */
-	int (*power_off)(struct generic_pm_domain *domain);
-	s64 power_off_latency_ns;
-	int (*power_on)(struct generic_pm_domain *domain);
-	s64 power_on_latency_ns;
-	struct gpd_dev_ops dev_ops;
+	int state_count;
+	int selected_state;	/* next state for the power domain */
+	struct genpd_power_state *states;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
+	struct gpd_dev_ops dev_ops;
 	bool max_off_time_changed;
-	bool cached_power_down_ok;
 	struct gpd_cpuidle_data *cpuidle_data;
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
@@ -97,8 +114,8 @@ struct gpd_link {
 struct gpd_timing_data {
 	s64 stop_latency_ns;
 	s64 start_latency_ns;
-	s64 save_state_latency_ns;
-	s64 restore_state_latency_ns;
+	s64 *save_state_latency_ns;
+	s64 *restore_state_latency_ns;
 	s64 effective_constraint_ns;
 	bool constraint_changed;
 	bool cached_stop_ok;
-- 
1.9.1

