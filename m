From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 3/3] PCI PM: Rework pci_set_power_state
Date: Tue, 17 Jun 2008 02:17:23 +0200
Message-ID: <200806170217.23693.rjw__40815.133348997$1213662261$gmane$org@sisk.pl>
References: <200806170206.26616.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806170206.26616.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

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
 drivers/pci/pci-acpi.c |    2 +-
 drivers/pci/pci.c      |   44 +++++++++++++++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 14 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -398,7 +398,8 @@ int (*platform_pci_set_power_state)(stru
 int
 pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int pm, need_restore = 0;
+	int pm;
+	bool platform_pm, platform_done = false, need_restore = false;
 	u16 pmcsr, pmc;
 
 	/* bound the state we're entering */
@@ -413,12 +414,35 @@ pci_set_power_state(struct pci_dev *dev,
 	if ((state == PCI_D1 || state == PCI_D2) && pci_no_d1d2(dev))
 		return 0;
 
+	platform_pm = (platform_pci_power_manageable
+			&& platform_pci_power_manageable(dev));
+	if (platform_pm) {
+		/*
+		 * Allow the platform to change the state, for example via ACPI
+		 * _PRx, _PSx and some such, but do not trust it.
+		 */
+		platform_done = !platform_pci_set_power_state(dev, state);
+		if (platform_done)
+			printk(KERN_INFO
+			"PCI: Power state of %s set by the platform\n",
+			pci_name(dev));
+	}
+
 	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
 
 	/* abort if the device doesn't support PM capabilities */
 	if (!pm)
-		return -EIO;
+		return platform_done ? 0 : -EIO;
+
+	if (platform_pm) {
+		/*
+		 * The platform might have changed the state, make sure that
+		 * the cached value is still valid.
+		 */
+		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+	}
 
 	/* Validate current state:
 	 * Can enter D0 from any state, but if we can only go deeper 
@@ -427,12 +451,12 @@ pci_set_power_state(struct pci_dev *dev,
 	if (state != PCI_D0 && dev->current_state > state) {
 		printk(KERN_ERR "%s(): %s: state=%d, current state=%d\n",
 			__func__, pci_name(dev), state, dev->current_state);
-		return -EINVAL;
+		return platform_done ? 0 : -EINVAL;
 	} else if (dev->current_state == state)
 		return 0;        /* we're already there */
 
 
-	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
+	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
 	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
 		printk(KERN_DEBUG
 		       "PCI: %s has unsupported PM cap regs version (%u)\n",
@@ -446,7 +470,8 @@ pci_set_power_state(struct pci_dev *dev,
 	else if (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2))
 		return -EIO;
 
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+	if (!platform_pm)
+		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
 
 	/* If we're (effectively) in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
@@ -462,7 +487,7 @@ pci_set_power_state(struct pci_dev *dev,
 	case PCI_UNKNOWN: /* Boot-up */
 		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
 		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
-			need_restore = 1;
+			need_restore = true;
 		/* Fall-through: force to D0 */
 	default:
 		pmcsr = 0;
@@ -479,13 +504,6 @@ pci_set_power_state(struct pci_dev *dev,
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(200);
 
-	/*
-	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
-	 * Firmware method after native method ?
-	 */
-	if (platform_pci_set_power_state)
-		platform_pci_set_power_state(dev, state);
-
 	dev->current_state = state;
 
 	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -341,7 +341,7 @@ static int acpi_pci_set_power_state(stru
 		return -ENODEV;
 	/* If the ACPI device has _EJ0, ignore the device */
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0", &tmp)))
-		return 0;
+		return -EINVAL;
 
 	switch (state) {
 	case PCI_D0:
