From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Fri, 18 Nov 2016 12:18:24 -0800
Message-ID: <20161118201823.GX4082@atomide.com>
References: <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com>
 <20161110184910.GA135921@google.com>
 <CAJZ5v0gAFmsZ3_YSG1VBzi=K-GTn+SnUj3K3mJ5Su1gCpiB3jQ@mail.gmail.com>
 <20161111163147.GC7138@atomide.com>
 <CAJZ5v0jkwHnCPhdm6XAgiWz2=X1SPbfHVHZtZ-ONsp2OL0d-4w@mail.gmail.com>
 <20161111222911.GL7138@atomide.com>
 <20161111223234.GM7138@atomide.com>
 <CAJZ5v0gjcRyZHoj9YTpw1aKjFqH9mTZFH=ERvj2-FV_7ZnqjgA@mail.gmail.com>
 <20161112001917.GN7138@atomide.com>
 <CAJZ5v0ivMWZ2c8MphWcyz_S=tNgUyUihcP4=Y4Mz_uw7iZ6dMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ivMWZ2c8MphWcyz_S=tNgUyUihcP4=Y4Mz_uw7iZ6dMA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

* Rafael J. Wysocki <rafael@kernel.org> [161111 16:35]:
> However, my understanding is that the current code actually works for
> runtime PM just fine.

Hmm well I just noticed that for drivers not using autosuspend it can be
flakey, see the patch below. That probably explains some mysteries people
are seeing with wakeirqs.

Do you have any better ideas for setting wirq->active on the first
rpm_suspend()?

> What Brian seems to be wanting is to make system resume synchronize
> the wakeup interrupt at one point, so maybe there could be a "sync"
> version of dev_pm_disable_wake_irq() to be invoked then?

We call rpm_resume() from handle_threaded_wake_irq(), that's no better :)

Regards,

Tony

8< -------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 18 Nov 2016 10:15:34 -0800
Subject: [PATCH] PM / wakeirq: Fix wakeirq init

I noticed some wakeirq flakeyness with consumer drivers not using
autosuspend. For drivers not using autosuspend, the wakeirq may never
get unmasked in rpm_suspend() because of irq desc->depth.

We are configuring dedicated wakeirqs to start with IRQ_NOAUTOEN as we
naturally don't want them running until rpm_suspend() is called.

However, when a consumer driver calls pm_runtime_get functions, we now
wrongly start with disable_irq_nosync() call on the dedicated wakeirq
that is disabled to start with.

This causes desc->depth to toggle between 1 and 2 instead of the usual
0 and 1. This can prevent enable_irq() from unmasking the wakeirq as
that only happens at desc->depth 1.

This does not necessarily show up with drivers using autosuspend as
there is time for disable_irq_nosync() before rpm_suspend() gets called
after the autosuspend timeout.

Fix the issue by adding wirq->active flag that lazily gets set on
the first rpm_suspend().

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/power/power.h   | 19 +++++++++++++++++++
 drivers/base/power/runtime.c |  1 +
 drivers/base/power/wakeirq.c | 10 ++++------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -24,9 +24,24 @@ extern void pm_runtime_remove(struct device *dev);
 struct wake_irq {
 	struct device *dev;
 	int irq;
+	bool active:1;
 	bool dedicated_irq:1;
 };
 
+/* Caller must hold &dev->power.lock to change wirq->active */
+static inline void dev_pm_check_wake_irq(struct device *dev)
+{
+	struct wake_irq *wirq = dev->power.wakeirq;
+
+	if (!wirq)
+		return;
+
+	if (unlikely(!wirq->active)) {
+		wirq->active = true;
+		wmb();	/* ensure dev_pm_enable_wake_irq() sees active */
+	}
+}
+
 extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
 
@@ -96,6 +111,10 @@ static inline void wakeup_sysfs_remove(struct device *dev) {}
 static inline int pm_qos_sysfs_add(struct device *dev) { return 0; }
 static inline void pm_qos_sysfs_remove(struct device *dev) {}
 
+static inline void dev_pm_check_wake_irq(struct device *dev)
+{
+}
+
 static inline void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 {
 }
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -592,6 +592,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
+	dev_pm_check_wake_irq(dev);
 	dev_pm_enable_wake_irq(dev);
 	retval = rpm_callback(callback, dev);
 	if (retval)
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -212,8 +212,7 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
  * dev_pm_enable_wake_irq - Enable device wake-up interrupt
  * @dev: Device
  *
- * Called from the bus code or the device driver for
- * runtime_suspend() to enable the wake-up interrupt while
+ * Called from rpm_suspend() to enable the wake-up interrupt while
  * the device is running.
  *
  * Note that for runtime_suspend()) the wake-up interrupts
@@ -224,7 +223,7 @@ void dev_pm_enable_wake_irq(struct device *dev)
 {
 	struct wake_irq *wirq = dev->power.wakeirq;
 
-	if (wirq && wirq->dedicated_irq)
+	if (wirq && wirq->dedicated_irq && wirq->active)
 		enable_irq(wirq->irq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_enable_wake_irq);
@@ -233,15 +232,14 @@ EXPORT_SYMBOL_GPL(dev_pm_enable_wake_irq);
  * dev_pm_disable_wake_irq - Disable device wake-up interrupt
  * @dev: Device
  *
- * Called from the bus code or the device driver for
- * runtime_resume() to disable the wake-up interrupt while
+ * Called from rpm_resume() to disable the wake-up interrupt while
  * the device is running.
  */
 void dev_pm_disable_wake_irq(struct device *dev)
 {
 	struct wake_irq *wirq = dev->power.wakeirq;
 
-	if (wirq && wirq->dedicated_irq)
+	if (wirq && wirq->dedicated_irq && wirq->active)
 		disable_irq_nosync(wirq->irq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);
-- 
2.10.2
