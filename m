From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/8] PCI / PCIe: Ask BIOS for control of all
	native services at once (v6)
Date: Mon, 2 Aug 2010 23:56:30 +0200
Message-ID: <201008022356.31166.rjw__29777.6288389743$1280788380$gmane$org@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008022351.31406.rjw@sisk.pl>
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
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

PCIe port service drivers ask the BIOS, through _OSC, for control of
the services they handle.  Unfortunately, each of them individually
asks for control of the PCIe capability structure and if that is
granted, some BIOSes expect that the other PCIe port services will be
configured and handled by the kernel as well.  If that is not the
case (eg. one of the PCIe port service drivers is not loaded), the
BIOS may be confused and may cause the system as a whole to misbehave
(eg. on one of such systems enabling the native PCIe PME service
without loading the native PCIe hot-plug service driver causes a
storm of ACPI notify requests to appear).

For this reason rework the PCIe port driver so that (1) it checks
which native PCIe port services can be enabled, according to the
BIOS, and (2) it requests control of all these services
simultaneously.  In particular, this causes pcie_portdrv_probe() to
fail if the BIOS refuses to grant control of the PCIe capability
structure, which means that no native PCIe port services can be
enabled for the PCIe root complex the given port belongs to.

Make it possible to override this behavior using 'pcie_ports=native'
(use the PCIe native services regardless of the BIOS response to the
control request), or 'pcie_ports=compat' (do not use the PCIe native
services at all).

Accordingly, rework the existing PCIe port service drivers so that
they don't request control of the services directly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/kernel-parameters.txt  |   13 ++---
 drivers/pci/hotplug/acpi_pcihp.c     |    4 -
 drivers/pci/hotplug/pciehp.h         |   12 ----
 drivers/pci/hotplug/pciehp_acpi.c    |    4 -
 drivers/pci/hotplug/pciehp_core.c    |    4 -
 drivers/pci/pcie/Makefile            |    3 -
 drivers/pci/pcie/aer/aerdrv_acpi.c   |   36 --------------
 drivers/pci/pcie/aer/aerdrv_core.c   |   14 -----
 drivers/pci/pcie/pme/Makefile        |    8 ---
 drivers/pci/pcie/pme/pcie_pme.c      |   64 ++-----------------------
 drivers/pci/pcie/pme/pcie_pme.h      |   28 -----------
 drivers/pci/pcie/pme/pcie_pme_acpi.c |   54 ---------------------
 drivers/pci/pcie/portdrv.h           |   20 ++++++++
 drivers/pci/pcie/portdrv_acpi.c      |   87 +++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv_core.c      |   22 +++++++-
 drivers/pci/pcie/portdrv_pci.c       |   15 +++++-
 16 files changed, 158 insertions(+), 230 deletions(-)

Index: linux-2.6/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-2.6/drivers/pci/pcie/portdrv_pci.c
@@ -32,10 +32,23 @@ MODULE_LICENSE("GPL");
 /* If this switch is set, PCIe port native services should not be enabled. */
 bool pcie_ports_disabled;
 
+/*
+ * If this switch is set, ACPI _OSC will be used to determine whether or not to
+ * enable PCIe port native services.
+ */
+bool pcie_ports_auto = true;
+
 static int __init pcie_port_setup(char *str)
 {
-	if (!strncmp(str, "compat", 6))
+	if (!strncmp(str, "compat", 6)) {
 		pcie_ports_disabled = true;
+	} else if (!strncmp(str, "native", 6)) {
+		pcie_ports_disabled = false;
+		pcie_ports_auto = false;
+	} else if (!strncmp(str, "auto", 4)) {
+		pcie_ports_disabled = false;
+		pcie_ports_auto = true;
+	}
 
 	return 1;
 }
