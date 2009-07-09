From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/06] sh: Runtime PM for SuperH Mobile
Date: Fri, 10 Jul 2009 00:19:53 +0900
Message-ID: <20090709151953.8385.89482.sendpatchset__29886.6410310895$1247153079$gmane$org@rx1.opensource.se>
References: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
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

This patch contains the processor independent part of the
SuperH Mobile Runtime PM prototype.

The patch adds fields for Runtime PM to the architecture
specific part of struct platform_device. The most important
field is hw_blk_id which contains an id for the hardware
block within the SoC.

This hwblk id is used by the SuperH specific Runtime PM
callbacks for the platform bus. Multiple devices are allowed
to use the same hwblk id.

The SuperH specific Runtime PM platform bus callbacks
platform_pm_runtime_suspend() and platform_pm_runtime_resume()
control clocks and adds/removes the platform device to a list
of platform devices that has had their bus suspend callback
executed.

The driver Runtime PM suspend callbacks get invoked when
cpuidle discovers that all devices in the power domain
has had their bus suspend callback executed. When all devices
have been suspended using their driver Runtime PM suspend
callbacks, cpuidle is allowed to enter the deepest mode
which involves turning off power to the domain.

Please note that the code is very experimental. Alan kindly
suggested a cleaner way to do this using the idle callback,
but for that to work I need to rearrange all platform devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/device.h             |   16 ++
 arch/sh/include/asm/hwblk.h              |    4 
 arch/sh/kernel/cpu/shmobile/Makefile     |    1 
 arch/sh/kernel/cpu/shmobile/pm_runtime.c |  206 ++++++++++++++++++++++++++++++
 4 files changed, 225 insertions(+), 2 deletions(-)

--- 0001/arch/sh/include/asm/device.h
+++ work/arch/sh/include/asm/device.h	2009-07-09 18:41:09.000000000 +0900
@@ -3,7 +3,9 @@
  *
  * This file is released under the GPLv2
  */
-#include <asm-generic/device.h>
+
+struct dev_archdata {
+};
 
 struct platform_device;
 /* allocate contiguous memory chunk and fill in struct resource */
