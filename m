From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH RESEND v6 1/3] Documentation: dts: Documentation entry to
 explain how to use PWM FAN as a cooling device
Date: Tue, 11 Aug 2015 15:07:18 +0200
Message-ID: <1439298440-15882-2-git-send-email-l.majewski@samsung.com>
References: <1425470624-25793-1-git-send-email-l.majewski@samsung.com>
 <1439298440-15882-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1439298440-15882-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Explanation of several properties, which allow PWM fan working as a cooling
device, have been embraced in this commit.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
 .../devicetree/bindings/hwmon/pwm-fan.txt          | 29 ++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
index 610757c..c6d5332 100644
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
@@ -3,10 +3,35 @@ Bindings for a fan connected to the PWM lines
 Required properties:
 - compatible	: "pwm-fan"
 - pwms		: the PWM that is used to control the PWM fan
+- cooling-levels      : PWM duty cycle values in a range from 0 to 255
+			which correspond to thermal cooling states
 
 Example:
-	pwm-fan {
+	fan0: pwm-fan {
 		compatible = "pwm-fan";
-		status = "okay";
+		cooling-min-state = <0>;
+		cooling-max-state = <3>;
+		#cooling-cells = <2>;
 		pwms = <&pwm 0 10000 0>;
+		cooling-levels = <0 102 170 230>;
 	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			     thermal-sensors = <&tmu 0>;
+			     polling-delay-passive = <0>;
+			     polling-delay = <0>;
+			     trips {
+					cpu_alert1: cpu-alert1 {
+						    temperature = <100000>; /* millicelsius */
+						    hysteresis = <2000>; /* millicelsius */
+						    type = "passive";
+					};
+			     };
+			     cooling-maps {
+					map0 {
+						    trip = <&cpu_alert1>;
+						    cooling-device = <&fan0 0 1>;
+					};
+			     };
+		};
-- 
2.0.0.rc2
