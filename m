From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Allow runtime suspend during system resume
Date: Wed, 08 Jan 2014 23:55:53 +0100
Message-ID: <1860008.68DHz0qP41@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1401081522240.1659-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61776 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757332AbaAHWmE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2014 17:42:04 -0500
In-Reply-To: <Pine.LNX.4.44L0.1401081522240.1659-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Phillip Susi <psusi@ubuntu.com>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Wednesday, January 08, 2014 03:44:53 PM Alan Stern wrote:
> On Wed, 8 Jan 2014, Alan Stern wrote:
> 
> > On Wed, 8 Jan 2014, Alan Stern wrote:
> > 
> > > In essence, you want your disk's state to move directly from unpowered
> > > (system asleep) to runtime-suspended with no intermediate active -- but
> > > only if the disk doesn't spin up all by itself.
> > 
> > > In the end, it sounds like what you want can be done fairly easily.  
> > 
> > It turns out there is a snag.  The PM core is set up such that during
> > system sleep transitions, there's no way to tell whether or not
> > userspace has permitted runtime PM for a device.  (This is because the
> > core wants to prevent untimely runtime suspends from occurring in the
> > middle of a system sleep transition, and to do so it uses the same
> > mechanism as it does when userspace disallows runtime suspend.)
> > 
> > As a result, we must not go directly from unpowered to
> > runtime-suspended.  Not without some sort of change to the PM core.
> 
> Rafael:
> 
> Right now the PM core does pm_runtime_get_noresume() during the prepare 
> phase of system sleep, and pm_runtime_put() during the complete phase.  
> Maybe we should cut down the range of coverage.
> 
> For example, we could do the pm_runtime_put() during dpm_resume(), or 
> even earlier.  That way, the resume routine could do something like:
> 
> 	if (!pm_runtime_in_use(dev)) {
> 		pm_runtime_disable(dev);
> 		pm_runtime_set_suspended(dev);
> 		pm_runtime_enable(dev);
> 		return 0;
> 	}
> 
> where pm_runtime_in_use() would check the device's usage counters.  
> The device would come out of system sleep in a powered-down state, and
> could remain runtime-suspended with no need for an extra
> power-up/power-down cycle.  Isn't this the sort of thing the embedded
> people want to do?
> 
> As it is, drivers have no way to safely put devices directly into 
> runtime suspend when coming out of system sleep.
> 
> What do you think?

There are two problems here.

First off, for some devices that were runtime-suspended before system suspend
we may not want to touch them at all during system suspend/resume.  I think
I know how to address that, but I need to prepare patches yet.  That's going
to take a few days at least, sorry about that.

Second, we may want some devices to be set to "runtime suspended" during
system resume without touching them, so that runtime PM resumes them when
necessary.  I have a patch for that, which hasn't been published yet and which
is appended.

The way it works is that whoever wants the system resume of certain device
to be skipped, sets the (new) skip_resume flag for that device using
device_pm_skip_resume() and that causes the PM core to basically ignore that
device's PM callbacks during system resume.

Whether or not doing the pm_request_resume(dev) for devices with skip_resume
set in dpm_resume_early() is a good idea is a discussion item in my opinion
(evidently, I thought it was when I was preparing this patch).

Thanks,
Rafael