Index: linux-2.6/drivers/pci/pcie/portdrv_acpi.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/pci/pcie/portdrv_acpi.c
@@ -0,0 +1,87 @@
+/*
+ * PCIe Port Native Services Support, ACPI-Related Part
+ *
+ * Copyright (C) 2010 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License V2.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/acpi.h>
+#include <linux/pci-acpi.h>
+#include <linux/pcieport_if.h>
+
+#include "aer/aerdrv.h"
+#include "../pci.h"
+
+/**
+ * pcie_port_acpi_setup - Request the BIOS to release control of PCIe services.
+ * @port: PCIe Port service for a root port or event collector.
+ * @srv_mask: Bit mask of services that can be enabled for @port.
+ *
+ * Invoked when @port is identified as a PCIe port device.  To avoid conflicts
+ * with the BIOS PCIe port native services support requires the BIOS to yield
+ * control of these services to the kernel.  The mask of services that the BIOS
+ * allows to be enabled for @port is written to @srv_mask.
+ *
+ * NOTE: It turns out that we cannot do that for individual port services
+ * separately, because that would make some systems work incorrectly.
+ */
+int pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
+{
+	acpi_status status;
+	acpi_handle handle;
+	u32 flags;
+
+	if (acpi_pci_disabled)
+		return 0;
+
+	handle = acpi_find_root_bridge_handle(port);
+	if (!handle)
+		return -EINVAL;
+
+	flags = OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
+		| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
+		| OSC_PCI_EXPRESS_PME_CONTROL;
+
+	if (pcie_aer_get_firmware_first(port))
+		dev_dbg(&port->dev, "PCIe errors handled by BIOS.\n");
+	else if (pci_aer_available())
+		flags |= OSC_PCI_EXPRESS_AER_CONTROL;
+
+	status = acpi_pci_osc_control_query(handle, &flags);
+	if (ACPI_FAILURE(status)) {
+		dev_dbg(&port->dev, "ACPI _OSC query failed (code %d)\n",
+			status);
+		return -ENODEV;
+	}
+
+	if (!(flags & OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)) {
+		dev_dbg(&port->dev, "BIOS refuses to grant control of PCIe "
+			"Capability Structure\n");
+		return -EACCES;
+	}
+
+	status = acpi_pci_osc_control_set(handle, flags);
+	if (ACPI_FAILURE(status)) {
+		dev_dbg(&port->dev, "ACPI _OSC request failed (code %d)\n",
+			status);
+		return -ENODEV;
+	}
+
+	dev_info(&port->dev, "ACPI _OSC control granted for 0x%02x\n", flags);
+
+	*srv_mask = PCIE_PORT_SERVICE_VC;
+	if (flags & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL)
+		*srv_mask |= PCIE_PORT_SERVICE_HP;
+	if (flags & OSC_PCI_EXPRESS_PME_CONTROL)
+		*srv_mask |= PCIE_PORT_SERVICE_PME;
+	if (flags & OSC_PCI_EXPRESS_AER_CONTROL)
+		*srv_mask |= PCIE_PORT_SERVICE_AER;
+
+	return 0;
+}
Index: linux-2.6/drivers/pci/pcie/portdrv.h
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv.h
+++ linux-2.6/drivers/pci/pcie/portdrv.h
@@ -21,6 +21,7 @@
 #define get_descriptor_id(type, service) (((type - 4) << 4) | service)
 
 extern bool pcie_ports_disabled;
+extern bool pcie_ports_auto;
 
 extern struct bus_type pcie_port_bus_type;
 extern int pcie_port_device_register(struct pci_dev *dev);
@@ -32,6 +33,8 @@ extern void pcie_port_device_remove(stru
 extern int __must_check pcie_port_bus_register(void);
 extern void pcie_port_bus_unregister(void);
 
+struct pci_dev;
+
 #ifdef CONFIG_PCIE_PME
 extern bool pcie_pme_msi_disabled;
 
@@ -44,9 +47,26 @@ static inline bool pcie_pme_no_msi(void)
 {
 	return pcie_pme_msi_disabled;
 }
+
+extern void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable);
 #else /* !CONFIG_PCIE_PME */
 static inline void pcie_pme_disable_msi(void) {}
 static inline bool pcie_pme_no_msi(void) { return false; }
+static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
+#ifdef CONFIG_ACPI
+extern int pcie_port_acpi_setup(struct pci_dev *port, int *mask);
+
+static inline int pcie_port_platform_notify(struct pci_dev *port, int *mask)
+{
+	return pcie_port_acpi_setup(port, mask);
+}
+#else /* !CONFIG_ACPI */
+static inline int pcie_port_platform_notify(struct pci_dev *port, int *mask)
+{
+	return 0;
+}
+#endif /* !CONFIG_ACPI */
+
 #endif /* _PORTDRV_H_ */
