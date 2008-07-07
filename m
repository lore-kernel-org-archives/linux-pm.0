From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/8] PCI ACPI: Rework PCI handling of wake-up
	(rev. 5)
Date: Mon, 7 Jul 2008 03:34:48 +0200
Message-ID: <200807070334.48957.rjw__8174.52399428493$1215395042$gmane$org@sisk.pl>
References: <200807012356.26669.rjw@sisk.pl> <200807070330.02849.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807070330.02849.rjw@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

PCI ACPI: Rework PCI handling of wake-up (rev. 5)

* Introduce function acpi_pm_device_sleep_wake() for enabling and
  disabling the system wake-up capability of devices that are power
  manageable by ACPI.

* Introduce function acpi_bus_can_wakeup() allowing other (dependent)
  subsystems to check if ACPI is able to enable the system wake-up
  capability of given device.

* Introduce callback .sleep_wake() in struct pci_platform_pm_ops and
  for the ACPI PCI 'driver' make it use acpi_pm_device_sleep_wake().

* Introduce callback .can_wakeup() in struct pci_platform_pm_ops and
  for the ACPI 'driver' make it use acpi_bus_can_wakeup().

* Move the PME# handlig code out of pci_enable_wake() and split it
  into two functions, pci_pme_capable() and pci_pme_active(),
  allowing the caller to check if given device is capable of
  generating PME# from given power state and to enable/disable the
  device's PME# functionality, respectively.

* Modify pci_enable_wake() to use the new ACPI callbacks and the new
  PME#-related functions.

* Drop the generic .platform_enable_wakeup() callback that is not
  used any more.

* Introduce device_set_wakeup_capable() that will set the
  power.can_wakeup flag of given device.

* Rework PCI device PM initialization so that, if given device is
  capable of generating wake-up events, either natively through the
  PME# mechanism, or with the help of the platform, its
  power.can_wakeup flag is set and its power.should_wakeup flag is
  unset as appropriate.

* Make ACPI set the power.can_wakeup flag for devices found to be
  wake-up capable by it.

* Make the ACPI wake-up code enable/disable GPEs for devices that
  have the wakeup.flags.prepared flag set (which means that their
  wake-up power has been enabled).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c          |   11 ++
 drivers/acpi/glue.c         |    2 
 drivers/acpi/sleep/main.c   |   25 ++++++
 drivers/acpi/sleep/wakeup.c |   11 +-
 drivers/base/power/sysfs.c  |    3 
 drivers/pci/pci-acpi.c      |   20 +++++
 drivers/pci/pci.c           |  169 ++++++++++++++++++++++++++++++++------------
 drivers/pci/pci.h           |    8 ++
 drivers/pci/probe.c         |   47 ------------
 include/acpi/acpi_bus.h     |    2 
 include/linux/pm_wakeup.h   |   26 +-----
 11 files changed, 208 insertions(+), 116 deletions(-)

Index: linux-pci/drivers/acpi/sleep/main.c
===================================================================
--- linux-pci.orig/drivers/acpi/sleep/main.c
+++ linux-pci/drivers/acpi/sleep/main.c
@@ -468,6 +468,31 @@ int acpi_pm_device_sleep_state(struct de
 		*d_min_p = d_min;
 	return d_max;
 }
+
+/**
+ *	acpi_pm_device_sleep_wake - enable or disable the system wake-up
+ *                                  capability of given device
+ *	@dev: device to handle
+ *	@enable: 'true' - enable, 'false' - disable the wake-up capability
+ */
+int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
+{
+	acpi_handle handle;
+	struct acpi_device *adev;
+
+	if (!device_may_wakeup(dev))
+		return -EINVAL;
+
+	handle = DEVICE_ACPI_HANDLE(dev);
+	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
+		printk(KERN_DEBUG "ACPI handle has no context!\n");
+		return -ENODEV;
+	}
+
+	return enable ?
+		acpi_enable_wakeup_device_power(adev, acpi_target_sleep_state) :
+		acpi_disable_wakeup_device_power(adev);
+}
 #endif
 
 static void acpi_power_off_prepare(void)
Index: linux-pci/drivers/pci/pci-acpi.c
===================================================================
--- linux-pci.orig/drivers/pci/pci-acpi.c
+++ linux-pci/drivers/pci/pci-acpi.c
@@ -299,10 +299,30 @@ static int acpi_pci_set_power_state(stru
 	return error;
 }
 
