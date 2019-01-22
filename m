From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [RFC PATCH v1 09/13] devicetree: bindings: ROHM bd70528 regulator
 bindings
Date: Tue, 22 Jan 2019 11:46:37 +0200
Message-ID: <4818d84fe334e9f68f3968663cddce8e45c87c6c.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org

ROHM bd70528 is a ultra low power PMIC which includes
3 bucks, 3 LDOs and 2 LED drivers. Document the bindings
for them.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../bindings/regulator/rohm,bd70528-regulator.txt  | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
new file mode 100644
index 000000000000..698cfc3bc3dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
@@ -0,0 +1,68 @@
+ROHM BD70528 Power Management Integrated Circuit regulator bindings
+
+Required properties:
+ - regulator-name: should be "buck1", "buck2", "buck3", "ldo1", "ldo2", "ldo3",
+		   "led_ldo1", "led_ldo2"
+
+List of regulators provided by this controller. BD70528 regulators node
+should be sub node of the BD70528 MFD node. See BD70528 MFD bindings at
+Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
+
+The valid names for BD70528 regulator nodes are:
+BUCK1, BUCK2, BUCK3, LDO1, LDO2, LDO3, LED_LDO1, LED_LDO2
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+regulators {
+	buck1: BUCK1 {
+		regulator-name = "buck1";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <3400000>;
+		regulator-boot-on;
+		regulator-ramp-delay = <125>;
+	};
+	buck2: BUCK2 {
+		regulator-name = "buck2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-ramp-delay = <125>;
+	};
+	buck3: BUCK3 {
+		regulator-name = "buck3";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-ramp-delay = <250>;
+	};
+	ldo1: LDO1 {
+		regulator-name = "ldo1";
+		regulator-min-microvolt = <1650000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+	ldo2: LDO2 {
+		regulator-name = "ldo2";
+		regulator-min-microvolt = <1650000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+
+	ldo3: LDO3 {
+		regulator-name = "ldo3";
+		regulator-min-microvolt = <1650000>;
+		regulator-max-microvolt = <3300000>;
+	};
+	led_ldo1: LED_LDO1 {
+		regulator-name = "led_ldo1";
+		regulator-min-microvolt = <200000>;
+		regulator-max-microvolt = <300000>;
+	};
+	led_ldo2: LED_LDO2 {
+		regulator-name = "led_ldo2";
+		regulator-min-microvolt = <200000>;
+		regulator-max-microvolt = <300000>;
+	};
+};
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
