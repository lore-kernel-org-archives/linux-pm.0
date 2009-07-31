From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/04] sh: SuperH platform bus code for Runtime
	PM v11
Date: Fri, 31 Jul 2009 23:02:12 +0900
Message-ID: <20090731140212.11351.77839.sendpatchset__40320.0213601396$1249049255$gmane$org@rx1.opensource.se>
References: <20090731140158.11351.26021.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090731140158.11351.26021.sendpatchset@rx1.opensource.se>
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

This patch is V2 of the SuperH Platform Bus prototype
implentation for Runtime PM v11.

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
is allowed to enter deep sleep from cpuidle. The cpuidle
implementation is however not part of this patch.

The runtime resume operation turns on clocks and also
restores registers if needed. It is worth noting that the
devices start in a suspended state and the device driver
is responsible for calling runtime resume before accessing
the actual hardware.

In this particular platform bus implementation runtime
resume is not allowed from interrupt context. Runtime
suspend is however allowed from interrupt context as
long as the synchronous functions are avoided.

This code is already working quite well, but it needs a
bit more attention before I remove the prototype label.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

  Changes since last V1:
  - update from Runtime PM v9 to v11
  - rework error handling
  - implement platform_pm_runtime_idle()
  - add might_sleep()
  - use dev_pm_ops helpers
  - use dev_dbg()
  - use core_initcall()

  TODO:
  - use a mutex to serialize dev_pm_ops calls
  - rewrite the schedule_work() code

 arch/sh/include/asm/device.h             |    8 
 arch/sh/include/asm/hwblk.h              |    4 
 arch/sh/kernel/cpu/shmobile/Makefile     |    1 
 arch/sh/kernel/cpu/shmobile/pm_runtime.c |  244 ++++++++++++++++++++++++++++++
 4 files changed, 256 insertions(+), 1 deletion(-)

