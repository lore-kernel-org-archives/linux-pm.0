From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/9] PM / ACPI: Provide option to disable direct_complete for ACPI devices
Date: Fri, 25 Aug 2017 15:42:35 +0200
Message-ID: <2333939.YcVPemMPxH@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org> <12333551.k204JYSgao@aspire.rjw.lan> <6003495.864qntojfu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <6003495.864qntojfu@aspire.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 24, 2017 11:50:40 PM CEST Rafael J. Wysocki wrote:
> On Thursday, August 24, 2017 6:35:49 PM CEST Rafael J. Wysocki wrote:
> > On Thursday, August 24, 2017 11:15:26 AM CEST Ulf Hansson wrote:
> 
> [cut]
> 
> > [BTW, it is not entirely clear to me why it ever is necessary to runtime resume
> > a device with direct_complete set after __device_suspend(), because it can only
> > have direct_complete set at that point if all of the hierarchy below it has
> > this flag set too and so runtime PM has to be disabled for all of those
> > devices as well.]
> 
> Which makes me realize that we should take a step back and look at what
> problems there are.
> 
> First, there are devices (I know about two examples so far and both are PCI)
> that may need to be runtime resumed during system suspend for reasons other
> than the ones checked by the ACPI PM domain (or the PCI bus type).  There needs
> to be a way to indicate that from the driver side.
> 
> However, it still may be valuable to check the power-related conditions for
> leaving the device in runtime suspend over system suspend/resume in case
> it actually doesn't need to be runtime resumed during system suspend after
> all.  That's what the majority of my patch was about.
> 
> The second problem is that the ACPI PM domain (and the PCI bus type)
> runtime resumes all devices unconditionally in its ->suspend callback,
> even though that may not be necessary for some devices.  Therefore there
> needs to be a way to indicate that too.  That still would be good to
> have *regardless* of the direct_complete mechanism, because the direct_complete
> flag may not be set very often due to dependencies and then the
> resume-during-suspend will take place unnecessarily.
> 
> Accordingly, it looks like we need a "no need to resume me" flag in the first
> place.  That would indicate to interested pieces of code that, from the
> driver perspective, the device doesn't need to be runtime resumed before
> invoking its system suspend callbacks.  This should be clear enough to everyone
> IMO.
> 
> [Note that if that flag is set for all devices, we may drop it along with
> direct_complete, but before that happens both are needed.]

I think we are in agreement that direct_complete will not be necessary any
more when all drivers/bus types/PM domains and so on can do the "safe
suspend", but we're not there yet. :-)

> To address the first issue I would add something like the flag in the patches
> I sent (but without the ACPI PM domain part which should be covered by the
> "no need to resume me" flag above), because that allows the device's ->suspend
> callback to run in principle and the driver may use that callback even to
> runtime resume the device if that's what it wants to do.  So something like
> "run my ->suspend callback even though I might stay in runtime suspend".
> 
> I would probably add driver_flags to dev_pm_info for that to set at the probe
> time (and I would make the core clear that on driver removal).
> 
> The complexity concern is there, but honestly I don't see a better way at
> this point.

So below is a prototype patch.  It still is missing a documentation update, but
other than that it should be complete unless I missed something.

The way it works is that the SAFE_SUSPEND flag is not looked at by the core
at all.  The ACPI PM domain looks at it and the PCI bus type can be modified
to take it into account in the future.  That is what causes the "runtime resume
during system suspend" to be skipped.

In turn, the ALWAYS_SUSPEND flag is only looked at by the core and it causes
the decision on whether or not to use direct_complete to be deferred to the
__device_suspend_late() time.  If you set it for a PCI device, the effect is
equivalent to "no direct_complete".  If you set it for a device in the ACPI
PM domain, that depends on whether or not SAFE_SUSPEND is set.  If it isn't
set, the effect is equivalent to "no direct_complete" too, but if it is set,
the core may still try to use direct_complete for the device, but it will
make the decision on it in __device_suspend_late() and then it will not invoke
the ->suspend_late callback for the device if it is still runtime suspended.
[Note that you cannot runtime resume and runtime suspend again a device during
system suspend, so if it is runtime suspended in __device_suspend_late(), it
has been runtime suspend all the way since device_prepare().]

