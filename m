From: andy.tang@nxp.com
Subject: [PATCH] thermal: qoriq: add multiple sensors support
Date: Thu, 27 Sep 2018 10:42:04 +0800
Message-ID: <20180927024204.17314-1-andy.tang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
List-Id: linux-pm@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

There is only one sensor supported in current driver.
Multiple sensors are existing on Layscape socs. To support them,
covert this driver to support multiple sensors.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 drivers/thermal/qoriq_thermal.c |  117 +++++++++++++++++++++++----------------
 1 files changed, 70 insertions(+), 47 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c866cc1..7c1e88a 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -69,14 +69,21 @@ struct qoriq_tmu_regs {
 	u32 ttr3cr;		/* Temperature Range 3 Control Register */
 };
 
+struct qoriq_tmu_data;
+
 /*
  * Thermal zone data
  */
+struct qoriq_sensor {
+	struct thermal_zone_device	*tzd;
+	struct qoriq_tmu_data		*qdata;
+	int				id;
+};
+
 struct qoriq_tmu_data {
-	struct thermal_zone_device *tz;
 	struct qoriq_tmu_regs __iomem *regs;
-	int sensor_id;
 	bool little_endian;
+	struct qoriq_sensor	*sensor[SITES_MAX];
 };
 
 static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
@@ -97,48 +104,83 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
 
 static int tmu_get_temp(void *p, int *temp)
 {
+	struct qoriq_sensor *qsensor = p;
+	struct qoriq_tmu_data *qdata = qsensor->qdata;
 	u32 val;
-	struct qoriq_tmu_data *data = p;
 
-	val = tmu_read(data, &data->regs->site[data->sensor_id].tritsr);
+	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
 	*temp = (val & 0xff) * 1000;
 
 	return 0;
 }
 
-static int qoriq_tmu_get_sensor_id(void)
+static const struct thermal_zone_of_device_ops tmu_tz_ops = {
+	.get_temp = tmu_get_temp,
+};
+
+static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 {
-	int ret, id;
+	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
 	struct of_phandle_args sensor_specs;
 	struct device_node *np, *sensor_np;
+	int ret, id, sites = 0;
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np)
 		return -ENODEV;
 
-	sensor_np = of_get_next_child(np, NULL);
-	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
-			"#thermal-sensor-cells",
-			0, &sensor_specs);
-	if (ret) {
+	for_each_available_child_of_node(np, sensor_np) {
+		ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
+				"#thermal-sensor-cells",
+				0, &sensor_specs);
+		if (ret) {
+			of_node_put(np);
+			of_node_put(sensor_np);
+			return ret;
+		}
+
+		if (sensor_specs.args_count >= 1) {
+			id = sensor_specs.args[0];
+			WARN(sensor_specs.args_count > 1,
+					"%s: too many cells in sensor specifier %d\n",
+					sensor_specs.np->name,
+					sensor_specs.args_count);
+		} else {
+			id = 0;
+		}
+
 		of_node_put(np);
 		of_node_put(sensor_np);
-		return ret;
-	}
 
-	if (sensor_specs.args_count >= 1) {
-		id = sensor_specs.args[0];
-		WARN(sensor_specs.args_count > 1,
-				"%s: too many cells in sensor specifier %d\n",
-				sensor_specs.np->name, sensor_specs.args_count);
-	} else {
-		id = 0;
+		if (id > SITES_MAX)
+			return -EINVAL;
+
+		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
+				sizeof(struct qoriq_sensor), GFP_KERNEL);
+		if (!qdata->sensor[id])
+			return -ENOMEM;
+
+		qdata->sensor[id]->id = id;
+		qdata->sensor[id]->qdata = qdata;
+
+		qdata->sensor[id]->tzd = devm_thermal_zone_of_sensor_register(
+				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
+
+		if (IS_ERR(qdata->sensor[id]->tzd)) {
+			ret = PTR_ERR(qdata->sensor[id]->tzd);
+			dev_err(&pdev->dev,
+				"Failed to register thermal zone device.\n");
+			return -ENODEV;
+		}
+
+		sites |= 0x1 << (15 - id);
 	}
 
-	of_node_put(np);
-	of_node_put(sensor_np);
+	/* Enable monitoring */
+	if (sites != 0)
+		tmu_write(qdata, sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
 
-	return id;
+	return 0;
 }
 
 static int qoriq_tmu_calibration(struct platform_device *pdev)
@@ -188,16 +230,11 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 }
 
-static const struct thermal_zone_of_device_ops tmu_tz_ops = {
-	.get_temp = tmu_get_temp,
-};
-
 static int qoriq_tmu_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
-	u32 site = 0;
 
 	if (!np) {
 		dev_err(&pdev->dev, "Device OF-Node is NULL");
@@ -213,13 +250,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
-	data->sensor_id = qoriq_tmu_get_sensor_id();
-	if (data->sensor_id < 0) {
-		dev_err(&pdev->dev, "Failed to get sensor id\n");
-		ret = -ENODEV;
-		goto err_iomap;
-	}
-
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
 		dev_err(&pdev->dev, "Failed to get memory region\n");
@@ -233,18 +263,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_tmu;
 
-	data->tz = thermal_zone_of_sensor_register(&pdev->dev, data->sensor_id,
-				data, &tmu_tz_ops);
-	if (IS_ERR(data->tz)) {
-		ret = PTR_ERR(data->tz);
-		dev_err(&pdev->dev,
-			"Failed to register thermal zone device %d\n", ret);
-		goto err_tmu;
+	ret = qoriq_tmu_register_tmu_zone(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register sensors\n");
+		ret = -ENODEV;
+		goto err_iomap;
 	}
 
-	/* Enable monitoring */
-	site |= 0x1 << (15 - data->sensor_id);
-	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
 
 	return 0;
 
@@ -261,8 +286,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 {
 	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
 
-	thermal_zone_of_sensor_unregister(&pdev->dev, data->tz);
-
 	/* Disable monitoring */
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
-- 
1.7.1
