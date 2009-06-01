From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Tue, 2 Jun 2009 01:21:38 +0200
Message-ID: <200906020121.38946.rjw__44796.1082020358$1243898609$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906011726150.3972-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906011726150.3972-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 02 June 2009, Alan Stern wrote:
> On Mon, 1 Jun 2009, Rafael J. Wysocki wrote:
> 
> > > With USB at least, this isn't true.  Some work items shouldn't be
> > > dequeued, namely, various sorts of resume requests generated while the
> > > driver is in interrupt context.  If they were dequeued during a system
> > > suspend then the device wouldn't ever be woken up, because usbcore
> > > doesn't pass system-resume messages to an autosuspended device.  The
> > > idea is if a device was autosuspended before the system sleep then it
> > > should remain autosuspended after the system wakes up.
> > 
> > Hmm, well, I'm not sure, really.  During a system-wide resume, does it really
> > matter if devices were autosuspended before the preceding suspend or they have
> > been suspended by the PM core?
> 
> It's partly a question of avoiding unnecessary activity.  Is there any
> reason to resume a device if it's just going to be autosuspended again
> a few seconds later?

Well, I'm not sure if we know in advance what's going to happen to the device
right after a system-wide resume.  It may be a totally different situation from
the device activity point of view.

> It's also a matter of principle.  A system sleep should be as
> transparent as possible (except for the passage of time, of course).  
> When the sleep is over, devices should be in the same state as before
> it began.

As a matter of fact, this need not be true at all.  For example, consider a
wireless network adapter that was assosicated with specific access point
before a system-wide suspend, but this access point is not present any more
after the subsequent system-wide resume.

I really don't think we can predict what's going to happen to a device after
a system-wide resume, so IMO we should assume that the device will be necessary
immediately after the resume and we should resume it.  It still can autosuspend
normally afterwards if it's not needed after all.

> >  Also, what happens if the platform firmware
> > resumes the autosuspended devices before passing control to the kernel during
> > system-wide resume?  How do we handle that?
> 
> In the case of USB, it's not possible to resume a suspended device
> without first resuming and using a host controller.  The host
> controller driver will realize that the firmware has taken over the
> controller and will reset the controller.
> 
> For devices that were not autosuspended, this action converts an
> ordinary resume into a reset-resume.  A different driver method is
> called, and drivers that don't support reset-resume are automatically
> unbound from their devices (and then reprobed afterward).
> 
> For devices that were autosuspended, the controller reset will put them 
> back into a suspended state.  They will remain that way until they are 
> autoresumed -- and of course it will be an "auto-reset-resume".

I'm not sure if this is doable so easily for PCI devices, for one example.
Most probably, they will come up in D0 after the system-wide suspend and
the PCI resume code will have to suspend them directly so that they remain
"autosuspended" after the resume.

> What happens if the firmware is sufficiently sneaky that it manages to
> fool the host controller driver?  In that case we end up with a device
> that really is at full power even though the kernel thinks it is
> autosuspended.  When we finally try to autoresume it, we will realize
> that it wasn't suspended after all.
> 
> > Moreover, what if the autosuspended device is no longer present in the system
> > after a system-wide resume.  Are we still going to attempt to autoresume it?
> 
> When the device or perhaps its parent hub is resumed, we will realize 
> the device is gone.  An attempted autoresume will simply fail.  Until 
> that happens, the kernel may believe the device is present when in fact 
> it isn't.
> 
> > > Furthermore, even if the existing work items were dequeued, you'd still 
> > > have to worry about new work items added on by drivers before they get 
> > > suspended.  If the workqueue were allowed to run freely, we might find 
> > > devices being autoresumed in the middle of the sleep transition!
> > 
> > Unless there's some other kind of synchronization between the workqueue and the
> > core suspend-resume code.
> 
> So the work routine would somehow be aware when a system sleep is in
> progress, at which point it would return immediately without doing
> anything?  That seems racey.  Isn't it easier just to freeze the
> workqueue?

Well, yes and no.  Namely, if we freeze the workqueue, all of the bus types
using it will have to check the vaildity of operations carried out by it,
because of the possibility that system-wide power transition took place in the
meantime and changed the state of the device.  Also, please take the PCI
example into consideration.