So say you point the ->suspend_late and ->resume_early callbacks of
the designware i2c driver to pm_runtime_force_suspend() and
pm_runtime_force_resume(), respectively, and set both the SAFE_SUSPEND
and ALWAYS_SUSPEND flags for the device.

If system suspend is started and the device is not runtime suspended,
direct_complete is not set for it and everything works as usual, so say
the device is runtime suspended in device_prepare().  Then, the ACPI PM
domain checks the other conditions for leaving it in runtime suspend and
returns either 0 or a positive number from acpi_subsys_prepare().

If 0 is returned, direct_complete is not set by the core and
acpi_subsys_suspend() is called.  It checks the SAFE_SUSPEND flag and sees
that the device need not be runtime resumed, so it invokes the driver's
->suspend callback (which is not present, so it doesn't do anything).
Next, in __device_suspend_late(), acpi_subsys_suspend_late() is invoked
and it calls pm_runtime_force_suspend(), which executes the driver's
->runtime_suspend() callback, and then (if successful) calls
acpi_dev_suspend_late() to put the device into a low-power state.  The
resume path is a reverse of the above in this case.  So far, so good.

If acpi_subsys_prepare() returns a positive number, the core sets
direct_complete for the device.  Next, in __device_suspend(), it sees
direct_complete set and checks the ALWAYS_SUSPEND flag.  It is set,
so the runtime PM disabling part is skipped.  acpi_subsys_suspend()
is called, it checks SAFE_SUSPEND and skips the runtime resume of the
device.  Now, the device can stay runtime suspended or it may be runtime
resumed in the meantime.

First, say it stays runtime suspended.  __device_suspend_late() is called
for it, sees direct_complete set and sees that the device is runtime
suspended, so it just returns with direct_complete set.  The resume path
will be skipped entirely for the device, so it remains runtime suspended
all the way throughout the system suspend and resume.  Still OK.

Now, say the device has been runtime resumed between __device_suspend()
and __device_suspend_late().  The latter will see direct_complete set
and will see that the device is not runtime suspended any more, so it
will clear direct_complete and call acpi_subsys_suspend_late().  That,
in turn, will call pm_runtime_force_suspend(), which will see that
the device is not runtime suspended, so it will call the driver's
->runtime_suspend() callback.  Next,  acpi_dev_suspend_late() will be
called to put the device into a low-power state.  From that point on
everything is equivalent to the case in which acpi_subsys_prepare()
returned 0.

---
 drivers/acpi/device_pm.c  |    7 +++++--
 drivers/base/dd.c         |    2 ++
 drivers/base/power/main.c |   21 +++++++++++++++++----
 include/linux/pm.h        |   32 ++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1271,9 +1271,16 @@ static int __device_suspend_late(struct
 		goto Complete;
 	}
 
-	if (dev->power.syscore || dev->power.direct_complete)
+	if (dev->power.syscore)
 		goto Complete;
 
+	if (dev->power.direct_complete) {
+		if (pm_runtime_status_suspended(dev))
+			goto Complete;
+
+		dev->power.direct_complete = false;
+	}
+
 	if (dev->pm_domain) {
 		info = "late power domain ";
 		callback = pm_late_early_op(&dev->pm_domain->ops, state);
@@ -1437,7 +1444,10 @@ static void dpm_clear_suppliers_direct_c
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
 		spin_lock_irq(&link->supplier->power.lock);
-		link->supplier->power.direct_complete = false;
+
+		if (!(link->supplier->power.driver_flags & DPM_FLAG_ALWAYS_SUSPEND))
+			link->supplier->power.direct_complete = false;
+
 		spin_unlock_irq(&link->supplier->power.lock);
 	}
 
@@ -1482,7 +1492,8 @@ static int __device_suspend(struct devic
 	if (dev->power.syscore)
 		goto Complete;
 
-	if (dev->power.direct_complete) {
+	if (dev->power.direct_complete &&
+	    !(dev->power.driver_flags & DPM_FLAG_ALWAYS_SUSPEND)) {
 		if (pm_runtime_status_suspended(dev)) {
 			pm_runtime_disable(dev);
 			if (pm_runtime_status_suspended(dev))
@@ -1549,7 +1560,9 @@ static int __device_suspend(struct devic
 		if (parent) {
 			spin_lock_irq(&parent->power.lock);
 
-			dev->parent->power.direct_complete = false;
+			if (!(dev->parent->power.driver_flags & DPM_FLAG_ALWAYS_SUSPEND))
+				dev->parent->power.direct_complete = false;
+
 			if (dev->power.wakeup_path
 			    && !dev->parent->power.ignore_children)
 				dev->parent->power.wakeup_path = true;
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -550,6 +550,37 @@ struct pm_subsys_data {
 #endif
 };
 
+/*
+ * Driver flags to control system suspend/resume behavior.
+ *
+ * SAFE_SUSPEND: No need to runtime resume the device during system suspend.
+ * ALWAYS_SUSPEND: Invoke ->suspend callback regardless of runtime PM status.
+ *
+ * These flags can be set by device drivers at the probe time.  They need not be
+ * cleared by the drivers as the driver core will take care of that.
+ *
+ * Setting SAFE_SUSPEND instructs bus types and PM domains that may want to
+ * runtime resume the device upfront during system suspend that doing so is not
+ * necessary from the driver's perspective, because its ->suspend callback can
+ * cope with a runtime suspended device (or is not present at all).
+ *
+ * Setting ALWAYS_SUSPEND instructs the PM core to always invoke the top-level
+ * ->suspend callback for the device during system suspend even though it may
+ * be runtime suspended at that point and might be left alone in principle.
+ * That is required for some devices that need to be prepared for system
+ * suspend in a special way which only is known to their drivers.  However,
+ * setting ALWAYS_SUSPEND may also affect the devices parent and its parent and
+ * so on, as it may cause those devices to be runtime resumed upfront during
+ * system suspend unless SAFE_SUSPEND is set for them.
+ *
+ * Moreover, some bus types and PM domains have a policy to runtime resume all
+ * devices upfront in their ->suspend callbacks, so if ALWAYS_SUSPEND is set and
+ * SAFE_SUSPEND is not set for a device belonging to one of them, the device
+ * will be runtime resumed upfront every time during system suspend.
+ */
+#define DPM_FLAG_SAFE_SUSPEND	BIT(0)
+#define DPM_FLAG_ALWAYS_SUSPEND	BIT(1)
+
 struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned int		can_wakeup:1;
@@ -561,6 +592,7 @@ struct dev_pm_info {
 	bool			is_late_suspended:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
+	unsigned int		driver_flags;
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -1024,11 +1024,14 @@ EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
  * @dev: Device to handle.
  *
  * Follow PCI and resume devices suspended at run time before running their
- * system suspend callbacks.
+ * system suspend callbacks, unless the DPM_FLAG_SAFE_SUSPEND driver flag is
+ * set for them.
  */
 int acpi_subsys_suspend(struct device *dev)
 {
-	pm_runtime_resume(dev);
+	if (!(dev->power.driver_flags & DPM_FLAG_SAFE_SUSPEND))
+		pm_runtime_resume(dev);
+
 	return pm_generic_suspend(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -436,6 +436,7 @@ pinctrl_bind_failed:
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
+	dev->power.driver_flags = 0;
 
 	switch (ret) {
 	case -EPROBE_DEFER:
@@ -841,6 +842,7 @@ static void __device_release_driver(stru
 		if (dev->pm_domain && dev->pm_domain->dismiss)
 			dev->pm_domain->dismiss(dev);
 		pm_runtime_reinit(dev);
+		dev->power.driver_flags = 0;
 
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
