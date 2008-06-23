From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 08/11] PCI PM: Rework device PM initialization
	(rev. 3)
Date: Mon, 23 Jun 2008 19:46:06 +0200
Message-ID: <200806231946.06813.rjw__19082.9096864492$1214244186$gmane$org@sisk.pl>
References: <200806231934.08565.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806231934.08565.rjw@sisk.pl>
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
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

PCI PM: Rework device PM initialization (rev. 3)

Rework PCI device PM initialization so that if given device is capable
of generating wake-up events, either natively through the PME#
mechanism, or with the help of the platform, its power.can_wakeup
and power.should_wakeup flags are set as appropriate.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c   |  150 ++++++++++++++++++++++++++++++++--------------------
 drivers/pci/pci.h   |    1 
 drivers/pci/probe.c |   47 +---------------
 3 files changed, 98 insertions(+), 100 deletions(-)

Index: linux-next/drivers/pci/pci.c
===================================================================
--- linux-next.orig/drivers/pci/pci.c
+++ linux-next/drivers/pci/pci.c
@@ -1049,6 +1049,53 @@ int pci_set_pcie_reset_state(struct pci_
 }
 
 /**
+ * pci_pme_capable - check the capability of PCI device to generate PME#
+ * @dev: PCI device to handle.
+ * @pm: PCI PM capability offset of the device.
+ * @state: PCI state from which device will issue PME#.
+ */
+static bool pci_pme_capable(struct pci_dev *dev, int pm, pci_power_t state)
+{
+	u16 pmc;
+
+	if (!pm)
+		return false;
+
+	/* Check device's ability to generate PME# from given state */
+	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
+
+	pmc &= PCI_PM_CAP_PME_MASK;
+	pmc >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
+
+	return !!(pmc & (1 << state));
+}
+
+/**
+ * pci_pme_active - enable or disable PCI device's PME# function
+ * @dev: PCI device to handle.
+ * @pm: PCI PM capability offset of the device.
+ * @enable: 'true' to enable PME# generation; 'false' to disable it.
+ *
+ * The caller must verify that the device is capable of generating PME# before
+ * calling this function with @enable equal to 'true'.
+ */
+static void pci_pme_active(struct pci_dev *dev, int pm, bool enable)
+{
+	u16 pmcsr;
+
+	if (!pm)
+		return;
+
+	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+	/* Clear PME_Status by writing 1 to it and enable PME# */
+	pmcsr |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
+	if (!enable)
+		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
+
+	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
+}
+
+/**
  * pci_enable_wake - enable PCI device as wakeup event source
  * @dev: PCI device affected
  * @state: PCI state from which device will issue wakeup events
@@ -1063,77 +1110,68 @@ int pci_set_pcie_reset_state(struct pci_
  * supporting the standard PCI PME# signal may require such platform hooks;
  * they always update bits in config space to allow PME# generation.
  *
- * -EIO is returned if the device can't be a wakeup event source.
- * -EINVAL is returned if the device can't generate wakeup events from
- * the specified PCI state.  Returns zero if the operation is successful.
+ * RETURN VALUE:
+ * 0 is returned on success
+ * -EINVAL is returned if device is not supposed to wake up the system
+ * Error code depending on the platform is returned if both the platform and the
+ * native mechanism fail to enable the generation of wake-up events
  */
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
 {
 	int pm;
-	u16 value = 0;
-	bool platform_done = false;
+	int error = 0;
 
-	if (enable && platform_pci_can_wakeup(dev)) {
-		/* Allow the platform to handle the device */
-		int err = platform_pci_sleep_wake(dev, true);
-		if (!err)
-			/*
-			 * The platform claims to have enabled the device's
-			 * system wake-up capability as requested, but we are
-			 * going to enable PME# anyway.
-			 */
-			platform_done = true;
-	}
+	if (!device_may_wakeup(&dev->dev))
+		return -EINVAL;
 
-	/* find PCI PM capability in list */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (enable && platform_pci_can_wakeup(dev))
+		error = platform_pci_sleep_wake(dev, true);
 
-	/* If device doesn't support PM Capabilities, but caller wants to
-	 * disable wake events, it's a NOP.  Otherwise fail unless the
-	 * platform hooks handled this legacy device already.
+	/*
+	 * We are going to enable/disable the generation of PME# even if the
+	 * platform claims to have handled the device as requested.
 	 */
-	if (!pm) {
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!enable || pci_pme_capable(dev, pm, state)) {
+		pci_pme_active(dev, pm, enable);
 		if (enable)
-			return platform_done ? 0 : -EIO;
-		else
-			goto Platform_disable;
-	}
-
-	/* Check device's ability to generate PME# */
-	pci_read_config_word(dev, pm + PCI_PM_PMC, &value);
-
-	value &= PCI_PM_CAP_PME_MASK;
-	value >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
-
-	/* Check if it can generate PME# from requested state. */
-	if (!value || !(value & (1 << state))) {
-		if (enable) {
-			return platform_done ? 0 : -EINVAL;
-		} else {
-			value = 0;
-			goto Platform_disable;
-		}
+			return 0;
 	}
 
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &value);
-
-	/* Clear PME_Status by writing 1 to it and enable PME# */
-	value |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
+	if (!enable && platform_pci_can_wakeup(dev))
+		error = platform_pci_sleep_wake(dev, false);
 
