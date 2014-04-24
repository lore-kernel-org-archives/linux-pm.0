From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 02/10] thermal: armada: Add infrastructure to support generic formulas
Date: Thu, 24 Apr 2014 17:23:16 -0300
Message-ID: <1398371004-15807-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40770 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752614AbaDXUYK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Apr 2014 16:24:10 -0400
In-Reply-To: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

In order to support other similar SoC, with different sensor
coeficients, this commit adds the coeficients to the per-variant
structure, instead of having the formula hardcoded.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c5db071..4de6e56 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -53,6 +53,11 @@ struct armada_thermal_data {
 
 	/* Test for a valid sensor value (optional) */
 	bool (*is_valid)(struct armada_thermal_priv *);
+
+	/* Formula coeficients: temp = (b + m * reg) / div */
+	unsigned long coef_b;
+	unsigned long coef_m;
+	unsigned long coef_div;
 };
 
 static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
@@ -111,6 +116,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 {
 	struct armada_thermal_priv *priv = thermal->devdata;
 	unsigned long reg;
+	unsigned long m, b, div;
 
 	/* Valid check */
 	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
@@ -121,7 +127,13 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 
 	reg = readl_relaxed(priv->sensor);
 	reg = (reg >> THERMAL_TEMP_OFFSET) & THERMAL_TEMP_MASK;
-	*temp = (3153000000UL - (10000000UL*reg)) / 13825;
+
+	/* Get formula coeficients */
+	b = priv->data->coef_b;
+	m = priv->data->coef_m;
+	div = priv->data->coef_div;
+
+	*temp = (b - (m * reg)) / div;
 	return 0;
 }
 
@@ -131,11 +143,17 @@ static struct thermal_zone_device_ops ops = {
 
 static const struct armada_thermal_data armadaxp_data = {
 	.init_sensor = armadaxp_init_sensor,
+	.coef_b = 3153000000UL,
+	.coef_m = 10000000UL,
+	.coef_div = 13825,
 };
 
 static const struct armada_thermal_data armada370_data = {
 	.is_valid = armada_is_valid,
 	.init_sensor = armada370_init_sensor,
+	.coef_b = 3153000000UL,
+	.coef_m = 10000000UL,
+	.coef_div = 13825,
 };
 
 static const struct of_device_id armada_thermal_id_table[] = {
-- 
1.9.1

