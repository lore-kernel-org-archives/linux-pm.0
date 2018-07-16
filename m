From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 04/23] thermal: armada: rename the initialization routine
Date: Mon, 16 Jul 2018 16:41:47 +0200
Message-ID: <20180716144206.30985-5-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180716144206.30985-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Calling a hook ->init_sensor() while what is initialized is the IP
itself and not the sensors is misleading. Rename the hook ->init() to
avoid any confusion in later work bringing multi-sensors support.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 18155e43e67f..3d22a6016b04 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -73,9 +73,9 @@ struct armada_thermal_priv {
 };
 
 struct armada_thermal_data {
-	/* Initialize the sensor */
-	void (*init_sensor)(struct platform_device *pdev,
-			    struct armada_thermal_priv *);
+	/* Initialize the thermal IC */
+	void (*init)(struct platform_device *pdev,
+		     struct armada_thermal_priv *priv);
 
 	/* Test for a valid sensor value (optional) */
 	bool (*is_valid)(struct armada_thermal_priv *);
@@ -94,8 +94,8 @@ struct armada_thermal_data {
 	bool needs_control0;
 };
 
-static void armadaxp_init_sensor(struct platform_device *pdev,
-				 struct armada_thermal_priv *priv)
+static void armadaxp_init(struct platform_device *pdev,
+			  struct armada_thermal_priv *priv)
 {
 	u32 reg;
 
@@ -117,8 +117,8 @@ static void armadaxp_init_sensor(struct platform_device *pdev,
 	writel(reg, priv->status);
 }
 
-static void armada370_init_sensor(struct platform_device *pdev,
-				  struct armada_thermal_priv *priv)
+static void armada370_init(struct platform_device *pdev,
+			   struct armada_thermal_priv *priv)
 {
 	u32 reg;
 
@@ -136,8 +136,8 @@ static void armada370_init_sensor(struct platform_device *pdev,
 	msleep(10);
 }
 
-static void armada375_init_sensor(struct platform_device *pdev,
-				  struct armada_thermal_priv *priv)
+static void armada375_init(struct platform_device *pdev,
+			   struct armada_thermal_priv *priv)
 {
 	u32 reg;
 
@@ -164,8 +164,8 @@ static void armada_wait_sensor_validity(struct armada_thermal_priv *priv)
 				   STATUS_POLL_TIMEOUT_US);
 }
 
-static void armada380_init_sensor(struct platform_device *pdev,
-				  struct armada_thermal_priv *priv)
+static void armada380_init(struct platform_device *pdev,
+			   struct armada_thermal_priv *priv)
 {
 	u32 reg = readl_relaxed(priv->control1);
 
@@ -186,8 +186,8 @@ static void armada380_init_sensor(struct platform_device *pdev,
 	armada_wait_sensor_validity(priv);
 }
 
-static void armada_ap806_init_sensor(struct platform_device *pdev,
-				     struct armada_thermal_priv *priv)
+static void armada_ap806_init(struct platform_device *pdev,
+			      struct armada_thermal_priv *priv)
 {
 	u32 reg;
 
@@ -247,7 +247,7 @@ static struct thermal_zone_device_ops ops = {
 };
 
 static const struct armada_thermal_data armadaxp_data = {
-	.init_sensor = armadaxp_init_sensor,
+	.init = armadaxp_init,
 	.temp_shift = 10,
 	.temp_mask = 0x1ff,
 	.coef_b = 3153000000ULL,
@@ -257,7 +257,7 @@ static const struct armada_thermal_data armadaxp_data = {
 
 static const struct armada_thermal_data armada370_data = {
 	.is_valid = armada_is_valid,
-	.init_sensor = armada370_init_sensor,
+	.init = armada370_init,
 	.is_valid_bit = BIT(9),
 	.temp_shift = 10,
 	.temp_mask = 0x1ff,
@@ -268,7 +268,7 @@ static const struct armada_thermal_data armada370_data = {
 
 static const struct armada_thermal_data armada375_data = {
 	.is_valid = armada_is_valid,
-	.init_sensor = armada375_init_sensor,
+	.init = armada375_init,
 	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
 	.temp_mask = 0x1ff,
@@ -280,7 +280,7 @@ static const struct armada_thermal_data armada375_data = {
 
 static const struct armada_thermal_data armada380_data = {
 	.is_valid = armada_is_valid,
-	.init_sensor = armada380_init_sensor,
+	.init = armada380_init,
 	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
@@ -292,7 +292,7 @@ static const struct armada_thermal_data armada380_data = {
 
 static const struct armada_thermal_data armada_ap806_data = {
 	.is_valid = armada_is_valid,
-	.init_sensor = armada_ap806_init_sensor,
+	.init = armada_ap806_init,
 	.is_valid_bit = BIT(16),
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
@@ -306,7 +306,7 @@ static const struct armada_thermal_data armada_ap806_data = {
 
 static const struct armada_thermal_data armada_cp110_data = {
 	.is_valid = armada_is_valid,
-	.init_sensor = armada380_init_sensor,
+	.init = armada380_init,
 	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
@@ -428,7 +428,7 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		priv->control1 = control + CONTROL1_OFFSET;
 	}
 
-	priv->data->init_sensor(pdev, priv);
+	priv->data->init(pdev, priv);
 
 	thermal = thermal_zone_device_register(priv->zone_name, 0, 0, priv,
 					       &ops, NULL, 0, 0);
-- 
2.14.1
