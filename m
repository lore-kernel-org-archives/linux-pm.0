From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/9] PM / ACPI: Provide option to disable direct_complete for ACPI devices
Date: Thu, 24 Aug 2017 03:03:57 +0200
Message-ID: <1726767.L8TO24juDO@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org> <3774251.HUIR40xRhc@aspire.rjw.lan> <9174364.s7oU13Tavs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54798 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750715AbdHXBMc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 21:12:32 -0400
In-Reply-To: <9174364.s7oU13Tavs@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>"Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vg>

On Thursday, August 24, 2017 2:20:00 AM CEST Rafael J. Wysocki wrote:
> On Thursday, August 24, 2017 2:13:55 AM CEST Rafael J. Wysocki wrote:
> > On Thursday, August 24, 2017 1:39:44 AM CEST Rafael J. Wysocki wrote:
> > > On Wed, Aug 23, 2017 at 4:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > In some cases a driver for an ACPI device needs to be able to prevent the
> > > > ACPI PM domain from using the direct_complete path during system sleep.
> > > >
> > > > One typical case is when the driver for the device needs its device to stay
> > > > runtime enabled, during the __device_suspend phase. This isn't the case
> > > > when the direct_complete path is being executed by the PM core, as it then
> > > > disables runtime PM for the device in __device_suspend(). Any following
> > > > attempts to runtime resume the device after that point, just fails.
> > > 
> > > OK, that is a problem.
> > > 
> > > > A workaround to this problem is to let the driver runtime resume its device
> > > > from its ->prepare() callback, as that would prevent the direct_complete
> > > > path from being executed. However, that may often be a waste, especially if
> > > > it turned out that no one really needed the device.
> > > >
> > > > For this reason, invent acpi_dev_disable|enable_direct_complete(), to allow
> > > > drivers to inform the ACPI PM domain to change its default behaviour during
> > > > system sleep, and thus control whether it may use the direct_complete path
> > > > or not.
> > > 
> > > But I'm not sure this is the right place to address it as it very well
> > > may affect a PCI device too.
> > > 
> > > Also, this is about the device and not about its ACPI companion
> > > object, so putting the flag in there is somewhat unclean, so to speak.
> > > 
> > > It looks like we need a flag in dev_pm_info saying something along the
> > > lines of "my system suspend callback can deal with runtime PM" that
> > > will cause the direct_complete update to occur in
> > > __device_suspend_late() instead of __device_suspend().
> > 
> > IOW, something like the patch below.
> > 
> > It actually should work with the ACPI PM domain code as is except that it
> > will cause the device to be runtime resumed every time during suspend.
> > 
> > But acpi_subsys_suspend() can be changed to avoid resuming the device if
> > power.force_suspend is set.
> 
> Or better yet, if power.direct_complete is not set, because that means the
> device needs to be resumed anyway.
> 
> And if power.direct_complete is set at that point, power.force_suspend has to
> be set too.

Overall, like below, and of course drivers that ser power.force_suspend need to
be able to deal with devices that have been runtime resumed during
__device_suspend().

---
 drivers/acpi/device_pm.c  |    8 ++++++++
 drivers/base/power/main.c |   11 +++++++++--
 include/linux/pm.h        |    1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

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
@@ -1482,7 +1489,7 @@ static int __device_suspend(struct devic
 	if (dev->power.syscore)
 		goto Complete;
 
-	if (dev->power.direct_complete) {
+	if (dev->power.direct_complete && !dev->power.force_suspend) {
 		if (pm_runtime_status_suspended(dev)) {
 			pm_runtime_disable(dev);
 			if (pm_runtime_status_suspended(dev))
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -554,6 +554,7 @@ struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned int		can_wakeup:1;
 	unsigned int		async_suspend:1;
+	unsigned int		force_suspend:1;
 	bool			in_dpm_list:1;	/* Owned by the PM core */
 	bool			is_prepared:1;	/* Owned by the PM core */
 	bool			is_suspended:1;	/* Ditto */
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -1025,9 +1025,17 @@ EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
  *
  * Follow PCI and resume devices suspended at run time before running their
  * system suspend callbacks.
+ *
+ * If the power.direct_complete flag is set for the device, though, skip all
+ * that, because the device doesn't need to be resumed then and if it is
+ * resumed via runtime PM, the core will notice that and will carry out the
+ * late suspend for it.
  */
 int acpi_subsys_suspend(struct device *dev)
 {
+	if (dev->power.direct_complete)
+		return 0;
+
 	pm_runtime_resume(dev);
 	return pm_generic_suspend(dev);
 }
