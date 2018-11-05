From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v7 3/6] dt-bindings: power: Introduce properties to present the battery OCV capacity table
Date: Mon,  5 Nov 2018 15:39:08 +0800
Message-ID: <ca572c16a79a51819850ac89b814155920dba28f.1541393063.git.baolin.wang@linaro.org>
References: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
In-Reply-To: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
References: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com, linus.walleij@linaro.org, quentin.schulz@bootlin.com
List-Id: linux-pm@vger.kernel.org

Some battery driver will use the open circuit voltage (OCV) value to look
up the corresponding battery capacity percent in one certain degree Celsius.
Thus this patch provides some battery properties to present the OCV table
temperatures and OCV capacity table values.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v6:
 - Add reviewed tag from Rob.

Changes from v5:
 - None.

Changes from v4:
 - Improve the description of ocv-capacity-table-n to make the order clear.

Changes from v3:
 - Split binding into one separate patch.
 - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
 - Add some words to specify the OCV's unit.

Changes from v2:
 - Use type __be32 to calculate the table length.
 - Update error messages.
 - Add some helper functions.

Changes from v1:
 - New patch in v2.
---
 .../devicetree/bindings/power/supply/battery.txt   |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 938d027..89871ab 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -23,6 +23,17 @@ Optional Properties:
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
  - factory-internal-resistance-micro-ohms: battery factory internal resistance
+ - ocv-capacity-table-0: An array providing the open circuit voltage (OCV)
+   of the battery and corresponding battery capacity percent, which is used
+   to look up battery capacity according to current OCV value. And the open
+   circuit voltage unit is microvolt.
+ - ocv-capacity-table-1: Same as ocv-capacity-table-0
+ ......
+ - ocv-capacity-table-n: Same as ocv-capacity-table-0
+ - ocv-capacity-celsius: An array containing the temperature in degree Celsius,
+   for each of the battery capacity lookup table. The first temperature value
+   specifies the OCV table 0, and the second temperature value specifies the
+   OCV table 1, and so on.
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -44,6 +55,10 @@ Example:
 		constant-charge-current-max-microamp = <900000>;
 		constant-charge-voltage-max-microvolt = <4200000>;
 		factory-internal-resistance-micro-ohms = <250000>;
+		ocv-capacity-celsius = <(-10) 0 10>;
+		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
+		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
+		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
 	};
 
 	charger: charger@11 {
-- 
1.7.9.5
