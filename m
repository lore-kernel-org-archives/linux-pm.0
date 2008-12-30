From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 2/10] PCI PM: Add suspend counterpart of
	pci_reenable_device
Date: Tue, 30 Dec 2008 23:37:09 +0100
Message-ID: <200812302337.10257.rjw__48241.7144616649$1230677579$gmane$org@sisk.pl>
References: <200812190049.34343.rjw@sisk.pl> <200812281607.28007.rjw@sisk.pl>
	<200812302333.45560.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812302333.45560.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Pavel Machek <pavel@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


PCI devices without drivers are not disabled during suspend and
hibernation, but they are enabled during resume, with the help of
pci_reenable_device(), so there is an unbalanced execution of
pcibios_enable_device() in the resume code path.

To correct this introduce function pci_disable_enabled_device()
that will disable the argument device, if it is enabled when the
function is being run, without updating the device's pci_dev
structure and use it in the suspend code path to balance the
pci_reenable_device() executed during resume.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |   35 ++++++++++++++++++++++++++++++-----
 drivers/pci/pci.c        |   36 ++++++++++++++++++++++++++++--------
 drivers/pci/pci.h        |    1 +
 3 files changed, 59 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -969,6 +969,32 @@ void pcim_pin_device(struct pci_dev *pde
  */
 void __attribute__ ((weak)) pcibios_disable_device (struct pci_dev *dev) {}
 
+static void do_pci_disable_device(struct pci_dev *dev)
+{
+	u16 pci_command;
+
+	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
+	if (pci_command & PCI_COMMAND_MASTER) {
+		pci_command &= ~PCI_COMMAND_MASTER;
+		pci_write_config_word(dev, PCI_COMMAND, pci_command);
+	}
+
+	pcibios_disable_device(dev);
+}
+
+/**
+ * pci_disable_enabled_device - Disable device without updating enable_cnt
+ * @dev: PCI device to disable
+ *
+ * NOTE: This function is a backend of PCI power management routines and is
+ * not supposed to be called drivers.
+ */
+void pci_disable_enabled_device(struct pci_dev *dev)
+{
+	if (atomic_read(&dev->enable_cnt))
+		do_pci_disable_device(dev);
+}
+
 /**
  * pci_disable_device - Disable PCI device after use
  * @dev: PCI device to be disabled
@@ -983,7 +1009,6 @@ void
 pci_disable_device(struct pci_dev *dev)
 {
 	struct pci_devres *dr;
-	u16 pci_command;
 
 	dr = find_pci_dr(dev);
 	if (dr)
@@ -992,14 +1017,9 @@ pci_disable_device(struct pci_dev *dev)
 	if (atomic_sub_return(1, &dev->enable_cnt) != 0)
 		return;
 
-	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_MASTER) {
-		pci_command &= ~PCI_COMMAND_MASTER;
-		pci_write_config_word(dev, PCI_COMMAND, pci_command);
-	}
-	dev->is_busmaster = 0;
+	do_pci_disable_device(dev);
 
-	pcibios_disable_device(dev);
+	dev->is_busmaster = 0;
 }
 
 /**
Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -40,6 +40,7 @@ struct pci_platform_pm_ops {
 };
 
 extern int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
+extern void pci_disable_enabled_device(struct pci_dev *dev);
 extern void pci_pm_init(struct pci_dev *dev);
 extern void pci_allocate_cap_save_buffers(struct pci_dev *dev);
 
Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -310,9 +310,19 @@ static bool pci_has_legacy_pm_support(st
 
 /*
  * Default "suspend" method for devices that have no driver provided suspend,
- * or not even a driver at all.
+ * or not even a driver at all (first part).
+ */
+static void pci_default_pm_suspend_early(struct pci_dev *pci_dev)
+{
+	/* If device is enabled at this point, disable it */
+	pci_disable_enabled_device(pci_dev);
+}
+
+/*
+ * Default "suspend" method for devices that have no driver provided suspend,
+ * or not even a driver at all (second part).
  */
-static void pci_default_pm_suspend(struct pci_dev *pci_dev)
+static void pci_default_pm_suspend_late(struct pci_dev *pci_dev)
 {
 	pci_save_state(pci_dev);
 	/*
@@ -363,7 +373,11 @@ static int pci_legacy_suspend(struct dev
 		i = drv->suspend(pci_dev, state);
 		suspend_report_result(drv->suspend, i);
 	} else {
-		pci_default_pm_suspend(pci_dev);
+		/*
+		 * For compatibility with existing code with legacy PM support
+		 * don't call pci_default_pm_suspend_early() here.
+		 */
+		pci_default_pm_suspend_late(pci_dev);
 	}
 	return i;
 }
@@ -441,7 +455,10 @@ static int pci_pm_suspend(struct device 
 		}
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend(dev, PMSG_SUSPEND);
+	} else {
+		pci_default_pm_suspend_early(pci_dev);
 	}
+
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
 	return error;
@@ -461,7 +478,7 @@ static int pci_pm_suspend_noirq(struct d
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend_late(dev, PMSG_SUSPEND);
 	} else {
-		pci_default_pm_suspend(pci_dev);
+		pci_default_pm_suspend_late(pci_dev);
 	}
 
 	return error;
@@ -532,6 +549,8 @@ static int pci_pm_freeze(struct device *
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend(dev, PMSG_FREEZE);
 		pci_fixup_device(pci_fixup_suspend, pci_dev);
+	} else {
+		pci_default_pm_suspend_early(pci_dev);
 	}
 
 	return error;
@@ -551,7 +570,7 @@ static int pci_pm_freeze_noirq(struct de
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend_late(dev, PMSG_FREEZE);
 	} else {
-		pci_default_pm_suspend(pci_dev);
+		pci_default_pm_suspend_late(pci_dev);
 	}
 
 	return error;
@@ -569,6 +588,8 @@ static int pci_pm_thaw(struct device *de
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		pci_fixup_device(pci_fixup_resume, pci_dev);
 		error = pci_legacy_resume(dev);
+	} else {
+		pci_default_pm_resume_late(pci_dev);
 	}
 
 	return error;
@@ -586,6 +607,8 @@ static int pci_pm_thaw_noirq(struct devi
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		pci_fixup_device(pci_fixup_resume_early, to_pci_dev(dev));
 		error = pci_legacy_resume_early(dev);
+	} else {
+		pci_default_pm_resume_early(pci_dev);
 	}
 
 	return error;
@@ -604,6 +627,8 @@ static int pci_pm_poweroff(struct device
 		}
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend(dev, PMSG_HIBERNATE);
+	} else {
+		pci_default_pm_suspend_early(pci_dev);
 	}
 
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
