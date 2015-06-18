From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V4] PM / Domains: Remove intermediate states from the power off sequence
Date: Thu, 18 Jun 2015 15:17:53 +0200
Message-ID: <1434633473-12908-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:34781 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbbFRNSF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 09:18:05 -0400
Received: by labbc20 with SMTP id bc20so54188228lab.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 06:18:03 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

Genpd's ->runtime_suspend() (assigned to pm_genpd_runtime_suspend())
doesn't immediately walk the hierarchy of ->runtime_suspend() callbacks.
Instead, pm_genpd_runtime_suspend() calls pm_genpd_poweroff() which
postpones that until *all* the devices in the genpd are runtime suspended.

When pm_genpd_poweroff() discovers that the last device in the genpd is
about to be runtime suspended, it calls __pm_genpd_save_device() for *all*
the devices in the genpd sequentially. Furthermore,
__pm_genpd_save_device() invokes the ->start() callback, walks the
hierarchy of the ->runtime_suspend() callbacks and invokes the ->stop()
callback. This causes a "thundering herd" problem.

Let's address this issue by having pm_genpd_runtime_suspend() immediately
walk the hierarchy of the ->runtime_suspend() callbacks, instead of
postponing that to the power off sequence via pm_genpd_poweroff(). If the
selected ->runtime_suspend() callback doesn't return an error code, call
pm_genpd_poweroff() to see if it's feasible to also power off the PM
domain.

Adopting this change enables us to simplify parts of the code in genpd,
for example the locking mechanism. Additionally, it gives some positive
side effects, as described below.

i)
One device's ->runtime_resume() latency is no longer affected by other
devices' latencies in a genpd.

The complexity genpd has to support the option to abort the power off
sequence suffers from latency issues. More precisely, a device that is
requested to be runtime resumed, may end up waiting for
__pm_genpd_save_device() to complete its operations for *another* device.
That's because pm_genpd_poweroff() can't confirm an abort request while it
waits for __pm_genpd_save_device() to return.

As this patch removes the intermediate states in pm_genpd_poweroff() while
powering off the PM domain, we no longer need the ability to abort that
sequence.

ii)
Make pm_runtime[_status]_suspended() reliable when used with genpd.

Until the last device in a genpd becomes idle, pm_genpd_runtime_suspend()
will return 0 without actually walking the hierarchy of the
->runtime_suspend() callbacks. However, by returning 0 the runtime PM core
considers the device as runtime_suspended, so
pm_runtime[_status]_suspended() will return true, even though the device
isn't (yet) runtime suspended.

After this patch, since pm_genpd_runtime_suspend() immediately walks the
hierarchy of the ->runtime_suspend() callbacks,
pm_runtime[_status]_suspended() will accurately reflect the status of the
device.

iii)
Enable fine-grained PM through runtime PM callbacks in drivers/subsystems.

There are currently cases were drivers/subsystems implements runtime PM
callbacks to deploy fine-grained PM (e.g. gate clocks, move pinctrl to
power-save state, etc.). While using the genpd, pm_genpd_runtime_suspend()
postpones invoking these callbacks until *all* the devices in the genpd
are runtime suspended. In essence, one runtime resumed device prevents
fine-grained PM for other devices within the same genpd.

After this patch, since pm_genpd_runtime_suspend() immediately walks the
hierarchy of the ->runtime_suspend() callbacks, fine-grained PM is enabled
throughout all the levels of runtime PM callbacks.

iiii)
Enable fine-grained PM for IRQ safe devices

Per the definition for an IRQ safe device, its runtime PM callbacks must
be able to execute in atomic context. In the path while genpd walks the
hierarchy of the ->runtime_suspend() callbacks for the device, it uses a
mutex. Therefore, genpd prevents that path to be executed for IRQ safe
devices.

As this patch changes pm_genpd_runtime_suspend() to immediately walk the
hierarchy of the ->runtime_suspend() callbacks and without needing to use
a mutex, fine-grained PM is enabled throughout all the levels of runtime
PM callbacks for IRQ safe devices.

Unfortunately this patch also comes with a drawback, as described in the
summary below.

Driver's/subsystem's runtime PM callbacks may be invoked even when the
genpd hasn't actually powered off the PM domain, potentially introducing
unnecessary latency.

However, in most cases, saving/restoring register contexts for devices are
typically fast operations or can be optimized in device specific ways
(e.g. shadow copies of register contents in memory, device-specific checks
to see if context has been lost before restoring context, etc.).

