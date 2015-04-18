From: Brian Bian <brian.bian@intel.com>
Subject: [PATCH] int340x_thermal/processor_thermal_device: add support to Skylake processors
Date: Fri, 17 Apr 2015 17:58:11 -0700
Message-ID: <1429318691-5666-1-git-send-email-brian.bian@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:24022 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbbDRBDu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Apr 2015 21:03:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com
Cc: linux-pm@vger.kernel.org, Brian Bian <brian.bian@intel.com>

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