Index: linux-2.6/drivers/pci/pcie/Makefile
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/Makefile
+++ linux-2.6/drivers/pci/pcie/Makefile
@@ -6,10 +6,11 @@
 obj-$(CONFIG_PCIEASPM)		+= aspm.o
 
 pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
+pcieportdrv-$(CONFIG_ACPI)	+= portdrv_acpi.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
 # Build PCI Express AER if needed
 obj-$(CONFIG_PCIEAER)		+= aer/
 
-obj-$(CONFIG_PCIE_PME) += pme/
+obj-$(CONFIG_PCIE_PME) += pme/pcie_pme.o
Index: linux-2.6/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2.6/drivers/pci/pcie/portdrv_core.c
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/pcieport_if.h>
+#include <linux/aer.h>
 
 #include "../pci.h"
 #include "portdrv.h"
@@ -236,23 +237,38 @@ static int get_port_device_capability(st
 	int services = 0, pos;
 	u16 reg16;
 	u32 reg32;
+	int cap_mask;
+	int err;
+
+	err = pcie_port_platform_notify(dev, &cap_mask);
+	if (pcie_ports_auto) {
+		if (err)
+			return 0;
+	} else {
+		cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP
+				| PCIE_PORT_SERVICE_VC;
+		if (pci_aer_available())
+			cap_mask |= PCIE_PORT_SERVICE_AER;
+	}
 
 	pos = pci_pcie_cap(dev);
 	pci_read_config_word(dev, pos + PCI_EXP_FLAGS, &reg16);
 	/* Hot-Plug Capable */
-	if (reg16 & PCI_EXP_FLAGS_SLOT) {
+	if ((cap_mask & PCIE_PORT_SERVICE_HP) && (reg16 & PCI_EXP_FLAGS_SLOT)) {
 		pci_read_config_dword(dev, pos + PCI_EXP_SLTCAP, &reg32);
 		if (reg32 & PCI_EXP_SLTCAP_HPC)
 			services |= PCIE_PORT_SERVICE_HP;
 	}
 	/* AER capable */
-	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR))
+	if ((cap_mask & PCIE_PORT_SERVICE_AER)
+	    && pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR))
 		services |= PCIE_PORT_SERVICE_AER;
 	/* VC support */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VC))
 		services |= PCIE_PORT_SERVICE_VC;
 	/* Root ports are capable of generating PME too */
