From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/05] sh: Runtime PM for SuperH Mobile platform
	bus devices
Date: Fri, 14 Aug 2009 19:48:16 +0900
Message-ID: <20090814104816.32396.60186.sendpatchset__32389.259132515$1250247256$gmane$org@rx1.opensource.se>
References: <20090814104808.32396.50021.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090814104808.32396.50021.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch is V3 of the SuperH Mobile Runtime PM platform bus
implentation matching Rafael's Runtime PM v16.

The code gets invoked from the SuperH specific Runtime PM
platform bus functions that override the weak symbols for:
 - platform_pm_runtime_suspend()
 - platform_pm_runtime_resume()
 - platform_pm_runtime_idle()

This Runtime PM implementation performs two levels of power
management. At the time of platform bus runtime suspend the
clock to the device is stopped instantly. Later on if all
devices within the power domain has their clocks stopped
then the device driver ->runtime_suspend() callbacks are
used to save hardware register state for each device.

Device driver ->runtime_suspend() calls are scheduled from
cpuidle context using platform_pm_runtime_suspend_idle().
When all devices have been fully suspended the processor
is allowed to enter deep sleep from cpuidle.

The runtime resume operation turns on clocks and also
restores registers if needed. It is worth noting that the
devices start in a suspended state and the device driver
is responsible for calling runtime resume before accessing
the actual hardware.

In this particular platform bus implementation runtime
resume is not allowed from interrupt context. Runtime
suspend is however allowed from interrupt context as
long as the synchronous functions are avoided.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

  Changes since V2
  - update to v16
  - rewrite work queue code
  - use mutex

  Changes since V1:
  - update from Runtime PM v9 to v11
  - rework error handling
  - implement platform_pm_runtime_idle()
  - add might_sleep()
  - use dev_pm_ops helpers
  - use dev_dbg()
  - use core_initcall()

 arch/sh/include/asm/device.h             |    9 
 arch/sh/include/asm/hwblk.h              |    4 
 arch/sh/kernel/cpu/shmobile/Makefile     |    1 
 arch/sh/kernel/cpu/shmobile/pm_runtime.c |  304 ++++++++++++++++++++++++++++++
 4 files changed, 317 insertions(+), 1 deletion(-)