@@ -12,3 +14,15 @@ int platform_resource_setup_memory(struc
 
 void plat_early_device_setup(void);
 
+#define PDEV_ARCHDATA_FLAG_INIT 0
+#define PDEV_ARCHDATA_FLAG_LIST 1
+#define PDEV_ARCHDATA_FLAG_SUSP 2
+
+struct pdev_archdata {
+#ifdef CONFIG_ARCH_SHMOBILE
+	int hw_blk_id;
+	unsigned long flags;
+	struct list_head entry;
+	struct work_struct work;
+#endif
+};
--- 0005/arch/sh/include/asm/hwblk.h
+++ work/arch/sh/include/asm/hwblk.h	2009-07-09 18:42:49.000000000 +0900
@@ -5,7 +5,9 @@
 #include <asm/io.h>
 
 #define HWBLK_CNT_USAGE 0
-#define HWBLK_CNT_NR 1
+#define HWBLK_CNT_IDLE 1
+#define HWBLK_CNT_DEVICES 2
+#define HWBLK_CNT_NR 3
 
 #define HWBLK_AREA_FLAG_PARENT (1 << 0) /* valid parent */
 
--- 0001/arch/sh/kernel/cpu/shmobile/Makefile
+++ work/arch/sh/kernel/cpu/shmobile/Makefile	2009-07-09 18:41:12.000000000 +0900
@@ -5,3 +5,4 @@
 # Power Management & Sleep mode
 obj-$(CONFIG_PM)	+= pm.o sleep.o
 obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
+obj-$(CONFIG_PM_RUNTIME)	+= pm_runtime.o
--- /dev/null
+++ work/arch/sh/kernel/cpu/shmobile/pm_runtime.c	2009-07-09 18:41:12.000000000 +0900
@@ -0,0 +1,206 @@
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
+static DEFINE_SPINLOCK(hwblk_idle_lock);
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
+	struct dev_pm_ops *dev_pm_ops = NULL;
+	unsigned long flags;
+	int hwblk = pdev->archdata.hw_blk_id;
+	int ret = 0;
+
+	pr_info("platform_pm_runtime_work() suspending \"%s\" [%d]\n",
+		dev_name(dev), hwblk);
+
+	if (dev->driver && dev->driver->pm)
+		dev_pm_ops = dev->driver->pm;
+
+	if (dev_pm_ops && dev_pm_ops->runtime_suspend) {
+		hwblk_enable(hwblk_info, hwblk);
+		ret = dev_pm_ops->runtime_suspend(dev);
+		hwblk_disable(hwblk_info, hwblk);
+	}
+
+	if (ret)
+		return;
+
+	/* remove device from idle list and decrease idle count */
+	spin_lock_irqsave(&hwblk_idle_lock, flags);
+	if (test_bit(PDEV_ARCHDATA_FLAG_LIST, &pdev->archdata.flags)) {
+		list_del(&pdev->archdata.entry);
+		__clear_bit(PDEV_ARCHDATA_FLAG_LIST, &pdev->archdata.flags);
+		__set_bit(PDEV_ARCHDATA_FLAG_SUSP, &pdev->archdata.flags);
+		hwblk_cnt_dec(hwblk_info, hwblk, HWBLK_CNT_IDLE);
+	}
+	spin_unlock_irqrestore(&hwblk_idle_lock, flags);
+
+	pr_info("platform_pm_runtime_work() suspended \"%s\" [%d]\n",
+		dev_name(dev), hwblk);
+}
+
+void platform_pm_runtime_suspend_idle(void)
+{
+	struct platform_device *pdev;
+	unsigned long flags;
+
+	/* schedule suspend for all devices on the idle list */
+	spin_lock_irqsave(&hwblk_idle_lock, flags);
+	list_for_each_entry(pdev, &hwblk_idle_list, archdata.entry)
+		schedule_work(&pdev->archdata.work);
+	spin_unlock_irqrestore(&hwblk_idle_lock, flags);
+}
+
+int platform_pm_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	unsigned long flags;
+	int hwblk = pdev->archdata.hw_blk_id;
+
+	if (!hwblk)
+		return -EINVAL;
+
+	pr_info("platform_pm_runtime_suspend() \"%s\" [%d]\n",
+		dev_name(dev), hwblk);
+
+	if (test_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags)) {
+		pr_warning("runtime_pm: driver should start from resume!\n");
+		return -EINVAL;
+	}
+
+	/* disable the clock */
+	hwblk_disable(hwblk_info, hwblk);
+
+	/* increase idle count */
+	hwblk_cnt_inc(hwblk_info, hwblk, HWBLK_CNT_IDLE);
+
+	/* put device on idle list */
+	spin_lock_irqsave(&hwblk_idle_lock, flags);
+	list_add_tail(&pdev->archdata.entry, &hwblk_idle_list);
+	__set_bit(PDEV_ARCHDATA_FLAG_LIST, &pdev->archdata.flags);
+	spin_unlock_irqrestore(&hwblk_idle_lock, flags);
+
+	return 0;
+};
+
+int platform_pm_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dev_pm_ops *dev_pm_ops = NULL;
+	unsigned long flags;
+	int hwblk = pdev->archdata.hw_blk_id;
+	int ret = 0;
+
+	if (!hwblk)
+		return -EINVAL;
+
+	pr_info("platform_pm_runtime_resume() \"%s\" [%d]\n",
+		dev_name(dev), hwblk);
+
+	/* remove device from idle list if needed */
+	spin_lock_irqsave(&hwblk_idle_lock, flags);
+	if (test_bit(PDEV_ARCHDATA_FLAG_LIST, &pdev->archdata.flags)) {
+		list_del(&pdev->archdata.entry);
+		__clear_bit(PDEV_ARCHDATA_FLAG_LIST, &pdev->archdata.flags);
+	}
+	spin_unlock_irqrestore(&hwblk_idle_lock, flags);
+
+	/* decrease idle count if needed */
+	if (!test_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags) &&
+	    !test_bit(PDEV_ARCHDATA_FLAG_SUSP, &pdev->archdata.flags))
+		hwblk_cnt_dec(hwblk_info, hwblk, HWBLK_CNT_IDLE);
+
+	__clear_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags);
+
+	/* enable the clock */
+	hwblk_enable(hwblk_info, hwblk);
+
+	/* resume the device if needed */
+	if (test_bit(PDEV_ARCHDATA_FLAG_SUSP, &pdev->archdata.flags)) {
+
+		pr_info("platform_pm_runtime_resume() resuming \"%s\" [%d]\n",
+			dev_name(dev), hwblk);
+
+		if (dev->driver && dev->driver->pm)
+			dev_pm_ops = dev->driver->pm;
+
+		if (dev_pm_ops && dev_pm_ops->runtime_resume)
+			ret = dev_pm_ops->runtime_resume(dev);
+
+		__clear_bit(PDEV_ARCHDATA_FLAG_SUSP, &pdev->archdata.flags);
+	}
+
+	return ret;
+};
+
+static int __devinit platform_bus_notify(struct notifier_block *nb,
+					 unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct platform_device *pdev = to_platform_device(dev);
+	int hwblk = pdev->archdata.hw_blk_id;
+
+	/* ignore off-chip non-SoC platform devices */
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
+arch_initcall(sh_pm_runtime_init);
