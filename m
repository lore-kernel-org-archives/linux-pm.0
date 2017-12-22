From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v7 08/11] thermal: armada: Update Kconfig and module description
Date: Fri, 22 Dec 2017 17:14:10 +0100
Message-ID: <20171222161413.20816-9-miquel.raynal@free-electrons.com>
References: <20171222161413.20816-1-miquel.raynal@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55759 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756438AbdLVQOi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 11:14:38 -0500
In-Reply-To: <20171222161413.20816-1-miquel.raynal@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>, Baruch Siach <baruch@tkos.co.il>, David Sniatkiwicz <davidsn@marvell.com>

Update Armada thermal driver Kconfig entry as well as the driver's
MODULE_DESCRIPTION content, now that 64-bit SoCs are also supported,
eg. Armada 7K and Armada 8K.

Use the generic term "Marvell EBU Armada SoCs" instead of listing all
the supported SoCs everywhere (excepted in the Kconfig description,
where it is useful to have a list).

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/thermal/Kconfig          | 4 ++--
 drivers/thermal/armada_thermal.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 315ae2926e20..b6adc54b96f1 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -301,13 +301,13 @@ config DB8500_THERMAL
 	  thermal zone if trip points reached.
 
 config ARMADA_THERMAL
-	tristate "Armada 370/XP thermal management"
+	tristate "Marvell EBU Armada SoCs thermal management"
 	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on OF
 	help
 	  Enable this option if you want to have support for thermal management
-	  controller present in Armada 370 and Armada XP SoC.
+	  controller present in Marvell EBU Armada SoCs (370,375,XP,38x,7K,8K).
 
 config DA9062_THERMAL
 	tristate "DA9062/DA9061 Dialog Semiconductor thermal driver"
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index f2eba2a6f1a5..d426b230e1c5 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -1,5 +1,5 @@
 /*
- * Marvell Armada 370/XP thermal sensor driver
+ * Marvell EBU Armada SoCs thermal sensor driver
  *
  * Copyright (C) 2013 Marvell
  *
@@ -407,5 +407,5 @@ static struct platform_driver armada_thermal_driver = {
 module_platform_driver(armada_thermal_driver);
 
 MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
-MODULE_DESCRIPTION("Armada 370/XP thermal driver");
+MODULE_DESCRIPTION("Marvell EBU Armada SoCs thermal driver");
 MODULE_LICENSE("GPL v2");
-- 
2.11.0
