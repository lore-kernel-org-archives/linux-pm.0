From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] thermal: int340x: processor_thermal: Add Cannon Lake support
Date: Thu, 19 Oct 2017 14:51:32 -0700
Message-ID: <1508449894-58797-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1508449894-58797-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58477 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753733AbdJSVvq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Oct 2017 17:51:46 -0400
In-Reply-To: <1508449894-58797-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added PCI-ID of Cannon Lake thermal device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/processor_thermal_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index f02341f..e724a23 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -30,6 +30,9 @@
 /* Skylake thermal reporting device */
 #define PCI_DEVICE_ID_PROC_SKL_THERMAL	0x1903
 
+/* CannonLake thermal reporting device */
+#define PCI_DEVICE_ID_PROC_CNL_THERMAL	0x5a03
+
 /* Braswell thermal reporting device */
 #define PCI_DEVICE_ID_PROC_BSW_THERMAL	0x22DC
 
@@ -461,6 +464,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXT1_THERMAL)},
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXTX_THERMAL)},
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXTP_THERMAL)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_CNL_THERMAL)},
 	{ 0, },
 };
 
-- 
2.7.5