> > IMO, it would be convenient to treat every system-wide suspend (or hibernation)
> > as a cancellation point for all of the pending autosuspend and autoresume
> > requests and to treat devices autosuspended before that point as just
> > suspended.  Of course, the bus type and device driver suspend callbacks would
> > have to be prepared to handle this situation cleanly.
> 
> For pending autosuspend, okay.  The device was powered up before the
> system sleep, it remains powered up afterward, and another autosuspend
> will occur in due course.
> 
> For pending autoresume requests coming from user I/O calls, again okay.  
> There can't be any of these because userspace is frozen, and besides,
> they wouldn't go through the workqueue anyway.
> 
> For autoresume requests coming from an interrupt handler, I'm not so 
> sure.  I don't know of any good examples -- in fact there don't seem to 
> be any examples at the moment.  (The USB core supports autoresume 
> requests in interrupt context, AFAICS no driver uses them.)  So maybe 
> it's premature to worry about this case.

Hmm.  Can you please describe a theoretical situation in which this kind
of autoresume request will appear?  I'm not really sure what you mean here. :-)

> Lastly, we have resume requests coming from a device -- i.e., remote
> wakeup requests.  This is a little tricky.  Suppose you have remote
> wakeup enabled, and you press a key on your USB keyboard just as the
> computer is going to sleep.  Should this cause the sleep to be aborted?  
> Should it cause the computer to wake back up again right away?  Should
> the keystroke be ignored?

This is a difficult problem in general.  I _think_ we should ignore such
autoresume requests for devices that are not marked as wake-up ones
and we should abort the suspend if there's a request from a wake-up device.
 
> More to the point, suppose you plug in a new USB device as the computer
> is going to sleep.  When the computer wakes up, shouldn't it realize
> that a new device has been connected?  This is the same problem that
> other people have been discussing -- what should happen to wakeup IRQs
> during the time the system is suspending?  Will they get delivered 
> later on (and when drivers are ready to receive them)?

I think they should abort the suspend unless it's too late (eg. the suspend
sequence has reached sysdev_suspend()).

Anyway, below is a prototype implementation of a generic runtime PM workqueue,
just for discussion.

pm_schedule_suspend() and pm_schedule_resume() are to be called by bus types
that are requesting the autosuspend or autoresume, respectively, of a device.
The supposed control flow is like this:
* bus type calls pm_schedule_suspend() to schedule autosuspend of a device
* at the right time the PM workqueue executes the bus type's ->autosuspend()
  callback which is responsible for calling the device driver to suspend the
  device (the way in which this is done is totally bus type-specific)
* if there's a resume event for the device, it's delivered to the bus type
  driver (in a bus type-specific way) and the bus type schedules autoresume of
  the device by calling pm_schedule_resume()
* the PM workqueue executes the bus type's ->autoresume() as soon as it can
  and this callback is responsible for calling the device driver to resume the
  device (the way in which this is done is totally bus type-specific).

Thanks,
Rafael

---
 drivers/base/power/main.c |   11 ++++--
 include/linux/pm.h        |   16 +++++++++
 kernel/power/main.c       |   75 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -22,6 +22,7 @@
 #define _LINUX_PM_H
 
 #include <linux/list.h>
+#include <linux/workqueue.h>
 
 /*
  * Callbacks for platform drivers to implement.
@@ -182,6 +183,8 @@ struct dev_pm_ops {
 	int (*thaw_noirq)(struct device *dev);
 	int (*poweroff_noirq)(struct device *dev);
 	int (*restore_noirq)(struct device *dev);
+	int (*autosuspend)(struct device *dev);
+	int (*autoresume)(struct device *dev);
 };
 
 /**
@@ -323,8 +326,21 @@ struct dev_pm_info {
 #ifdef	CONFIG_PM_SLEEP
 	struct list_head	entry;
 #endif
+	struct delayed_work	dwork;
 };
 
+extern void pm_schedule_suspend(struct device *dev, unsigned long delay);
+extern void pm_schedule_resume(struct device *dev);
+
+extern bool transition_started;
+
+static inline bool pm_transition_in_progress(void)
+{
+	return transition_started;
+}
+
+extern void pm_flush_workqueue(void);
+
 /*
  * The PM_EVENT_ messages are also used by drivers implementing the legacy
  * suspend framework, based on the ->suspend() and ->resume() callbacks common
Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -22,6 +22,8 @@
 #include <linux/freezer.h>
 #include <linux/vmstat.h>
 #include <linux/syscalls.h>
+#include <linux/workqueue.h>
+#include <linux/device.h>
 
 #include "power.h"
 
@@ -578,12 +580,20 @@ static struct attribute_group attr_group
 	.attrs = g,
 };
 
+static int __init pm_start_workqueue(void);
 
 static int __init pm_init(void)
 {
+	int error;
+
+	error = pm_start_workqueue();
+	if (error)
+		return error;
+
 	power_kobj = kobject_create_and_add("power", NULL);
 	if (!power_kobj)
 		return -ENOMEM;
+
 	return sysfs_create_group(power_kobj, &attr_group);
 }
 
@@ -729,3 +739,68 @@ done:
 late_initcall(test_suspend);
 
 #endif /* CONFIG_PM_TEST_SUSPEND */
