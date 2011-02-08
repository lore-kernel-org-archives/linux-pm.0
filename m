From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/5] PM: Replace CONFIG_PM_OPS with CONFIG_PM
Date: Tue, 8 Feb 2011 22:22:52 +0100
Message-ID: <201102082222.52483.rjw__32689.47375841$1297201717$gmane$org@sisk.pl>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110208122159.GA8284@elte.hu> <201102082218.28015.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102082218.28015.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-embedded@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

After redefining CONFIG_PM to depend on (CONFIG_PM_SLEEP ||
CONFIG_PM_RUNTIME) the CONFIG_PM_OPS option is redundant and can be
replaced with CONFIG_PM.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c               |    4 ++--
 drivers/base/power/Makefile        |    3 +--
 drivers/net/e1000e/netdev.c        |    8 ++++----
 drivers/net/pch_gbe/pch_gbe_main.c |    2 +-
 drivers/pci/pci-driver.c           |    4 ++--
 drivers/scsi/Makefile              |    2 +-
 drivers/scsi/scsi_priv.h           |    2 +-
 drivers/scsi/scsi_sysfs.c          |    2 +-
 drivers/usb/core/hcd-pci.c         |    4 ++--
 include/acpi/acpi_bus.h            |    2 +-
 include/linux/pm.h                 |    2 +-
 kernel/power/Kconfig               |    5 -----
 12 files changed, 17 insertions(+), 23 deletions(-)

Index: linux-2.6/drivers/net/e1000e/netdev.c
===================================================================
--- linux-2.6.orig/drivers/net/e1000e/netdev.c
+++ linux-2.6/drivers/net/e1000e/netdev.c
@@ -5307,7 +5307,7 @@ void e1000e_disable_aspm(struct pci_dev
 	__e1000e_disable_aspm(pdev, state);
 }
 