---
 drivers/base/power/main.c |   98 ++++++++++++++++++++++++++++++++++------------
 include/linux/pm.h        |   13 +++++-
 2 files changed, 85 insertions(+), 26 deletions(-)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -532,9 +532,12 @@ struct dev_pm_info {
 	struct wakeup_source	*wakeup;
 	bool			wakeup_path:1;
 	bool			syscore:1;
+#ifdef CONFIG_PM_RUNTIME
+	bool			skip_resume:1;
+#endif
 #else
 	unsigned int		should_wakeup:1;
-#endif
+#endif /* CONFIG_PM_SLEEP */
 #ifdef CONFIG_PM_RUNTIME
 	struct timer_list	suspend_timer;
 	unsigned long		timer_expires;
@@ -561,7 +564,7 @@ struct dev_pm_info {
 	unsigned long		active_jiffies;
 	unsigned long		suspended_jiffies;
 	unsigned long		accounting_timestamp;
-#endif
+#endif /* CONFIG_PM_RUNTIME */
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	struct dev_pm_qos	*qos;
 };
@@ -716,4 +719,10 @@ enum dpm_order {
 	DPM_ORDER_DEV_LAST,
 };
 
+#if defined(CONFIG_PM_RUNTIME) && defined(CONFIG_PM_SLEEP)
+void device_pm_skip_resume(struct device *dev, bool enable);
+#else
+static inline void device_pm_skip_resume(struct device *dev, bool enable) {}
+#endif /* CONFIG_PM_RUNTIME && CONFIG_PM_SLEEP */
+
 #endif /* _LINUX_PM_H */
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -384,6 +384,29 @@ static int dpm_run_callback(pm_callback_
 	return error;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+void device_pm_skip_resume(struct device *dev, bool enable)
+{
+	device_pm_lock();
+
+	if (!dev->power.is_prepared)
+		dev->power.skip_resume = !!enable;
+
+	device_pm_unlock();
+}
+
+static inline bool skip_device_resume(struct device *dev, pm_message_t state)
+{
+	return dev->power.skip_resume && (state.event == PM_EVENT_RESUME
+		|| state.event == PM_EVENT_RESTORE);
+}
+#else
+static inline bool skip_device_resume(struct device *dev, pm_message_t state)
+{
+	return false;
+}
+#endif /* CONFIG_PM_RUNTIME */
+
 /*------------------------- Resume routines -------------------------*/
 
 /**
@@ -446,21 +469,24 @@ static void dpm_resume_noirq(pm_message_
 	mutex_lock(&dpm_list_mtx);
 	while (!list_empty(&dpm_noirq_list)) {
 		struct device *dev = to_device(dpm_noirq_list.next);
-		int error;
 
 		get_device(dev);
 		list_move_tail(&dev->power.entry, &dpm_late_early_list);
-		mutex_unlock(&dpm_list_mtx);
+		if (!skip_device_resume(dev, state)) {
+			int error;
 
-		error = device_resume_noirq(dev, state);
-		if (error) {
-			suspend_stats.failed_resume_noirq++;
-			dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
-			dpm_save_failed_dev(dev_name(dev));
-			pm_dev_err(dev, state, " noirq", error);
-		}
+			mutex_unlock(&dpm_list_mtx);
+
+			error = device_resume_noirq(dev, state);
+			if (error) {
+				suspend_stats.failed_resume_noirq++;
+				dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
+				dpm_save_failed_dev(dev_name(dev));
+				pm_dev_err(dev, state, " noirq", error);
+			}
 
-		mutex_lock(&dpm_list_mtx);
+			mutex_lock(&dpm_list_mtx);
+		}
 		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
@@ -527,21 +553,39 @@ static void dpm_resume_early(pm_message_
 	mutex_lock(&dpm_list_mtx);
 	while (!list_empty(&dpm_late_early_list)) {
 		struct device *dev = to_device(dpm_late_early_list.next);
-		int error;
 
 		get_device(dev);
 		list_move_tail(&dev->power.entry, &dpm_suspended_list);
-		mutex_unlock(&dpm_list_mtx);
+		if (skip_device_resume(dev, state)) {
+			pm_runtime_set_suspended(dev);
+			pm_runtime_enable(dev);
+			/*
+			 * Balance the pm_runtime_get_noresume() in
+			 * device_prepare().
+			 */
+			pm_runtime_put_noidle(dev);
+			/*
+			 * The device might have been powered up by the platform
+			 * firmware already, so make it resume and then possibly
+			 * suspend again to avoid leaving powered up devices as
+			 * "suspended" for too long.
+			 */
+			pm_request_resume(dev);
+		} else {
+			int error;
 
-		error = device_resume_early(dev, state);
-		if (error) {
-			suspend_stats.failed_resume_early++;
-			dpm_save_failed_step(SUSPEND_RESUME_EARLY);
-			dpm_save_failed_dev(dev_name(dev));
-			pm_dev_err(dev, state, " early", error);
-		}
+			mutex_unlock(&dpm_list_mtx);
+
+			error = device_resume_early(dev, state);
+			if (error) {
+				suspend_stats.failed_resume_early++;
+				dpm_save_failed_step(SUSPEND_RESUME_EARLY);
+				dpm_save_failed_dev(dev_name(dev));
+				pm_dev_err(dev, state, " early", error);
+			}
 
-		mutex_lock(&dpm_list_mtx);
+			mutex_lock(&dpm_list_mtx);
+		}
 		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
@@ -682,6 +726,10 @@ void dpm_resume(pm_message_t state)
 
 	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
 		INIT_COMPLETION(dev->power.completion);
+		if (skip_device_resume(dev, state)) {
+			complete(&dev->power.completion);
+			continue;
+		}
 		if (is_async(dev)) {
 			get_device(dev);
 			async_schedule(async_resume, dev);
@@ -691,7 +739,7 @@ void dpm_resume(pm_message_t state)
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
 		get_device(dev);
-		if (!is_async(dev)) {
+		if (!is_async(dev) && !skip_device_resume(dev, state)) {
 			int error;
 
 			mutex_unlock(&dpm_list_mtx);
@@ -780,11 +828,13 @@ void dpm_complete(pm_message_t state)
 		get_device(dev);
 		dev->power.is_prepared = false;
 		list_move(&dev->power.entry, &list);
-		mutex_unlock(&dpm_list_mtx);
+		if (!skip_device_resume(dev, state)) {
+			mutex_unlock(&dpm_list_mtx);
 
-		device_complete(dev, state);
+			device_complete(dev, state);
 
-		mutex_lock(&dpm_list_mtx);
+			mutex_lock(&dpm_list_mtx);
+		}
 		put_device(dev);
 	}
 	list_splice(&list, &dpm_list);

