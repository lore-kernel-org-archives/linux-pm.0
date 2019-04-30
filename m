From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] drivers: thermal: processor_thermal: Read PPCC on resume
Date: Mon, 29 Apr 2019 20:47:43 -0700
Message-ID: <20190430034743.43576-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Read PPCC power limits on system resume in case those limits changed
while system was suspended.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_device.c     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 436c256f111d..acb22157b9ac 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -465,6 +465,18 @@ static void  proc_thermal_pci_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static int proc_thermal_resume(struct device *dev)
+{
+	struct proc_thermal_device *proc_dev;
+
+	proc_dev = dev_get_drvdata(dev);
+	proc_thermal_read_ppcc(proc_dev);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(proc_thermal_pm, NULL, proc_thermal_resume);
+
 static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BDW_THERMAL)},
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_HSB_THERMAL)},
@@ -489,6 +501,7 @@ static struct pci_driver proc_thermal_pci_driver = {
 	.probe		= proc_thermal_pci_probe,
 	.remove		= proc_thermal_pci_remove,
 	.id_table	= proc_thermal_pci_ids,
+	.driver.pm	= &proc_thermal_pm,
 };
 
 static const struct acpi_device_id int3401_device_ids[] = {
@@ -503,6 +516,7 @@ static struct platform_driver int3401_driver = {
 	.driver = {
 		.name = "int3401 thermal",
 		.acpi_match_table = int3401_device_ids,
+		.pm = &proc_thermal_pm,
 	},
 };
 
-- 
2.17.2
