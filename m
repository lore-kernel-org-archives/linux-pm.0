From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'
Date: Tue, 24 Jul 2018 16:51:30 -0700
Message-ID: <20180724235130.58592-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

The documentation claims that the 'reg' property consists of two values,
the SPMI address and the length of the controller's registers. However
the SPMI bus to which it is added specifies "#size-cells = <0>;". Remove
the controller register length from the documentation of the field and the
example.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt     | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
index 290ec06fa33a..86fb41fe772f 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
@@ -6,8 +6,7 @@ interrupt signal and status register to identify high PMIC die temperature.
 
 Required properties:
 - compatible:      Should contain "qcom,spmi-temp-alarm".
-- reg:             Specifies the SPMI address and length of the controller's
-                   registers.
+- reg:             Specifies the SPMI address.
 - interrupts:      PMIC temperature alarm interrupt.
 - #thermal-sensor-cells: Should be 0. See thermal.txt for a description.
 
@@ -20,7 +19,7 @@ Example:
 
 	pm8941_temp: thermal-alarm@2400 {
 		compatible = "qcom,spmi-temp-alarm";
-		reg = <0x2400 0x100>;
+		reg = <0x2400>;
 		interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
 		#thermal-sensor-cells = <0>;
 
-- 
2.18.0.233.g985f88cf7e-goog
