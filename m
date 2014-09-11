From: Bai Ping <b51503@freescale.com>
Subject: [PATCH] thermal: imx: correct thermal driver load sequence
Date: Thu, 11 Sep 2014 16:04:17 +0800
Message-ID: <1410422657-30726-1-git-send-email-b51503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bon0117.outbound.protection.outlook.com ([157.56.111.117]:26944
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751410AbaIKIUQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Sep 2014 04:20:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org

Thermal driver should be registered after cpufreq driver have
been registered and probed. Doing so is to make sure that thermal
driver can get the max cpu cooling states correctly when calling
get_property.

Signed-off-by: Bai Ping <b51503@freescale.com>
---
 drivers/thermal/imx_thermal.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 45af765..d00aaaf 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2013 Freescale Semiconductor, Inc.
+ * Copyright 2013-2014 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -557,7 +557,14 @@ static struct platform_driver imx_thermal = {
 	.probe		= imx_thermal_probe,
 	.remove		= imx_thermal_remove,
 };
-module_platform_driver(imx_thermal);
+
+static int __init imx_thermal_init(void)
+{
+	return platform_driver_register(&imx_thermal);
+}
+
+late_initcall(imx_thermal_init);
+
 MODULE_AUTHOR("Freescale Semiconductor, Inc.");
 MODULE_DESCRIPTION("Thermal driver for Freescale i.MX SoCs");
-- 
1.9.1


