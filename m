From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 3/3 update] PCI PM: Run-time callbacks for
	PCI bus type
Date: Tue, 8 Sep 2009 01:22:28 +0200
Message-ID: <200909080122.29040.rjw__4470.73331238261$1252365893$gmane$org@sisk.pl>
References: <200909070102.21056.rjw@sisk.pl> <200909070105.25835.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909070105.25835.rjw@sisk.pl>
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
Cc: linux-pci <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PCI PM: Run-time callbacks for PCI bus type

Introduce run-time PM callbacks for the PCI bus type.  Make the new
callbacks work in analogy with the existing system sleep PM
callbacks, so that the drivers already converted to struct dev_pm_ops
can use their suspend and resume routines for run-time PM without
modifications.

Not-yet-signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
Fixed compilation.

One thing is still missing from here.  Namely, when the device is being
suspended, it generally is necessary to set up the device's GPE to wake it up
and the bus type callback should take care of that (analogously, the resume
callback should switch the GPE back to the "inactive" state).

Thanks,
Rafael

---
 drivers/pci/pci-driver.c |   96 ++++++++++++++++++++++++++++++++++++++++++++---
 kernel/power/Kconfig     |    5 ++
 2 files changed, 96 insertions(+), 5 deletions(-)

Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -236,3 +236,8 @@ config PM_RUNTIME
 	  and the bus type drivers of the buses the devices are on are
 	  responsible for the actual handling of the autosuspend requests and
 	  wake-up events.
+
+config PM_OPERATIONS
+	bool
+	depends on PM_SLEEP || PM_RUNTIME
+	default y
Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/cpu.h>
+#include <linux/pm_runtime.h>
 #include "pci.h"
 
 /*
@@ -509,7 +510,7 @@ static int pci_restore_standard_config(s
 	return pci_restore_state(pci_dev);
 }
 
-static void pci_pm_default_resume_noirq(struct pci_dev *pci_dev)
+static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 {
 	pci_restore_standard_config(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
@@ -653,7 +654,7 @@ static int pci_pm_resume_noirq(struct de
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	pci_pm_default_resume_noirq(pci_dev);
+	pci_pm_default_resume_early(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
@@ -851,7 +852,7 @@ static int pci_pm_restore_noirq(struct d
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	pci_pm_default_resume_noirq(pci_dev);
+	pci_pm_default_resume_early(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
@@ -903,6 +904,88 @@ static int pci_pm_restore(struct device 
 
 #endif /* !CONFIG_HIBERNATION */
 
+#endif /* !CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM_RUNTIME
+
+static int pci_pm_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	pci_power_t prev = pci_dev->current_state;
+	int error;
+
+	if (!pm || !pm->runtime_suspend)
+		return -ENOSYS;
+
+	error = pm->runtime_suspend(dev);
+	suspend_report_result(pm->runtime_suspend, error);
+	if (error)
+		return error;
+
+	pci_fixup_device(pci_fixup_suspend, pci_dev);
+
+	if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
+	    && pci_dev->current_state != PCI_UNKNOWN) {
+		WARN_ONCE(pci_dev->current_state != prev,
+			"PCI PM: State of device not saved by %pF\n",
+			pm->runtime_suspend);
+		return 0;
+	}
+
+	if (!pci_dev->state_saved) {
+		pci_save_state(pci_dev);
+		if (!pci_is_bridge(pci_dev))
+			pci_prepare_to_sleep(pci_dev);
+	}
+
+	pci_pm_set_unknown_state(pci_dev);
+
+	return 0;
+}
+
+static int pci_pm_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+
+	if (!pm || !pm->runtime_resume)
+		return -ENOSYS;
+
+	pci_pm_default_resume_early(pci_dev);
+	pci_pm_default_resume(pci_dev);
+
+	return pm->runtime_resume(dev);
+}
+
+static int pci_pm_runtime_idle(struct device *dev)
+{
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+
+	if (!pm)
+		return -ENOSYS;
+
+	if (pm->runtime_idle) {
+		int ret = pm->runtime_idle(dev);
+		if (ret)
+			return ret;
+	}
+
+	pm_runtime_suspend(dev);
+
+	return 0;
+}
+
+#else /* !CONFIG_PM_RUNTIME */
+
+#define pci_pm_runtime_suspend	NULL
+#define pci_pm_runtime_resume	NULL
+#define pci_pm_runtime_idle	NULL
+
+#endif /* !CONFIG_PM_RUNTIME */
+
+#ifdef CONFIG_PM_OPERATIONS
+
 const struct dev_pm_ops pci_dev_pm_ops = {
 	.prepare = pci_pm_prepare,
 	.complete = pci_pm_complete,
@@ -918,15 +1001,18 @@ const struct dev_pm_ops pci_dev_pm_ops =
 	.thaw_noirq = pci_pm_thaw_noirq,
 	.poweroff_noirq = pci_pm_poweroff_noirq,
 	.restore_noirq = pci_pm_restore_noirq,
+	.runtime_suspend = pci_pm_runtime_suspend,
+	.runtime_resume = pci_pm_runtime_resume,
+	.runtime_idle = pci_pm_runtime_idle,
 };
 
 #define PCI_PM_OPS_PTR	(&pci_dev_pm_ops)
 
-#else /* !CONFIG_PM_SLEEP */
+#else /* !COMFIG_PM_OPERATIONS */
 
 #define PCI_PM_OPS_PTR	NULL
 
-#endif /* !CONFIG_PM_SLEEP */
+#endif /* !COMFIG_PM_OPERATIONS */
 
 /**
  * __pci_register_driver - register a new pci driver
