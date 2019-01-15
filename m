From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/4] power: supply: sc27xx: Add one property to read charge voltage
Date: Tue, 15 Jan 2019 18:32:35 +0800
Message-ID: <bb75e6c5c7bd89100c7c667c877b8c97b359ff8a.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, zhang.lyra@gmail.com, orsonzhai@gmail.com
List-Id: linux-pm@vger.kernel.org

Add POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE property to get charge
voltage sampling by ADC controller, which is used to validate if the
charge voltage is in normal range or not in charger manager.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 76da189..4926b8a 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -72,6 +72,7 @@
  * @lock: protect the structure
  * @gpiod: GPIO for battery detection
  * @channel: IIO channel to get battery temperature
+ * @charge_chan: IIO channel to get charge voltage
  * @internal_resist: the battery internal resistance in mOhm
  * @total_cap: the total capacity of the battery in mAh
  * @init_cap: the initial capacity of the battery in mAh
@@ -92,6 +93,7 @@ struct sc27xx_fgu_data {
 	struct mutex lock;
 	struct gpio_desc *gpiod;
 	struct iio_channel *channel;
+	struct iio_channel *charge_chan;
 	bool bat_present;
 	int internal_resist;
 	int total_cap;
@@ -391,6 +393,18 @@ static int sc27xx_fgu_get_vbat_ocv(struct sc27xx_fgu_data *data, int *val)
 	return 0;
 }
 
+static int sc27xx_fgu_get_charge_vol(struct sc27xx_fgu_data *data, int *val)
+{
+	int ret, vol;
+
+	ret = iio_read_channel_processed(data->charge_chan, &vol);
+	if (ret < 0)
+		return ret;
+
+	*val = vol * 1000;
+	return 0;
+}
+
 static int sc27xx_fgu_get_temp(struct sc27xx_fgu_data *data, int *temp)
 {
 	return iio_read_channel_processed(data->channel, temp);
@@ -502,6 +516,14 @@ static int sc27xx_fgu_get_property(struct power_supply *psy,
 		val->intval = value;
 		break;
 
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = sc27xx_fgu_get_charge_vol(data, &value);
+		if (ret)
+			goto error;
+
+		val->intval = value;
+		break;
+
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 		ret = sc27xx_fgu_get_current(data, &value);
@@ -567,6 +589,7 @@ static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 	POWER_SUPPLY_PROP_VOLTAGE_OCV,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 };
 
 static const struct power_supply_desc sc27xx_fgu_desc = {
@@ -907,6 +930,12 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 		return PTR_ERR(data->channel);
 	}
 
+	data->charge_chan = devm_iio_channel_get(&pdev->dev, "charge-vol");
+	if (IS_ERR(data->charge_chan)) {
+		dev_err(&pdev->dev, "failed to get charge IIO channel\n");
+		return PTR_ERR(data->charge_chan);
+	}
+
 	data->gpiod = devm_gpiod_get(&pdev->dev, "bat-detect", GPIOD_IN);
 	if (IS_ERR(data->gpiod)) {
 		dev_err(&pdev->dev, "failed to get battery detection GPIO\n");
-- 
1.7.9.5
