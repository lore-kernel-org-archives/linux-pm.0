From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/9] PM / ACPI: Provide option to disable direct_complete for ACPI devices
Date: Mon, 28 Aug 2017 15:40:48 +0200
Message-ID: <1644235.K1erQvOgW9@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org> <26411805.tiHaCQcaUh@aspire.rjw.lan> <CAPDyKFr6RZuEqwUR3QwV9cDtzNe8Qi12PmkYttUia2QEwNRWqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr6RZuEqwUR3QwV9cDtzNe8Qi12PmkYttUia2QEwNRWqQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, August 28, 2017 2:54:40 PM CEST Ulf Hansson wrote:
> On 28 August 2017 at 14:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, August 28, 2017 10:31:44 AM CEST Ulf Hansson wrote:
> >> On 28 August 2017 at 03:30, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Friday, August 25, 2017 3:42:35 PM CEST Rafael J. Wysocki wrote:
> >> >> On Thursday, August 24, 2017 11:50:40 PM CEST Rafael J. Wysocki wrote:
> >> >> > On Thursday, August 24, 2017 6:35:49 PM CEST Rafael J. Wysocki wrote:
> >> >> > > On Thursday, August 24, 2017 11:15:26 AM CEST Ulf Hansson wrote:

[cut]

> >> >
> >> > Well, not really, because if the device remains runtime suspended,
> >> > ->runtime_suspend() will not be called by pm_runtime_force_suspend() and
> >> > acpi_dev_suspend_late() should not be called then.
> >> >
> >> > So more changes in the ACPI PM domain are needed after all.
> >>
> >> Yes, that's what I thought as well.
> >>
> >> Anyway, let me cook a new version of the series - trying to address
> >> the first bits you have pointed out. Then we can continue with
> >> fine-tuning on top, addressing further optimizations of the ACPI PM
> >> domain.
> >
> > Actually, please hold on and let me show you what I would like to do
> > first.
> 
> Hmm.
> 
> I think I have almost done the work for the ACPI PM domain already.
> It's just a matter of minor tweaks to the changes in patch 6 and 7
> (and of course to get them into a shape that you prefer) and then
> dropping patch 5 altogether.
> 
> Wouldn't it be better if you build upon my changes?
> 
> Anyway, if you have strong opinion of driving this, I am fine stepping aside.

OK, so see below. :-)

If what you want is to make the i2c designware driver use _force_suspend() and
_force_resume(), then to me this is only tangentially related to direct_complete
and can be done without messing up with that one.

