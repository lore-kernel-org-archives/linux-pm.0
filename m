From: Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v5 02/11] dt-bindings: power: supply: axp20x: add AXP803 power bindings
Date: Tue, 23 Oct 2018 21:53:21 +0300
Message-ID: <20181023185330.10472-3-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The AXP803 power supplies are compatible with AXP813, but
add specific compatibles for them.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 .../devicetree/bindings/power/supply/axp20x_ac_power.txt         | 1 +
 .../devicetree/bindings/power/supply/axp20x_battery.txt          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
index 7a1fb532abe5..acdeb4b8f4cc 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
@@ -4,6 +4,7 @@ Required Properties:
  - compatible: One of:
 			"x-powers,axp202-ac-power-supply"
 			"x-powers,axp221-ac-power-supply"
+			"x-powers,axp803-ac-power-supply"
 			"x-powers,axp813-ac-power-supply"
 
 This node is a subnode of the axp20x PMIC.
diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
index 41916f69902c..780ebd7e3b84 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
@@ -4,6 +4,7 @@ Required Properties:
  - compatible, one of:
 			"x-powers,axp209-battery-power-supply"
 			"x-powers,axp221-battery-power-supply"
+			"x-powers,axp803-battery-power-supply"
 			"x-powers,axp813-battery-power-supply"
 
 This node is a subnode of its respective PMIC DT node.
-- 
2.17.1
