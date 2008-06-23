From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 11/11] PCI: Simplify PCI device PM code
Date: Mon, 23 Jun 2008 19:49:38 +0200
Message-ID: <200806231949.39015.rjw__40103.485066402$1214245330$gmane$org@sisk.pl>
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

PCI: Simplify PCI device PM code

If the offset of PCI device's PM capability in its configuration space and the
mask of states that the device supports PME# from are cached in the
corresponding struct pci_dev, the PCI device PM code can be simplified quite
a bit.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c        |   88 ++++++++++++++++++-----------------------------
 include/linux/pci.h      |    4 ++
 include/linux/pci_regs.h |    1 
 3 files changed, 39 insertions(+), 54 deletions(-)

Index: linux-next/include/linux/pci.h
===================================================================
--- linux-next.orig/include/linux/pci.h
+++ linux-next/include/linux/pci.h
@@ -177,6 +177,10 @@ struct pci_dev {
 	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
+	int		pm_cap;		/* PM capability offset in the
+					   configuration space */
+	unsigned int	pme_data:5;	/* Bitmask of states from which PME#
+					   can be generated */
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state. */
Index: linux-next/drivers/pci/pci.c
===================================================================
--- linux-next.orig/drivers/pci/pci.c
+++ linux-next/drivers/pci/pci.c
@@ -419,7 +419,6 @@ static inline int platform_pci_sleep_wak
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *                           given PCI device
  * @dev: PCI device to handle.
- * @pm: PCI PM capability offset of the device.
  * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
  *
  * RETURN VALUE:
@@ -430,12 +429,12 @@ static inline int platform_pci_sleep_wak
  * 0 if device's power state has been successfully changed.
  */
 static int
-pci_raw_set_power_state(struct pci_dev *dev, int pm, pci_power_t state)
+pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	u16 pmcsr, pmc;
 	bool need_restore = false;
 
-	if (!pm)
+	if (!dev->pm_cap)
 		return -EIO;
 
 	if (state < PCI_D0 || state > PCI_D3hot)
@@ -455,7 +454,7 @@ pci_raw_set_power_state(struct pci_dev *
 		return -EINVAL;
 	}
 
-	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_PMC, &pmc);
 
 	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
 		printk(KERN_ERR
@@ -469,7 +468,7 @@ pci_raw_set_power_state(struct pci_dev *
 	   || (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2)))
 		return -EIO;
 
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 
 	/* If we're (effectively) in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
@@ -493,7 +492,7 @@ pci_raw_set_power_state(struct pci_dev *
 	}
 
 	/* enter specified state */
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
+	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
 
 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */
