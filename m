From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 03/10] thermal: armada: Add generic infrastructure to handle the sensor
Date: Thu, 24 Apr 2014 17:23:17 -0300
Message-ID: <1398371004-15807-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40777 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752675AbaDXUYP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Apr 2014 16:24:15 -0400
In-Reply-To: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

In order to support similar SoC where the sensor value and valid
bit can have different offset and/or mask, we add such fields to the
per-variant structure, instead of having the values hardcoded.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 4de6e56..3e4d8ef 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -24,10 +24,7 @@
 #include <linux/of_device.h>
 #include <linux/thermal.h>
 
-#define THERMAL_VALID_OFFSET		9
 #define THERMAL_VALID_MASK		0x1
-#define THERMAL_TEMP_OFFSET		10
-#define THERMAL_TEMP_MASK		0x1ff
 
 /* Thermal Manager Control and Status Register */
 #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
@@ -58,6 +55,11 @@ struct armada_thermal_data {
 	unsigned long coef_b;
 	unsigned long coef_m;
 	unsigned long coef_div;
+
+	/* Offset and mask to access the sensor temperature */
+	unsigned int temp_offset;
+	unsigned int temp_mask;
+	unsigned int is_valid_offset;
 };
 
 static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
@@ -108,7 +110,7 @@ static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
 	unsigned long reg = readl_relaxed(priv->sensor);
 
-	return (reg >> THERMAL_VALID_OFFSET) & THERMAL_VALID_MASK;
+	return (reg >> priv->data->is_valid_offset) & THERMAL_VALID_MASK;
 }
 
 static int armada_get_temp(struct thermal_zone_device *thermal,
@@ -126,7 +128,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 	}
 
 	reg = readl_relaxed(priv->sensor);
-	reg = (reg >> THERMAL_TEMP_OFFSET) & THERMAL_TEMP_MASK;
+	reg = (reg >> priv->data->temp_offset) & priv->data->temp_mask;
 
 	/* Get formula coeficients */
 	b = priv->data->coef_b;
@@ -143,6 +145,8 @@ static struct thermal_zone_device_ops ops = {
 
 static const struct armada_thermal_data armadaxp_data = {
 	.init_sensor = armadaxp_init_sensor,
+	.temp_offset = 10,
+	.temp_mask = 0x1ff,
 	.coef_b = 3153000000UL,
 	.coef_m = 10000000UL,
 	.coef_div = 13825,
@@ -151,6 +155,9 @@ static const struct armada_thermal_data armadaxp_data = {
 static const struct armada_thermal_data armada370_data = {
 	.is_valid = armada_is_valid,
 	.init_sensor = armada370_init_sensor,
+	.is_valid_offset = 9,
+	.temp_offset = 10,
+	.temp_mask = 0x1ff,
 	.coef_b = 3153000000UL,
 	.coef_m = 10000000UL,
 	.coef_div = 13825,
-- 
1.9.1

