From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] ACPI/int340x_thermal: enumerate INT3401 for Intel SoC DTS thermal driver
Date: Sun,  4 Jan 2015 14:24:24 +0800
Message-ID: <1420352664-20808-2-git-send-email-rui.zhang@intel.com>
References: <1420352664-20808-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30848 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbbADGYs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 4 Jan 2015 01:24:48 -0500
In-Reply-To: <1420352664-20808-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com

Intel SoC DTS thermal driver on Baytrail platform uses IRQ 86 for
critical overheating notification.
But this IRQ 86 is described in the _CRS control method of INT3401 device,
thus we should enumerate INT3401 to set the IRQ descriptor when
Intel SoC DTS thermal driver is built.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/int340x_thermal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/int340x_thermal.c b/drivers/acpi/int340x_thermal.c
index dc3553d..9dcf836 100644
--- a/drivers/acpi/int340x_thermal.c
+++ b/drivers/acpi/int340x_thermal.c
@@ -14,9 +14,10 @@
 
 #include "internal.h"
 
+#define INT3401_DEVICE 0X01
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT3400"},
-	{"INT3401"},
+	{"INT3401", INT3401_DEVICE},
 	{"INT3402"},
 	{"INT3403"},
 	{"INT3404"},
@@ -34,6 +35,10 @@ static int int340x_thermal_handler_attach(struct acpi_device *adev,
 {
 #if defined(CONFIG_INT340X_THERMAL) || defined(CONFIG_INT340X_THERMAL_MODULE)
 	acpi_create_platform_device(adev);
+#elif defined(INTEL_SOC_DTS_THERMAL) || defined(INTEL_SOC_DTS_THERMAL_MODULE)
+	/* Intel SoC DTS thermal driver needs INT3401 to set IRQ descriptor */
+	if (id->driver_data == INT3401_DEVICE)
+		acpi_create_platform_device(adev);
 #endif
 	return 1;
 }
-- 
1.9.1