--- 0006/arch/sh/include/asm/device.h
+++ work/arch/sh/include/asm/device.h	2009-07-31 19:53:40.000000000 +0900
@@ -14,8 +14,16 @@ int platform_resource_setup_memory(struc
 
 void plat_early_device_setup(void);
 
+#define PDEV_ARCHDATA_FLAG_INIT 0
+#define PDEV_ARCHDATA_FLAG_LIST 1
+#define PDEV_ARCHDATA_FLAG_SUSP 2
+#define PDEV_ARCHDATA_FLAG_WORK 3
+
 struct pdev_archdata {
 #ifdef CONFIG_ARCH_SHMOBILE
 	int hwblk_id;
+	unsigned long flags;
+	struct list_head entry;
+	struct work_struct work;
 #endif
 };
--- 0001/arch/sh/include/asm/hwblk.h
+++ work/arch/sh/include/asm/hwblk.h	2009-07-31 19:53:40.000000000 +0900
@@ -5,7 +5,9 @@
 #include <asm/io.h>
 
 #define HWBLK_CNT_USAGE 0
-#define HWBLK_CNT_NR 1
+#define HWBLK_CNT_IDLE 1
+#define HWBLK_CNT_DEVICES 2
+#define HWBLK_CNT_NR 3
 
 #define HWBLK_AREA_FLAG_PARENT (1 << 0) /* valid parent */
 
--- 0001/arch/sh/kernel/cpu/shmobile/Makefile
+++ work/arch/sh/kernel/cpu/shmobile/Makefile	2009-07-31 19:53:40.000000000 +0900
@@ -5,3 +5,4 @@
 # Power Management & Sleep mode
 obj-$(CONFIG_PM)	+= pm.o sleep.o
 obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
+obj-$(CONFIG_PM_RUNTIME)	+= pm_runtime.o
--- /dev/null
+++ work/arch/sh/kernel/cpu/shmobile/pm_runtime.c	2009-07-31 21:36:49.000000000 +0900
@@ -0,0 +1,244 @@
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
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <asm/hwblk.h>
+
+static DEFINE_SPINLOCK(hwblk_lock);
+static LIST_HEAD(hwblk_idle_list);
+
+extern struct hwblk_info *hwblk_info;
+
+static void platform_pm_runtime_work(struct work_struct *work)
+{
+	struct platform_device *pdev = container_of(work,
+						    struct platform_device,
+						    archdata.work);
+	struct device *dev = &pdev->dev;
+	unsigned long flags;
+	int hwblk = pdev->archdata.hwblk_id;
+	int ret = 0;
+
+	dev_dbg(dev, "platform_pm_runtime_work() [%d]\n", hwblk);
+
+	if (dev->driver) {
+		hwblk_enable(hwblk_info, hwblk);
+		ret = pm_runtime_ops_suspend(dev, dev->driver->pm);
+		hwblk_disable(hwblk_info, hwblk);
+	}
+
+	if (ret)
+		return;
+
+	/* remove device from idle list and decrease idle count */
+	spin_lock_irqsave(&hwblk_lock, flags);
+	if (test_bit(PDEV_ARCHDATA_FLAG_LIST, &pdev->archdata.flags)) {
+		list_del(&pdev->archdata.entry);
+		__clear_bit(PDEV_ARCHDATA_FLAG_LIST, &pdev->archdata.flags);
+	}
+	__set_bit(PDEV_ARCHDATA_FLAG_SUSP, &pdev->archdata.flags);
+	__clear_bit(PDEV_ARCHDATA_FLAG_WORK, &pdev->archdata.flags);
+	spin_unlock_irqrestore(&hwblk_lock, flags);
+
+	hwblk_cnt_dec(hwblk_info, hwblk, HWBLK_CNT_IDLE);
+
+	dev_dbg(dev, "platform_pm_runtime_work() suspended [%d]\n", hwblk);
+}
+
+/* this function gets called from cpuidle context when all devices in
+ * a power domain are unused but some are coutned as idle, ie the hwblk
+ * counter values are (HWBLK_CNT_USAGE == 0) && (HWBLK_CNT_IDLE != 0)
+ */
+void platform_pm_runtime_suspend_idle(void)
+{
+	struct platform_device *pdev;
+	struct pdev_archdata *ad;
+	unsigned long flags;
+
+	/* schedule suspend for all devices on the idle list */
+	spin_lock_irqsave(&hwblk_lock, flags);
+	list_for_each_entry(pdev, &hwblk_idle_list, archdata.entry) {
+		ad = &pdev->archdata;
+		if (!test_and_set_bit(PDEV_ARCHDATA_FLAG_WORK, &ad->flags))
+			schedule_work(&ad->work);
+	}
+	spin_unlock_irqrestore(&hwblk_lock, flags);
+}
+
+int platform_pm_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	unsigned long flags;
+	int hwblk = pdev->archdata.hwblk_id;
+	int ret = 0;
+
+	/* ignore off-chip platform devices */
+	if (!hwblk)
+		return 0;
+
+	dev_dbg(dev, "platform_pm_runtime_suspend() [%d]\n", hwblk);
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
+	/* disable clock */
+	hwblk_disable(hwblk_info, hwblk);
+
+	/* put device on idle list */
+	spin_lock_irqsave(&hwblk_lock, flags);
+	list_add_tail(&pdev->archdata.entry, &hwblk_idle_list);
+	__set_bit(PDEV_ARCHDATA_FLAG_LIST, &pdev->archdata.flags);
+	spin_unlock_irqrestore(&hwblk_lock, flags);
+
+	/* increase idle count */
+	hwblk_cnt_inc(hwblk_info, hwblk, HWBLK_CNT_IDLE);
+
+ out:
+	dev_dbg(dev, "platform_pm_runtime_suspend() [%d] returns %d\n",
+		hwblk, ret);
+
+	return ret;
+};
+
+int platform_pm_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	unsigned long flags;
+	int hwblk = pdev->archdata.hwblk_id;
+	int ret = 0;
+
+	/* ignore off-chip platform devices */
+	if (!hwblk)
+		return 0;
+
+	dev_dbg(dev, "platform_pm_runtime_resume() [%d]\n", hwblk);
+
+	/* interrupt context not allowed */
+	might_sleep();
+
+	/* make sure device is removed from idle list */
+	spin_lock_irqsave(&hwblk_lock, flags);
+	if (test_bit(PDEV_ARCHDATA_FLAG_LIST, &pdev->archdata.flags)) {
+		list_del(&pdev->archdata.entry);
+		__clear_bit(PDEV_ARCHDATA_FLAG_LIST, &pdev->archdata.flags);
+	}
+	spin_unlock_irqrestore(&hwblk_lock, flags);
+
+	/* decrease idle count if needed */
+	if (!test_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags) &&
+	    !test_bit(PDEV_ARCHDATA_FLAG_SUSP, &pdev->archdata.flags))
+		hwblk_cnt_dec(hwblk_info, hwblk, HWBLK_CNT_IDLE);
+
+	/* enable clock */
+	hwblk_enable(hwblk_info, hwblk);
+
+	/* resume the device if needed */
+	if (test_bit(PDEV_ARCHDATA_FLAG_SUSP, &pdev->archdata.flags)) {
+		if (dev->driver)
+			ret = pm_runtime_ops_resume(dev, dev->driver->pm);
+	}
+
+	spin_lock_irqsave(&hwblk_lock, flags);
+
+	/* the driver has been initialized now, so clear the init flag */
+	__clear_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags);
+
+	/* clear susp flag if driver runtime resume was successful */
+	if (!ret)
+		__clear_bit(PDEV_ARCHDATA_FLAG_SUSP, &pdev->archdata.flags);
+
+	spin_unlock_irqrestore(&hwblk_lock, flags);
+
+	/* disable clock again if driver runtime resume failed */
+	if (ret)
+		hwblk_disable(hwblk_info, hwblk);
+
+	dev_dbg(dev, "platform_pm_runtime_resume() [%d] returns %d\n",
+		hwblk, ret);
+
+	return ret;
+};
+
+void platform_pm_runtime_idle(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int hwblk = pdev->archdata.hwblk_id;
+
+	/* ignore off-chip platform devices */
+	if (!hwblk)
+		return;
+
+	/* interrupt context not allowed, use pm_runtime_put()! */
+	might_sleep();
+
+	/* suspend synchronously to disable clocks immediately */
+	pm_runtime_suspend(dev);
+};
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
+		INIT_WORK(&pdev->archdata.work, platform_pm_runtime_work);
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
+	bus_register_notifier(&platform_bus_type, &platform_bus_notifier);
+	return 0;
+}
+
+core_initcall(sh_pm_runtime_init);