+static bool acpi_pci_can_wakeup(struct pci_dev *dev)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+
+	return handle ? acpi_bus_can_wakeup(handle) : false;
+}
+
+static int acpi_pci_sleep_wake(struct pci_dev *dev, bool enable)
+{
+	int error = acpi_pm_device_sleep_wake(&dev->dev, enable);
+
+	if (!error)
+		dev_printk(KERN_INFO, &dev->dev,
+				"wake-up capability %s by ACPI\n",
+				enable ? "enabled" : "disabled");
+	return error;
+}
+
 static struct pci_platform_pm_ops acpi_pci_platform_pm = {
 	.is_manageable = acpi_pci_power_manageable,
 	.set_state = acpi_pci_set_power_state,
 	.choose_state = acpi_pci_choose_state,
+	.can_wakeup = acpi_pci_can_wakeup,
+	.sleep_wake = acpi_pci_sleep_wake,
 };
 
 /* ACPI bus type */
Index: linux-pci/drivers/pci/pci.h
===================================================================
--- linux-pci.orig/drivers/pci/pci.h
+++ linux-pci/drivers/pci/pci.h
@@ -17,6 +17,11 @@ extern void pci_cleanup_rom(struct pci_d
  *                 platform; to be used during system-wide transitions from a
  *                 sleeping state to the working state and vice versa
  *
+ * @can_wakeup - returns 'true' if given device is capable of waking up the
+ *               system from a sleeping state
+ *
+ * @sleep_wake - enables/disables the system wake up capability of given device
+ *
  * If given platform is generally capable of power managing PCI devices, all of
  * these callbacks are mandatory.
  */
@@ -24,9 +29,12 @@ struct pci_platform_pm_ops {
 	bool (*is_manageable)(struct pci_dev *dev);
 	int (*set_state)(struct pci_dev *dev, pci_power_t state);
 	pci_power_t (*choose_state)(struct pci_dev *dev);
+	bool (*can_wakeup)(struct pci_dev *dev);
+	int (*sleep_wake)(struct pci_dev *dev, bool enable);
 };
 
 extern int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
+extern void pci_pm_init(struct pci_dev *dev);
 
 extern int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
 extern int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
Index: linux-pci/include/acpi/acpi_bus.h
===================================================================
--- linux-pci.orig/include/acpi/acpi_bus.h
+++ linux-pci/include/acpi/acpi_bus.h
@@ -337,6 +337,7 @@ int acpi_bus_get_status(struct acpi_devi
 int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
 bool acpi_bus_power_manageable(acpi_handle handle);
+bool acpi_bus_can_wakeup(acpi_handle handle);
 #ifdef CONFIG_ACPI_PROC_EVENT
 int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data);
 int acpi_bus_generate_proc_event4(const char *class, const char *bid, u8 type, int data);
@@ -379,6 +380,7 @@ acpi_handle acpi_get_pci_rootbridge_hand
 
 #ifdef CONFIG_PM_SLEEP
 int acpi_pm_device_sleep_state(struct device *, int *);
+int acpi_pm_device_sleep_wake(struct device *, bool);
 #else /* !CONFIG_PM_SLEEP */
 static inline int acpi_pm_device_sleep_state(struct device *d, int *p)
 {
Index: linux-pci/drivers/pci/pci.c
===================================================================
--- linux-pci.orig/drivers/pci/pci.c
+++ linux-pci/drivers/pci/pci.c
@@ -380,7 +380,8 @@ static struct pci_platform_pm_ops *pci_p
 
 int pci_set_platform_pm(struct pci_platform_pm_ops *ops)
 {
-	if (!ops->is_manageable || !ops->set_state || !ops->choose_state)
+	if (!ops->is_manageable || !ops->set_state || !ops->choose_state
+	    || !ops->sleep_wake || !ops->can_wakeup)
 		return -EINVAL;
 	pci_platform_pm = ops;
 	return 0;
@@ -403,6 +404,17 @@ static inline pci_power_t platform_pci_c
 			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
 }
 
+static inline bool platform_pci_can_wakeup(struct pci_dev *dev)
+{
+	return pci_platform_pm ? pci_platform_pm->can_wakeup(dev) : false;
+}
+
+static inline int platform_pci_sleep_wake(struct pci_dev *dev, bool enable)
+{
+	return pci_platform_pm ?
+			pci_platform_pm->sleep_wake(dev, enable) : -ENODEV;
+}
+
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *                           given PCI device
@@ -1036,6 +1048,56 @@ int pci_set_pcie_reset_state(struct pci_
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
+
+	dev_printk(KERN_INFO, &dev->dev, "PME# %s\n",
+			enable ? "enabled" : "disabled");
+}
+
+/**
  * pci_enable_wake - enable PCI device as wakeup event source
  * @dev: PCI device affected
  * @state: PCI state from which device will issue wakeup events
@@ -1046,66 +1108,83 @@ int pci_set_pcie_reset_state(struct pci_
  * called automatically by this routine.
  *
  * Devices with legacy power management (no standard PCI PM capabilities)
- * always require such platform hooks.  Depending on the platform, devices
- * supporting the standard PCI PME# signal may require such platform hooks;
- * they always update bits in config space to allow PME# generation.
- *
- * -EIO is returned if the device can't ever be a wakeup event source.
- * -EINVAL is returned if the device can't generate wakeup events from
- * the specified PCI state.  Returns zero if the operation is successful.
+ * always require such platform hooks.
+ *
+ * RETURN VALUE:
+ * 0 is returned on success
+ * -EINVAL is returned if device is not supposed to wake up the system
+ * Error code depending on the platform is returned if both the platform and
+ * the native mechanism fail to enable the generation of wake-up events
  */
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
 {
 	int pm;
-	int status;
-	u16 value;
+	int error = 0;
+	bool pme_done = false;
+
+	if (!device_may_wakeup(&dev->dev))
+		return -EINVAL;
 
-	/* Note that drivers should verify device_may_wakeup(&dev->dev)
-	 * before calling this function.  Platform code should report
-	 * errors when drivers try to enable wakeup on devices that
-	 * can't issue wakeups, or on which wakeups were disabled by
-	 * userspace updating the /sys/devices.../power/wakeup file.
+	/*
+	 * According to "PCI System Architecture" 4th ed. by Tom Shanley & Don
+	 * Anderson we should be doing PME# wake enable followed by ACPI wake
+	 * enable.  To disable wake-up we call the platform first, for symmetry.
 	 */
 
-	status = call_platform_enable_wakeup(&dev->dev, enable);
+	if (!enable && platform_pci_can_wakeup(dev))
+		error = platform_pci_sleep_wake(dev, false);
 
-	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!enable || pci_pme_capable(dev, pm, state)) {
+		pci_pme_active(dev, pm, enable);
+		pme_done = true;
+	}
 
-	/* If device doesn't support PM Capabilities, but caller wants to
-	 * disable wake events, it's a NOP.  Otherwise fail unless the
-	 * platform hooks handled this legacy device already.
-	 */
-	if (!pm)
-		return enable ? status : 0;
+	if (enable && platform_pci_can_wakeup(dev))
+		error = platform_pci_sleep_wake(dev, true);
 
+	return pme_done ? 0 : error;
+}
+
+/**
+ * pci_pm_init - Initialize PM functions of given PCI device
+ * @dev: PCI device to handle.
+ */
+void pci_pm_init(struct pci_dev *dev)
+{
+	int pm;
+	u16 pmc;
+
+	/* find PCI PM capability in list */
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!pm)
+		return;
 	/* Check device's ability to generate PME# */
-	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
+	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
 
-	value &= PCI_PM_CAP_PME_MASK;
-	value >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
+	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
+		dev_err(&dev->dev, "unsupported PM cap regs version (%u)\n",
+			pmc & PCI_PM_CAP_VER_MASK);
+		return;
+	}
 
