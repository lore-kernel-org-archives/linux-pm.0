From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 07/11] PCI ACPI: Introduce can_wakeup platform
	callback
Date: Mon, 23 Jun 2008 19:46:00 +0200
Message-ID: <200806231946.00912.rjw__47154.2247491472$1214243940$gmane$org@sisk.pl>
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

PCI ACPI: Introduce can_wakeup platform callback

Introduce function acpi_bus_can_wakeup() allowing other (dependent)
subsystems to check if ACPI is able to enable the system wake-up
capability of given device.

Introduce callback .can_wakeup() in struct pci_platform_pm_ops and
for the ACPI 'driver' make it use acpi_bus_can_wakeup().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c      |   11 +++++++++++
 drivers/pci/pci-acpi.c  |    8 ++++++++
 drivers/pci/pci.c       |   11 ++++++++---
 drivers/pci/pci.h       |    4 ++++
 include/acpi/acpi_bus.h |    1 +
 5 files changed, 32 insertions(+), 3 deletions(-)

Index: linux-next/drivers/pci/pci.h
===================================================================
--- linux-next.orig/drivers/pci/pci.h
+++ linux-next/drivers/pci/pci.h
@@ -17,6 +17,9 @@ extern void pci_cleanup_rom(struct pci_d
  *                 platform; to be used during system-wide transitions from a
  *                 sleeping state to the working state and vice versa
  *
+ * @can_wakeup - returns 'true' if given device is capable of waking up the
+ *               system from a sleeping state
+ *
  * @sleep_wake - enables/disables the system wake up capability of given device
  *
  * If given platform is generally capable of power managing PCI devices, all of
@@ -26,6 +29,7 @@ struct pci_platform_pm_ops {
 	bool (*is_manageable)(struct pci_dev *dev);
 	int (*set_state)(struct pci_dev *dev, pci_power_t state);
 	pci_power_t (*choose_state)(struct pci_dev *dev);
+	bool (*can_wakeup)(struct pci_dev *dev);
 	int (*sleep_wake)(struct pci_dev *dev, bool enable);
 };
 
Index: linux-next/drivers/pci/pci.c
===================================================================
--- linux-next.orig/drivers/pci/pci.c
+++ linux-next/drivers/pci/pci.c
@@ -381,7 +381,7 @@ static struct pci_platform_pm_ops *pci_p
 int pci_set_platform_pm(struct pci_platform_pm_ops *ops)
 {
 	if (!ops->is_manageable || !ops->set_state || !ops->choose_state
-	    || !ops->sleep_wake)
+	    || !ops->sleep_wake || !ops->can_wakeup)
 		return -EINVAL;
 	pci_platform_pm = ops;
 	return 0;
@@ -404,6 +404,11 @@ static inline pci_power_t platform_pci_c
 			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
 }
 
+static inline bool platform_pci_can_wakeup(struct pci_dev *dev)
+{
+	return pci_platform_pm ? pci_platform_pm->can_wakeup(dev) : false;
+}
+
 static inline int platform_pci_sleep_wake(struct pci_dev *dev, bool enable)
 {
 	return pci_platform_pm ?
@@ -1068,7 +1073,7 @@ int pci_enable_wake(struct pci_dev *dev,
 	u16 value = 0;
 	bool platform_done = false;
 
-	if (enable && platform_pci_power_manageable(dev)) {
+	if (enable && platform_pci_can_wakeup(dev)) {
 		/* Allow the platform to handle the device */
 		int err = platform_pci_sleep_wake(dev, true);
 		if (!err)
@@ -1121,7 +1126,7 @@ int pci_enable_wake(struct pci_dev *dev,
 	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
 
  Platform_disable:
-	if (!enable && platform_pci_power_manageable(dev)) {
+	if (!enable && platform_pci_can_wakeup(dev)) {
 		/* Allow the platform to finalize the operation */
 		int err = platform_pci_sleep_wake(dev, false);
 		if (err && !value)
Index: linux-next/drivers/acpi/bus.c
===================================================================
--- linux-next.orig/drivers/acpi/bus.c
+++ linux-next/drivers/acpi/bus.c
@@ -306,6 +306,17 @@ bool acpi_bus_power_manageable(acpi_hand
 
 EXPORT_SYMBOL(acpi_bus_power_manageable);
 
+bool acpi_bus_can_wakeup(acpi_handle handle)
+{
+	struct acpi_device *device;
+	int result;
+
+	result = acpi_bus_get_device(handle, &device);
+	return result ? false : device->wakeup.flags.valid;
+}
+
+EXPORT_SYMBOL(acpi_bus_can_wakeup);
+
 /* --------------------------------------------------------------------------
                                 Event Management
    -------------------------------------------------------------------------- */
Index: linux-next/drivers/pci/pci-acpi.c
===================================================================
--- linux-next.orig/drivers/pci/pci-acpi.c
+++ linux-next/drivers/pci/pci-acpi.c
@@ -299,6 +299,13 @@ static int acpi_pci_set_power_state(stru
 	return error;
 }
 
+static bool acpi_pci_can_wakeup(struct pci_dev *dev)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+
+	return handle ? acpi_bus_can_wakeup(handle) : false;
+}
+
 static int acpi_pci_sleep_wake(struct pci_dev *dev, bool enable)
 {
 	int error = acpi_pm_device_sleep_wake(&dev->dev, enable);
@@ -313,6 +320,7 @@ static struct pci_platform_pm_ops acpi_p
 	.is_manageable = acpi_pci_power_manageable,
 	.set_state = acpi_pci_set_power_state,
 	.choose_state = acpi_pci_choose_state,
+	.can_wakeup = acpi_pci_can_wakeup,
 	.sleep_wake = acpi_pci_sleep_wake,
 };
 
Index: linux-next/include/acpi/acpi_bus.h
===================================================================
--- linux-next.orig/include/acpi/acpi_bus.h
+++ linux-next/include/acpi/acpi_bus.h
@@ -337,6 +337,7 @@ int acpi_bus_get_status(struct acpi_devi
 int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
 bool acpi_bus_power_manageable(acpi_handle handle);
+bool acpi_bus_can_wakeup(acpi_handle handle);
 #ifdef CONFIG_ACPI_PROC_EVENT
 int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data);
 int acpi_bus_generate_proc_event4(const char *class, const char *bid, u8 type,
