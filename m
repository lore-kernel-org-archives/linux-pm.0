From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 08/12] thermal: armada: Update Kconfig and module description
Date: Mon, 18 Dec 2017 15:36:39 +0100
Message-ID: <20171218143643.7714-9-miquel.raynal@free-electrons.com>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171218143643.7714-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Update Armada thermal driver Kconfig entry as well as the driver's
MODULE_DESCRIPTION content, now that 64-bit SoCs are also supported,
eg. Armada 7K and Armada 8K.

Use the generic term "Marvell EBU Armada SoCs" instead of listing all
the supported SoCs everywhere (excepted in the Kconfig description,
where it is useful to have a list).

Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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
index 11a94ad66c35..cef5c65c8f32 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -1,5 +1,5 @@
 /*
- * Marvell Armada 370/XP thermal sensor driver
+ * Marvell EBU Armada SoCs thermal sensor driver
  *
  * Copyright (C) 2013 Marvell
  *
@@ -408,5 +408,5 @@ static struct platform_driver armada_thermal_driver = {
 module_platform_driver(armada_thermal_driver);
 
 MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>");
-MODULE_DESCRIPTION("Armada 370/XP thermal driver");
+MODULE_DESCRIPTION("Marvell EBU Armada SoCs thermal driver");
 MODULE_LICENSE("GPL v2");
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
