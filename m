From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH RFC 2/3] thermal: dove: convert to a thermal OF sensor device
Date: Sun, 12 Mar 2017 19:07:45 +0000
Message-ID: <E1cn8qH-0002v6-SE@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45638 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935050AbdCLTIH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 15:08:07 -0400
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

Convert the dove thermal infrastructure to an OF sensor device, and add
the thermal zones for the SoC, with a critical trip point of 120°C.
This allows us to specify thermal zones and couple them to cooling
devices in DT.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi    | 17 +++++++++++++++++
 drivers/thermal/dove_thermal.c | 33 +++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 698d58cea20d..40fb98687230 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -455,6 +455,7 @@
 				};
 
 				thermal: thermal-diode@001c {
+					#thermal-sensor-cells = <0>;
 					compatible = "marvell,dove-thermal";
 					reg = <0x001c 0x0c>, <0x005c 0x08>;
 				};
@@ -800,4 +801,20 @@
 			};
 		};
 	};
+
+	thermal-zones {
+		soc-thermal {
+			polling-delay-passive = <250>; /* ms */
+			polling-delay = <1000>; /* ms */
+			thermal-sensors = <&thermal>;
+
+			soc_trips: trips {
+				soc_trip_crit: soc-crit {
+					temperature = <120000>; /* °mC */
+					hysteresis = <2000>; /* °mC */
+					type = "critical";
+				};
+			};
+		};
+	};
 };
diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index a0bc9de42553..51b1a9e78576 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -46,6 +46,7 @@
 struct dove_thermal_priv {
 	void __iomem *sensor;
 	void __iomem *control;
+	struct device *dev;
 };
 
 static int dove_init_sensor(const struct dove_thermal_priv *priv)
@@ -92,17 +93,15 @@ static int dove_init_sensor(const struct dove_thermal_priv *priv)
 	return 0;
 }
 
-static int dove_get_temp(struct thermal_zone_device *thermal,
-			  int *temp)
+static int dove_of_get_temp(void *data, int *temp)
 {
+	struct dove_thermal_priv *priv = data;
 	unsigned long reg;
-	struct dove_thermal_priv *priv = thermal->devdata;
 
 	/* Valid check */
 	reg = readl_relaxed(priv->control + PMU_TEMP_DIOD_CTRL1_REG);
 	if ((reg & PMU_TDC1_TEMP_VALID_MASK) == 0x0) {
-		dev_err(&thermal->device,
-			"Temperature sensor reading not valid\n");
+		dev_err(priv->dev, "Temperature sensor reading not valid\n");
 		return -EIO;
 	}
 
@@ -118,10 +117,22 @@ static int dove_get_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
+static int dove_get_temp(struct thermal_zone_device *thermal,
+			  int *temp)
+{
+	struct dove_thermal_priv *priv = thermal->devdata;
+
+	return dove_of_get_temp(priv, temp);
+}
+
 static struct thermal_zone_device_ops ops = {
 	.get_temp = dove_get_temp,
 };
 
+static const struct thermal_zone_of_device_ops of_ops = {
+	.get_temp = dove_of_get_temp,
+};
+
 static const struct of_device_id dove_thermal_id_table[] = {
 	{ .compatible = "marvell,dove-thermal" },
 	{}
@@ -138,6 +149,8 @@ static int dove_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->dev = &pdev->dev;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->sensor))
@@ -154,8 +167,11 @@ static int dove_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	thermal = thermal_zone_device_register("dove_thermal", 0, 0,
-					       priv, &ops, NULL, 0, 0);
+	thermal = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
+						       priv, &of_ops);
+	if (IS_ERR(thermal))
+		thermal = thermal_zone_device_register("dove_thermal", 0, 0,
+						       priv, &ops, NULL, 0, 0);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
@@ -172,7 +188,8 @@ static int dove_thermal_exit(struct platform_device *pdev)
 	struct thermal_zone_device *dove_thermal =
 		platform_get_drvdata(pdev);
 
-	thermal_zone_device_unregister(dove_thermal);
+	if (!pdev->dev.of_node)
+		thermal_zone_device_unregister(dove_thermal);
 
 	return 0;
 }
-- 
2.7.4
