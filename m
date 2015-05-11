From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH/RFC] PM / Domains: Minimize latencies by not delaying save/restore
Date: Mon, 11 May 2015 15:24:33 +0200
Message-ID: <1431350673-871-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34826 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973AbbEKNZE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 09:25:04 -0400
Received: by lbbuc2 with SMTP id uc2so93592041lbb.2
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2015 06:25:01 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, linux-arm-kernel@lists.infradead.org

This patch actually address two issues which exists due to the current
policy of how genpd deals with devices' ->runtime_suspend|resume()
callbacks.

The two issues are described below.

Issue 1) A thundering herd problem with latencies issues:

Currently genpd delays to walk the hierarchy of ->runtime_suspend()
callbacks for a device, until all devices in a PM domain becomes
inactive.

Support for fine grained PM is instead handled via the gpd_dev_ops'
->stop|start() callbacks. The ->stop() callback is invoked immediately
when genpd's ->runtime_suspend() callback is called at the PM domain
level.

When genpd realizes that all devices have become inactive within the PM
domain, it starts the power off sequence.

Those devices that were re-activated since the last powered off
sequence, needs to be given the opportunity to have their register
context saved. That means walking the hierarchy of the devices'
->runtime_suspend() callbacks.

Though, genpd first need to invoke the ->start() callbacks, else
drivers/subsystems won't be able to save their devices' register
context.

After invoking the ->start() and then ->runtime_suspend() callback,
genpd again needs to invoke the ->stop() callback. A sequence which
is repeated for each of the re-activated devices within the PM domain,
during the power off sequence.

This leads to a suboptimal power off sequence, both from the
perspective that the ->start|stop() callback needs to be invoked but
also because all operations are serialized. It simply causes a
thundering herd problem and gives latency issues.

To elaborate on the latency issues, let's follow the below scenario.

	* Device [A] and [B] lives in the same generic PM domain.

	* Device [A] has been re-activated and has recently also become
	inactive, which means genpd has invoked the ->stop() callback
	for it and started the power off sequence.

	* Then someone calls pm_runtime_get_sync() for the inactive
	device [B]. The ongoing power off sequence should thus be
	aborted as soon as possible.

	* In this scenario the actual PM domain hasn't yet been powered
	off, but instead the power off sequence calls
	__pm_genpd_save_device() for device [A].

	* In parallel genpd's ->runtime_resume() callback at the PM
	domain level is invoked for device [B]. It notifies the power
	off sequence to abort, which needs confirmation to be able to
	continue.

	* Unfortunate, aborting the power off sequence won't be
	confirmed until device [A] has been powered off through
	__pm_genpd_save_device().

In this scenario, device [B] will be waiting for device [A] to complete
->start(), ->runtime_suspend() and ->stop(), which are invoked from
__pm_genpd_save_device(). In other words, device [B]'s
->runtime_resume() latency will be extended with device [A]'s time to
complete power off.

To move this reasoning a step further, it means all devices within the
same generic PM domain suffers from an increased ->runtime_resume()
latency. Moreover, that extended latency comes from the device with the
slowest power off sequence.

This behavior in genpd, is a consequence from that the power off
sequence needs to protect itself by using locks and states. Therefore
can an abort only be confirmed in between calls to
__pm_genpd_save_device().

Issue 2) The runtime PM core don't know the real status of the device:

When genpd returns 0 from the ->runtime_suspend() callback at the PM
domain level, but without walking the hierarchy of the device's
->runtime_suspend() callbacks, it tells the runtime PM core that the
device's runtime PM status shall be considered as inactive.

Drivers/subsystems which manages devices that may reside in a generic
PM domain, thus can't trust that the pm_runtime_suspended() API (and
similar runtime APIs) returns a correct result.

This becomes an issue when for example drivers/subsystems tries to
optimize the system PM suspend path about leaving already runtime PM
suspended devices in that state. In these cases it's common to use the
pm_runtime_suspended() API.

To address these two issues, let's change the policy in genpd. More
precisely, let's walk the hierarchy of the ->runtime_suspend()
callbacks immediately when genpd's ->runtime_suspend() callback at the
PM domain level is invoked.

