From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 9/12] ACPI / PM: Introduce acpi_pm_wakeup_power()
Date: Sun, 27 Dec 2009 21:06:26 +0100
Message-ID: <200912272106.26569.rjw__30848.1238353581$1261945394$gmane$org@sisk.pl>
References: <200912272057.10443.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912272057.10443.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

PCI run-time power management generally requires us to set up wake-up
power for devices that are supposed to generate wake-up events, but
at the moment we only have acpi_pm_device_sleep_wake() allowing us
only to do that during system-wide power transitions.  For this
reason introduce another helper function, acpi_pm_wakeup_power(),
allowing us to enable/disable wake-up power for a device at any time
and rework acpi_pm_device_sleep_wake() to use it too.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c    |   22 ++++++++++++++++------
 include/acpi/acpi_bus.h |   11 ++++++++---
 2 files changed, 24 insertions(+), 9 deletions(-)

Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -236,3 +236,8 @@ config PM_RUNTIME
 	  and the bus type drivers of the buses the devices are on are
 	  responsible for the actual handling of the autosuspend requests and
 	  wake-up events.
+
+config PM_WAKEUP
+	bool
+	depends on SUSPEND || HIBERNATION || PM_RUNTIME
+	default y
Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -634,7 +634,7 @@ int acpi_suspend(u32 acpi_state)
 	return -EINVAL;
 }
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_WAKEUP
 /**
  *	acpi_pm_device_sleep_state - return preferred power state of ACPI device
  *		in the system sleep state given by %acpi_target_sleep_state
@@ -720,6 +720,18 @@ int acpi_pm_device_sleep_state(struct de
 }
 
 /**
+ * acpi_pm_wakeup_power - Enable/disable device wake-up power.
+ * @dev: ACPI device to handle.
+ * @enable: Whether to enable or disable the wake-up power of the device.
+ */
+int acpi_pm_wakeup_power(struct acpi_device *dev, bool enable)
+{
+	return enable ?
+		acpi_enable_wakeup_device_power(dev, acpi_target_sleep_state) :
+		acpi_disable_wakeup_device_power(dev);
+}
+
+/**
  *	acpi_pm_device_sleep_wake - enable or disable the system wake-up
  *                                  capability of given device
  *	@dev: device to handle
@@ -740,16 +752,14 @@ int acpi_pm_device_sleep_wake(struct dev
 		return -ENODEV;
 	}
 
-	error = enable ?
-		acpi_enable_wakeup_device_power(adev, acpi_target_sleep_state) :
-		acpi_disable_wakeup_device_power(adev);
+	error = acpi_pm_wakeup_power(adev, enable);
 	if (!error)
-		dev_info(dev, "wake-up capability %s by ACPI\n",
+		dev_info(dev, "wake-up power %s by ACPI\n",
 				enable ? "enabled" : "disabled");
 
 	return error;
 }
-#endif
+#endif /* CONFIG_PM_WAKEUP */
 
 static void acpi_power_off_prepare(void)
 {
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -388,21 +388,26 @@ acpi_handle acpi_get_pci_rootbridge_hand
 struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle);
 #define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_WAKEUP
 int acpi_pm_device_sleep_state(struct device *, int *);
+int acpi_pm_wakeup_power(struct acpi_device *, bool);
 int acpi_pm_device_sleep_wake(struct device *, bool);
-#else /* !CONFIG_PM_SLEEP */
+#else /* !CONFIG_PM_WAKEUP */
 static inline int acpi_pm_device_sleep_state(struct device *d, int *p)
 {
 	if (p)
 		*p = ACPI_STATE_D0;
 	return ACPI_STATE_D3;
 }
+static inline int acpi_pm_wakeup_power(struct acpi_device *dev, bool enable)
+{
+	return -ENODEV;
+}
 static inline int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
 {
 	return -ENODEV;
 }
-#endif /* !CONFIG_PM_SLEEP */
+#endif /* !CONFIG_PM_WAKEUP */
 
 #endif				/* CONFIG_ACPI */
 
