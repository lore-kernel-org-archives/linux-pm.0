From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/8] PCI: Rework pci_set_power_state function
	(rev. 4)
Date: Fri, 27 Jun 2008 00:25:41 +0200
Message-ID: <200806270025.42520.rjw__9006.02781116522$1214520277$gmane$org@sisk.pl>
References: <200806270022.24496.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806270022.24496.rjw@sisk.pl>
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
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Zhao Yakui <yakui.zhao@intel.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

PCI: Rework pci_set_power_state function (rev. 4)

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
 drivers/pci/pci-acpi.c |   16 +++--
 drivers/pci/pci.c      |  152 +++++++++++++++++++++++++++++++++----------------
 2 files changed, 115 insertions(+), 53 deletions(-)

Index: linux-next/drivers/pci/pci.c
===================================================================
--- linux-next.orig/drivers/pci/pci.c
+++ linux-next/drivers/pci/pci.c
@@ -404,67 +404,56 @@ static inline pci_power_t platform_pci_c
 }
 
 /**
- * pci_set_power_state - Set the power state of a PCI device
- * @dev: PCI device to be suspended
- * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
- *
- * Transition a device to a new power state, using the Power Management 
- * Capabilities in the device's config space.
- *
- * RETURN VALUE: 
- * -EINVAL if trying to enter a lower state than we're already in.
- * 0 if we're already in the requested state.
- * -EIO if device does not support PCI PM.
- * 0 if we can successfully change the power state.
+ * pci_raw_set_power_state - Use PCI PM registers to set the power state of
+ *                           given PCI device
+ * @dev: PCI device to handle.
+ * @pm: PCI PM capability offset of the device.
+ * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
+ *
+ * RETURN VALUE:
+ * -EINVAL if the requested state is invalid.
+ * -EIO if device does not support PCI PM or its PM capabilities register has a
+ * wrong version, or device doesn't support the requested state.
+ * 0 if device already is in the requested state.
+ * 0 if device's power state has been successfully changed.
  */
-int
-pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+static int
+pci_raw_set_power_state(struct pci_dev *dev, int pm, pci_power_t state)
 {
-	int pm, need_restore = 0;
 	u16 pmcsr, pmc;
+	bool need_restore = false;
 
-	/* bound the state we're entering */
-	if (state > PCI_D3hot)
-		state = PCI_D3hot;
-
-	/*
-	 * If the device or the parent bridge can't support PCI PM, ignore
-	 * the request if we're doing anything besides putting it into D0
-	 * (which would only happen on boot).
-	 */
-	if ((state == PCI_D1 || state == PCI_D2) && pci_no_d1d2(dev))
-		return 0;
-
-	/* find PCI PM capability in list */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-
-	/* abort if the device doesn't support PM capabilities */
 	if (!pm)
 		return -EIO;
 
+	if (state < PCI_D0 || state > PCI_D3hot)
+		return -EINVAL;
+
 	/* Validate current state:
 	 * Can enter D0 from any state, but if we can only go deeper 
 	 * to sleep if we're already in a low power state
 	 */
-	if (state != PCI_D0 && dev->current_state > state) {
+	if (dev->current_state == state) {
+		/* we're already there */
+		return 0;
+	} else if (state != PCI_D0 && dev->current_state <= PCI_D3cold
+	    && dev->current_state > state) {
 		dev_err(&dev->dev, "invalid power transition "
 			"(from state %d to %d)\n", dev->current_state, state);
 		return -EINVAL;
-	} else if (dev->current_state == state)
-		return 0;        /* we're already there */
+	}
 
+	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
 
-	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
 	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
-		dev_printk(KERN_DEBUG, &dev->dev, "unsupported PM cap regs "
-			   "version (%u)\n", pmc & PCI_PM_CAP_VER_MASK);
+		dev_err(&dev->dev, "unsupported PM cap regs version (%u)\n",
+			pmc & PCI_PM_CAP_VER_MASK);
 		return -EIO;
 	}
 
 	/* check if this device supports the desired state */
-	if (state == PCI_D1 && !(pmc & PCI_PM_CAP_D1))
-		return -EIO;
-	else if (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2))
+	if ((state == PCI_D1 && !(pmc & PCI_PM_CAP_D1))
+	   || (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2)))
 		return -EIO;
 
 	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
@@ -483,7 +472,7 @@ pci_set_power_state(struct pci_dev *dev,
 	case PCI_UNKNOWN: /* Boot-up */
 		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
 		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
-			need_restore = 1;
+			need_restore = true;
 		/* Fall-through: force to D0 */
 	default:
 		pmcsr = 0;
@@ -500,12 +489,6 @@ pci_set_power_state(struct pci_dev *dev,
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
@@ -530,6 +513,81 @@ pci_set_power_state(struct pci_dev *dev,
 }
 
 /**
+ * pci_update_current_state - Read PCI power state of given device from its
+ *                            PCI PM registers and cache it
+ * @dev: PCI device to handle.
+ * @pm: PCI PM capability offset of the device.
+ */
+static void pci_update_current_state(struct pci_dev *dev, int pm)
+{
+	if (pm) {
+		u16 pmcsr;
+
+		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+	}
+}
+
+/**
+ * pci_set_power_state - Set the power state of a PCI device
+ * @dev: PCI device to handle.
+ * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
+ *
+ * Transition a device to a new power state, using the platform formware and/or
+ * the device's PCI PM registers.
+ *
+ * RETURN VALUE:
+ * -EINVAL if the requested state is invalid.
+ * -EIO if device does not support PCI PM or its PM capabilities register has a
+ * wrong version, or device doesn't support the requested state.
+ * 0 if device already is in the requested state.
+ * 0 if device's power state has been successfully changed.
+ */
+int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	int pm, error;
+
+	/* bound the state we're entering */
+	if (state > PCI_D3hot)
+		state = PCI_D3hot;
+	else if (state < PCI_D0)
+		state = PCI_D0;
+	else if ((state == PCI_D1 || state == PCI_D2) && pci_no_d1d2(dev))
+		/*
+		 * If the device or the parent bridge do not support PCI PM,
+		 * ignore the request if we're doing anything other than putting
+		 * it into D0 (which would only happen on boot).
+		 */
+		return 0;
+
+	/* Find PCI PM capability in the list */
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+
+	if (state == PCI_D0 && platform_pci_power_manageable(dev)) {
+		/*
+		 * Allow the platform to change the state, for example via ACPI
+		 * _PR0, _PS0 and some such, but do not trust it.
+		 */
+		int ret = platform_pci_set_power_state(dev, PCI_D0);
+		if (!ret)
+			pci_update_current_state(dev, pm);
+	}
+
+	error = pci_raw_set_power_state(dev, pm, state);
+
+	if (state > PCI_D0 && platform_pci_power_manageable(dev)) {
+		/* Allow the platform to finalize the transition */
+		int ret = platform_pci_set_power_state(dev, state);
+		if (!ret) {
+			pci_update_current_state(dev, pm);
+			error = 0;
+		}
+	}
+
+	return error;
+}
+
+/**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
  * @state: target sleep state for the whole system. This is the value
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