This has the effect of decouple the PM domain's power off sequence from
the devices' power off sequence. The thundering herd issue becomes
minimized and so also the latencies.

Moreover the runtime PM status of the device would reflect the actual
status and can thus be trusted by clients outside genpd.

Adopting this the behavior, will unfortunate also mean that for those
->runtime_suspend|resume() callbacks that manages register context
save/restore only, is invoked even if the PM domain hasn't been powered
off/on.

In most cases, saving and restoring register context for a device,
are rather quick operations. Still, in some cases drivers/subsystems
may suffer from latencies if they would deal with that for each I/O
request. To prevent such, they may enable the runtime PM autosuspend
feature.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 345 +++++++-------------------------------------
 include/linux/pm_domain.h   |   7 -
 2 files changed, 52 insertions(+), 300 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2327613..3b3367b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -133,41 +133,6 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
 	smp_mb__after_atomic();
 }
 
-static void genpd_acquire_lock(struct generic_pm_domain *genpd)
-{
-	DEFINE_WAIT(wait);
-
-	mutex_lock(&genpd->lock);
-	/*
-	 * Wait for the domain to transition into either the active,
-	 * or the power off state.
-	 */
-	for (;;) {
-		prepare_to_wait(&genpd->status_wait_queue, &wait,
-				TASK_UNINTERRUPTIBLE);
-		if (genpd->status == GPD_STATE_ACTIVE
-		    || genpd->status == GPD_STATE_POWER_OFF)
-			break;
-		mutex_unlock(&genpd->lock);
-
-		schedule();
-
-		mutex_lock(&genpd->lock);
-	}
-	finish_wait(&genpd->status_wait_queue, &wait);
-}
-
-static void genpd_release_lock(struct generic_pm_domain *genpd)
-{
-	mutex_unlock(&genpd->lock);
-}
-
-static void genpd_set_active(struct generic_pm_domain *genpd)
-{
-	if (genpd->resume_count == 0)
-		genpd->status = GPD_STATE_ACTIVE;
-}
-
 static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 {
 	s64 usecs64;
@@ -242,35 +207,14 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
  * resume a device belonging to it.
  */
 static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
-	__releases(&genpd->lock) __acquires(&genpd->lock)
 {
 	struct gpd_link *link;
-	DEFINE_WAIT(wait);
 	int ret = 0;
 
-	/* If the domain's master is being waited for, we have to wait too. */
-	for (;;) {
-		prepare_to_wait(&genpd->status_wait_queue, &wait,
-				TASK_UNINTERRUPTIBLE);
-		if (genpd->status != GPD_STATE_WAIT_MASTER)
-			break;
-		mutex_unlock(&genpd->lock);
-
-		schedule();
-
-		mutex_lock(&genpd->lock);
-	}
-	finish_wait(&genpd->status_wait_queue, &wait);
-
 	if (genpd->status == GPD_STATE_ACTIVE
 	    || (genpd->prepared_count > 0 && genpd->suspend_power_off))
 		return 0;
 
-	if (genpd->status != GPD_STATE_POWER_OFF) {
-		genpd_set_active(genpd);
-		return 0;
-	}
-
 	if (genpd->cpuidle_data) {
 		cpuidle_pause_and_lock();
 		genpd->cpuidle_data->idle_state->disabled = true;
@@ -285,20 +229,8 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 	 */
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_inc(link->master);
-		genpd->status = GPD_STATE_WAIT_MASTER;
-
-		mutex_unlock(&genpd->lock);
 
 		ret = pm_genpd_poweron(link->master);
-
-		mutex_lock(&genpd->lock);
-
-		/*
-		 * The "wait for parent" status is guaranteed not to change
-		 * while the master is powering on.
-		 */
-		genpd->status = GPD_STATE_POWER_OFF;
-		wake_up_all(&genpd->status_wait_queue);
 		if (ret) {
 			genpd_sd_counter_dec(link->master);
 			goto err;
@@ -310,14 +242,15 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 		goto err;
 
  out:
-	genpd_set_active(genpd);
-
+	genpd->status = GPD_STATE_ACTIVE;
 	return 0;
 
  err:
 	list_for_each_entry_continue_reverse(link, &genpd->slave_links, slave_node)
 		genpd_sd_counter_dec(link->master);
 
+	/* In case we powered on a master, try to power it off again. */
+	pm_genpd_poweroff_unused();
 	return ret;
 }
 
@@ -407,89 +340,6 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 }
 
 /**
- * __pm_genpd_save_device - Save the pre-suspend state of a device.
- * @pdd: Domain data of the device to save the state of.
- * @genpd: PM domain the device belongs to.
- */
-static int __pm_genpd_save_device(struct pm_domain_data *pdd,
-				  struct generic_pm_domain *genpd)
-	__releases(&genpd->lock) __acquires(&genpd->lock)
-{
-	struct generic_pm_domain_data *gpd_data = to_gpd_data(pdd);
-	struct device *dev = pdd->dev;
-	int ret = 0;
-
-	if (gpd_data->need_restore > 0)
-		return 0;
-
-	/*
-	 * If the value of the need_restore flag is still unknown at this point,
-	 * we trust that pm_genpd_poweroff() has verified that the device is
-	 * already runtime PM suspended.
-	 */
-	if (gpd_data->need_restore < 0) {
-		gpd_data->need_restore = 1;
-		return 0;
-	}
-
-	mutex_unlock(&genpd->lock);
-
-	genpd_start_dev(genpd, dev);
-	ret = genpd_save_dev(genpd, dev);
-	genpd_stop_dev(genpd, dev);
-
-	mutex_lock(&genpd->lock);
-
-	if (!ret)
-		gpd_data->need_restore = 1;
-
-	return ret;
-}
-
-/**
- * __pm_genpd_restore_device - Restore the pre-suspend state of a device.
- * @pdd: Domain data of the device to restore the state of.
- * @genpd: PM domain the device belongs to.
- */
-static void __pm_genpd_restore_device(struct pm_domain_data *pdd,
-				      struct generic_pm_domain *genpd)
-	__releases(&genpd->lock) __acquires(&genpd->lock)
-{
-	struct generic_pm_domain_data *gpd_data = to_gpd_data(pdd);
-	struct device *dev = pdd->dev;
-	int need_restore = gpd_data->need_restore;
-
-	gpd_data->need_restore = 0;
-	mutex_unlock(&genpd->lock);
-
-	genpd_start_dev(genpd, dev);
-
-	/*
-	 * Call genpd_restore_dev() for recently added devices too (need_restore
-	 * is negative then).
-	 */
-	if (need_restore)
-		genpd_restore_dev(genpd, dev);
-
-	mutex_lock(&genpd->lock);
-}
-
-/**
- * genpd_abort_poweroff - Check if a PM domain power off should be aborted.
- * @genpd: PM domain to check.
- *
- * Return true if a PM domain's status changed to GPD_STATE_ACTIVE during
- * a "power off" operation, which means that a "power on" has occured in the
- * meantime, or if its resume_count field is different from zero, which means
- * that one of its devices has been resumed in the meantime.
- */
-static bool genpd_abort_poweroff(struct generic_pm_domain *genpd)
-{
-	return genpd->status == GPD_STATE_WAIT_MASTER
-		|| genpd->status == GPD_STATE_ACTIVE || genpd->resume_count > 0;
-}
-
-/**
  * genpd_queue_power_off_work - Queue up the execution of pm_genpd_poweroff().
  * @genpd: PM domait to power off.
  *
@@ -506,34 +356,27 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
  * @genpd: PM domain to power down.
  *
  * If all of the @genpd's devices have been suspended and all of its subdomains
- * have been powered down, run the runtime suspend callbacks provided by all of
- * the @genpd's devices' drivers and remove power from @genpd.
+ * have been powered down, remove power from @genpd.
  */
 static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
-	__releases(&genpd->lock) __acquires(&genpd->lock)
 {
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
-	unsigned int not_suspended;
-	int ret = 0;
+	unsigned int not_suspended = 0;
 
- start:
 	/*
 	 * Do not try to power off the domain in the following situations:
 	 * (1) The domain is already in the "power off" state.
 	 * (2) The domain is waiting for its master to power up.
-	 * (3) One of the domain's devices is being resumed right now.
-	 * (4) System suspend is in progress.
+	 * (3) System suspend is in progress.
 	 */
 	if (genpd->status == GPD_STATE_POWER_OFF
-	    || genpd->status == GPD_STATE_WAIT_MASTER
-	    || genpd->resume_count > 0 || genpd->prepared_count > 0)
+	    || genpd->prepared_count > 0)
 		return 0;
 
 	if (atomic_read(&genpd->sd_count) > 0)
 		return -EBUSY;
 
-	not_suspended = 0;
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
 		enum pm_qos_flags_status stat;
 
@@ -551,41 +394,11 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 	if (not_suspended > genpd->in_progress)
 		return -EBUSY;
 
-	if (genpd->poweroff_task) {
-		/*
-		 * Another instance of pm_genpd_poweroff() is executing
-		 * callbacks, so tell it to start over and return.
-		 */
-		genpd->status = GPD_STATE_REPEAT;
-		return 0;
-	}
-
 	if (genpd->gov && genpd->gov->power_down_ok) {
 		if (!genpd->gov->power_down_ok(&genpd->domain))
 			return -EAGAIN;
 	}
 
-	genpd->status = GPD_STATE_BUSY;
-	genpd->poweroff_task = current;
-
-	list_for_each_entry_reverse(pdd, &genpd->dev_list, list_node) {
-		ret = atomic_read(&genpd->sd_count) == 0 ?
-			__pm_genpd_save_device(pdd, genpd) : -EBUSY;
-
-		if (genpd_abort_poweroff(genpd))
-			goto out;
-
-		if (ret) {
-			genpd_set_active(genpd);
-			goto out;
-		}
-
-		if (genpd->status == GPD_STATE_REPEAT) {
-			genpd->poweroff_task = NULL;
-			goto start;
-		}
-	}
-
 	if (genpd->cpuidle_data) {
 		/*
 		 * If cpuidle_data is set, cpuidle should turn the domain off
@@ -598,14 +411,14 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		cpuidle_pause_and_lock();
 		genpd->cpuidle_data->idle_state->disabled = false;
 		cpuidle_resume_and_unlock();
-		goto out;
+		return 0;
 	}
 
 	if (genpd->power_off) {
-		if (atomic_read(&genpd->sd_count) > 0) {
-			ret = -EBUSY;
-			goto out;
-		}
+		int ret;
+
+		if (atomic_read(&genpd->sd_count) > 0)
+			return -EBUSY;
 
 		/*
 		 * If sd_count > 0 at this point, one of the subdomains hasn't
@@ -616,10 +429,8 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		 * happen very often).
 		 */
 		ret = genpd_power_off(genpd);
-		if (ret == -EBUSY) {
-			genpd_set_active(genpd);
-			goto out;
-		}
+		if (ret)
+			return ret;
 	}
 
 	genpd->status = GPD_STATE_POWER_OFF;
@@ -629,10 +440,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		genpd_queue_power_off_work(link->master);
 	}
 
- out:
-	genpd->poweroff_task = NULL;
-	wake_up_all(&genpd->status_wait_queue);
-	return ret;
+	return 0;
 }
 
 /**
@@ -645,9 +453,9 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 	pm_genpd_poweroff(genpd);
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 }
 
 /**
@@ -661,7 +469,6 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 static int pm_genpd_runtime_suspend(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	struct generic_pm_domain_data *gpd_data;
 	bool (*stop_ok)(struct device *__dev);
 	int ret;
 
@@ -671,32 +478,29 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
+	/*
+	 * We can't allow to power off the PM domain if it holds an irq_safe
+	 * device. That's beacuse we use mutexes to protect data while power
+	 * off and on the PM domain, thus we can't execute in atomic context.
+	 */
+	if (dev->power.irq_safe)
+		return -EBUSY;
+
 	stop_ok = genpd->gov ? genpd->gov->stop_ok : NULL;
 	if (stop_ok && !stop_ok(dev))
 		return -EBUSY;
 
