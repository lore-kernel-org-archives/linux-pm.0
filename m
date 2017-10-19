From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] thermal: int340x: processor_thermal: Add Coffee Lake support
Date: Thu, 19 Oct 2017 14:51:33 -0700
Message-ID: <1508449894-58797-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1508449894-58797-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29819 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753816AbdJSVvq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Oct 2017 17:51:46 -0400
In-Reply-To: <1508449894-58797-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Add new PCI id for Coffee lake processor thermal device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/processor_thermal_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index e724a23..1d9f524 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -32,6 +32,7 @@
 
 /* CannonLake thermal reporting device */
 #define PCI_DEVICE_ID_PROC_CNL_THERMAL	0x5a03
+#define PCI_DEVICE_ID_PROC_CFL_THERMAL	0x3E83
 
 /* Braswell thermal reporting device */
 #define PCI_DEVICE_ID_PROC_BSW_THERMAL	0x22DC
-- 
2.7.5
