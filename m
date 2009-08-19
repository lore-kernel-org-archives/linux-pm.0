From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 5/5] acpi-based wakeup event detection
Date: Wed, 19 Aug 2009 15:24:21 +0800
Message-ID: <1250666661.23178.120.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, mjg59 <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org


In ACPI platform, if native PME isn't enabled, GPE is used to report wakeup event.
---
 drivers/acpi/Kconfig        |    9 ++++++
 drivers/acpi/bus.c          |   15 +++++++++++
 drivers/acpi/sleep/wakeup.c |   60 ++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h     |    4 ++
 4 files changed, 88 insertions(+)

Index: linux/drivers/acpi/Kconfig
===================================================================
--- linux.orig/drivers/acpi/Kconfig	2009-08-05 11:00:06.000000000 +0800
+++ linux/drivers/acpi/Kconfig	2009-08-19 10:07:05.000000000 +0800
@@ -45,6 +45,15 @@ config ACPI_SLEEP
 	depends on SUSPEND || HIBERNATION
 	default y
 
+config ACPI_GPE_WAKEUP
+	bool "ACPI wakeup event support"
+	depends on PM_SLEEP && EXPERIMENTAL
+	help
+	  Enable ACPI to detect wakeup event. For example, PCI device can
+	  invoke PME, and in ACPI platform, the PME will invoke a GPE. With
+	  the option, we can detect which device invokes wakeup event.
+
+
 config ACPI_PROCFS
 	bool "Deprecated /proc/acpi files"
 	depends on PROC_FS
Index: linux/drivers/acpi/wakeup.c
===================================================================
--- linux.orig/drivers/acpi/wakeup.c	2009-07-24 11:31:05.000000000 +0800
+++ linux/drivers/acpi/wakeup.c	2009-08-19 10:16:27.000000000 +0800
@@ -124,6 +124,63 @@ void acpi_disable_wakeup_device(u8 sleep
 	}
 }
 
+#ifdef CONFIG_ACPI_GPE_WAKEUP
+static int acpi_gpe_pme_check(struct acpi_device *dev)
+{
+	struct device *ldev;
+
+	ldev = acpi_get_physical_device(dev->handle);
+	if (!ldev)
+		return -ENODEV;
+	/*
+	 * AML code might already clear the event, so ignore the return value.
+	 * Actually we can't correctly detect which device invokes GPE if the
+	 * event is cleared.
+	 */
+	if (ldev->bus->pm && ldev->bus->pm->wakeup_event)
+		ldev->bus->pm->wakeup_event(ldev);
+
+	put_device(ldev);
+	return 0;
+}
+
+static int acpi_gpe_pme_handler(struct notifier_block *nb,
+	unsigned long type, void *data)
+{
+	int ret;
+	acpi_handle handle = data;
+	struct acpi_device *dev;
+
+	if (type != ACPI_NOTIFY_DEVICE_WAKE)
+		return NOTIFY_DONE;
+
+	if (acpi_bus_get_device(handle, &dev))
+		return NOTIFY_DONE;
+
+	ret = acpi_gpe_pme_check(dev);
+
+	acpi_disable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number);
+
+	/* FIXME: spurious interrupt, disables it? */
+	if (ret)
+		printk(KERN_ERR"Spurious GPE %d detected\n",
+			dev->wakeup.gpe_number);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block acpi_gpe_pme_nb = {
+	.notifier_call = acpi_gpe_pme_handler,
+};
+
+static void acpi_init_gpe_pme(void)
+{
+	register_acpi_bus_notifier(&acpi_gpe_pme_nb);
+}
+#else
+static inline void acpi_init_gpe_pme(void) {}
+#endif
+
 int __init acpi_wakeup_device_init(void)
 {
 	struct list_head *node, *next;
@@ -144,5 +201,7 @@ int __init acpi_wakeup_device_init(void)
 		dev->wakeup.state.enabled = 1;
 	}
 	mutex_unlock(&acpi_device_lock);
+
+	acpi_init_gpe_pme();
 	return 0;
 }


