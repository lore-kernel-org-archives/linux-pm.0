From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/04] PM: Add platform bus runtime dev_pm_ops
Date: Wed, 27 May 2009 19:06:50 +0900
Message-ID: <20090527100650.29671.82139.sendpatchset__27387.243792373$1243419071$gmane$org@rx1.opensource.se>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
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
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Wrap the platform device bus dev_pm_ops to allow runtime
pm and regular suspend and resume to coexist.

Platform device data is extended with flags that allow
us to keep track of which dev_pm_ops that has been called.

Basically, if a device has been frozen by the runtime pm
code, don't call ->freeze() again when hibernating.

Architecture code can use platform_runtime_dev_pm_ops to
call driver dev_pm_ops associated with a certain device.

Enable with CONFIG_HAVE_PLATFORM_DEVICE_RUNTIME_PM.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 This is a bit of a hack, any better way to wrap dev_pm_ops?

 arch/Kconfig                    |    3 
 drivers/base/platform.c         |  193 ++++++++++++++++++++++++++++++++++++++-
 include/linux/platform_device.h |    8 +
 3 files changed, 203 insertions(+), 1 deletion(-)

--- 0003/arch/Kconfig
+++ work/arch/Kconfig	2009-05-26 21:22:17.000000000 +0900
@@ -118,3 +118,6 @@ config HAVE_PLATFORM_DEVICE_ARCHDATA
 
 config HAVE_PLATFORM_DEVICE_IDLE_WAKEUP
 	bool
+
+config HAVE_PLATFORM_DEVICE_RUNTIME_PM
+	bool
--- 0001/drivers/base/platform.c
+++ work/drivers/base/platform.c	2009-05-27 17:31:06.000000000 +0900
@@ -962,12 +962,203 @@ static struct dev_pm_ops platform_dev_pm
 
 #endif /* !CONFIG_PM_SLEEP */
 