-	ret = genpd_stop_dev(genpd, dev);
+	ret = genpd_save_dev(genpd, dev);
 	if (ret)
 		return ret;
 
-	/*
-	 * If power.irq_safe is set, this routine will be run with interrupts
-	 * off, so it can't use mutexes.
-	 */
-	if (dev->power.irq_safe)
-		return 0;
+	ret = genpd_stop_dev(genpd, dev);
+	if (ret) {
+		genpd_restore_dev(genpd, dev);
+		return ret;
+	}
 
 	mutex_lock(&genpd->lock);
-
-	/*
-	 * If we have an unknown state of the need_restore flag, it means none
-	 * of the runtime PM callbacks has been invoked yet. Let's update the
-	 * flag to reflect that the current state is active.
-	 */
-	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
-	if (gpd_data->need_restore < 0)
-		gpd_data->need_restore = 0;
-
 	genpd->in_progress++;
 	pm_genpd_poweroff(genpd);
 	genpd->in_progress--;
@@ -716,7 +520,6 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 static int pm_genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	DEFINE_WAIT(wait);
 	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
@@ -731,34 +534,13 @@ static int pm_genpd_runtime_resume(struct device *dev)
 
 	mutex_lock(&genpd->lock);
 	ret = __pm_genpd_poweron(genpd);
