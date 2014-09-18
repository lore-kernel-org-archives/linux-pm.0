From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 01/19] ACPI: introduce ACPI int340x thermal scan handler
Date: Thu, 18 Sep 2014 09:53:32 +0800
Message-ID: <1411005230-2227-2-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5126 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756686AbaIRByP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Sep 2014 21:54:15 -0400
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Zhang Rui <rui.zhang@intel.com>

Newer laptops and tablets that use ACPI may have thermal sensors and
other devices with thermal control capabilities outside the core CPU/SOC,
for thermal safety reasons.
They are exposed for the OS to use via
1) INT3400 ACPI device object as the master.
2) INT3401 ~ INT340B ACPI device objects as the slaves.

This patch introduces a scan handler to enumerate the INT3400
ACPI device object to platform bus, and prevent its slaves
from being enumerated before the controller driver being probed.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Makefile          |  1 +
 drivers/acpi/int340x_thermal.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h        |  1 +
 drivers/acpi/scan.c            |  1 +
 drivers/thermal/Kconfig        | 17 ++++++++++++++
 5 files changed, 71 insertions(+)
 create mode 100644 drivers/acpi/int340x_thermal.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 505d4d7..c3b2fcb 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -43,6 +43,7 @@ acpi-y				+= pci_root.o pci_link.o pci_irq.o
 acpi-y				+= acpi_lpss.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
+acpi-y				+= int340x_thermal.o
 acpi-y				+= power.o
 acpi-y				+= event.o
 acpi-y				+= sysfs.o
diff --git a/drivers/acpi/int340x_thermal.c b/drivers/acpi/int340x_thermal.c
new file mode 100644
index 0000000..2103bb6
--- /dev/null
+++ b/drivers/acpi/int340x_thermal.c
@@ -0,0 +1,51 @@
+/*
+ * ACPI support for int340x thermal drivers
+ *
+ * Copyright (C) 2014, Intel Corporation
+ * Authors: Zhang Rui <rui.zhang@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+
+#include "internal.h"
+
+#define DO_ENUMERATION 0x01
+static const struct acpi_device_id int340x_thermal_device_ids[] = {
+	{"INT3400", DO_ENUMERATION },
+	{"INT3401"},
+	{"INT3402"},
+	{"INT3403"},
+	{"INT3404"},
+	{"INT3406"},
+	{"INT3407"},
+	{"INT3408"},
+	{"INT3409"},
+	{"INT340A"},
+	{"INT340B"},
+	{""},
+};
+
+static int int340x_thermal_handler_attach(struct acpi_device *adev,
+					const struct acpi_device_id *id)
+{
+#ifdef CONFIG_INT340X_THERMAL
+	if (id->driver_data == DO_ENUMERATION)
+		acpi_create_platform_device(adev);
+#endif
+	return 1;
+}
+
+static struct acpi_scan_handler int340x_thermal_handler = {
+	.ids = int340x_thermal_device_ids,
+	.attach = int340x_thermal_handler_attach,
+};
+
+void __init acpi_int340x_thermal_init(void)
+{
+	acpi_scan_add_handler(&int340x_thermal_handler);
+}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 4c5cf77..de47f9f 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -31,6 +31,7 @@ void acpi_pci_link_init(void);
 void acpi_processor_init(void);
 void acpi_platform_init(void);
 void acpi_pnp_init(void);
+void acpi_int340x_thermal_init(void);
 int acpi_sysfs_init(void);
 void acpi_container_init(void);
 void acpi_memory_hotplug_init(void);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0a817ad..eed9740 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2306,6 +2306,7 @@ int __init acpi_scan_init(void)
 	acpi_container_init();
 	acpi_memory_hotplug_init();
 	acpi_pnp_init();
+	acpi_int340x_thermal_init();
 
 	mutex_lock(&acpi_scan_lock);
 	/*
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 693208e..2ff7416 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -234,6 +234,23 @@ config INTEL_SOC_DTS_THERMAL
 	  notification methods.The other trip is a critical trip point, which
 	  was set by the driver based on the TJ MAX temperature.
 
+config INT340X_THERMAL
+	bool
+	depends on X86 && ACPI
+	help
+	  Newer laptops and tablets that use ACPI may have thermal sensors and
+	  other devices with thermal control capabilities outside the core
+	  CPU/SOC, for thermal safety reasons.
+	  They are exposed for the OS to use via the INT3400 ACPI device object
+	  as the master, and INT3401~INT340B ACPI device objects as the slaves.
+	  Enable this to expose the temperature information and cooling ability
+	  from these objects to userspace via the normal thermal framework.
+	  This means that a wide range of applications and GUI widgets can show
+	  the information to the user or use this information for making
+	  decisions. For example, the Intel Thermal Daemon can use this
+	  information to allow the user to select his laptop to run without
+	  turning on the fans.
+
 menu "Texas Instruments thermal drivers"
 source "drivers/thermal/ti-soc-thermal/Kconfig"
 endmenu
-- 
1.8.3.2