Still, in some cases the driver/subsystem may suffer from latency if
runtime PM is used in a very fine-grained manner (e.g. for each IO request
or xfer). To prevent that extra overhead, the driver/subsystem may deploy
the runtime PM autosuspend feature.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- According to comments from Lina, restore to existing behavior to
	invoke the ->start|stop() callbacks for IRQ safe devices.
	- Improve fine-grained PM support for IRQ safe devices, by allowing to
	walk the hierarchy of the ->runtime_suspend|resume() callbacks.
	- Updated the changelog to describe the forth positive side effect case
	conserning IRQ safe devices.
	- Rebased on top Geert's recently queued genpd patch.

Changes in v3:
	Moved from RFC to PATCH.
	According to comment from Lina, changed __pm_genpd_poweron() to keep
	current behavior which means to *not* power off potentially unused
	masters in the error path. Instead, let's deal with that from a separate
	patch.
	Updated a comment in pm_genpd_poweroff().

Changes in v2:
	Updated the changelog and the commit message header.
	Header for v1 was "PM / Domains: Minimize latencies by not delaying
	save/restore".

---
 drivers/base/power/domain.c | 363 ++++++++------------------------------------
 include/linux/pm_domain.h   |   7 -
 2 files changed, 62 insertions(+), 308 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cdd547b..87d405a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -111,8 +111,12 @@ static int genpd_stop_dev(struct generic_pm_domain *genpd, struct device *dev)
 					stop_latency_ns, "stop");
 }
 
-static int genpd_start_dev(struct generic_pm_domain *genpd, struct device *dev)
+static int genpd_start_dev(struct generic_pm_domain *genpd, struct device *dev,
+			bool timed)
 {
+	if (!timed)
+		return GENPD_DEV_CALLBACK(genpd, int, start, dev);
+
 	return GENPD_DEV_TIMED_CALLBACK(genpd, int, start, dev,
 					start_latency_ns, "start");
 }
@@ -133,41 +137,6 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
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
@@ -248,35 +217,14 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
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
@@ -291,20 +239,8 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
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
@@ -316,8 +252,7 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 		goto err;
 
  out:
-	genpd_set_active(genpd);
-
+	genpd->status = GPD_STATE_ACTIVE;
 	return 0;
 
  err:
@@ -353,20 +288,18 @@ int pm_genpd_name_poweron(const char *domain_name)
 	return genpd ? pm_genpd_poweron(genpd) : -EINVAL;
 }
 
-static int genpd_start_dev_no_timing(struct generic_pm_domain *genpd,
-				     struct device *dev)
-{
-	return GENPD_DEV_CALLBACK(genpd, int, start, dev);
-}
-
 static int genpd_save_dev(struct generic_pm_domain *genpd, struct device *dev)
 {
 	return GENPD_DEV_TIMED_CALLBACK(genpd, int, save_state, dev,
 					save_state_latency_ns, "state save");
 }
 
-static int genpd_restore_dev(struct generic_pm_domain *genpd, struct device *dev)
+static int genpd_restore_dev(struct generic_pm_domain *genpd,
+			struct device *dev, bool timed)
 {
+	if (!timed)
+		return GENPD_DEV_CALLBACK(genpd, int, restore_state, dev);
+
 	return GENPD_DEV_TIMED_CALLBACK(genpd, int, restore_state, dev,
 					restore_state_latency_ns,
 					"state restore");
@@ -413,89 +346,6 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
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
@@ -512,34 +362,26 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
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
-	 * (2) The domain is waiting for its master to power up.
-	 * (3) One of the domain's devices is being resumed right now.
-	 * (4) System suspend is in progress.
+	 * (2) System suspend is in progress.
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
 
@@ -557,41 +399,11 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
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
@@ -604,14 +416,14 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
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
@@ -622,10 +434,8 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		 * happen very often).
 		 */
 		ret = genpd_power_off(genpd, true);
-		if (ret == -EBUSY) {
-			genpd_set_active(genpd);
-			goto out;
-		}
+		if (ret)
+			return ret;
 	}
 
 	genpd->status = GPD_STATE_POWER_OFF;
@@ -635,10 +445,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		genpd_queue_power_off_work(link->master);
 	}
 