So the problem is not when direct_complete is set (becasue the driver's and
PM domain's callbacks will not be invoked then even), but when it is not set.
If direct_complete is not set, the ACPI PM domain resumes the device in
acpi_subsys_suspend(), because it doesn't know two things: (a) why direct_complete
is not set and (b) whether or not the drivers PM callbacks can cope with a
runtime suspended device.  These two things are separate, so they need to
be addressed separately.

For (b) I'd like to use the SAFE_SUSPEND flag from my previous patch.

As far as (a) is concerned, there are two possible reasons for not setting
direct_complete.  First, it may be necessary to change the power state of the
device and in that case the device *should* be resumed in acpi_subsys_suspend().
Second, direct_complete may not be set for the device's children and in that
case acpi_subsys_suspend() may not care as long as SAFE_SUSPEND is set.

So the ACPI PM domain needs to distinguish these two cases and for that reason
it has to track whether or not the power state of the device needs to be updated
which is what the (untested) patch below does, but of course it doesn't
cover the LPSS.

---
 Documentation/driver-api/pm/devices.rst     |    7 ++
 drivers/acpi/device_pm.c                    |   72 +++++++++++++++++++++-------
 drivers/base/dd.c                           |    2 
 drivers/i2c/busses/i2c-designware-platdrv.c |    4 +
 include/acpi/acpi_bus.h                     |    1 
 include/linux/pm.h                          |   16 ++++++
 6 files changed, 83 insertions(+), 19 deletions(-)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -550,6 +550,21 @@ struct pm_subsys_data {
 #endif
 };
 
+/*
+ * Driver flags to control system suspend/resume behavior.
+ *
+ * These flags can be set by device drivers at the probe time.  They need not be
+ * cleared by the drivers as the driver core will take care of that.
+ *
+ * SAFE_SUSPEND: No need to runtime resume the device during system suspend.
+ *
+ * Setting SAFE_SUSPEND instructs bus types and PM domains which may want to
+ * runtime resume the device upfront during system suspend that doing so is not
+ * necessary from the driver's perspective, because the system suspend callbacks
+ * provided by it can cope with a runtime suspended device.
+ */
+#define DPM_FLAG_SAFE_SUSPEND	BIT(0)
+
 struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned int		can_wakeup:1;
@@ -561,6 +576,7 @@ struct dev_pm_info {
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
@@ -899,6 +899,7 @@ int acpi_dev_runtime_resume(struct devic
 
 	error = acpi_dev_pm_full_power(adev);
 	acpi_device_wakeup_disable(adev);
+	adev->power.update_state = true;
 	return error;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_runtime_resume);
@@ -989,33 +990,47 @@ int acpi_dev_resume_early(struct device
 }
 EXPORT_SYMBOL_GPL(acpi_dev_resume_early);
 
-/**
- * acpi_subsys_prepare - Prepare device for system transition to a sleep state.
- * @dev: Device to prepare.
- */
-int acpi_subsys_prepare(struct device *dev)
+static bool acpi_dev_state_update_needed(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	u32 sys_target;
 	int ret, state;
 
-	ret = pm_generic_prepare(dev);
-	if (ret < 0)
-		return ret;
+	if (!adev || !pm_runtime_suspended(dev))
+		return true;
 
-	if (!adev || !pm_runtime_suspended(dev)
-	    || device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
-		return 0;
+	if (device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
+		return true;
 
 	sys_target = acpi_target_system_state();
 	if (sys_target == ACPI_STATE_S0)
-		return 1;
+		return false;
 
 	if (adev->power.flags.dsw_present)
-		return 0;
+		return true;
 
 	ret = acpi_dev_pm_get_state(dev, adev, sys_target, NULL, &state);
-	return !ret && state == adev->power.state;
+	if (ret)
+		return true;
+
+	return state != adev->power.state;
+}
+
+/**
+ * acpi_subsys_prepare - Prepare device for system transition to a sleep state.
+ * @dev: Device to prepare.
+ */
+int acpi_subsys_prepare(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int ret;
+
+	ret = pm_generic_prepare(dev);
+	if (ret < 0)
+		return ret;
+
+	adev->power.update_state = acpi_dev_state_update_needed(dev);
+	return !adev->power.update_state;
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
 
@@ -1024,11 +1039,20 @@ EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
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
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return 0;
+
+	if (adev->power.update_state ||
+	    !(dev->power.driver_flags & DPM_FLAG_SAFE_SUSPEND))
+		pm_runtime_resume(dev);
+
 	return pm_generic_suspend(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
@@ -1042,8 +1066,20 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
  */
 int acpi_subsys_suspend_late(struct device *dev)
 {
-	int ret = pm_generic_suspend_late(dev);
-	return ret ? ret : acpi_dev_suspend_late(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int ret;
+
+	if (!adev)
+		return 0;
+
+	ret = pm_generic_suspend_late(dev);
+	if (ret)
+		return ret;
+
+	if (adev->power.update_state)
+		return acpi_dev_suspend_late(dev);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend_late);
 
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
Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -729,6 +729,13 @@ state temporarily, for example so that i
 disabled.  This all depends on the hardware and the design of the subsystem and
 device driver in question.
 
+Some bus types and PM domains have a policy to runtime resume all
+devices upfront in their ``->suspend`` callbacks, but that may not be really
+necessary if the system suspend-resume callbacks provided by the device's
+driver can cope with a runtime-suspended device.  The driver can indicate that
+by setting ``DPM_FLAG_SAFE_SUSPEND`` in :c:member:`power.driver_flags` at the
+probe time.
+
 During system-wide resume from a sleep state it's easiest to put devices into
 the full-power state, as explained in :file:`Documentation/power/runtime_pm.txt`.
 Refer to that document for more information regarding this particular issue as
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -287,6 +287,7 @@ struct acpi_device_power {
 	int state;		/* Current state */
 	struct acpi_device_power_flags flags;
 	struct acpi_device_power_state states[ACPI_D_STATE_COUNT];	/* Power states (D0-D3Cold) */
+	bool update_state;
 };
 
 /* Performance Management */
Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
+++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -358,6 +358,7 @@ static int dw_i2c_plat_probe(struct plat
 	if (dev->pm_disabled) {
 		pm_runtime_forbid(&pdev->dev);
 	} else {
+		dev->power.driver_flags = DPM_FLAG_SAFE_SUSPEND;
 		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
 		pm_runtime_use_autosuspend(&pdev->dev);
 		pm_runtime_set_active(&pdev->dev);
@@ -455,7 +456,8 @@ static int dw_i2c_plat_resume(struct dev
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 	.prepare = dw_i2c_plat_prepare,
 	.complete = dw_i2c_plat_complete,
-	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
 };
 

