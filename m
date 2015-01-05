From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] int340x_thermal/processor_thermal_device: return failure
 when there is no ACPI device object
Date: Mon, 05 Jan 2015 09:20:47 +0800
Message-ID: <1420420847.32092.1.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5088 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773AbbAEBUv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 4 Jan 2015 20:20:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

>From cd4c9293694090b02d305f2e3364618752e07693 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Sun, 4 Jan 2015 16:35:59 +0800
Subject: [PATCH] int340x_thermal/processor_thermal_device: return failure when
 there is no ACPI device object

processor_thermal_device driver needs ACPI support to work. Thus, the driver
probing should fail when there is no ACPI device object asscociated.

This fixes a NULL pointer dereference when the driver is loaded
with INT340X feature disabled in BIOS.

Reported-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/thermal/int340x_thermal/processor_thermal_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 31bb553..0fe5dbb 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -130,6 +130,8 @@ static int proc_thermal_add(struct device *dev,
 	int ret;
 
 	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
 
 	status = acpi_evaluate_object(adev->handle, "PPCC", NULL, &buf);
 	if (ACPI_FAILURE(status))
-- 
1.9.1