- out:
-	genpd->poweroff_task = NULL;
-	wake_up_all(&genpd->status_wait_queue);
-	return ret;
+	return 0;
 }
 
 /**
@@ -651,9 +458,9 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 	pm_genpd_poweroff(genpd);
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 }
 
 /**
@@ -667,7 +474,6 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 static int pm_genpd_runtime_suspend(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	struct generic_pm_domain_data *gpd_data;
 	bool (*stop_ok)(struct device *__dev);
 	int ret;
 
@@ -681,10 +487,16 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	if (stop_ok && !stop_ok(dev))
 		return -EBUSY;
 
-	ret = genpd_stop_dev(genpd, dev);
+	ret = genpd_save_dev(genpd, dev);
 	if (ret)
 		return ret;
 
+	ret = genpd_stop_dev(genpd, dev);
+	if (ret) {
+		genpd_restore_dev(genpd, dev, true);
+		return ret;
+	}
+
 	/*
 	 * If power.irq_safe is set, this routine will be run with interrupts
 	 * off, so it can't use mutexes.
@@ -693,16 +505,6 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 		return 0;
 
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
@@ -722,8 +524,8 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 static int pm_genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	DEFINE_WAIT(wait);
 	int ret;
+	bool timed = true;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -732,39 +534,21 @@ static int pm_genpd_runtime_resume(struct device *dev)
 		return -EINVAL;
 
 	/* If power.irq_safe, the PM domain is never powered off. */
-	if (dev->power.irq_safe)
-		return genpd_start_dev_no_timing(genpd, dev);
+	if (dev->power.irq_safe) {
+		timed = false;
+		goto out;
+	}
 
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
+ out:
+	genpd_start_dev(genpd, dev, timed);
+	genpd_restore_dev(genpd, dev, timed);
 
 	return 0;
 }
@@ -880,7 +664,7 @@ static void pm_genpd_sync_poweron(struct generic_pm_domain *genpd,
 {
 	struct gpd_link *link;
 
-	if (genpd->status != GPD_STATE_POWER_OFF)
+	if (genpd->status == GPD_STATE_ACTIVE)
 		return;
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
@@ -957,14 +741,14 @@ static int pm_genpd_prepare(struct device *dev)
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
@@ -1099,7 +883,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	pm_genpd_sync_poweron(genpd, true);
 	genpd->suspended_count--;
 
-	return genpd_start_dev(genpd, dev);
+	return genpd_start_dev(genpd, dev, true);
 }
 
 /**
@@ -1227,7 +1011,7 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_start_dev(genpd, dev);
+	return genpd->suspend_power_off ? 0 : genpd_start_dev(genpd, dev, true);
 }
 
 /**
@@ -1321,7 +1105,7 @@ static int pm_genpd_restore_noirq(struct device *dev)
 
 	pm_genpd_sync_poweron(genpd, true);
 
-	return genpd_start_dev(genpd, dev);
+	return genpd_start_dev(genpd, dev, true);
 }
 
 /**
@@ -1437,7 +1221,6 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 		gpd_data->td = *td;
 
 	gpd_data->base.dev = dev;
-	gpd_data->need_restore = -1;
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
@@ -1499,7 +1282,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 
 	if (genpd->prepared_count > 0) {
 		ret = -EAGAIN;
@@ -1516,7 +1299,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
  out:
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1560,7 +1343,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	gpd_data = to_gpd_data(pdd);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
 
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 
 	if (genpd->prepared_count > 0) {
 		ret = -EAGAIN;
@@ -1575,14 +1358,14 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
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
@@ -1603,17 +1386,9 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
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
@@ -1641,7 +1416,7 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 
  out:
 	mutex_unlock(&subdomain->lock);
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 
 	return ret;
 }
@@ -1689,8 +1464,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
 		return -EINVAL;
 
- start:
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 
 	list_for_each_entry(link, &genpd->master_links, master_node) {
 		if (link->slave != subdomain)
@@ -1698,13 +1472,6 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 
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
@@ -1717,7 +1484,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 		break;
 	}
 
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 
 	return ret;
 }
@@ -1741,7 +1508,7 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 	if (IS_ERR_OR_NULL(genpd) || state < 0)
 		return -EINVAL;
 
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 
 	if (genpd->cpuidle_data) {
 		ret = -EEXIST;
@@ -1772,7 +1539,7 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 	genpd_recalc_cpu_exit_latency(genpd);
 
  out:
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 	return ret;
 
  err:
@@ -1809,7 +1576,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 	if (IS_ERR_OR_NULL(genpd))
 		return -EINVAL;
 
-	genpd_acquire_lock(genpd);
+	mutex_lock(&genpd->lock);
 
 	cpuidle_data = genpd->cpuidle_data;
 	if (!cpuidle_data) {
@@ -1827,7 +1594,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 	kfree(cpuidle_data);
 
  out:
-	genpd_release_lock(genpd);
+	mutex_unlock(&genpd->lock);
 	return ret;
 }
 
@@ -1909,9 +1676,6 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->in_progress = 0;
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
-	init_waitqueue_head(&genpd->status_wait_queue);
-	genpd->poweroff_task = NULL;
-	genpd->resume_count = 0;
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
 	genpd->max_off_time_changed = true;
@@ -2284,9 +2048,6 @@ static int pm_genpd_summary_one(struct seq_file *s,
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

