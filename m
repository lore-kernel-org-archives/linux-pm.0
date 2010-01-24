From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PM: Asynchronous suspend and resume of
	devices
Date: Sun, 24 Jan 2010 21:09:15 +0100
Message-ID: <201001242109.15407.rjw__47171.4171967053$1264363916$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1001241128250.28594-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1001241128250.28594-100000@netrider.rowland.org>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Greg KH <gregkh@suse.de>, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

[CC list trimmed.]

On Sunday 24 January 2010, Alan Stern wrote:
> On Sun, 24 Jan 2010, Rafael J. Wysocki wrote:
> 
> > The async threads started for different devices as a result of
> > calling async_schedule() are synchronized with each other and with
> > the main suspend/resume thread with the help of completions, in the
> > following way:
> > (1) There is a completion, power.completion, for each device object.
> > (2) Each device's completion is reset before calling async_schedule()
> >     for the device or, in the case of devices with the
> >     power.async_suspend flags unset, before executing the device's
> >     suspend and resume callbacks.
> > (3) During suspend, right before running the bus type, device type
> >     and device class suspend callbacks for the device, the PM core
> >     waits for the completions of all the device's children to be
> >     completed.
> > (4) During resume, right before running the bus type, device type and
> >     device class resume callbacks for the device, the PM core waits
> >     for the completion of the device's parent to be completed.
> > (5) The PM core completes power.completion for each device right
> >     after the bus type, device type and device class suspend (or
> >     resume) callbacks executed for the device have returned.
> 
> ...
> 
> >  /**
> > + * dpm_wait - Wait for a PM operation to complete.
> > + * @dev: Device to wait for.
> > + * @async: If unset, wait only if the device's power.async_suspend flag is set.
> > + */
> > +static void dpm_wait(struct device *dev, bool async)
> > +{
> > +	if (!dev)
> > +		return;
> > +
> > +	if (async || dev->power.async_suspend)
> > +		wait_for_completion(&dev->power.completion);
> > +}
> 
> There needs to be a public interface to this function available for 
> drivers that have non-tree constraints.  The arguments should be the 
> device to wait for and the device doing the waiting (needed only to 
> determine whether the caller is running synchronously or not).

Something like the patch below?

> This will be necessary for USB.  In fact, your current code (with patch 
> 7/8 applied) is subject to a race that will sometimes cause a 
> non-high-speed USB device to fail to resume from hibernation.

That's the kind of information I need at this point.  What exactly should be
added to patch 7/8 to avoid this problem?

Rafael

---
 drivers/base/power/main.c |   11 +++++++++++
 include/linux/pm.h        |    2 ++
 2 files changed, 13 insertions(+)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -1050,3 +1050,14 @@ void __suspend_report_result(const char 
 		printk(KERN_ERR "%s(): %pF returns %d\n", function, fn, ret);
 }
 EXPORT_SYMBOL_GPL(__suspend_report_result);
+
+/**
+ * device_pm_wait_for_dev - Wait for suspend/resume of a device to complete.
+ * @dev: Device to wait for.
+ * @subordinate: Device that needs to wait for @dev.
+ */
+void device_pm_wait_for_dev(struct device *subordinate, struct device *dev)
+{
+	dpm_wait(dev, subordinate->power.async_suspend);
+}
+EXPORT_SYMBOL_GPL(device_pm_wait_for_dev);
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -512,6 +512,7 @@ extern void __suspend_report_result(cons
 		__suspend_report_result(__func__, fn, ret);		\
 	} while (0)
 
+extern void device_pm_wait_for_dev(struct device *sub, struct device *dev);
 #else /* !CONFIG_PM_SLEEP */
 
 #define device_pm_lock() do {} while (0)
@@ -524,6 +525,7 @@ static inline int dpm_suspend_start(pm_m
 
 #define suspend_report_result(fn, ret)		do {} while (0)
 
+static inline void device_pm_wait_for_dev(struct device *a, struct device *b) {}
 #endif /* !CONFIG_PM_SLEEP */
 
 /* How to reorder dpm_list after device_move() */