+
+
+static struct workqueue_struct *pm_wq;
+
+static int __init pm_start_workqueue(void)
+{
+	pm_wq = create_singlethread_workqueue("pm");
+
+	return pm_wq ? 0 : -ENOMEM;
+}
+
+void pm_flush_workqueue(void)
+{
+	flush_workqueue(pm_wq);
+}
+
+static inline struct device *pm_dwork_to_device(struct delayed_work *dwork)
+{
+	struct dev_pm_info *d = container_of(dwork, struct dev_pm_info, dwork);
+	return container_of(d, struct device, power);
+}
+
+static void pm_autosuspend(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct device *dev = pm_dwork_to_device(dwork);
+
+	device_pm_lock();
+	if (dev && dev->bus && dev->bus->pm && dev->bus->pm->autosuspend
+	    && !pm_transition_in_progress())
+		dev->bus->pm->autosuspend(dev);
+	device_pm_unlock();
+}
+
+void pm_schedule_suspend(struct device *dev, unsigned long delay)
+{
+	device_pm_lock();
+	if (!pm_transition_in_progress()) {
+		INIT_DELAYED_WORK(&dev->power.dwork, pm_autosuspend);
+		queue_delayed_work(pm_wq, &dev->power.dwork, delay);
+	}
+	device_pm_unlock();
+}
+
+static void pm_autoresume(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct device *dev = pm_dwork_to_device(dwork);
+
+	device_pm_lock();
+	if (dev && dev->bus && dev->bus->pm && dev->bus->pm->autoresume
+	    && !pm_transition_in_progress())
+		dev->bus->pm->autoresume(dev);
+	device_pm_unlock();
+}
+
+void pm_schedule_resume(struct device *dev)
+{
+	device_pm_lock();
+	if (!pm_transition_in_progress()) {
+		INIT_WORK(&dev->power.dwork.work, pm_autoresume);
+		queue_work(pm_wq, &dev->power.dwork.work);
+	}
+	device_pm_unlock();
+}
Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -46,7 +46,7 @@ static DEFINE_MUTEX(dpm_list_mtx);
  * Set once the preparation of devices for a PM transition has started, reset
  * before starting to resume devices.  Protected by dpm_list_mtx.
  */
-static bool transition_started;
+bool transition_started;
 
 /**
  *	device_pm_lock - lock the list of active devices used by the PM core
@@ -436,7 +436,6 @@ static void dpm_resume(pm_message_t stat
 
 	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
-	transition_started = false;
 	while (!list_empty(&dpm_list)) {
 		struct device *dev = to_device(dpm_list.next);
 
@@ -461,6 +460,7 @@ static void dpm_resume(pm_message_t stat
 		put_device(dev);
 	}
 	list_splice(&list, &dpm_list);
+	transition_started = false;
 	mutex_unlock(&dpm_list_mtx);
 }
 
@@ -752,9 +752,14 @@ static int dpm_prepare(pm_message_t stat
 	struct list_head list;
 	int error = 0;
 
-	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
 	transition_started = true;
+	mutex_unlock(&dpm_list_mtx);
+
+	pm_flush_workqueue();
+
+	INIT_LIST_HEAD(&list);
+	mutex_lock(&dpm_list_mtx);
 	while (!list_empty(&dpm_list)) {
 		struct device *dev = to_device(dpm_list.next);
 