-	/* Check if it can generate PME# from requested state. */
-	if (!value || !(value & (1 << state))) {
-		/* if it can't, revert what the platform hook changed,
-		 * always reporting the base "EINVAL, can't PME#" error
+	if (pmc & PCI_PM_CAP_PME_MASK) {
+		dev_printk(KERN_INFO, &dev->dev,
+			"PME# supported from%s%s%s%s%s\n",
+			(pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
+			(pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
+			(pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
+			(pmc & PCI_PM_CAP_PME_D3) ? " D3hot" : "",
+			(pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" : "");
+		/*
+		 * Make device's PM flags reflect the wake-up capability, but
+		 * let the user space enable it to wake up the system as needed.
 		 */
-		if (enable)
-			call_platform_enable_wakeup(&dev->dev, 0);
-		return enable ? -EINVAL : 0;
+		device_set_wakeup_capable(&dev->dev, true);
+		device_set_wakeup_enable(&dev->dev, false);
+		/* Disable the PME# generation functionality */
+		pci_pme_active(dev, pm, false);
 	}
-
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &value);
-
-	/* Clear PME_Status by writing 1 to it and enable PME# */
-	value |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
-
-	if (!enable)
-		value &= ~PCI_PM_CTRL_PME_ENABLE;
-
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
-
-	return 0;
 }
 
 int
Index: linux-pci/include/linux/pm_wakeup.h
===================================================================
--- linux-pci.orig/include/linux/pm_wakeup.h
+++ linux-pci/include/linux/pm_wakeup.h
@@ -35,6 +35,11 @@ static inline void device_init_wakeup(st
 	dev->power.can_wakeup = dev->power.should_wakeup = !!val;
 }
 
