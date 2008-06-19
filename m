From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 2/9] PCI: Introduce
	platform_pci_power_manageable function
Date: Fri, 20 Jun 2008 01:47:15 +0200
Message-ID: <200806200147.16040.rjw__7903.44917118109$1213920594$gmane$org@sisk.pl>
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

PCI: Introduce platform_pci_power_manageable function

Introduce function pointer platform_pci_power_manageable to be used
by the platform-related code to point to a function allowing us to
check if given device is power manageable by the platform.

Introduce acpi_pci_power_manageable() playing that role for ACPI.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |   19 +++++++++++++------
 drivers/pci/pci.c      |   40 ++++++++++++++++++++++++++++++----------
 drivers/pci/pci.h      |   26 ++++++++++++++++++++++----
 3 files changed, 65 insertions(+), 20 deletions(-)

Index: linux-next/drivers/pci/pci-acpi.c
===================================================================
--- linux-next.orig/drivers/pci/pci-acpi.c
+++ linux-next/drivers/pci/pci-acpi.c
@@ -215,7 +215,6 @@ acpi_status pci_osc_control_set(acpi_han
 }
 EXPORT_SYMBOL(pci_osc_control_set);
 
-#ifdef CONFIG_ACPI_SLEEP
 /*
  * _SxD returns the D-state with the highest power
  * (lowest D-state number) supported in the S-state "x".
@@ -259,7 +258,13 @@ static pci_power_t acpi_pci_choose_state
 	}
 	return PCI_POWER_ERROR;
 }
-#endif
+
+static bool acpi_pci_power_manageable(struct pci_dev *dev)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+
+	return handle ? acpi_bus_power_manageable(handle) : false;
+}
 
 static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
@@ -290,6 +295,11 @@ static int acpi_pci_set_power_state(stru
 	return -EINVAL;
 }
 
+static struct pci_platform_pm_ops acpi_pci_platform_pm = {
+	.is_manageable = acpi_pci_power_manageable,
+	.set_state = acpi_pci_set_power_state,
+	.choose_state = acpi_pci_choose_state,
+};
 
 /* ACPI bus type */
 static int acpi_pci_find_device(struct device *dev, acpi_handle *handle)
@@ -341,10 +351,7 @@ static int __init acpi_pci_init(void)
 	ret = register_acpi_bus_type(&acpi_pci_bus);
 	if (ret)
 		return 0;
-#ifdef	CONFIG_ACPI_SLEEP
-	platform_pci_choose_state = acpi_pci_choose_state;
-#endif
-	platform_pci_set_power_state = acpi_pci_set_power_state;
+	pci_set_platform_pm(&acpi_pci_platform_pm);
 	return 0;
 }
 arch_initcall(acpi_pci_init);
Index: linux-next/drivers/pci/pci.c
===================================================================
--- linux-next.orig/drivers/pci/pci.c
+++ linux-next/drivers/pci/pci.c
@@ -376,7 +376,32 @@ pci_restore_bars(struct pci_dev *dev)
 		pci_update_resource(dev, &dev->resource[i], i);
 }
 
-int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t t);
+static struct pci_platform_pm_ops *pci_platform_pm;
+
+int pci_set_platform_pm(struct pci_platform_pm_ops *ops)
+{
+	if (!ops->is_manageable || !ops->set_state || !ops->choose_state)
+		return -EINVAL;
+	pci_platform_pm = ops;
+	return 0;
+}
+
+static inline bool platform_pci_power_manageable(struct pci_dev *dev)
+{
+	return pci_platform_pm ? pci_platform_pm->is_manageable(dev) : false;
+}
+
+static inline int platform_pci_set_power_state(struct pci_dev *dev,
+                                                pci_power_t t)
+{
+	return pci_platform_pm ? pci_platform_pm->set_state(dev, t) : -ENOSYS;
+}
+
+static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
+{
+	return pci_platform_pm ?
+			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
+}
 
 /**
  * pci_set_power_state - Set the power state of a PCI device
@@ -480,8 +505,7 @@ pci_set_power_state(struct pci_dev *dev,
 	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
 	 * Firmware method after native method ?
 	 */
-	if (platform_pci_set_power_state)
-		platform_pci_set_power_state(dev, state);
+	platform_pci_set_power_state(dev, state);
 
 	dev->current_state = state;
 
@@ -506,8 +530,6 @@ pci_set_power_state(struct pci_dev *dev,
 	return 0;
 }
 
-pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
- 
 /**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
@@ -525,11 +547,9 @@ pci_power_t pci_choose_state(struct pci_
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
-	if (platform_pci_choose_state) {
-		ret = platform_pci_choose_state(dev);
-		if (ret != PCI_POWER_ERROR)
-			return ret;
-	}
+	ret = platform_pci_choose_state(dev);
+	if (ret != PCI_POWER_ERROR)
+		return ret;
 
 	switch (state.event) {
 	case PM_EVENT_ON:
Index: linux-next/drivers/pci/pci.h
===================================================================
--- linux-next.orig/drivers/pci/pci.h
+++ linux-next/drivers/pci/pci.h
@@ -5,10 +5,28 @@ extern int pci_create_sysfs_dev_files(st
 extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern void pci_cleanup_rom(struct pci_dev *dev);
 
-/* Firmware callbacks */
-extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
-extern int (*platform_pci_set_power_state)(struct pci_dev *dev,
-						pci_power_t state);
+/**
+ * Firmware PM callbacks
+ *
+ * @is_manageable - returns 'true' if given device is power manageable by the
+ *                  platform firmware
+ *
+ * @set_state - invokes the platform firmware to set the device's power state
+ *
+ * @choose_state - returns PCI power state of given device preferred by the
+ *                 platform; to be used during system-wide transitions from a
+ *                 sleeping state to the working state and vice versa
+ *
+ * If given platform is generally capable of power managing PCI devices, all of
+ * these callbacks are mandatory.
+ */
+struct pci_platform_pm_ops {
+	bool (*is_manageable)(struct pci_dev *dev);
+	int (*set_state)(struct pci_dev *dev, pci_power_t state);
+	pci_power_t (*choose_state)(struct pci_dev *dev);
+};
+
+extern int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
 
 extern int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
 extern int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
