From: Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
Date: Tue, 23 Oct 2018 21:53:23 +0300
Message-ID: <20181023185330.10472-5-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The AXP803 ADC is compatible with AXP813 ADC, but add
specific compatible for it.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
index 7a6313913923..1dbd5e480acd 100644
--- a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
@@ -4,6 +4,7 @@ Required properties:
   - compatible: should be one of:
     - "x-powers,axp209-adc",
     - "x-powers,axp221-adc",
+    - "x-powers,axp803-adc",
     - "x-powers,axp813-adc",
   - #io-channel-cells: should be 1,
 
@@ -39,6 +40,7 @@ AXP22x
  2 | batt_chrg_i
  3 | batt_dischrg_i
 
+AXP803
 AXP813
 ------
  0 | pmic_temp
-- 
2.17.1
