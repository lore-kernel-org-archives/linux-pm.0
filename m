From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 09/23] thermal: armada: add multi-channel sensors support
Date: Mon, 16 Jul 2018 16:41:52 +0200
Message-ID: <20180716144206.30985-10-miquel.raynal@bootlin.com>
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

MVEBU thermal IP supports multiple channels. Each channel may have
several sensors but for now each channel is wired to only one thermal
sensor. The first channel always points to the so called internal
sensor, within the thermal IP. There is usually one more channel (with
one sensor each time) per CPU. The code has been written to support
possible evolutions of the ap806 IP that would embed more CPUs and thus
more channels to select. Each channel should be referenced in the device
tree as an independent thermal zone.

Add the possibility to read each of these sensors through sysfs by
registering all the sensors (translated in "thermal_zone"). Also add a
mutex on these accesses to avoid read conflicts (only one channel/sensor
may be selected and read at a time).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 131 +++++++++++++++++++++++++++++++++------
 1 file changed, 111 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index dd894312dedf..eef8947b9b20 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -49,8 +49,13 @@
 #define CONTROL0_TSEN_RESET		BIT(1)
 #define CONTROL0_TSEN_ENABLE		BIT(2)
 #define CONTROL0_TSEN_AVG_BYPASS	BIT(6)
+#define CONTROL0_TSEN_CHAN_SHIFT	13
+#define CONTROL0_TSEN_CHAN_MASK		0xF
 #define CONTROL0_TSEN_OSR_SHIFT		24
 #define CONTROL0_TSEN_OSR_MAX		0x3
+#define CONTROL0_TSEN_MODE_SHIFT	30
+#define CONTROL0_TSEN_MODE_EXTERNAL	0x2
+#define CONTROL0_TSEN_MODE_MASK		0x3
 
 #define CONTROL1_TSEN_AVG_SHIFT		0
 #define CONTROL1_TSEN_AVG_MASK		0x7