-	if (dev->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
+	if ((cap_mask & PCIE_PORT_SERVICE_PME)
+	    && dev->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
 		services |= PCIE_PORT_SERVICE_PME;
 
 	return services;
Index: linux-2.6/drivers/pci/pcie/pme/pcie_pme.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/pme/pcie_pme.c
+++ linux-2.6/drivers/pci/pcie/pme/pcie_pme.c
@@ -24,37 +24,12 @@
 #include <linux/pm_runtime.h>
 
 #include "../../pci.h"
-#include "pcie_pme.h"
+#include "../portdrv.h"
 
 #define PCI_EXP_RTSTA_PME	0x10000 /* PME status */
 #define PCI_EXP_RTSTA_PENDING	0x20000 /* PME pending */
 
 /*
- * If set, this switch will prevent the PCIe root port PME service driver from
- * being registered.  Consequently, the interrupt-based PCIe PME signaling will
- * not be used by any PCIe root ports in that case.
- */
-static bool pcie_pme_disabled = true;
-
-/*
- * The PCI Express Base Specification 2.0, Section 6.1.8, states the following:
- * "In order to maintain compatibility with non-PCI Express-aware system
- * software, system power management logic must be configured by firmware to use
- * the legacy mechanism of signaling PME by default.  PCI Express-aware system
- * software must notify the firmware prior to enabling native, interrupt-based
- * PME signaling."  However, if the platform doesn't provide us with a suitable
- * notification mechanism or the notification fails, it is not clear whether or
- * not we are supposed to use the interrupt-based PCIe PME signaling.  The
- * switch below can be used to indicate the desired behaviour.  When set, it
- * will make the kernel use the interrupt-based PCIe PME signaling regardless of
- * the platform notification status, although the kernel will attempt to notify
- * the platform anyway.  When unset, it will prevent the kernel from using the
- * the interrupt-based PCIe PME signaling if the platform notification fails,
- * which is the default.
- */
-static bool pcie_pme_force_enable;
-
-/*
  * If this switch is set, MSI will not be used for PCIe PME signaling.  This
  * causes the PCIe port driver to use INTx interrupts only, but it turns out
  * that using MSI for PCIe PME signaling doesn't play well with PCIe PME-based
@@ -64,38 +39,13 @@ bool pcie_pme_msi_disabled;
 
 static int __init pcie_pme_setup(char *str)
 {
-	if (!strncmp(str, "auto", 4))
-		pcie_pme_disabled = false;
-	else if (!strncmp(str, "force", 5))
-		pcie_pme_force_enable = true;
-
-	str = strchr(str, ',');
-	if (str) {
-		str++;
-		str += strspn(str, " \t");
-		if (*str && !strcmp(str, "nomsi"))
-			pcie_pme_msi_disabled = true;
-	}
+	if (!strncmp(str, "nomsi", 5))
+		pcie_pme_msi_disabled = true;
 
 	return 1;
 }
 __setup("pcie_pme=", pcie_pme_setup);
 
-/**
- * pcie_pme_platform_setup - Ensure that the kernel controls the PCIe PME.
- * @srv: PCIe PME root port service to use for carrying out the check.
- *
- * Notify the platform that the native PCIe PME is going to be used and return
- * 'true' if the control of the PCIe PME registers has been acquired from the
- * platform.
- */
-static bool pcie_pme_platform_setup(struct pcie_device *srv)
-{
-	if (!pcie_pme_platform_notify(srv))
-		return true;
-	return pcie_pme_force_enable;
-}
-
 struct pcie_pme_service_data {
 	spinlock_t lock;
 	struct pcie_device *srv;
@@ -108,7 +58,7 @@ struct pcie_pme_service_data {
  * @dev: PCIe root port or event collector.
  * @enable: Enable or disable the interrupt.
  */
-static void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable)
+void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable)
 {
 	int rtctl_pos;
 	u16 rtctl;
@@ -417,9 +367,6 @@ static int pcie_pme_probe(struct pcie_de
 	struct pcie_pme_service_data *data;
 	int ret;
 
-	if (!pcie_pme_platform_setup(srv))
-		return -EACCES;
-
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -509,8 +456,7 @@ static struct pcie_port_service_driver p
  */
 static int __init pcie_pme_service_init(void)
 {
-	return pcie_pme_disabled ?
-		-ENODEV : pcie_port_service_register(&pcie_pme_driver);
+	return pcie_port_service_register(&pcie_pme_driver);
 }
 
 module_init(pcie_pme_service_init);
Index: linux-2.6/drivers/pci/pcie/pme/pcie_pme.h
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/pme/pcie_pme.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * drivers/pci/pcie/pme/pcie_pme.h
- *
- * PCI Express Root Port PME signaling support
- *
- * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
- */
-
-#ifndef _PCIE_PME_H_
-#define _PCIE_PME_H_
-
-struct pcie_device;
-
-#ifdef CONFIG_ACPI
-extern int pcie_pme_acpi_setup(struct pcie_device *srv);
-
-static inline int pcie_pme_platform_notify(struct pcie_device *srv)
-{
-	return pcie_pme_acpi_setup(srv);
-}
-#else /* !CONFIG_ACPI */
-static inline int pcie_pme_platform_notify(struct pcie_device *srv)
-{
-	return 0;
-}
-#endif /* !CONFIG_ACPI */
-
-#endif
Index: linux-2.6/drivers/pci/pcie/pme/pcie_pme_acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/pme/pcie_pme_acpi.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * PCIe Native PME support, ACPI-related part
- *
- * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License V2.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/acpi.h>
-#include <linux/pci-acpi.h>
-#include <linux/pcieport_if.h>
-
-/**
- * pcie_pme_acpi_setup - Request the ACPI BIOS to release control over PCIe PME.
- * @srv - PCIe PME service for a root port or event collector.
- *
- * Invoked when the PCIe bus type loads PCIe PME service driver.  To avoid
- * conflict with the BIOS PCIe support requires the BIOS to yield PCIe PME
- * control to the kernel.
- */
-int pcie_pme_acpi_setup(struct pcie_device *srv)
-{
-	acpi_status status = AE_NOT_FOUND;
-	struct pci_dev *port = srv->port;
-	acpi_handle handle;
-	int error = 0;
-
-	if (acpi_pci_disabled)
-		return -ENOSYS;
-
-	dev_info(&port->dev, "Requesting control of PCIe PME from ACPI BIOS\n");
-
-	handle = acpi_find_root_bridge_handle(port);
-	if (!handle)
-		return -EINVAL;
-
-	status = acpi_pci_osc_control_set(handle,
-			OSC_PCI_EXPRESS_PME_CONTROL |
-			OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
-	if (ACPI_FAILURE(status)) {
-		dev_info(&port->dev,
-			"Failed to receive control of PCIe PME service: %s\n",
-			(status == AE_SUPPORT || status == AE_NOT_FOUND) ?
-			"no _OSC support" : "ACPI _OSC failed");
-		error = -ENODEV;
-	}
-
-	return error;
-}
Index: linux-2.6/drivers/pci/pcie/pme/Makefile
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/pme/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-#
-# Makefile for PCI-Express Root Port PME signaling driver
-#
-
-obj-$(CONFIG_PCIE_PME) += pmedriver.o
-
-pmedriver-objs := pcie_pme.o
-pmedriver-$(CONFIG_ACPI) += pcie_pme_acpi.o
Index: linux-2.6/drivers/pci/pcie/aer/aerdrv_acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ linux-2.6/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -19,42 +19,6 @@
 #include <acpi/apei.h>
 #include "aerdrv.h"
 
-/**
- * aer_osc_setup - run ACPI _OSC method
- * @pciedev: pcie_device which AER is being enabled on
- *
- * @return: Zero on success. Nonzero otherwise.
- *
- * Invoked when PCIe bus loads AER service driver. To avoid conflict with
- * BIOS AER support requires BIOS to yield AER control to OS native driver.
- **/
-int aer_osc_setup(struct pcie_device *pciedev)
-{
-	acpi_status status = AE_NOT_FOUND;
-	struct pci_dev *pdev = pciedev->port;
-	acpi_handle handle = NULL;
-
-	if (acpi_pci_disabled)
-		return -1;
-
-	handle = acpi_find_root_bridge_handle(pdev);
-	if (handle) {
-		status = acpi_pci_osc_control_set(handle,
-					OSC_PCI_EXPRESS_AER_CONTROL |
-					OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
-	}
-
-	if (ACPI_FAILURE(status)) {
-		dev_printk(KERN_DEBUG, &pciedev->device, "AER service couldn't "
-			   "init device: %s\n",
-			   (status == AE_SUPPORT || status == AE_NOT_FOUND) ?
-			   "no _OSC support" : "_OSC failed");
-		return -1;
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_ACPI_APEI
 static inline int hest_match_pci(struct acpi_hest_aer_common *p,
 				 struct pci_dev *pci)
Index: linux-2.6/drivers/pci/pcie/aer/aerdrv_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/aer/aerdrv_core.c
+++ linux-2.6/drivers/pci/pcie/aer/aerdrv_core.c
@@ -771,22 +771,10 @@ void aer_isr(struct work_struct *work)
  */
 int aer_init(struct pcie_device *dev)
 {
-	if (pcie_aer_get_firmware_first(dev->port)) {
-		dev_printk(KERN_DEBUG, &dev->device,
-			   "PCIe errors handled by platform firmware.\n");
-		goto out;
-	}
-
-	if (aer_osc_setup(dev))
-		goto out;
-
-	return 0;
-out:
 	if (forceload) {
 		dev_printk(KERN_DEBUG, &dev->device,
 			   "aerdrv forceload requested.\n");
 		pcie_aer_force_firmware_first(dev->port, 0);
-		return 0;
 	}
-	return -ENXIO;
+	return 0;
 }
Index: linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/acpi_pcihp.c
+++ linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
@@ -338,9 +338,7 @@ int acpi_get_hp_hw_control_from_firmware
 	acpi_handle chandle, handle;
 	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	flags &= (OSC_PCI_EXPRESS_NATIVE_HP_CONTROL |
-		  OSC_SHPC_NATIVE_HP_CONTROL |
-		  OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+	flags &= OSC_SHPC_NATIVE_HP_CONTROL;
 	if (!flags) {
 		err("Invalid flags %u specified!\n", flags);
 		return -EINVAL;
Index: linux-2.6/drivers/pci/hotplug/pciehp.h
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp.h
+++ linux-2.6/drivers/pci/hotplug/pciehp.h
@@ -176,19 +176,7 @@ static inline void pciehp_firmware_init(
 {
 	pciehp_acpi_slot_detection_init();
 }
-
-static inline int pciehp_get_hp_hw_control_from_firmware(struct pci_dev *dev)
-{
-	int retval;
-	u32 flags = (OSC_PCI_EXPRESS_NATIVE_HP_CONTROL |
-		     OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
-	retval = acpi_get_hp_hw_control_from_firmware(dev, flags);
-	if (retval)
-		return retval;
-	return pciehp_acpi_slot_detection_check(dev);
-}
 #else
 #define pciehp_firmware_init()				do {} while (0)
-#define pciehp_get_hp_hw_control_from_firmware(dev) 	0
 #endif 				/* CONFIG_ACPI */
 #endif				/* _PCIEHP_H */
Index: linux-2.6/drivers/pci/hotplug/pciehp_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_core.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_core.c
@@ -59,7 +59,7 @@ module_param(pciehp_force, bool, 0644);
 MODULE_PARM_DESC(pciehp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
-MODULE_PARM_DESC(pciehp_force, "Force pciehp, even if _OSC and OSHP are missing");
+MODULE_PARM_DESC(pciehp_force, "Force pciehp, even if OSHP is missing");
 
 #define PCIE_MODULE_NAME "pciehp"
 
@@ -235,7 +235,7 @@ static int pciehp_probe(struct pcie_devi
 		dev_info(&dev->device,
 			 "Bypassing BIOS check for pciehp use on %s\n",
 			 pci_name(dev->port));
-	else if (pciehp_get_hp_hw_control_from_firmware(dev->port))
+	else if (pciehp_acpi_slot_detection_check(dev->port))
 		goto err_out_none;
 
 	ctrl = pcie_init(dev);
Index: linux-2.6/drivers/pci/hotplug/pciehp_acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_acpi.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_acpi.c
@@ -85,9 +85,7 @@ static int __init dummy_probe(struct pci
 	acpi_handle handle;
 	struct dummy_slot *slot, *tmp;
 	struct pci_dev *pdev = dev->port;
-	/* Note: pciehp_detect_mode != PCIEHP_DETECT_ACPI here */
-	if (pciehp_get_hp_hw_control_from_firmware(pdev))
-		return -ENODEV;
+
 	pos = pci_pcie_cap(pdev);
 	if (!pos)
 		return -ENODEV;
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -2048,18 +2048,17 @@ and is between 256 and 4096 characters. 
 			WARNING: Forcing ASPM on may cause system lockups.
 
 	pcie_ports=	[PCIE] PCIe ports handling:
+		auto	Ask the BIOS whether or not to use native PCIe services
+			associated with PCIe ports (PME, hot-plug, AER).  Use
+			them only if that is allowed by the BIOS.
+		native	Use native PCIe services associated with PCIe ports
+			unconditionally.
 		compat	Treat PCIe ports as PCI-to-PCI bridges, disable the PCIe
 			ports driver.
 
 	pcie_pme=	[PCIE,PM] Native PCIe PME signaling options:
-			Format: {auto|force}[,nomsi]
-		auto	Use native PCIe PME signaling if the BIOS allows the
-			kernel to control PCIe config registers of root ports.
-		force	Use native PCIe PME signaling even if the BIOS refuses
-			to allow the kernel to control the relevant PCIe config
-			registers.
 		nomsi	Do not use MSI for native PCIe PME signaling (this makes
-			all PCIe root ports use INTx for everything).
+			all PCIe root ports use INTx for all services).
 
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