-	if (!enable)
-		value &= ~PCI_PM_CTRL_PME_ENABLE;
+	return error;
+}
 
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
+/**
+ * pci_pm_init - Initialize PM functions of given PCI device
+ * @dev: PCI device to handle.
+ */
+void pci_pm_init(struct pci_dev *dev)
+{
+	int pm;
+	u16 pmc;
 
- Platform_disable:
-	if (!enable && platform_pci_can_wakeup(dev)) {
-		/* Allow the platform to finalize the operation */
-		int err = platform_pci_sleep_wake(dev, false);
-		if (err && !value)
-			return -EIO;
+	/* find PCI PM capability in list */
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!pm)
+		return;
+	/* Check device's ability to generate PME# */
+	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
+	if (pmc & PCI_PM_CAP_PME_MASK) {
+		printk(KERN_INFO "PCI: Device %s supports PME# from"
+			"%s%s%s%s%s\n", pci_name(dev),
+			(pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
+			(pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
+			(pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
+			(pmc & PCI_PM_CAP_PME_D3) ? " D3hot" : "",
+			(pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" : "");
+		/* Mak device's PM flags reflect the wake-up capability */
+		device_init_wakeup(&dev->dev, true);
+		/* Disable the PME# generation functionality */
+		pci_pme_active(dev, pm, false);
 	}
-
-	return 0;
 }
 
 int
Index: linux-next/drivers/pci/pci.h
===================================================================
--- linux-next.orig/drivers/pci/pci.h
+++ linux-next/drivers/pci/pci.h
@@ -34,6 +34,7 @@ struct pci_platform_pm_ops {
 };
 
 extern int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
+extern void pci_pm_init(struct pci_dev *dev);
 
 extern int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
 extern int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
Index: linux-next/drivers/pci/probe.c
===================================================================
--- linux-next.orig/drivers/pci/probe.c
+++ linux-next/drivers/pci/probe.c
@@ -858,49 +858,6 @@ int pci_cfg_space_size_ext(struct pci_de
 	return PCI_CFG_SPACE_SIZE;
 }
 
-/**
- * pci_disable_pme - Disable the PME function of PCI device
- * @dev: PCI device affected
- * -EINVAL is returned if PCI device doesn't support PME.
- * Zero is returned if the PME is supported and can be disabled.
- */
-static int pci_disable_pme(struct pci_dev *dev)
-{
-	int pm;
-	u16 value;
-
-	/* find PCI PM capability in list */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-
-	/* If device doesn't support PM Capabilities, it means that PME is
-	 * not supported.
-	 */
-	if (!pm)
-		return -EINVAL;
-	/* Check device's ability to generate PME# */
-	pci_read_config_word(dev, pm + PCI_PM_PMC, &value);
-
-	value &= PCI_PM_CAP_PME_MASK;
-	/* Check if it can generate PME# */
-	if (!value) {
-		/*
-		 * If it is zero, it means that PME is still unsupported
-		 * although there exists the PM capability.
-		 */
-		return -EINVAL;
-	}
-
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &value);
-
-	/* Clear PME_Status by writing 1 to it */
-	value |= PCI_PM_CTRL_PME_STATUS ;
-	/* Disable PME enable bit */
-	value &= ~PCI_PM_CTRL_PME_ENABLE;
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
-
-	return 0;
-}
-
 int pci_cfg_space_size(struct pci_dev *dev)
 {
 	int pos;
@@ -1008,7 +965,6 @@ static struct pci_dev *pci_scan_device(s
 	}
 
 	pci_vpd_pci22_init(dev);
-	pci_disable_pme(dev);
 
 	return dev;
 }
@@ -1029,6 +985,9 @@ void pci_device_add(struct pci_dev *dev,
 	/* Fix up broken headers */
 	pci_fixup_device(pci_fixup_header, dev);
 
+	/* Initialize power management of the device */
+	pci_pm_init(dev);
+
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.
