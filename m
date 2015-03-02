From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] Thermal/int340x/processor_thermal: Enable auxiliary DTS for Braswell
Date: Mon,  2 Mar 2015 13:13:00 -0800
Message-ID: <1425330780-18957-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1425330780-18957-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17025 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbbCBVOT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Mar 2015 16:14:19 -0500
In-Reply-To: <1425330780-18957-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Support two auxiliary DTS present on Braswell platform using side band
IOSF interface. This supports two read write trips, which can be used
to get notification on trip violation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/Kconfig                            |  1 +
 .../int340x_thermal/processor_thermal_device.c     | 55 +++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 210e170..5692237 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -278,6 +278,7 @@ config INT340X_THERMAL
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
+	select INTEL_SOC_DTS_IOSF_CORE
 	help
 	  Newer laptops and tablets that use ACPI may have thermal sensors and
 	  other devices with thermal control capabilities outside the core
diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 5e8d8e9..e9f1b72 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -16,10 +16,12 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/thermal.h>
 #include "int340x_thermal_zone.h"
+#include "../intel_soc_dts_iosf.h"
 
 /* Broadwell-U/HSB thermal reporting device */
 #define PCI_DEVICE_ID_PROC_BDW_THERMAL	0x1603
@@ -42,6 +44,7 @@ struct proc_thermal_device {
 	struct acpi_device *adev;
 	struct power_config power_limits[2];
 	struct int34x_thermal_zone *int340x_zone;
+	struct intel_soc_dts_sensors *soc_dts;
 };
 
 enum proc_thermal_emum_mode_type {
@@ -308,6 +311,18 @@ static int int3401_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static irqreturn_t proc_thermal_pci_msi_irq(int irq, void *devid)
+{
+	struct proc_thermal_device *proc_priv;
+	struct pci_dev *pdev = devid;
+
+	proc_priv = pci_get_drvdata(pdev);
+
+	intel_soc_dts_iosf_interrupt_handler(proc_priv->soc_dts);
+
+	return IRQ_HANDLED;
+}
+
 static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *unused)
 {
@@ -334,12 +349,50 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, proc_priv);
 	proc_thermal_emum_mode = PROC_THERMAL_PCI;
 
+	if (pdev->device == PCI_DEVICE_ID_PROC_BSW_THERMAL) {
+		/*
+		 * Enumerate additional DTS sensors available via IOSF.
+		 * But we are not treating as a failure condition, if
+		 * there are no aux DTSs enabled or fails. This driver
+		 * already exposes sensors, which can be accessed via
+		 * ACPI/MSR. So we don't want to fail for auxiliary DTSs.
+		 */
+		proc_priv->soc_dts = intel_soc_dts_iosf_init(
+					INTEL_SOC_DTS_INTERRUPT_MSI, 2, 0);
+
+		if (proc_priv->soc_dts && pdev->irq) {
+			ret = pci_enable_msi(pdev);
+			if (!ret) {
+				ret = request_threaded_irq(pdev->irq, NULL,
+						proc_thermal_pci_msi_irq,
+						IRQF_ONESHOT, "proc_thermal",
+						pdev);
+				if (ret) {
+					intel_soc_dts_iosf_exit(
+							proc_priv->soc_dts);
+					pci_disable_msi(pdev);
+					proc_priv->soc_dts = NULL;
+				}
+			}
+		} else
+			dev_err(&pdev->dev, "No auxiliary DTSs enabled\n");
+	}
+
 	return 0;
 }
 
 static void  proc_thermal_pci_remove(struct pci_dev *pdev)
 {
-	proc_thermal_remove(pci_get_drvdata(pdev));
+	struct proc_thermal_device *proc_priv = pci_get_drvdata(pdev);
+
+	if (proc_priv->soc_dts) {
+		intel_soc_dts_iosf_exit(proc_priv->soc_dts);
+		if (pdev->irq) {
+			free_irq(pdev->irq, pdev);
+			pci_disable_msi(pdev);
+		}
+	}
+	proc_thermal_remove(proc_priv);
 	pci_disable_device(pdev);
 }
 
-- 
1.9.3