@@ -529,14 +528,13 @@ pci_raw_set_power_state(struct pci_dev *
  * pci_update_current_state - Read PCI power state of given device from its
  *                            PCI PM registers and cache it
  * @dev: PCI device to handle.
- * @pm: PCI PM capability offset of the device.
  */
-static void pci_update_current_state(struct pci_dev *dev, int pm)
+static void pci_update_current_state(struct pci_dev *dev)
 {
-	if (pm) {
+	if (dev->pm_cap) {
 		u16 pmcsr;
 
-		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
 	}
 }
@@ -558,7 +556,7 @@ static void pci_update_current_state(str
  */
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int pm, error;
+	int error;
 
 	/* bound the state we're entering */
 	if (state > PCI_D3hot)
@@ -573,9 +571,6 @@ int pci_set_power_state(struct pci_dev *
 		 */
 		return 0;
 
-	/* Find PCI PM capability in the list */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-
 	if (state == PCI_D0 && platform_pci_power_manageable(dev)) {
 		/*
 		 * Allow the platform to change the state, for example via ACPI
@@ -583,16 +578,16 @@ int pci_set_power_state(struct pci_dev *
 		 */
 		int ret = platform_pci_set_power_state(dev, PCI_D0);
 		if (!ret)
-			pci_update_current_state(dev, pm);
+			pci_update_current_state(dev);
 	}
 
-	error = pci_raw_set_power_state(dev, pm, state);
+	error = pci_raw_set_power_state(dev, state);
 
 	if (state > PCI_D0 && platform_pci_power_manageable(dev)) {
 		/* Allow the platform to finalize the transition */
 		int ret = platform_pci_set_power_state(dev, state);
 		if (!ret) {
-			pci_update_current_state(dev, pm);
+			pci_update_current_state(dev);
 			error = 0;
 		}
 	}
@@ -1051,48 +1046,40 @@ int pci_set_pcie_reset_state(struct pci_
 /**
  * pci_pme_capable - check the capability of PCI device to generate PME#
  * @dev: PCI device to handle.
- * @pm: PCI PM capability offset of the device.
  * @state: PCI state from which device will issue PME#.
  */
-static bool pci_pme_capable(struct pci_dev *dev, int pm, pci_power_t state)
+static bool pci_pme_capable(struct pci_dev *dev, pci_power_t state)
 {
 	u16 pmc;
 
-	if (!pm)
+	if (!dev->pm_cap)
 		return false;
 
-	/* Check device's ability to generate PME# from given state */
-	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
-
-	pmc &= PCI_PM_CAP_PME_MASK;
-	pmc >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
-
-	return !!(pmc & (1 << state));
+	return !!(dev->pme_data & (1 << state));
 }
 
 /**
  * pci_pme_active - enable or disable PCI device's PME# function
  * @dev: PCI device to handle.
- * @pm: PCI PM capability offset of the device.
  * @enable: 'true' to enable PME# generation; 'false' to disable it.
  *
  * The caller must verify that the device is capable of generating PME# before
  * calling this function with @enable equal to 'true'.
  */
-static void pci_pme_active(struct pci_dev *dev, int pm, bool enable)
+static void pci_pme_active(struct pci_dev *dev, bool enable)
 {
 	u16 pmcsr;
 
-	if (!pm)
+	if (!dev->pm_cap)
 		return;
 
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	/* Clear PME_Status by writing 1 to it and enable PME# */
 	pmcsr |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
 	if (!enable)
 		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
 
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
+	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
 }
 
 /**
@@ -1118,7 +1105,6 @@ static void pci_pme_active(struct pci_de
  */
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
 {
-	int pm;
 	int error = 0;
 
 	if (!device_may_wakeup(&dev->dev))
@@ -1131,9 +1117,8 @@ int pci_enable_wake(struct pci_dev *dev,
 	 * We are going to enable/disable the generation of PME# even if the
 	 * platform claims to have handled the device as requested.
 	 */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-	if (!enable || pci_pme_capable(dev, pm, state)) {
-		pci_pme_active(dev, pm, enable);
+	if (!enable || pci_pme_capable(dev, state)) {
+		pci_pme_active(dev, enable);
 		if (enable)
 			return 0;
 	}
@@ -1156,7 +1141,6 @@ int pci_enable_wake(struct pci_dev *dev,
 int pci_prepare_to_sleep(struct pci_dev *dev)
 {
 	pci_power_t target_state = PCI_D3hot;
-	int pm = pci_find_capability(dev, PCI_CAP_ID_PM);
 	int error;
 
 	if (platform_pci_power_manageable(dev)) {
@@ -1184,23 +1168,14 @@ int pci_prepare_to_sleep(struct pci_dev 
 		 * wake-up events, make it the target state and enable device
 		 * to generate PME#.
 		 */
-		u16 pmc;
-
-		if (!pm)
+		if (!dev->pm_cap)
 			return -EIO;
 
-		pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
-		if (pmc & PCI_PM_CAP_PME_MASK) {
-			if (!(pmc & PCI_PM_CAP_PME_D3)) {
-				/* Device cannot generate PME# from D3_hot */
-				if (pmc & PCI_PM_CAP_PME_D2)
-					target_state = PCI_D2;
-				else if (pmc & PCI_PM_CAP_PME_D1)
-					target_state = PCI_D1;
-				else
-					target_state = PCI_D0;
-			}
-			pci_pme_active(dev, pm, true);
+		if (dev->pme_data) {
+			while (target_state
+			      && !(dev->pme_data & (1 << target_state)))
+				target_state--;
+			pci_pme_active(dev, true);
 		}
 	}
 
@@ -1236,11 +1211,13 @@ void pci_pm_init(struct pci_dev *dev)
 
 	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	dev->pm_cap = pm;
 	if (!pm)
 		return;
 	/* Check device's ability to generate PME# */
 	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
-	if (pmc & PCI_PM_CAP_PME_MASK) {
+	pmc &= PCI_PM_CAP_PME_MASK;
+	if (pmc) {
 		printk(KERN_INFO "PCI: Device %s supports PME# from"
 			"%s%s%s%s%s\n", pci_name(dev),
 			(pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
@@ -1248,10 +1225,13 @@ void pci_pm_init(struct pci_dev *dev)
 			(pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
 			(pmc & PCI_PM_CAP_PME_D3) ? " D3hot" : "",
 			(pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" : "");
+		dev->pme_data = pmc >> PCI_PM_CAP_PME_SHIFT;
 		/* Mak device's PM flags reflect the wake-up capability */
 		device_init_wakeup(&dev->dev, true);
 		/* Disable the PME# generation functionality */
-		pci_pme_active(dev, pm, false);
+		pci_pme_active(dev, false);
+	} else {
+		dev->pme_data = 0;
 	}
 }
 
Index: linux-next/include/linux/pci_regs.h
===================================================================
--- linux-next.orig/include/linux/pci_regs.h
+++ linux-next/include/linux/pci_regs.h
@@ -231,6 +231,7 @@
 #define  PCI_PM_CAP_PME_D2	0x2000	/* PME# from D2 */
 #define  PCI_PM_CAP_PME_D3	0x4000	/* PME# from D3 (hot) */
 #define  PCI_PM_CAP_PME_D3cold	0x8000	/* PME# from D3 (cold) */
+#define  PCI_PM_CAP_PME_SHIFT	11	/* Start of the PME Mask in PMC */
 #define PCI_PM_CTRL		4	/* PM control and status register */
 #define  PCI_PM_CTRL_STATE_MASK	0x0003	/* Current power state (D0 to D3) */
 #define  PCI_PM_CTRL_NO_SOFT_RESET	0x0004	/* No reset for D3hot->D0 */