+#ifdef CONFIG_HAVE_PLATFORM_DEVICE_RUNTIME_PM
+
+#define DEV_PM_OP_PREPARE offsetof(struct dev_pm_ops, prepare)
+#define DEV_PM_OP_COMPLETE offsetof(struct dev_pm_ops, complete)
+#define DEV_PM_OP_SUSPEND offsetof(struct dev_pm_ops, suspend)
+#define DEV_PM_OP_RESUME offsetof(struct dev_pm_ops, resume)
+#define DEV_PM_OP_FREEZE offsetof(struct dev_pm_ops, freeze)
+#define DEV_PM_OP_THAW offsetof(struct dev_pm_ops, thaw)
+#define DEV_PM_OP_POWEROFF offsetof(struct dev_pm_ops, poweroff)
+#define DEV_PM_OP_RESTORE offsetof(struct dev_pm_ops, restore)
+#define DEV_PM_OP_SUSPEND_NOIRQ offsetof(struct dev_pm_ops, suspend_noirq)
+#define DEV_PM_OP_RESUME_NOIRQ offsetof(struct dev_pm_ops, resume_noirq)
+#define DEV_PM_OP_FREEZE_NOIRQ offsetof(struct dev_pm_ops, freeze_noirq)
+#define DEV_PM_OP_THAW_NOIRQ offsetof(struct dev_pm_ops, thaw_noirq)
+#define DEV_PM_OP_POWEROFF_NOIRQ offsetof(struct dev_pm_ops, poweroff_noirq)
+#define DEV_PM_OP_RESTORE_NOIRQ offsetof(struct dev_pm_ops, restore_noirq)
+
+static DEFINE_SPINLOCK(platform_runtime_lock);
+
+static int platform_runtime_call_op(struct device *dev, unsigned int op)
+{
+	struct dev_pm_ops *dev_pm_ops = PLATFORM_PM_OPS_PTR;
+	void **vp = (void **)dev_pm_ops;
+	int (*int_op)(struct device *);
+
+	if (dev_pm_ops) {
+		if (op == DEV_PM_OP_COMPLETE) {
+			if (dev_pm_ops->complete)
+				dev_pm_ops->complete(dev);
+		} else {
+			int_op = vp[op / sizeof(void *)];
+			if (int_op)
+				return int_op(dev);
+		}
+	}
+
+	return 0;
+}
+
+static int platform_runtime_call_once(struct device *dev,
+				      unsigned int op)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	unsigned long flags;
+	int bit, bit_op, is_suspend, ret;
+
+	ret = 0;
+	is_suspend = 0;
+
+	switch (op) {
+	case DEV_PM_OP_COMPLETE:
+		bit_op = DEV_PM_OP_PREPARE;
+		break;
+	case DEV_PM_OP_RESUME:
+		bit_op = DEV_PM_OP_SUSPEND;
+		break;
+	case DEV_PM_OP_THAW:
+		bit_op = DEV_PM_OP_FREEZE;
+		break;
+	case DEV_PM_OP_RESTORE:
+		bit_op = DEV_PM_OP_POWEROFF;
+		break;
+	case DEV_PM_OP_RESUME_NOIRQ:
+		bit_op = DEV_PM_OP_SUSPEND_NOIRQ;
+		break;
+	case DEV_PM_OP_THAW_NOIRQ:
+		bit_op = DEV_PM_OP_FREEZE_NOIRQ;
+		break;
+	case DEV_PM_OP_RESTORE_NOIRQ:
+		bit_op = DEV_PM_OP_POWEROFF_NOIRQ;
+		break;
+	default:
+		bit_op = op;
+		is_suspend = 1;
+	}
+
+	bit = bit_op / sizeof(void *);
+
+	spin_lock_irqsave(&platform_runtime_lock, flags);
+
+	if (test_bit(bit, &pdev->runtime_flags) != is_suspend) {
+		ret = platform_runtime_call_op(dev, op);
+
+		if (!ret) {
+			if (is_suspend)
+				__set_bit(bit, &pdev->runtime_flags);
+			else
+				__clear_bit(bit, &pdev->runtime_flags);
+		}
+	}
+
+	spin_unlock_irqrestore(&platform_runtime_lock, flags);
+
+	return ret;
+}
+
+static int platform_runtime_prepare(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_PREPARE);
+}
+
+static void platform_runtime_complete(struct device *dev)
+{
+	platform_runtime_call_once(dev, DEV_PM_OP_COMPLETE);
+}
+
+static int platform_runtime_suspend(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_SUSPEND);
+}
+
+static int platform_runtime_resume(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_RESUME);
+}
+
+static int platform_runtime_freeze(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_FREEZE);
+}
+
+static int platform_runtime_thaw(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_THAW);
+}
+
+static int platform_runtime_poweroff(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_POWEROFF);
+}
+
+static int platform_runtime_restore(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_RESTORE);
+}
+
+static int platform_runtime_suspend_noirq(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_SUSPEND_NOIRQ);
+}
+
+static int platform_runtime_resume_noirq(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_RESUME_NOIRQ);
+}
+
+static int platform_runtime_freeze_noirq(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_FREEZE_NOIRQ);
+}
+
+static int platform_runtime_thaw_noirq(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_THAW_NOIRQ);
+}
+
+static int platform_runtime_poweroff_noirq(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_POWEROFF_NOIRQ);
+}
+
+static int platform_runtime_restore_noirq(struct device *dev)
+{
+	return platform_runtime_call_once(dev, DEV_PM_OP_RESTORE_NOIRQ);
+}
+
+struct dev_pm_ops platform_runtime_dev_pm_ops = {
+	.prepare = platform_runtime_prepare,
+	.complete = platform_runtime_complete,
+	.suspend = platform_runtime_suspend,
+	.resume = platform_runtime_resume,
+	.freeze = platform_runtime_freeze,
+	.thaw = platform_runtime_thaw,
+	.poweroff = platform_runtime_poweroff,
+	.restore = platform_runtime_restore,
+	.suspend_noirq = platform_runtime_suspend_noirq,
+	.resume_noirq = platform_runtime_resume_noirq,
+	.freeze_noirq = platform_runtime_freeze_noirq,
+	.thaw_noirq = platform_runtime_thaw_noirq,
+	.poweroff_noirq = platform_runtime_poweroff_noirq,
+	.restore_noirq = platform_runtime_restore_noirq,
+};
+
+#define PLATFORM_RUNTIME_PM_OPS_PTR	(&platform_runtime_dev_pm_ops)
+
+#else /* !CONFIG_HAVE_PLATFORM_DEVICE_RUNTIME_PM */
+
+#define PLATFORM_RUNTIME_PM_OPS_PTR	PLATFORM_PM_OPS_PTR
+
+#endif /* !CONFIG_HAVE_PLATFORM_DEVICE_RUNTIME_PM */
+
 struct bus_type platform_bus_type = {
 	.name		= "platform",
 	.dev_attrs	= platform_dev_attrs,
 	.match		= platform_match,
 	.uevent		= platform_uevent,
-	.pm		= PLATFORM_PM_OPS_PTR,
+	.pm		= PLATFORM_RUNTIME_PM_OPS_PTR,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
--- 0003/include/linux/platform_device.h
+++ work/include/linux/platform_device.h	2009-05-26 21:22:17.000000000 +0900
@@ -27,6 +27,10 @@ struct platform_device {
 	/* arch specific additions */
 	struct pdev_archdata	archdata;
 #endif
+#ifdef CONFIG_HAVE_PLATFORM_DEVICE_RUNTIME_PM
+	unsigned long runtime_flags;
+#endif
+
 };
 
 #define platform_get_device_id(pdev)	((pdev)->id_entry)
@@ -65,6 +69,10 @@ static inline void platform_device_idle(
 static inline void platform_device_wakeup(struct platform_device *pdev) {}
 #endif
 
+#ifdef CONFIG_HAVE_PLATFORM_DEVICE_RUNTIME_PM
+extern struct dev_pm_ops platform_runtime_dev_pm_ops;
+#endif
+
 struct platform_driver {
 	int (*probe)(struct platform_device *);
 	int (*remove)(struct platform_device *);
