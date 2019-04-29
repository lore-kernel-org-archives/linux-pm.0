From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] thermal: broadcom: Remove ACPI support
Date: Mon, 29 Apr 2019 22:25:29 +0530
Message-ID: <1556556929-25704-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: linux-pm@vger.kernel.org

Unlike DT framework, thermal-zones and its parameters can't be parsed
using ACPI framework. So that ACPI support is removed in this driver.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reported-by: David Woodhouse <dwmw2@infradead.org>
---
 drivers/thermal/broadcom/sr-thermal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
index 2284cbe..475ce29 100644
--- a/drivers/thermal/broadcom/sr-thermal.c
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Broadcom
  */
 
-#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -100,18 +99,11 @@ static const struct of_device_id sr_thermal_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sr_thermal_of_match);
 
-static const struct acpi_device_id sr_thermal_acpi_ids[] = {
-	{ .id = "BRCM0500" },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(acpi, sr_thermal_acpi_ids);
-
 static struct platform_driver sr_thermal_driver = {
 	.probe		= sr_thermal_probe,
 	.driver = {
 		.name = "sr-thermal",
 		.of_match_table = sr_thermal_of_match,
-		.acpi_match_table = ACPI_PTR(sr_thermal_acpi_ids),
 	},
 };
 module_platform_driver(sr_thermal_driver);
-- 
2.7.4
