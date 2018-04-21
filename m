From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 08/27] thermal: armada: use the resource managed registration
 helper alternative
Date: Sat, 21 Apr 2018 17:12:36 +0200
Message-ID: <20180421151255.29929-9-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com>
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

Current use of thermal_zone_device_register() triggers a warning at boot
and should be replaced by devm_thermal_zone_of_sensor_register(). This
allows better handling of multiple thermal zones for later multi-sensors
support.

Also change the driver data to embed a new structure to make the
difference between legacy data (which needs to be cleaned) and
syscon-related data.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 128 ++++++++++++++++++++++++++++++++-------
 1 file changed, 107 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index be346c6afde2..8a734264ecdd 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -64,6 +64,7 @@ struct armada_thermal_data;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
 struct armada_thermal_priv {
+	struct device *dev;
 	struct regmap *syscon;
 	char zone_name[THERMAL_NAME_LENGTH];
 	struct armada_thermal_data *data;
@@ -95,6 +96,26 @@ struct armada_thermal_data {
 	unsigned int syscon_status_off;
 };
 
+struct armada_drvdata {
+	enum drvtype {
+		LEGACY,
+		SYSCON
+	} type;
+	union {
+		struct armada_thermal_priv *priv;
+		struct thermal_zone_device *tz;
+	} data;
+};
+
+/*
+ * struct armada_thermal_sensor - hold the information of one thermal sensor
+ * @thermal: pointer to the local private structure
+ * @tzd: pointer to the thermal zone device
+ */
+struct armada_thermal_sensor {
+	struct armada_thermal_priv *priv;
+};
+
 static void armadaxp_init(struct platform_device *pdev,
 			  struct armada_thermal_priv *priv)
 {
@@ -243,16 +264,14 @@ static bool armada_is_valid(struct armada_thermal_priv *priv)
 	return reg & priv->data->is_valid_bit;
 }
 
-static int armada_get_temp(struct thermal_zone_device *thermal,
-			   int *temp)
+static int armada_read_sensor(struct armada_thermal_priv *priv, long *temp)
 {
-	struct armada_thermal_priv *priv = thermal->devdata;
 	u32 reg, div;
 	s64 sample, b, m;
 
 	/* Valid check */
 	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
-		dev_err(&thermal->device,
+		dev_err(priv->dev,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
 	}
@@ -278,7 +297,39 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static struct thermal_zone_device_ops ops = {
+static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
+				  int *temp)
+{
+	struct armada_thermal_priv *priv = thermal->devdata;
+	long temperature;
+	int ret;
+
+	/* Do the actual reading */
+	ret = armada_read_sensor(priv, &temperature);
+	*temp = temperature;
+
+	return ret;
+}
+
+static struct thermal_zone_device_ops legacy_ops = {
+	.get_temp = armada_get_temp_legacy,
+};
+
+static int armada_get_temp(void *_sensor, int *temp)
+{
+	struct armada_thermal_sensor *sensor = _sensor;
+	struct armada_thermal_priv *priv = sensor->priv;
+	long temperature;
+	int ret;
+
+	/* Do the actual reading */
+	ret = armada_read_sensor(priv, &temperature);
+	*temp = temperature;
+
+	return ret;
+}
+
+static struct thermal_zone_of_device_ops of_ops = {
 	.get_temp = armada_get_temp,
 };
 
@@ -480,7 +531,9 @@ static void armada_set_sane_name(struct platform_device *pdev,
 
 static int armada_thermal_probe(struct platform_device *pdev)
 {
-	struct thermal_zone_device *thermal;
+	struct thermal_zone_device *tz;
+	struct armada_thermal_sensor *sensors;
+	struct armada_drvdata *drvdata;
 	const struct of_device_id *match;
 	struct armada_thermal_priv *priv;
 	int ret;
@@ -493,11 +546,13 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
 	priv->data = (struct armada_thermal_data *)match->data;
 
-	/* Ensure device name is correct for the thermal core */
-	armada_set_sane_name(pdev, priv);
-
 	/*
 	 * Legacy DT bindings only described "control1" register (also referred
 	 * as "control MSB" on old documentation). Then, bindings moved to cover
@@ -510,35 +565,66 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	 * is to define an overall system controller and put the thermal node
 	 * into it, which requires the use of regmaps across all the driver.
 	 */
-	if (IS_ERR(syscon_node_to_regmap(pdev->dev.parent->of_node)))
+	if (IS_ERR(syscon_node_to_regmap(pdev->dev.parent->of_node))) {
+		/* Ensure device name is correct for the thermal core */
+		armada_set_sane_name(pdev, priv);
+
 		ret = armada_thermal_probe_legacy(pdev, priv);
-	else
-		ret = armada_thermal_probe_syscon(pdev, priv);
+		if (ret)
+			return ret;
 
+		priv->data->init(pdev, priv);
+
+		tz = thermal_zone_device_register(priv->zone_name, 0, 0, priv,
+						  &legacy_ops, NULL, 0, 0);
+		if (IS_ERR(tz)) {
+			dev_err(&pdev->dev,
+				"Failed to register thermal zone device\n");
+			return PTR_ERR(tz);
+		}
+
+		drvdata->type = LEGACY;
+		drvdata->data.tz = tz;
+		platform_set_drvdata(pdev, drvdata);
+
+		return 0;
+	}
+
+	ret = armada_thermal_probe_syscon(pdev, priv);
 	if (ret)
 		return ret;
 
 	priv->data->init(pdev, priv);
 
-	thermal = thermal_zone_device_register(priv->zone_name, 0, 0, priv,
-					       &ops, NULL, 0, 0);
-	if (IS_ERR(thermal)) {
+	sensors = devm_kzalloc(&pdev->dev, sizeof(struct armada_thermal_sensor),
+			       GFP_KERNEL);
+	if (!sensors)
+		return -ENOMEM;
+
+	sensors->priv = priv;
+
+	tz = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, sensors,
+						  &of_ops);
+	if (IS_ERR(tz)) {
 		dev_err(&pdev->dev,
-			"Failed to register thermal zone device\n");
-		return PTR_ERR(thermal);
+			"Failed to register thermal sensor (err: %ld)\n",
+			PTR_ERR(tz));
+		return PTR_ERR(tz);
 	}
 
-	platform_set_drvdata(pdev, thermal);
+	drvdata->type = SYSCON;
+	drvdata->data.priv = priv;
+	platform_set_drvdata(pdev, drvdata);
 
 	return 0;
 }
 
 static int armada_thermal_exit(struct platform_device *pdev)
 {
-	struct thermal_zone_device *armada_thermal =
-		platform_get_drvdata(pdev);
+	struct armada_drvdata *drvdata = platform_get_drvdata(pdev);
 
-	thermal_zone_device_unregister(armada_thermal);
+	if (drvdata->type == LEGACY)
+		thermal_zone_device_unregister(drvdata->data.tz);
 
 	return 0;
 }
-- 
2.14.1
