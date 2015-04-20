From: Brian Bian <brian.bian@intel.com>
Subject: [PATCH v1] int340x_thermal/processor_thermal_device: add support to Skylake processors
Date: Mon, 20 Apr 2015 11:25:37 -0700
Message-ID: <1429554337-32493-1-git-send-email-brian.bian@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38288 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbbDTSaL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Apr 2015 14:30:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Brian Bian <brian.bian@intel.com>

Add PCI ID of Skylake thermal reporting device.

Signed-off-by: Brian Bian <brian.bian@intel.com>
---
 drivers/thermal/int340x_thermal/processor_thermal_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 5e8d8e9..cdfff52 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -25,6 +25,9 @@
 #define PCI_DEVICE_ID_PROC_BDW_THERMAL	0x1603
 #define PCI_DEVICE_ID_PROC_HSB_THERMAL	0x0A03
 
+/* Skylake thermal reporting device */
+#define PCI_DEVICE_ID_PROC_SKL_THERMAL	0x1903
+
 /* Braswell thermal reporting device */
 #define PCI_DEVICE_ID_PROC_BSW_THERMAL	0x22DC
 
@@ -346,6 +349,7 @@ static void  proc_thermal_pci_remove(struct pci_dev *pdev)
 static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BDW_THERMAL)},
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_HSB_THERMAL)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_SKL_THERMAL)},
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BSW_THERMAL)},
 	{ 0, },
 };
-- 
1.9.1