@@ -67,7 +72,9 @@ struct armada_thermal_priv {
 	struct device *dev;
 	struct regmap *syscon;
 	char zone_name[THERMAL_NAME_LENGTH];
+	struct mutex update_lock;
 	struct armada_thermal_data *data;
+	int current_channel;
 };
 
 struct armada_thermal_data {
@@ -94,6 +101,9 @@ struct armada_thermal_data {
 	unsigned int syscon_control0_off;
 	unsigned int syscon_control1_off;
 	unsigned int syscon_status_off;
+
+	/* One sensor is in the thermal IC, the others are in the CPUs if any */
+	unsigned int cpu_nr;
 };
 
 struct armada_drvdata {
@@ -111,9 +121,11 @@ struct armada_drvdata {
  * struct armada_thermal_sensor - hold the information of one thermal sensor
  * @thermal: pointer to the local private structure
  * @tzd: pointer to the thermal zone device
+ * @id: identifier of the thermal sensor
  */
 struct armada_thermal_sensor {
 	struct armada_thermal_priv *priv;
+	int id;
 };
 
 static void armadaxp_init(struct platform_device *pdev,
@@ -181,14 +193,15 @@ static void armada375_init(struct platform_device *pdev,
 	msleep(50);
 }
 
-static void armada_wait_sensor_validity(struct armada_thermal_priv *priv)
+static int armada_wait_sensor_validity(struct armada_thermal_priv *priv)
 {
 	u32 reg;
 
-	regmap_read_poll_timeout(priv->syscon, priv->data->syscon_status_off,
-				 reg, reg & priv->data->is_valid_bit,
-				 STATUS_POLL_PERIOD_US,
-				 STATUS_POLL_TIMEOUT_US);
+	return regmap_read_poll_timeout(priv->syscon,
+					priv->data->syscon_status_off, reg,
+					reg & priv->data->is_valid_bit,
+					STATUS_POLL_PERIOD_US,
+					STATUS_POLL_TIMEOUT_US);
 }
 
 static void armada380_init(struct platform_device *pdev,
@@ -264,6 +277,58 @@ static bool armada_is_valid(struct armada_thermal_priv *priv)
 	return reg & priv->data->is_valid_bit;
 }
 
+/* There is currently no board with more than one sensor per channel */
+static int armada_select_channel(struct armada_thermal_priv *priv, int channel)
+{
+	struct armada_thermal_data *data = priv->data;
+	u32 ctrl0;
+
+	if (channel < 0 || channel > priv->data->cpu_nr)
+		return -EINVAL;
+
+	if (priv->current_channel == channel)
+		return 0;
+
+	/* Stop the measurements */
+	regmap_read(priv->syscon, data->syscon_control0_off, &ctrl0);
+	ctrl0 &= ~CONTROL0_TSEN_START;
+	regmap_write(priv->syscon, data->syscon_control0_off, ctrl0);
+
+	/* Reset the mode, internal sensor will be automatically selected */
+	ctrl0 &= ~(CONTROL0_TSEN_MODE_MASK << CONTROL0_TSEN_MODE_SHIFT);
+
+	/* Other channels are external and should be selected accordingly */
+	if (channel) {
+		/* Change the mode to external */
+		ctrl0 |= CONTROL0_TSEN_MODE_EXTERNAL <<
+			 CONTROL0_TSEN_MODE_SHIFT;
+		/* Select the sensor */
+		ctrl0 &= ~(CONTROL0_TSEN_CHAN_MASK << CONTROL0_TSEN_CHAN_SHIFT);
+		ctrl0 |= (channel - 1) << CONTROL0_TSEN_CHAN_SHIFT;
+	}
+
+	/* Actually set the mode/channel */
+	regmap_write(priv->syscon, data->syscon_control0_off, ctrl0);
+	priv->current_channel = channel;
+
+	/* Re-start the measurements */
+	ctrl0 |= CONTROL0_TSEN_START;
+	regmap_write(priv->syscon, data->syscon_control0_off, ctrl0);
+
+	/*
+	 * The IP has a latency of ~15ms, so after updating the selected source,
+	 * we must absolutely wait for the sensor validity bit to ensure we read
+	 * actual data.
+	 */
+	if (armada_wait_sensor_validity(priv)) {
+		dev_err(priv->dev,
+			"Temperature sensor reading not valid\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int armada_read_sensor(struct armada_thermal_priv *priv, int *temp)
 {
 	u32 reg, div;
@@ -319,8 +384,20 @@ static int armada_get_temp(void *_sensor, int *temp)
 	struct armada_thermal_priv *priv = sensor->priv;
 	int ret;
 
+	mutex_lock(&priv->update_lock);
+
+	/* Select the desired channel */
+	ret = armada_select_channel(priv, sensor->id);
+	if (ret)
+		goto unlock_mutex;
+
 	/* Do the actual reading */
-	return armada_read_sensor(priv, &temp);
+	ret = armada_read_sensor(priv, &temp);
+
+unlock_mutex:
+	mutex_unlock(&priv->update_lock);
+
+	return ret;
 }
 
 static struct thermal_zone_of_device_ops of_ops = {
@@ -394,6 +471,7 @@ static const struct armada_thermal_data armada_ap806_data = {
 	.syscon_control0_off = 0x84,
 	.syscon_control1_off = 0x88,
 	.syscon_status_off = 0x8C,
+	.cpu_nr = 4,
 };
 
 static const struct armada_thermal_data armada_cp110_data = {
@@ -526,10 +604,11 @@ static void armada_set_sane_name(struct platform_device *pdev,
 static int armada_thermal_probe(struct platform_device *pdev)
 {
 	struct thermal_zone_device *tz;
-	struct armada_thermal_sensor *sensors;
+	struct armada_thermal_sensor *sensor;
 	struct armada_drvdata *drvdata;
 	const struct of_device_id *match;
 	struct armada_thermal_priv *priv;
+	int sensor_id;
 	int ret;
 
 	match = of_match_device(armada_thermal_id_table, &pdev->dev);
@@ -547,6 +626,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	priv->data = (struct armada_thermal_data *)match->data;
 
+	mutex_init(&priv->update_lock);
+
 	/*
 	 * Legacy DT bindings only described "control1" register (also referred
 	 * as "control MSB" on old documentation). Then, bindings moved to cover
@@ -588,25 +669,35 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	priv->current_channel = -1;
 	priv->data->init(pdev, priv);
 	drvdata->type = SYSCON;
 	drvdata->data.priv = priv;
 	platform_set_drvdata(pdev, drvdata);
 
-	sensors = devm_kzalloc(&pdev->dev, sizeof(struct armada_thermal_sensor),
-			       GFP_KERNEL);
-	if (!sensors)
-		return -ENOMEM;
+	/*
+	 * There is one channel for the IC and one per CPU (if any), each
+	 * channel has one sensor.
+	 */
+	for (sensor_id = 0; sensor_id <= priv->data->cpu_nr; sensor_id++) {
+		sensor = devm_kzalloc(&pdev->dev,
+				      sizeof(struct armada_thermal_sensor),
+				      GFP_KERNEL);
+		if (!sensor)
+			return -ENOMEM;
 
-	sensors->priv = priv;
-
-	tz = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, sensors,
-						  &of_ops);
-	if (IS_ERR(tz)) {
-		dev_err(&pdev->dev,
-			"Failed to register thermal sensor (err: %ld)\n",
-			PTR_ERR(tz));
-		return PTR_ERR(tz);
+		/* Register the sensor */
+		sensor->priv = priv;
+		sensor->id = sensor_id;
+		tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
+							  sensor->id, sensor,
+							  &of_ops);
+		if (IS_ERR(tz)) {
+			dev_info(&pdev->dev, "Thermal sensor %d unavailable\n",
+				 sensor_id);
+			devm_kfree(&pdev->dev, sensor);
+			continue;
+		}
 	}
 
 	return 0;
-- 
2.14.1
