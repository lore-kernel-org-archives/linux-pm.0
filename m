From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 2/2] PM / sleep: Kick devices that might have been reset by firmware
Date: Wed, 30 Sep 2015 23:51:47 +0200
Message-ID: <2877152.vgpvethKO3@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509301039270.15216-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1509301039270.15216-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 30, 2015 10:46:03 AM Alan Stern wrote:
> On Wed, 30 Sep 2015, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If the platform firmware was involved in the system resume that's
> > being completed, there is a concern that some devices might have
> > been reset by it and if those devices had the power.direct_complete
> > flag set during the preceding suspend transition, they may stay
> > in a reset-power-on state indefinitely (until they are runtime-resumed
> > and then suspended again).  That may not be a big deal from the
> > individual device's perspective, but if the system is an SoC, it may
> > be prevented from entering deep SoC-wide low-power states on idle
> > because of that.
> > 
> > To prevent that from happening, force a runtime resume for devices
> > with power.direct_complete set if the platform firmware was involved
> > in the resume transition currently in progress.
> > 
> > Something similar was done by the ACPI PM domain, but regardless of
> > the platform firmware involvement, and the new mechanism should be
> > sufficient to replace that code, so drop it.
> 
> Maybe I'm not reading patch 1/2 correctly, but it looks like an
> ordinary ACPI-based desktop PC will always believe the firmware was
> involved in an S3 sleep transition.

That's correct and it reflects the reality.

> If that's so then won't this change defeat all the work being done by
> people trying to prevent unneeded runtime resumes during system resume?
> direct_complete would be useful only on non-ACPI systems.

To me at least the main motivation for direct_complete was to avoid unneeded
runtime resumes during system suspend and this patch doesn't change that.

Moreover, there is a difference between scheduling an asynchronous runtime
resume during system resume and doing a synchrouous runtime resume at that
point.  In the latter case the resume process has to wait for the runtime
resume to complete, while in the former case we can get to thawing user
space while the scheduled runtime resume is in progress (or even still
waiting for that matter).

This means that direct_complete would be useful even for S3 transitions
with this patch applied.  Not to mention the suspend-to-idle case in which
the resume really doesn't go through the firmware.

That said, perhaps the check as proposed is too coarse-grained.  We need to
do something like this in the ACPI PM domain code (and we do it already) and
for PCI devices that are likely to be affected by the issue at hand.  So
what about the appended patch (on top of https://patchwork.kernel.org/patch/7291711/)
instead?

Rafael


---
 drivers/acpi/acpi_lpss.c         |    2 +-
 drivers/acpi/device_pm.c         |   19 +------------------
 drivers/base/power/generic_ops.c |   23 +++++++++++++++++++++++
 drivers/pci/pci-driver.c         |    2 +-
 include/linux/pm.h               |    2 +-
 5 files changed, 27 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -963,23 +963,6 @@ int acpi_subsys_prepare(struct device *d
 EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
 
 /**
- * acpi_subsys_complete - Finalize device's resume during system resume.
- * @dev: Device to handle.
- */
-void acpi_subsys_complete(struct device *dev)
-{
-	pm_generic_complete(dev);
-	/*
-	 * If the device had been runtime-suspended before the system went into
-	 * the sleep state it is going out of and it has never been resumed till
-	 * now, resume it in case the firmware powered it up.
-	 */
-	if (dev->power.direct_complete)
-		pm_request_resume(dev);
-}
-EXPORT_SYMBOL_GPL(acpi_subsys_complete);
-
-/**
  * acpi_subsys_suspend - Run the device driver's suspend callback.
  * @dev: Device to handle.
  *
@@ -1047,7 +1030,7 @@ static struct dev_pm_domain acpi_general
 		.runtime_resume = acpi_subsys_runtime_resume,
 #ifdef CONFIG_PM_SLEEP
 		.prepare = acpi_subsys_prepare,
-		.complete = acpi_subsys_complete,
+		.complete = pm_complete_with_resume_check,
 		.suspend = acpi_subsys_suspend,
 		.suspend_late = acpi_subsys_suspend_late,
 		.resume_early = acpi_subsys_resume_early,
Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -664,7 +664,7 @@ static struct dev_pm_domain acpi_lpss_pm
 #ifdef CONFIG_PM
 #ifdef CONFIG_PM_SLEEP
 		.prepare = acpi_subsys_prepare,
-		.complete = acpi_subsys_complete,
+		.complete = pm_complete_with_resume_check,
 		.suspend = acpi_subsys_suspend,
 		.suspend_late = acpi_lpss_suspend_late,
 		.resume_early = acpi_lpss_resume_early,
Index: linux-pm/drivers/base/power/generic_ops.c
===================================================================
--- linux-pm.orig/drivers/base/power/generic_ops.c
+++ linux-pm/drivers/base/power/generic_ops.c
@@ -9,6 +9,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/export.h>
+#include <linux/suspend.h>
 
 #ifdef CONFIG_PM
 /**
@@ -297,4 +298,26 @@ void pm_generic_complete(struct device *
 	if (drv && drv->pm && drv->pm->complete)
 		drv->pm->complete(dev);
 }
+
+/**
+ * pm_complete_with_resume_check - Complete a device power transition.
+ * @dev: Device to handle.
+ *
+ * Complete a device power transition during a system-wide power transition and
+ * optionally schedule a runtime resume of the device if the system resume in
+ * progress has been initated by the platform firmware and the device had its
+ * power.direct_complete flag set.
+ */
+void pm_complete_with_resume_check(struct device *dev)
+{
+	pm_generic_complete(dev);
+	/*
+	 * If the device had been runtime-suspended before the system went into
+	 * the sleep state it is going out of and it has never been resumed till
+	 * now, resume it in case the firmware powered it up.
+	 */
+	if (dev->power.direct_complete && pm_resume_via_firmware())
+		pm_request_resume(dev);
+}
+EXPORT_SYMBOL_GPL(pm_complete_with_resume_check);
 #endif /* CONFIG_PM_SLEEP */
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -687,7 +687,7 @@ static int pci_pm_prepare(struct device
 static void pci_pm_complete(struct device *dev)
 {
 	pci_dev_complete_resume(to_pci_dev(dev));
-	pm_generic_complete(dev);
+	pm_complete_with_resume_check(dev);
 }
 
 #else /* !CONFIG_PM_SLEEP */
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -731,7 +731,7 @@ extern int pm_generic_restore(struct dev
 extern int pm_generic_poweroff_noirq(struct device *dev);
 extern int pm_generic_poweroff_late(struct device *dev);
 extern int pm_generic_poweroff(struct device *dev);
-extern void pm_generic_complete(struct device *dev);
+extern void pm_complete_with_resume_check(struct device *dev);
 
 #else /* !CONFIG_PM_SLEEP */
 