-#ifdef CONFIG_PM_OPS
+#ifdef CONFIG_PM
 static bool e1000e_pm_ready(struct e1000_adapter *adapter)
 {
 	return !!adapter->tx_ring->buffer_info;
@@ -5458,7 +5458,7 @@ static int e1000_runtime_resume(struct d
 	return __e1000_resume(pdev);
 }
 #endif /* CONFIG_PM_RUNTIME */
-#endif /* CONFIG_PM_OPS */
+#endif /* CONFIG_PM */
 
 static void e1000_shutdown(struct pci_dev *pdev)
 {
@@ -6164,7 +6164,7 @@ static DEFINE_PCI_DEVICE_TABLE(e1000_pci
 };
 MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
 
-#ifdef CONFIG_PM_OPS
+#ifdef CONFIG_PM
 static const struct dev_pm_ops e1000_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(e1000_suspend, e1000_resume)
 	SET_RUNTIME_PM_OPS(e1000_runtime_suspend,
@@ -6178,7 +6178,7 @@ static struct pci_driver e1000_driver =
 	.id_table = e1000_pci_tbl,
 	.probe    = e1000_probe,
 	.remove   = __devexit_p(e1000_remove),
-#ifdef CONFIG_PM_OPS
+#ifdef CONFIG_PM
 	.driver.pm = &e1000_pm_ops,
 #endif
 	.shutdown = e1000_shutdown,
Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -567,7 +567,7 @@ int acpi_suspend(u32 acpi_state)
 	return -EINVAL;
 }
 
-#ifdef CONFIG_PM_OPS
+#ifdef CONFIG_PM
 /**
  *	acpi_pm_device_sleep_state - return preferred power state of ACPI device
  *		in the system sleep state given by %acpi_target_sleep_state
@@ -653,7 +653,7 @@ int acpi_pm_device_sleep_state(struct de
 		*d_min_p = d_min;
 	return d_max;
 }
-#endif /* CONFIG_PM_OPS */
+#endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
 /**
Index: linux-2.6/drivers/base/power/Makefile
===================================================================
--- linux-2.6.orig/drivers/base/power/Makefile
+++ linux-2.6/drivers/base/power/Makefile
@@ -1,7 +1,6 @@
-obj-$(CONFIG_PM)	+= sysfs.o
+obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
-obj-$(CONFIG_PM_OPS)	+= generic_ops.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_OPP)	+= opp.o
 
Index: linux-2.6/drivers/scsi/scsi_priv.h
===================================================================
--- linux-2.6.orig/drivers/scsi/scsi_priv.h
+++ linux-2.6/drivers/scsi/scsi_priv.h
@@ -146,7 +146,7 @@ static inline void scsi_netlink_exit(voi
 #endif
 
 /* scsi_pm.c */
-#ifdef CONFIG_PM_OPS
+#ifdef CONFIG_PM
 extern const struct dev_pm_ops scsi_bus_pm_ops;
 #endif
 #ifdef CONFIG_PM_RUNTIME
Index: linux-2.6/drivers/scsi/Makefile
===================================================================
--- linux-2.6.orig/drivers/scsi/Makefile
+++ linux-2.6/drivers/scsi/Makefile
@@ -165,7 +165,7 @@ scsi_mod-$(CONFIG_SCSI_NETLINK)	+= scsi_
 scsi_mod-$(CONFIG_SYSCTL)	+= scsi_sysctl.o
 scsi_mod-$(CONFIG_SCSI_PROC_FS)	+= scsi_proc.o
 scsi_mod-y			+= scsi_trace.o
-scsi_mod-$(CONFIG_PM_OPS)	+= scsi_pm.o
+scsi_mod-$(CONFIG_PM)		+= scsi_pm.o
 
 scsi_tgt-y			+= scsi_tgt_lib.o scsi_tgt_if.o
 
Index: linux-2.6/drivers/scsi/scsi_sysfs.c
===================================================================
--- linux-2.6.orig/drivers/scsi/scsi_sysfs.c
+++ linux-2.6/drivers/scsi/scsi_sysfs.c
@@ -383,7 +383,7 @@ struct bus_type scsi_bus_type = {
         .name		= "scsi",
         .match		= scsi_bus_match,
 	.uevent		= scsi_bus_uevent,
-#ifdef CONFIG_PM_OPS
+#ifdef CONFIG_PM
 	.pm		= &scsi_bus_pm_ops,
 #endif
 };
Index: linux-2.6/drivers/usb/core/hcd-pci.c
===================================================================
--- linux-2.6.orig/drivers/usb/core/hcd-pci.c
+++ linux-2.6/drivers/usb/core/hcd-pci.c
@@ -335,7 +335,7 @@ void usb_hcd_pci_shutdown(struct pci_dev
 }
 EXPORT_SYMBOL_GPL(usb_hcd_pci_shutdown);
 
-#ifdef	CONFIG_PM_OPS
+#ifdef	CONFIG_PM
 
 #ifdef	CONFIG_PPC_PMAC
 static void powermac_set_asic(struct pci_dev *pci_dev, int enable)
@@ -580,4 +580,4 @@ const struct dev_pm_ops usb_hcd_pci_pm_o
 };
 EXPORT_SYMBOL_GPL(usb_hcd_pci_pm_ops);
 
-#endif	/* CONFIG_PM_OPS */
+#endif	/* CONFIG_PM */
Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -431,7 +431,7 @@ static void pci_device_shutdown(struct d
 	pci_msix_shutdown(pci_dev);
 }
 
-#ifdef CONFIG_PM_OPS
+#ifdef CONFIG_PM
 
 /* Auxiliary functions used for system resume and run-time resume. */
 
@@ -1059,7 +1059,7 @@ static int pci_pm_runtime_idle(struct de
 
 #endif /* !CONFIG_PM_RUNTIME */
 
-#ifdef CONFIG_PM_OPS
+#ifdef CONFIG_PM
 
 const struct dev_pm_ops pci_dev_pm_ops = {
 	.prepare = pci_pm_prepare,
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -380,7 +380,7 @@ struct acpi_pci_root *acpi_pci_find_root
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int state);
 int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 
-#ifdef CONFIG_PM_OPS
+#ifdef CONFIG_PM
 int acpi_pm_device_sleep_state(struct device *, int *);
 #else
 static inline int acpi_pm_device_sleep_state(struct device *d, int *p)
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -267,7 +267,7 @@ const struct dev_pm_ops name = { \
  * callbacks provided by device drivers supporting both the system sleep PM and
  * runtime PM, make the pm member point to generic_subsys_pm_ops.
  */
-#ifdef CONFIG_PM_OPS
+#ifdef CONFIG_PM
 extern struct dev_pm_ops generic_subsys_pm_ops;
 #define GENERIC_SUBSYS_PM_OPS	(&generic_subsys_pm_ops)
 #else
Index: linux-2.6/drivers/net/pch_gbe/pch_gbe_main.c
===================================================================
--- linux-2.6.orig/drivers/net/pch_gbe/pch_gbe_main.c
+++ linux-2.6/drivers/net/pch_gbe/pch_gbe_main.c
@@ -2430,7 +2430,7 @@ static struct pci_driver pch_gbe_pcidev
 	.id_table = pch_gbe_pcidev_id,
 	.probe = pch_gbe_probe,
 	.remove = pch_gbe_remove,
-#ifdef CONFIG_PM_OPS
+#ifdef CONFIG_PM
 	.driver.pm = &pch_gbe_pm_ops,
 #endif
 	.shutdown = pch_gbe_shutdown,
Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -220,11 +220,6 @@ config APM_EMULATION
 	  anything, try disabling/enabling this option (or disabling/enabling
 	  APM in your BIOS).
 
-config PM_OPS
-	bool
-	depends on PM_SLEEP || PM_RUNTIME
-	default y
-
 config ARCH_HAS_OPP
 	bool
 
