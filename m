From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 3/9] PCI: Rework pci_set_power_state function
Date: Fri, 20 Jun 2008 01:48:23 +0200
Message-ID: <200806200148.24365.rjw__16005.4490007044$1213920613$gmane$org@sisk.pl>
References: <200806200145.33053.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806200145.33053.rjw@sisk.pl>
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

PCI: Rework pci_set_power_state function

Rework pci_set_power_state() so that the platform callback is
invoked before the native mechanism, if necessary.  Also, make
the function check if the device is power manageable by the
platform before invoking the platform callback.

This may matter if the device dependent on additional power
resources controlled by the platform is being put into D0, in which
case those power resources must be turned on before we attempt to
handle the device itself. 

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |   16 ++++++-----
 drivers/pci/pci.c      |   71 +++++++++++++++++++++++++++++++++----------------
 2 files changed, 58 insertions(+), 29 deletions(-)

Index: linux-next/drivers/pci/pci.c
===================================================================
--- linux-next.orig/drivers/pci/pci.c
+++ linux-next/drivers/pci/pci.c
@@ -414,14 +414,17 @@ static inline pci_power_t platform_pci_c
  * RETURN VALUE: 
  * -EINVAL if trying to enter a lower state than we're already in.
  * 0 if we're already in the requested state.
- * -EIO if device does not support PCI PM.
+ * -EIO if device does not support PCI PM or it doesn't support given state.
  * 0 if we can successfully change the power state.
+ * Platform-dependent error code if the platform has failed to change state and
+ * it is impossible to use the native mechanism for that.
  */
 int
 pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int pm, need_restore = 0;
+	int pm;
 	u16 pmcsr, pmc;
+	bool platform_pm, platform_done = false, need_restore = false;
 
 	/* bound the state we're entering */
 	if (state > PCI_D3hot)
@@ -438,37 +441,57 @@ pci_set_power_state(struct pci_dev *dev,
 	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
 
-	/* abort if the device doesn't support PM capabilities */
-	if (!pm)
-		return -EIO;
+	platform_pm = platform_pci_power_manageable(dev);
+
+	if (platform_pm && state == PCI_D0) {
+		/*
+		 * Allow the platform to change the state, for example via ACPI
+		 * _PR0, _PS0 and some such, but do not trust it.
+		 */
+		int err = platform_pci_set_power_state(dev, state);
+		if (err && !pm)
+			return err;
+		/*
+		 * The platform might have changed the state, make sure that the
+		 * cached value is still valid.
+		 */
+		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+
+		platform_done = true;
+	} else if (!pm) {
+		goto Platform_low;
+	}
 
 	/* Validate current state:
 	 * Can enter D0 from any state, but if we can only go deeper 
 	 * to sleep if we're already in a low power state
 	 */
-	if (state != PCI_D0 && dev->current_state > state) {
-		printk(KERN_ERR "%s(): %s: state=%d, current state=%d\n",
+	if (dev->current_state == state) {
+		/* we're already there */
+		return 0;
+	} else if (state != PCI_D0 && dev->current_state > state) {
+		printk(KERN_ERR "%s(): %s: state=D%d, current state=D%d\n",
 			__func__, pci_name(dev), state, dev->current_state);
 		return -EINVAL;
-	} else if (dev->current_state == state)
-		return 0;        /* we're already there */
+	}
 
+	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
 
-	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
 	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
-		printk(KERN_DEBUG
+		printk(KERN_ERR
 		       "PCI: %s has unsupported PM cap regs version (%u)\n",
 		       pci_name(dev), pmc & PCI_PM_CAP_VER_MASK);
-		return -EIO;
+		return platform_done ? 0 : -EIO;
 	}
 
 	/* check if this device supports the desired state */
-	if (state == PCI_D1 && !(pmc & PCI_PM_CAP_D1))
-		return -EIO;
-	else if (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2))
+	if ((state == PCI_D1 && !(pmc & PCI_PM_CAP_D1))
+	   || (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2)))
 		return -EIO;
 
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+	if (!platform_done)
+		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
 
 	/* If we're (effectively) in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
@@ -484,7 +507,7 @@ pci_set_power_state(struct pci_dev *dev,
 	case PCI_UNKNOWN: /* Boot-up */
 		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
 		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
-			need_restore = 1;
+			need_restore = true;
 		/* Fall-through: force to D0 */
 	default:
 		pmcsr = 0;
@@ -501,12 +524,6 @@ pci_set_power_state(struct pci_dev *dev,
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(200);
 
-	/*
-	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
-	 * Firmware method after native method ?
-	 */
-	platform_pci_set_power_state(dev, state);
-
 	dev->current_state = state;
 
 	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
@@ -527,6 +544,14 @@ pci_set_power_state(struct pci_dev *dev,
 	if (dev->bus->self)
 		pcie_aspm_pm_state_change(dev->bus->self);
 
+ Platform_low:
+	if (platform_pm && state > PCI_D0) {
+		/* Allow the platform to finalize the transition */
+		int err = platform_pci_set_power_state(dev, state);
+		if (err && dev->current_state != state)
+			return err;
+	}
+
 	return 0;
 }
 
Index: linux-next/drivers/pci/pci-acpi.c
===================================================================
--- linux-next.orig/drivers/pci/pci-acpi.c
+++ linux-next/drivers/pci/pci-acpi.c
@@ -277,12 +277,11 @@ static int acpi_pci_set_power_state(stru
 		[PCI_D3hot] = ACPI_STATE_D3,
 		[PCI_D3cold] = ACPI_STATE_D3
 	};
+	int error = -EINVAL;
 
-	if (!handle)
-		return -ENODEV;
 	/* If the ACPI device has _EJ0, ignore the device */
-	if (ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0", &tmp)))
-		return 0;
+	if (!handle || ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0", &tmp)))
+		return -ENODEV;
 
 	switch (state) {
 	case PCI_D0:
@@ -290,9 +289,14 @@ static int acpi_pci_set_power_state(stru
 	case PCI_D2:
 	case PCI_D3hot:
 	case PCI_D3cold:
-		return acpi_bus_set_power(handle, state_conv[state]);
+		error = acpi_bus_set_power(handle, state_conv[state]);
 	}
-	return -EINVAL;
+
+	if (!error)
+		printk(KERN_INFO "PCI: Power state of %s changed by ACPI\n",
+			pci_name(dev));
+
+	return error;
 }
 
 static struct pci_platform_pm_ops acpi_pci_platform_pm = {
