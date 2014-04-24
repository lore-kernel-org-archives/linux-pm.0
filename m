From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 04/10] thermal: armada: Pass the platform_device to init_sensor()
Date: Thu, 24 Apr 2014 17:23:18 -0300
Message-ID: <1398371004-15807-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40789 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752675AbaDXUYT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Apr 2014 16:24:19 -0400
In-Reply-To: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

In order to perform SoC-specific quirks on platforms that need them,
this commit adds a new parameter to the init_sensor() function.
This will be used to support early silicons of the Armada 375 SoC,
to workaround some hardware issues.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 3e4d8ef..aafcc4d 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -46,7 +46,8 @@ struct armada_thermal_priv {
 
 struct armada_thermal_data {
 	/* Initialize the sensor */
-	void (*init_sensor)(struct armada_thermal_priv *);
+	void (*init_sensor)(struct platform_device *pdev,
+			    struct armada_thermal_priv *);
 
 	/* Test for a valid sensor value (optional) */
 	bool (*is_valid)(struct armada_thermal_priv *);
@@ -62,7 +63,8 @@ struct armada_thermal_data {
 	unsigned int is_valid_offset;
 };
 
-static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
+static void armadaxp_init_sensor(struct platform_device *pdev,
+				 struct armada_thermal_priv *priv)
 {
 	unsigned long reg;
 
@@ -87,7 +89,8 @@ static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
 	writel(reg, priv->sensor);
 }
 
-static void armada370_init_sensor(struct armada_thermal_priv *priv)
+static void armada370_init_sensor(struct platform_device *pdev,
+				  struct armada_thermal_priv *priv)
 {
 	unsigned long reg;
 
@@ -204,7 +207,7 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->control);
 
 	priv->data = (struct armada_thermal_data *)match->data;
-	priv->data->init_sensor(priv);
+	priv->data->init_sensor(pdev, priv);
 
 	thermal = thermal_zone_device_register("armada_thermal", 0, 0,
 					       priv, &ops, NULL, 0, 0);
-- 
1.9.1

