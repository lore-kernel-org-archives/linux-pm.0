From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Tue, 09 Jan 2018 17:25:43 +0100
Message-ID: <23692721.edtBXv1IdE@aspire.rjw.lan>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <CAMuHMdX=rc4M9oO0dFQ9b2TtRgUXRG_37sw+MVJ3REeAa-0ogw@mail.gmail.com> <CAJZ5v0gvN4DDgLUfHftpJ+Mj5nPkhaKBqadzPtvLXpWs9M6nqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gvN4DDgLUfHftpJ+Mj5nPkhaKBqadzPtvLXpWs9M6nqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lukas Wunner <lukas@wunner.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 9, 2018 4:00:35 PM CET Rafael J. Wysocki wrote:
> On Tue, Jan 9, 2018 at 2:37 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Hi Rafael,
> >
> > On Wed, Jan 3, 2018 at 12:06 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> One of the limitations of pm_runtime_force_suspend/resume() is that
> >> if a parent driver wants to use these functions, all of its child
> >> drivers have to do that too because of the parent usage counter
> >> manipulations necessary to get the correct state of the parent during
> >> system-wide transitions to the working state (system resume).
> >> However, that limitation turns out to be artificial, so remove it.
> >>
> >> Namely, pm_runtime_force_suspend() only needs to update the children
> >> counter of its parent (if there's is a parent) when the device can
> >> stay in suspend after the subsequent system resume transition, as
> >> that counter is correct already otherwise.  Now, if the parent's
> >> children counter is not updated, it is not necessary to increment
> >> the parent's usage counter in that case any more, as long as the
> >> children counters of devices are checked along with their usage
> >> counters in order to decide whether or not the devices may be left
> >> in suspend after the subsequent system resume transition.
> >>
> >> Accordingly, modify pm_runtime_force_suspend() to only call
> >> pm_runtime_set_suspended() for devices whose usage and children
> >> counters are at the "no references" level (the runtime PM status
> >> of the device needs to be updated to "suspended" anyway in case
> >> this function is called once again for the same device during the
> >> transition under way), drop the parent usage counter incrementation
> >> from it and update pm_runtime_force_resume() to compensate for these
> >> changes.
> >>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > This patch causes a regression during system resume on Renesas Salvator-XS
> > with R-Car H3 ES2.0:
> 
> I have dropped it for now, but we need to address the underlying issue.
> 
> >     SError Interrupt on CPU3, code 0xbf000002 -- SError
> >     SError Interrupt on CPU2, code 0xbf000002 -- SError
> >     CPU: 3 PID: 1769 Comm: kworker/u16:13 Not tainted
> > 4.15.0-rc7-arm64-renesas-05338-gf14cf570a813c9ca-dirty #97
> >     CPU: 2 PID: 1774 Comm: kworker/u16:18 Not tainted
> > 4.15.0-rc7-arm64-renesas-05338-gf14cf570a813c9ca-dirty #97
> >     Hardware name: Renesas Salvator-X 2nd version board based on
> > r8a7795 ES2.0+ (DT)
> >     Hardware name: Renesas Salvator-X 2nd version board based on
> > r8a7795 ES2.0+ (DT)
> >     Workqueue: events_unbound async_run_entry_fn
> >     Workqueue: events_unbound async_run_entry_fn
> >     pstate: 60000005 (nZCv daif -PAN -UAO)
> >     pstate: 60000005 (nZCv daif -PAN -UAO)
> >     pc : rcar_gen3_phy_usb2_init+0x34/0xf8
> >     pc : rcar_gen3_phy_usb2_init+0x34/0xf8
> >     lr : phy_init+0x64/0xcc
> >     lr : phy_init+0x64/0xcc
> >     ...
> >     Kernel panic - not syncing: Asynchronous SError Interrupt
> >
> > Note that before, it printed a warning instead:
> >
> >     Enabling runtime PM for inactive device (ee0a0200.usb-phy) with
> > active children
> >     WARNING: CPU: 0 PID: 1741 at drivers/base/power/runtime.c:1300
> > pm_runtime_enable+0x94/0xd8
> >
> > Reverting commit 0408584d580d4a2c ("PM / runtime: Rework
> > pm_runtime_force_suspend/resume()") fixes the crash.
> >
> > Note that applying Ulf's "[PATCH v2 0/3] phy: core: Re-work runtime PM
> > deployment and fix an issue"
> > (https://www.spinics.net/lists/linux-renesas-soc/msg21719.html) instead
> > does not fix the crash.
> 
> OK
> 
> > With more debug code added, it seems the EHCI module clocks (701-703) are
> > enabled earlier than before. I guess this triggers the workqueue to perform
> > an operation while another related device (HSUSB 704?) is still disabled?
> 
> Probably.
> 
> Likely a device that wasn't resumed before resumes now and that causes
> the issue to appear.
> 
> I'm wondering if adding the ignore_children check to the patch helps.
> If not, there clearly is a resume ordering issue that is papered over
> by the current code.

Below is an alternative version of the patch that caused the problem
to happen which checks the ignore_children flag of the device.  It may
avoid the issue by accident, but then I'd rather make it not happen. :-)

Please try this patch anyway, though, and let me know if the crash is still
there.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()

One of the limitations of pm_runtime_force_suspend/resume() is that
if a parent driver wants to use these functions, all of its child
drivers have to do that too because of the parent usage counter
manipulations necessary to get the correct state of the parent during
system-wide transitions to the working state (system resume).
However, that limitation turns out to be artificial, so remove it.

Namely, pm_runtime_force_suspend() only needs to update the children
counter of its parent (if there's is a parent) when the device can
stay in suspend after the subsequent system resume transition, as
that counter is correct already otherwise.  Now, if the parent's
children counter is not updated, it is not necessary to increment
the parent's usage counter in that case any more, as long as the
children counters of devices are checked along with their usage
counters in order to decide whether or not the devices may be left
in suspend after the subsequent system resume transition.

Accordingly, modify pm_runtime_force_suspend() to only call
pm_runtime_set_suspended() for devices whose usage and children
counters are at the "no references" level (the runtime PM status
of the device needs to be updated to "suspended" anyway in case
this function is called once again for the same device during the
transition under way), drop the parent usage counter incrementation
from it and update pm_runtime_force_resume() to compensate for these
changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   75 ++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1613,17 +1613,29 @@ void pm_runtime_drop_link(struct device
 	spin_unlock_irq(&dev->power.lock);
 }
 
+static bool pm_runtime_need_not_resume(struct device *dev)
+{
+	return atomic_read(&dev->power.usage_count) <= 1 &&
+		(atomic_read(&dev->power.child_count) == 0 ||
+		 dev->power.ignore_children);
+}
+
 /**
  * pm_runtime_force_suspend - Force a device into suspend state if needed.
  * @dev: Device to suspend.
  *
  * Disable runtime PM so we safely can check the device's runtime PM status and
- * if it is active, invoke it's .runtime_suspend callback to bring it into
- * suspend state. Keep runtime PM disabled to preserve the state unless we
- * encounter errors.
+ * if it is active, invoke its ->runtime_suspend callback to suspend it and
+ * change its runtime PM status field to RPM_SUSPENDED.  Also, if the device's
+ * usage and children counters don't indicate that the device was in use before
+ * the system-wide transition under way, decrement its parent's children counter
+ * (if there is a parent).  Keep runtime PM disabled to preserve the state
+ * unless we encounter errors.
  *
  * Typically this function may be invoked from a system suspend callback to make
- * sure the device is put into low power state.
+ * sure the device is put into low power state and it should only be used during
+ * system-wide PM transitions to sleep states.  It assumes that the analogous
+ * pm_runtime_force_resume() will be used to resume the device.
  */
 int pm_runtime_force_suspend(struct device *dev)
 {
@@ -1646,17 +1658,18 @@ int pm_runtime_force_suspend(struct devi
 		goto err;
 
 	/*
-	 * Increase the runtime PM usage count for the device's parent, in case
-	 * when we find the device being used when system suspend was invoked.
-	 * This informs pm_runtime_force_resume() to resume the parent
-	 * immediately, which is needed to be able to resume its children,
-	 * when not deferring the resume to be managed via runtime PM.
+	 * If the device can stay in suspend after the system-wide transition
+	 * to the working state that will follow, drop the children counter of
+	 * its parent, but set its status to RPM_SUSPENDED anyway in case this
+	 * function will be called again for it in the meantime.
 	 */
-	if (dev->parent && atomic_read(&dev->power.usage_count) > 1)
-		pm_runtime_get_noresume(dev->parent);
+	if (pm_runtime_need_not_resume(dev))
+		pm_runtime_set_suspended(dev);
+	else
+		__update_runtime_status(dev, RPM_SUSPENDED);
 
-	pm_runtime_set_suspended(dev);
 	return 0;
+
 err:
 	pm_runtime_enable(dev);
 	return ret;
@@ -1669,13 +1682,9 @@ EXPORT_SYMBOL_GPL(pm_runtime_force_suspe
  *
  * Prior invoking this function we expect the user to have brought the device
  * into low power state by a call to pm_runtime_force_suspend(). Here we reverse
- * those actions and brings the device into full power, if it is expected to be
- * used on system resume. To distinguish that, we check whether the runtime PM
- * usage count is greater than 1 (the PM core increases the usage count in the
- * system PM prepare phase), as that indicates a real user (such as a subsystem,
- * driver, userspace, etc.) is using it. If that is the case, the device is
- * expected to be used on system resume as well, so then we resume it. In the
- * other case, we defer the resume to be managed via runtime PM.
+ * those actions and bring the device into full power, if it is expected to be
+ * used on system resume.  In the other case, we defer the resume to be managed
+ * via runtime PM.
  *
  * Typically this function may be invoked from a system resume callback.
  */
@@ -1684,32 +1693,18 @@ int pm_runtime_force_resume(struct devic
 	int (*callback)(struct device *);
 	int ret = 0;
 
-	callback = RPM_GET_CALLBACK(dev, runtime_resume);
-
-	if (!callback) {
-		ret = -ENOSYS;
-		goto out;
-	}
-
-	if (!pm_runtime_status_suspended(dev))
+	if (!pm_runtime_status_suspended(dev) || pm_runtime_need_not_resume(dev))
 		goto out;
 
 	/*
-	 * Decrease the parent's runtime PM usage count, if we increased it
-	 * during system suspend in pm_runtime_force_suspend().
-	*/
-	if (atomic_read(&dev->power.usage_count) > 1) {
-		if (dev->parent)
-			pm_runtime_put_noidle(dev->parent);
-	} else {
-		goto out;
-	}
+	 * The value of the parent's children counter is correct already, so
+	 * just update the status of the device.
+	 */
+	__update_runtime_status(dev, RPM_ACTIVE);
 
-	ret = pm_runtime_set_active(dev);
-	if (ret)
-		goto out;
+	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
-	ret = callback(dev);
+	ret = callback ? callback(dev) : -ENOSYS;
 	if (ret) {
 		pm_runtime_set_suspended(dev);
 		goto out;
