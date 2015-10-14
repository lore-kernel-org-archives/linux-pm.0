From: amy.l.wiles@intel.com
Subject: [PATCH 1/2] Enabled Broxton SoC thermal reporting device
Date: Wed, 14 Oct 2015 08:09:14 -0700
Message-ID: <1444835355-26582-3-git-send-email-amy.l.wiles@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36840 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbbJNWNT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 18:13:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, srinivas.pandruvada@intel.com, linux-pm@vger.kernel.org
Cc: Amy Wiles <amy.l.wiles@intel.com>

From: Amy Wiles <amy.l.wiles@intel.com>

Signed-off-by: Amy Wiles <amy.l.wiles@intel.com>
---
 drivers/thermal/int340x_thermal/processor_thermal_device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index ccc0ad0..36fa724 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -33,6 +33,12 @@
 /* Braswell thermal reporting device */
 #define PCI_DEVICE_ID_PROC_BSW_THERMAL	0x22DC
 
+/* Broxton thermal reporting device */
+#define PCI_DEVICE_ID_PROC_BXT0_THERMAL  0x0A8C
+#define PCI_DEVICE_ID_PROC_BXT1_THERMAL  0x1A8C
+#define PCI_DEVICE_ID_PROC_BXTX_THERMAL  0x4A8C
+#define PCI_DEVICE_ID_PROC_BXTP_THERMAL  0x5A8C
+
 struct power_config {
 	u32	index;
 	u32	min_uw;
@@ -404,6 +410,10 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_HSB_THERMAL)},
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_SKL_THERMAL)},
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BSW_THERMAL)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXT0_THERMAL)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXT1_THERMAL)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXTX_THERMAL)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXTP_THERMAL)},
 	{ 0, },
 };
 
-- 
1.9.1