-	if (ret) {
-		mutex_unlock(&genpd->lock);
-		return ret;
-	}
-	genpd->status = GPD_STATE_BUSY;
-	genpd->resume_count++;
-	for (;;) {
-		prepare_to_wait(&genpd->status_wait_queue, &wait,
-				TASK_UNINTERRUPTIBLE);
-		/*
-		 * If current is the powering off task, we have been called
-		 * reentrantly from one of the device callbacks, so we should
-		 * not wait.
-		 */
-		if (!genpd->poweroff_task || genpd->poweroff_task == current)
-			break;
-		mutex_unlock(&genpd->lock);
+	mutex_unlock(&genpd->lock);
 
-		schedule();
+	if (ret)
+		return ret;
 
-		mutex_lock(&genpd->lock);
-	}
-	finish_wait(&genpd->status_wait_queue, &wait);
-	__pm_genpd_restore_device(dev->power.subsys_data->domain_data, genpd);
-	genpd->resume_count--;
-	genpd_set_active(genpd);
-	wake_up_all(&genpd->status_wait_queue);
-	mutex_unlock(&genpd->lock);
+	genpd_start_dev(genpd, dev);
+	genpd_restore_dev(genpd, dev);
 
 	return 0;
 }
@@ -870,7 +652,7 @@ static void pm_genpd_sync_poweron(struct generic_pm_domain *genpd)
 {
 	struct gpd_link *link;
 
-	if (genpd->status != GPD_STATE_POWER_OFF)
+	if (genpd->status == GPD_STATE_ACTIVE)
 		return;
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
@@ -947,14 +729,14 @@ static int pm_genpd_prepare(struct device *dev)
 	if (resume_needed(dev, genpd))
 		pm_runtime_resume(dev);
 
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 
 	if (genpd->prepared_count++ == 0) {
 		genpd->suspended_count = 0;
 		genpd->suspend_power_off = genpd->status == GPD_STATE_POWER_OFF;
 	}
 
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 
 	if (genpd->suspend_power_off) {
 		pm_runtime_put_noidle(dev);
@@ -1427,7 +1209,6 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 		gpd_data->td = *td;
 
 	gpd_data->base.dev = dev;
-	gpd_data->need_restore = -1;
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
@@ -1489,7 +1270,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 
 	if (genpd->prepared_count > 0) {
 		ret = -EAGAIN;
@@ -1506,7 +1287,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
  out:
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1550,7 +1331,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	gpd_data = to_gpd_data(pdd);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
 
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 
 	if (genpd->prepared_count > 0) {
 		ret = -EAGAIN;
@@ -1565,14 +1346,14 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	list_del_init(&pdd->list_node);
 
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 
 	genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
 
  out:
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
 
 	return ret;
@@ -1593,17 +1374,9 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 	    || genpd == subdomain)
 		return -EINVAL;
 
- start:
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
 
-	if (subdomain->status != GPD_STATE_POWER_OFF
-	    && subdomain->status != GPD_STATE_ACTIVE) {
-		mutex_unlock(&subdomain->lock);
-		genpd_release_lock(genpd);
-		goto start;
-	}
-
 	if (genpd->status == GPD_STATE_POWER_OFF
 	    &&  subdomain->status != GPD_STATE_POWER_OFF) {
 		ret = -EINVAL;
@@ -1631,7 +1404,7 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 
  out:
 	mutex_unlock(&subdomain->lock);
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 
 	return ret;
 }
@@ -1679,8 +1452,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
 		return -EINVAL;
 
- start:
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 
 	list_for_each_entry(link, &genpd->master_links, master_node) {
 		if (link->slave != subdomain)
@@ -1688,13 +1460,6 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 
 		mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
 
-		if (subdomain->status != GPD_STATE_POWER_OFF
-		    && subdomain->status != GPD_STATE_ACTIVE) {
-			mutex_unlock(&subdomain->lock);
-			genpd_release_lock(genpd);
-			goto start;
-		}
-
 		list_del(&link->master_node);
 		list_del(&link->slave_node);
 		kfree(link);
@@ -1707,7 +1472,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 		break;
 	}
 
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 
 	return ret;
 }
@@ -1731,7 +1496,7 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 	if (IS_ERR_OR_NULL(genpd) || state < 0)
 		return -EINVAL;
 
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 
 	if (genpd->cpuidle_data) {
 		ret = -EEXIST;
@@ -1762,7 +1527,7 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 	genpd_recalc_cpu_exit_latency(genpd);
 
  out:
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 	return ret;
 
  err:
@@ -1799,7 +1564,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 	if (IS_ERR_OR_NULL(genpd))
 		return -EINVAL;
 
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 
 	cpuidle_data = genpd->cpuidle_data;
 	if (!cpuidle_data) {
@@ -1817,7 +1582,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 	kfree(cpuidle_data);
 
  out:
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 	return ret;
 }
 
@@ -1899,9 +1664,6 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->in_progress = 0;
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
-	init_waitqueue_head(&genpd->status_wait_queue);
-	genpd->poweroff_task = NULL;
-	genpd->resume_count = 0;
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
 	genpd->max_off_time_changed = true;
@@ -2274,9 +2036,6 @@ static int pm_genpd_summary_one(struct seq_file *s,
 {
 	static const char * const status_lookup[] = {
 		[GPD_STATE_ACTIVE] = "on",
-		[GPD_STATE_WAIT_MASTER] = "wait-master",
-		[GPD_STATE_BUSY] = "busy",
-		[GPD_STATE_REPEAT] = "off-in-progress",
 		[GPD_STATE_POWER_OFF] = "off"
 	};
 	struct pm_domain_data *pm_data;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 681ccb0..b2725e6 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -22,9 +22,6 @@
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
-	GPD_STATE_WAIT_MASTER,	/* PM domain's master is being waited for */
-	GPD_STATE_BUSY,		/* Something is happening to the PM domain */
-	GPD_STATE_REPEAT,	/* Power off in progress, to be repeated */
 	GPD_STATE_POWER_OFF,	/* PM domain is off */
 };
 
@@ -59,9 +56,6 @@ struct generic_pm_domain {
 	unsigned int in_progress;	/* Number of devices being suspended now */
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
-	wait_queue_head_t status_wait_queue;
-	struct task_struct *poweroff_task;	/* Powering off task */
-	unsigned int resume_count;	/* Number of devices being resumed */
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
@@ -113,7 +107,6 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
-	int need_restore;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
-- 
1.9.1

