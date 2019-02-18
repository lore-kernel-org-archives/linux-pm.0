From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 12/12] thermal: qoriq: Add support for multiple thremal sites
Date: Mon, 18 Feb 2019 11:11:41 -0800
Message-ID: <20190218191141.3729-13-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

TMU IP block provides temerature measurement for up to 16 sites,
current implementation of the driver however hardcodes a single site
ID. Change the code so it would be possible to reference multiple
sites as indivudial sensors and get their temperature readings.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 132 ++++++++++++++++++++------------
 1 file changed, 84 insertions(+), 48 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index f746c62789b0..6cc6e6b36fb0 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -24,6 +24,8 @@
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
+#define TMR_ALPF_MASK	GENMASK(27, 26)
+
 
 #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
@@ -41,21 +43,32 @@
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
+struct qoriq_tmu_sensor {
+	struct thermal_zone_device *tz;
+	int id;
+};
+
 /*
  * Thermal zone data
  */
 struct qoriq_tmu_data {
 	struct thermal_zone_device *tz;
 	struct regmap *regmap;
-	int sensor_id;
+	struct qoriq_tmu_sensor sensors[SITES_MAX];
 };
 
+static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_tmu_sensor *s)
+{
+	return container_of(s, struct qoriq_tmu_data, sensors[s->id]);
+}
+
 static int tmu_get_temp(void *p, int *temp)
 {
 	u32 val;
-	struct qoriq_tmu_data *data = p;
+	struct qoriq_tmu_sensor *s = p;
+	struct qoriq_tmu_data *data = qoriq_sensor_to_data(s);
 
-	regmap_read(data->regmap, REGS_TRITSR(data->sensor_id), &val);
+	regmap_read(data->regmap, REGS_TRITSR(s->id), &val);
 	if (!(val & TRITSR_V))
 		return -ENODATA;
 
@@ -63,38 +76,86 @@ static int tmu_get_temp(void *p, int *temp)
 	return 0;
 }
 
-static int qoriq_tmu_get_sensor_id(void)
+static const struct thermal_zone_of_device_ops tmu_tz_ops = {
+	.get_temp = tmu_get_temp,
+};
+
+static int qoriq_tmu_populate_sensors(struct device *dev,
+				      struct qoriq_tmu_data *data)
 {
-	int ret, id;
+	int ret, id, i, count = 0;
 	struct of_phandle_args sensor_specs;
 	struct device_node *np, *sensor_np;
+	struct qoriq_tmu_sensor *s;
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np)
 		return -ENODEV;
 
-	sensor_np = of_get_next_child(np, NULL);
-	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
-			"#thermal-sensor-cells",
-			0, &sensor_specs);
-	if (ret) {
-		id = ret;
-		goto out;
+	for_each_child_of_node(np, sensor_np) {
+		u16 msite;
+
+		ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
+						 "#thermal-sensor-cells",
+						 0, &sensor_specs);
+		if (ret)
+			break;
+
+		if (sensor_specs.args_count != 1) {
+			pr_err("%pOFn: Invalid number of cells in sensor specifier %d\n",
+			       sensor_specs.np, sensor_specs.args_count);
+			ret = -EINVAL;
+			break;
+		}
+
+		id = sensor_specs.args[0];
+		if (id >= SITES_MAX) {
+			ret = -EINVAL;
+			dev_err(dev, "Sensor id %d is out of range\n", id);
+			break;
+		}
+
+		msite = BIT(15 - id);
+		/* Enable monitoring of that particular sensor*/
+		regmap_update_bits(data->regmap, REGS_TMR, msite, msite);
+
+		s = &data->sensors[id];
+		s->id = id;
+		count++;
 	}
 
-	if (sensor_specs.args_count != 1) {
-		pr_err("%pOFn: Invalid number of cells in sensor specifier %d\n",
-		       sensor_specs.np, sensor_specs.args_count);
-		id = -EINVAL;
-		goto out;
+	of_node_put(np);
+	if (ret) {
+		/* We only need to "put" sensor_np if we exited the
+		 * loop early with "break"
+		 */
+		of_node_put(sensor_np);
+		return ret;
 	}
 
-	id = sensor_specs.args[0];
-out:
-	of_node_put(np);
-	of_node_put(sensor_np);
+	/* Enable monitoring */
+	regmap_update_bits(data->regmap, REGS_TMR, TMR_ME | TMR_ALPF_MASK,
+			   TMR_ME | TMR_ALPF);
+
+	for (i = 0; i < count; i++) {
+		s = &data->sensors[i];
+		s->tz = devm_thermal_zone_of_sensor_register(dev, s->id, s,
+							     &tmu_tz_ops);
+		if (IS_ERR(s->tz)) {
+			ret = PTR_ERR(s->tz);
+			dev_err(dev,
+				"Failed to register thermal zone device %d\n",
+				ret);
+			break;
+		}
+
+		ret = devm_thermal_add_hwmon_sysfs(s->tz);
+		if (ret)
+			break;
+
+	}
 
-	return id;
+	return ret;
 }
 
 static int qoriq_tmu_calibration(struct device *dev,
@@ -142,10 +203,6 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 }
 
-static const struct thermal_zone_of_device_ops tmu_tz_ops = {
-	.get_temp = tmu_get_temp,
-};
-
 static const struct regmap_range qiriq_wr_yes_ranges[] = {
 	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
 	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
@@ -187,19 +244,12 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		.max_register		= SZ_4K,
 	};
 	void __iomem *base;
-	u32 site;
 
 	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->sensor_id = qoriq_tmu_get_sensor_id();
-	if (data->sensor_id < 0) {
-		dev_err(dev, "Failed to get sensor id\n");
-		return -ENODEV;
-	}
-
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io) {
 		dev_err(dev, "Failed to get memory region\n");
@@ -225,21 +275,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	/* Enable monitoring */
-	site = 0x1 << (15 - data->sensor_id);
-	regmap_write(data->regmap, REGS_TMR, site | TMR_ME | TMR_ALPF);
-
-	data->tz = devm_thermal_zone_of_sensor_register(dev,
-							data->sensor_id,
-							data, &tmu_tz_ops);
-	if (IS_ERR(data->tz)) {
-		ret = PTR_ERR(data->tz);
-		dev_err(dev, "Failed to register thermal zone device %d\n",
-			ret);
-		goto disable_monitoring;
-	}
-
-	ret = devm_thermal_add_hwmon_sysfs(data->tz);
+	ret = qoriq_tmu_populate_sensors(dev, data);
 	if (ret)
 		goto disable_monitoring;
 
-- 
2.20.1
