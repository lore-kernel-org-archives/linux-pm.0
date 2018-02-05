From: <sean.wang@mediatek.com>
Subject: [PATCH 2/2] thermal: mediatek: add support for MT7622 SoC
Date: Mon, 5 Feb 2018 16:11:52 +0800
Message-ID: <796b53ce7fc5e81a04c5ab9cfa4cee67015b355f.1517817887.git.sean.wang@mediatek.com>
References: <0b7dabc3b2c7ed93b88ec0923c2cce2f84fba5b1.1517817887.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0b7dabc3b2c7ed93b88ec0923c2cce2f84fba5b1.1517817887.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, Shunli Wang <shunli.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MT7622 SoC has built-in thermal controller with one sensing point, the
patch just is to extend the functionality of the existing logic.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 1e61c09..8a53151 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -158,6 +158,12 @@
 /* The number of sensing points per bank */
 #define MT2712_NUM_SENSORS_PER_ZONE	4
 
+#define MT7622_TEMP_AUXADC_CHANNEL	11
+#define MT7622_NUM_SENSORS		1
+#define MT7622_NUM_ZONES		1
+#define MT7622_NUM_SENSORS_PER_ZONE	1
+#define MT7622_TS1	0
+
 #define THERMAL_NAME    "mtk-thermal"
 
 struct mtk_thermal;
@@ -249,6 +255,12 @@ static const int mt2712_adcpnp[MT2712_NUM_SENSORS_PER_ZONE] = {
 
 static const int mt2712_mux_values[MT2712_NUM_SENSORS] = { 0, 1, 2, 3 };
 
+/* MT7622 thermal sensor data */
+static const int mt7622_bank_data[MT7622_NUM_SENSORS] = { MT7622_TS1, };
+static const int mt7622_msr[MT7622_NUM_SENSORS_PER_ZONE] = { TEMP_MSR0, };
+static const int mt7622_adcpnp[MT7622_NUM_SENSORS_PER_ZONE] = { TEMP_ADCPNP0, };
+static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
+
 /**
  * The MT8173 thermal controller has four banks. Each bank can read up to
  * four temperature sensors simultaneously. The MT8173 has a total of 5
@@ -336,6 +348,25 @@ static const struct mtk_thermal_data mt2712_thermal_data = {
 	.sensor_mux_values = mt2712_mux_values,
 };
 
+/*
+ * MT7622 have only one sensing point which uses AUXADC Channel 11 for raw data
+ * access.
+ */
+static const struct mtk_thermal_data mt7622_thermal_data = {
+	.auxadc_channel = MT7622_TEMP_AUXADC_CHANNEL,
+	.num_banks = MT7622_NUM_ZONES,
+	.num_sensors = MT7622_NUM_SENSORS,
+	.bank_data = {
+		{
+			.num_sensors = 1,
+			.sensors = mt7622_bank_data,
+		},
+	},
+	.msr = mt7622_msr,
+	.adcpnp = mt7622_adcpnp,
+	.sensor_mux_values = mt7622_mux_values,
+};
+
 /**
  * raw_to_mcelsius - convert a raw ADC value to mcelsius
  * @mt:		The thermal controller
@@ -638,6 +669,10 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 	{
 		.compatible = "mediatek,mt2712-thermal",
 		.data = (void *)&mt2712_thermal_data,
+	},
+	{
+		.compatible = "mediatek,mt7622-thermal",
+		.data = (void *)&mt7622_thermal_data,
 	}, {
 	},
 };
-- 
2.7.4
