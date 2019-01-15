From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/4] dt-bindings: power: sc27xx: Add one IIO channel to read charge voltage
Date: Tue, 15 Jan 2019 18:32:34 +0800
Message-ID: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, zhang.lyra@gmail.com, orsonzhai@gmail.com
List-Id: linux-pm@vger.kernel.org

Add one IIO channel named "charge_vol" to read the charge voltage for
the SC27XX fuel gauge controller.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
index fc35ac5..0a5705b 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
@@ -9,8 +9,8 @@ Required properties:
   "sprd,sc2731-fgu".
 - reg: The address offset of fuel gauge unit.
 - battery-detect-gpios: GPIO for battery detection.
-- io-channels: Specify the IIO ADC channel to get temperature.
-- io-channel-names: Should be "bat-temp".
+- io-channels: Specify the IIO ADC channels to get temperature and charge voltage.
+- io-channel-names: Should be "bat-temp" or "charge-vol".
 - nvmem-cells: A phandle to the calibration cells provided by eFuse device.
 - nvmem-cell-names: Should be "fgu_calib".
 - monitored-battery: Phandle of battery characteristics devicetree node.
@@ -47,8 +47,8 @@ Example:
 			compatible = "sprd,sc2731-fgu";
 			reg = <0xa00>;
 			battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
-			io-channels = <&pmic_adc 5>;
-			io-channel-names = "bat-temp";
+			io-channels = <&pmic_adc 5>, <&pmic_adc 14>;
+			io-channel-names = "bat-temp", "charge-vol";
 			nvmem-cells = <&fgu_calib>;
 			nvmem-cell-names = "fgu_calib";
 			monitored-battery = <&bat>;
-- 
1.7.9.5