+static inline void device_set_wakeup_capable(struct device *dev, int val)
+{
+	dev->power.can_wakeup = !!val;
+}
+
 static inline int device_can_wakeup(struct device *dev)
 {
 	return dev->power.can_wakeup;
@@ -47,21 +52,7 @@ static inline void device_set_wakeup_ena
 
 static inline int device_may_wakeup(struct device *dev)
 {
-	return dev->power.can_wakeup & dev->power.should_wakeup;
-}
-
-/*
- * Platform hook to activate device wakeup capability, if that's not already
- * handled by enable_irq_wake() etc.
- * Returns zero on success, else negative errno
- */
-extern int (*platform_enable_wakeup)(struct device *dev, int is_on);
-
-static inline int call_platform_enable_wakeup(struct device *dev, int is_on)
-{
-	if (platform_enable_wakeup)
-		return (*platform_enable_wakeup)(dev, is_on);
-	return 0;
+	return dev->power.can_wakeup && dev->power.should_wakeup;
 }
 
 #else /* !CONFIG_PM */
@@ -80,11 +71,6 @@ static inline int device_can_wakeup(stru
 #define device_set_wakeup_enable(dev, val)	do {} while (0)
 #define device_may_wakeup(dev)			0
 
-static inline int call_platform_enable_wakeup(struct device *dev, int is_on)
-{
-	return 0;
-}
-
 #endif /* !CONFIG_PM */
 
 #endif /* _LINUX_PM_WAKEUP_H */
Index: linux-pci/drivers/base/power/sysfs.c
===================================================================
--- linux-pci.orig/drivers/base/power/sysfs.c
+++ linux-pci/drivers/base/power/sysfs.c
@@ -6,9 +6,6 @@
 #include <linux/string.h>
 #include "power.h"
 
-int (*platform_enable_wakeup)(struct device *dev, int is_on);
-
-
 /*
  *	wakeup - Report/change current wakeup option for device
  *
Index: linux-pci/drivers/acpi/bus.c
===================================================================
--- linux-pci.orig/drivers/acpi/bus.c
+++ linux-pci/drivers/acpi/bus.c
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
Index: linux-pci/drivers/pci/probe.c
===================================================================
--- linux-pci.orig/drivers/pci/probe.c
+++ linux-pci/drivers/pci/probe.c
@@ -860,49 +860,6 @@ int pci_cfg_space_size_ext(struct pci_de
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
@@ -1010,7 +967,6 @@ static struct pci_dev *pci_scan_device(s
 	}
 
 	pci_vpd_pci22_init(dev);
-	pci_disable_pme(dev);
 
 	return dev;
 }
@@ -1031,6 +987,9 @@ void pci_device_add(struct pci_dev *dev,
 	/* Fix up broken headers */
 	pci_fixup_device(pci_fixup_header, dev);
 
+	/* Initialize power management of the device */
+	pci_pm_init(dev);
+
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.
Index: linux-pci/drivers/acpi/glue.c
===================================================================
--- linux-pci.orig/drivers/acpi/glue.c
+++ linux-pci/drivers/acpi/glue.c
@@ -166,6 +166,8 @@ static int acpi_bind_one(struct device *
 				"firmware_node");
 		ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
 				"physical_node");
+		if (acpi_dev->wakeup.flags.valid)
+			device_set_wakeup_capable(dev, true);
 	}
 
 	return 0;
Index: linux-pci/drivers/acpi/sleep/wakeup.c
===================================================================
--- linux-pci.orig/drivers/acpi/sleep/wakeup.c
+++ linux-pci/drivers/acpi/sleep/wakeup.c
@@ -66,13 +66,15 @@ void acpi_enable_wakeup_device(u8 sleep_
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
+
 		if (!dev->wakeup.flags.valid)
 			continue;
+
 		/* If users want to disable run-wake GPE,
 		 * we only disable it for wake and leave it for runtime
 		 */
-		if (!dev->wakeup.state.enabled ||
-		    sleep_state > (u32) dev->wakeup.sleep_state) {
+		if ((!dev->wakeup.state.enabled && !dev->wakeup.flags.prepared)
+		    || sleep_state > (u32) dev->wakeup.sleep_state) {
 			if (dev->wakeup.flags.run_wake) {
 				spin_unlock(&acpi_device_lock);
 				/* set_gpe_type will disable GPE, leave it like that */
@@ -110,8 +112,9 @@ void acpi_disable_wakeup_device(u8 sleep
 
 		if (!dev->wakeup.flags.valid)
 			continue;
-		if (!dev->wakeup.state.enabled ||
-		    sleep_state > (u32) dev->wakeup.sleep_state) {
+
+		if ((!dev->wakeup.state.enabled && !dev->wakeup.flags.prepared)
+		    || sleep_state > (u32) dev->wakeup.sleep_state) {
 			if (dev->wakeup.flags.run_wake) {
 				spin_unlock(&acpi_device_lock);
 				acpi_set_gpe_type(dev->wakeup.gpe_device,