--- 0011/arch/sh/include/asm/device.h
+++ work/arch/sh/include/asm/device.h	2009-08-14 18:23:00.000000000 +0900
@@ -14,6 +14,15 @@ int platform_resource_setup_memory(struc
 
 void plat_early_device_setup(void);
 
+#define PDEV_ARCHDATA_FLAG_INIT 0
+#define PDEV_ARCHDATA_FLAG_IDLE 1
+#define PDEV_ARCHDATA_FLAG_SUSP 2
+
 struct pdev_archdata {
 	int hwblk_id;
+#ifdef CONFIG_PM_RUNTIME
+	unsigned long flags;
+	struct list_head entry;
+	struct mutex mutex;
+#endif
 };
--- 0001/arch/sh/include/asm/hwblk.h
+++ work/arch/sh/include/asm/hwblk.h	2009-08-14 18:22:22.000000000 +0900
@@ -5,7 +5,9 @@
 #include <asm/io.h>
 
 #define HWBLK_CNT_USAGE 0
-#define HWBLK_CNT_NR 1
+#define HWBLK_CNT_IDLE 1
+#define HWBLK_CNT_DEVICES 2
+#define HWBLK_CNT_NR 3
 
 #define HWBLK_AREA_FLAG_PARENT (1 << 0) /* valid parent */
 
--- 0001/arch/sh/kernel/cpu/shmobile/Makefile
+++ work/arch/sh/kernel/cpu/shmobile/Makefile	2009-08-14 18:22:22.000000000 +0900
@@ -5,3 +5,4 @@
 # Power Management & Sleep mode
 obj-$(CONFIG_PM)	+= pm.o sleep.o
 obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
+obj-$(CONFIG_PM_RUNTIME)	+= pm_runtime.o
--- /dev/null
+++ work/arch/sh/kernel/cpu/shmobile/pm_runtime.c	2009-08-14 18:25:56.000000000 +0900
@@ -0,0 +1,304 @@
+/*
+ * arch/sh/kernel/cpu/shmobile/pm_runtime.c
+ *
+ * Runtime PM support code for SuperH Mobile
+ *
+ *  Copyright (C) 2009 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <asm/hwblk.h>
+
+static DEFINE_SPINLOCK(hwblk_lock);
+static LIST_HEAD(hwblk_idle_list);
+static struct work_struct hwblk_work;
+
+extern struct hwblk_info *hwblk_info;
+
+static void platform_pm_runtime_not_idle(struct platform_device *pdev)
+{
+	unsigned long flags;
+
+	/* remove device from idle list */
+	spin_lock_irqsave(&hwblk_lock, flags);
+	if (test_bit(PDEV_ARCHDATA_FLAG_IDLE, &pdev->archdata.flags)) {
+		list_del(&pdev->archdata.entry);
+		__clear_bit(PDEV_ARCHDATA_FLAG_IDLE, &pdev->archdata.flags);
+	}
+	spin_unlock_irqrestore(&hwblk_lock, flags);
+}
+
+static int __platform_pm_runtime_resume(struct platform_device *pdev)
+{
+	struct device *d = &pdev->dev;
+	struct pdev_archdata *ad = &pdev->archdata;
+	int hwblk = ad->hwblk_id;
+	int ret = -ENOSYS;
+
+	dev_dbg(d, "__platform_pm_runtime_resume() [%d]\n", hwblk);
+
+	if (d->driver && d->driver->pm && d->driver->pm->runtime_resume) {
+		hwblk_enable(hwblk_info, hwblk);
+		ret = 0;
+
+		if (test_bit(PDEV_ARCHDATA_FLAG_SUSP, &ad->flags)) {
+			ret = d->driver->pm->runtime_resume(d);
+			if (!ret)
+				clear_bit(PDEV_ARCHDATA_FLAG_SUSP, &ad->flags);
+			else
+				hwblk_disable(hwblk_info, hwblk);
+		}
+	}
+
+	dev_dbg(d, "__platform_pm_runtime_resume() [%d] - returns %d\n",
+		hwblk, ret);
+
+	return ret;
+}
+
+static int __platform_pm_runtime_suspend(struct platform_device *pdev)
+{
+	struct device *d = &pdev->dev;
+	struct pdev_archdata *ad = &pdev->archdata;
+	int hwblk = ad->hwblk_id;
+	int ret = -ENOSYS;
+
+	dev_dbg(d, "__platform_pm_runtime_suspend() [%d]\n", hwblk);
+
+	if (d->driver && d->driver->pm && d->driver->pm->runtime_suspend) {
+		BUG_ON(!test_bit(PDEV_ARCHDATA_FLAG_IDLE, &ad->flags));
+
+		hwblk_enable(hwblk_info, hwblk);
+		ret = d->driver->pm->runtime_suspend(d);
+		hwblk_disable(hwblk_info, hwblk);
+
+		if (!ret) {
+			set_bit(PDEV_ARCHDATA_FLAG_SUSP, &ad->flags);
+			platform_pm_runtime_not_idle(pdev);
+			hwblk_cnt_dec(hwblk_info, hwblk, HWBLK_CNT_IDLE);
+		}
+	}
+
+	dev_dbg(d, "__platform_pm_runtime_suspend() [%d] - returns %d\n",
+		hwblk, ret);
+
+	return ret;
+}
+
+static void platform_pm_runtime_work(struct work_struct *work)
+{
+	struct platform_device *pdev;
+	unsigned long flags;
+	int ret;
+
+	/* go through the idle list and suspend one device at a time */
+	do {
+		spin_lock_irqsave(&hwblk_lock, flags);
+		if (list_empty(&hwblk_idle_list))
+			pdev = NULL;
+		else
+			pdev = list_first_entry(&hwblk_idle_list,
+						struct platform_device,
+						archdata.entry);
+		spin_unlock_irqrestore(&hwblk_lock, flags);
+
+		if (pdev) {
+			mutex_lock(&pdev->archdata.mutex);
+			ret = __platform_pm_runtime_suspend(pdev);
+
+			/* at this point the platform device may be:
+			 * suspended: ret = 0, FLAG_SUSP set, clock stopped
+			 * failed: ret < 0, FLAG_IDLE set, clock stopped
+			 */
+			mutex_unlock(&pdev->archdata.mutex);
+		} else {
+			ret = -ENODEV;
+		}
+	} while (!ret);
+}
+
+/* this function gets called from cpuidle context when all devices in the
+ * main power domain are unused but some are counted as idle, ie the hwblk
+ * counter values are (HWBLK_CNT_USAGE == 0) && (HWBLK_CNT_IDLE != 0)
+ */
+void platform_pm_runtime_suspend_idle(void)
+{
+	queue_work(pm_wq, &hwblk_work);
+}
+
+int platform_pm_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pdev_archdata *ad = &pdev->archdata;
+	unsigned long flags;
+	int hwblk = ad->hwblk_id;
+	int ret = 0;
+
+	dev_dbg(dev, "platform_pm_runtime_suspend() [%d]\n", hwblk);
+
+	/* ignore off-chip platform devices */
+	if (!hwblk)
+		goto out;
+
+	/* interrupt context not allowed */
+	might_sleep();
+
+	/* catch misconfigured drivers not starting with resume */
+	if (test_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* serialize */
+	mutex_lock(&ad->mutex);
+
+	/* disable clock */
+	hwblk_disable(hwblk_info, hwblk);
+
+	/* put device on idle list */
+	spin_lock_irqsave(&hwblk_lock, flags);
+	list_add_tail(&pdev->archdata.entry, &hwblk_idle_list);
+	__set_bit(PDEV_ARCHDATA_FLAG_IDLE, &pdev->archdata.flags);
+	spin_unlock_irqrestore(&hwblk_lock, flags);
+
+	/* increase idle count */
+	hwblk_cnt_inc(hwblk_info, hwblk, HWBLK_CNT_IDLE);
+
+	/* at this point the platform device is:
+	 * idle: ret = 0, FLAG_IDLE set, clock stopped
+	 */
+	mutex_unlock(&ad->mutex);
+
+ out:
+	dev_dbg(dev, "platform_pm_runtime_suspend() [%d] returns %d\n",
+		hwblk, ret);
+
+	return ret;
+}
+
+int platform_pm_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pdev_archdata *ad = &pdev->archdata;
+	int hwblk = ad->hwblk_id;
+	int ret = 0;
+
+	dev_dbg(dev, "platform_pm_runtime_resume() [%d]\n", hwblk);
+
+	/* ignore off-chip platform devices */
+	if (!hwblk)
+		goto out;
+
+	/* interrupt context not allowed */
+	might_sleep();
+
+	/* serialize */
+	mutex_lock(&ad->mutex);
+
+	/* make sure device is removed from idle list */
+	platform_pm_runtime_not_idle(pdev);
+
+	/* decrease idle count */
+	if (!test_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags) &&
+	    !test_bit(PDEV_ARCHDATA_FLAG_SUSP, &pdev->archdata.flags))
+		hwblk_cnt_dec(hwblk_info, hwblk, HWBLK_CNT_IDLE);
+
+	/* resume the device if needed */
+	ret = __platform_pm_runtime_resume(pdev);
+
+	/* the driver has been initialized now, so clear the init flag */
+	clear_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags);
+
+	/* at this point the platform device may be:
+	 * resumed: ret = 0, flags = 0, clock started
+	 * failed: ret < 0, FLAG_SUSP set, clock stopped
+	 */
+	mutex_unlock(&ad->mutex);
+ out:
+	dev_dbg(dev, "platform_pm_runtime_resume() [%d] returns %d\n",
+		hwblk, ret);
+
+	return ret;
+}
+
+void platform_pm_runtime_idle(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int hwblk = pdev->archdata.hwblk_id;
+
+	dev_dbg(dev, "platform_pm_runtime_idle() [%d]\n", hwblk);
+
+	/* ignore off-chip platform devices */
+	if (!hwblk)
+		goto out;
+
+	/* interrupt context not allowed, use pm_runtime_put()! */
+	might_sleep();
+
+	/* suspend synchronously to disable clocks immediately */
+	pm_runtime_suspend(dev);
+ out:
+	dev_dbg(dev, "platform_pm_runtime_idle() [%d] done!\n", hwblk);
+	return;
+}
+
+static int __devinit platform_bus_notify(struct notifier_block *nb,
+					 unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct platform_device *pdev = to_platform_device(dev);
+	int hwblk = pdev->archdata.hwblk_id;
+
+	/* ignore off-chip platform devices */
+	if (!hwblk)
+		return 0;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		INIT_LIST_HEAD(&pdev->archdata.entry);
+		mutex_init(&pdev->archdata.mutex);
+		/* platform devices without drivers should be disabled */
+		hwblk_enable(hwblk_info, hwblk);
+		hwblk_disable(hwblk_info, hwblk);
+		/* make sure driver re-inits itself once */
+		__set_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags);
+		break;
+	/* TODO: add BUS_NOTIFY_BIND_DRIVER and increase idle count */
+	case BUS_NOTIFY_BOUND_DRIVER:
+		/* keep track of number of devices in use per hwblk */
+		hwblk_cnt_inc(hwblk_info, hwblk, HWBLK_CNT_DEVICES);
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		/* keep track of number of devices in use per hwblk */
+		hwblk_cnt_dec(hwblk_info, hwblk, HWBLK_CNT_DEVICES);
+		/* make sure driver re-inits itself once */
+		__set_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags);
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		break;
+	}
+	return 0;
+}
+
+static struct notifier_block platform_bus_notifier = {
+	.notifier_call = platform_bus_notify
+};
+
+static int __init sh_pm_runtime_init(void)
+{
+	INIT_WORK(&hwblk_work, platform_pm_runtime_work);
+
+	bus_register_notifier(&platform_bus_type, &platform_bus_notifier);
+	return 0;
+}
+
+core_initcall(sh_pm_runtime_init);
