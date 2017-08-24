From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/9] PM / ACPI: Provide option to disable direct_complete for ACPI devices
Date: Thu, 24 Aug 2017 18:35:49 +0200
Message-ID: <12333551.k204JYSgao@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org> <1726767.L8TO24juDO@aspire.rjw.lan> <CAPDyKFrj6RdsG4Qf847OvLQMgqHeyh1=YyeKZMeaGgQ2du3cNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrj6RdsG4Qf847OvLQMgqHeyh1=YyeKZMeaGgQ2du3cNA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 24, 2017 11:15:26 AM CEST Ulf Hansson wrote:
> [...]
> 
> >> >
> >> > It actually should work with the ACPI PM domain code as is except that it
> >> > will cause the device to be runtime resumed every time during suspend.
> >> >
> >> > But acpi_subsys_suspend() can be changed to avoid resuming the device if
> >> > power.force_suspend is set.
> >>
> >> Or better yet, if power.direct_complete is not set, because that means the
> >> device needs to be resumed anyway.
> >>
> >> And if power.direct_complete is set at that point, power.force_suspend has to
> >> be set too.
> 
> I believe I understand your goal here. You want to consider if it is
> possible to extend the behavior of the direct_complete path, instead
> of enabling the runtime PM centric path for the ACPI PM domain, to
> accomplish the same optimizations.

This isn't really "instead of", but rather "in addition to".

> I think the answer to that, is that it simply can't. See more
> information about why further down below.
> 
> >
> > Overall, like below, and of course drivers that ser power.force_suspend need to
> > be able to deal with devices that have been runtime resumed during
> > __device_suspend().
> 
> The a concern I see with this approach, is that is going to be too
> complex to understand.

That is a valid concern, but then your approach with using an extra flag
just for the ACPI PM domain isn't particularly straightforward either IMO.

> We have already seen how the i2c-designware-driver was screwed up when
> it was trying to take advantage of the optimizations provided by the
> current direct_complete path. I think we should be careful when
> considering making it even more complex.

OK, but this applies to your series as well, as it is adding a new flag too,
just not in the core. :-)

> In the runtime PM centric path, driver authors can easily deploy
> system sleep support. In some cases it may even consists of only two
> lines of code. As can be shown in patch9 for the i2c driver.

That still requires the new flag to be set if the ACPI PM is in use AFAICS,
which then will prevent the entire hierarchy above the device from having
direct_complete set.

> Just to be clear, that doesn't mean that I think the direct_complete
> path isn't useful. Especially it is a good match for the ACPI PM
> domain, as it can easily affect all its devices, without having to
> care much about the behavior of the drivers.

OK

[cut]

> 
> The above change would offer an improvement, however there are more
> benefits from the runtime PM centric path that it doesn't cover.

The idea, though, is not to make it instead of, but in addition to the
runtime PM centric path.

So a driver using the runtime PM centric (or rather runtime PM aware)
callbacks can set power.force_suspend and benefit from having direct_complete
set conditional on whether or not the device is runtime resumed before the
late suspend.

If device_complete remains set in __device_suspend_late(), no system
suspend/resume callbacks will be invoked from that point on.  If it isn't
set, pm_runtime_force_suspend() should work just fine and then
pm_runtime_force_resume() should do the right thing on the way back.

All boils down to (a) setting a flag and (b) using the right callbacks
for system suspend which is the case with your patches either.

> The below is pasted from the changelog for patch9 (I will make sure to
> fold in this in the changelog for $subject patch next version).
> 
> In case the device is/gets runtime resumed before the device_suspend()
> phase is entered, the PM core doesn't run the direct_complete path for
> the device during system sleep. During system resume, this lead to
> that the device will always be brought back to full power when the
> i2c-dw-plat driver's ->resume() callback is invoked. This may not be
> necessary, thus increasing the resume time for the device and wasting
> power.

Well, I guess that depends on what is there in its resume callbacks.

> In the runtime PM centric path, the pm_runtime_force_resume() helper
> takes better care, as it resumes the device only in case it's really
> needed. Normally this means it can be postponed to be dealt with via
> regular calls to runtime PM (pm_runtime_get*()) instead. In other
> words, the device remains in its low power state until someone request
> a new i2c transfer, whenever that may be.
> 
> As far as I can think of, the direct_complete path can't be adjusted
> to support this. Or can it?

It surely can, it's just software. :-)  The question is how complicated that
is going to be in the end, however.

So the patch I sent didn't address the dependency issue, but it allows the
core to deal with the issue which is a core issue, not an ACPI PM domain
issue, because the core disables runtime PM for devices with direct_complete
set, not the ACPI PM domain or PCI etc.

[BTW, it is not entirely clear to me why it ever is necessary to runtime resume
a device with direct_complete set after __device_suspend(), because it can only
have direct_complete set at that point if all of the hierarchy below it has
this flag set too and so runtime PM has to be disabled for all of those
devices as well.]

It can be made slightly better by adding a piece to avoid clearing the
parent's direct_complete if it had the new flag set, so below is a new
version (with the new flag renamed to safe_suspend which seemed better to
me).

Of course, having safe_suspend set will still cause the parent's
direct_complete to be cleared unless the parent has safe_suspend set too,
but that's better than not allowing the parent to use direct_complete at all.

---
 drivers/acpi/device_pm.c  |    8 ++++++++
 drivers/base/power/main.c |   15 ++++++++++++---
 include/linux/pm.h        |    1 +
 3 files changed, 21 insertions(+), 3 deletions(-)

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
+	if (dev->power.direct_complete && !dev->power.safe_suspend) {
 		if (pm_runtime_status_suspended(dev)) {
 			pm_runtime_disable(dev);
 			if (pm_runtime_status_suspended(dev))
@@ -1549,7 +1556,9 @@ static int __device_suspend(struct devic
 		if (parent) {
 			spin_lock_irq(&parent->power.lock);
 
-			dev->parent->power.direct_complete = false;
+			if (!dev->parent->power.safe_suspend)
+				dev->parent->power.direct_complete = false;
+
 			if (dev->power.wakeup_path
 			    && !dev->parent->power.ignore_children)
 				dev->parent->power.wakeup_path = true;
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -554,6 +554,7 @@ struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned int		can_wakeup:1;
 	unsigned int		async_suspend:1;
+	unsigned int		safe_suspend:1;
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

