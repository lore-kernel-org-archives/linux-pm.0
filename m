From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/5] dt-bindings: power: supply: Add nvmem properties to calibrate FGU
Date: Wed, 14 Nov 2018 17:07:04 +0800
Message-ID: <09143dca85a260cb6c3abc5efcf09075a8050265.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Add nvmem properties to calibrate FGU from eFuse controller.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
index 98a2400..fc35ac5 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
@@ -11,6 +11,8 @@ Required properties:
 - battery-detect-gpios: GPIO for battery detection.
 - io-channels: Specify the IIO ADC channel to get temperature.
 - io-channel-names: Should be "bat-temp".
+- nvmem-cells: A phandle to the calibration cells provided by eFuse device.
+- nvmem-cell-names: Should be "fgu_calib".
 - monitored-battery: Phandle of battery characteristics devicetree node.
   See Documentation/devicetree/bindings/power/supply/battery.txt
 
@@ -47,6 +49,8 @@ Example:
 			battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
 			io-channels = <&pmic_adc 5>;
 			io-channel-names = "bat-temp";
+			nvmem-cells = <&fgu_calib>;
+			nvmem-cell-names = "fgu_calib";
 			monitored-battery = <&bat>;
 		};
 	};
-- 
1.7.9.5
