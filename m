From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] devicetree: power: add bindings for GPIO-driven power switches
Date: Sun, 11 Dec 2016 23:21:44 +0100
Message-ID: <1481494905-18037-2-git-send-email-bgolaszewski@baylibre.com>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Some boards are equipped with simple, GPIO-driven power load switches.
An example of such ICs is the TI tps229* series.

Add device tree bindings allowing to describe them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/power/gpio-power-switch.txt           | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/gpio-power-switch.txt

diff --git a/Documentation/devicetree/bindings/power/gpio-power-switch.txt b/Documentation/devicetree/bindings/power/gpio-power-switch.txt
new file mode 100644
index 0000000..21420ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/gpio-power-switch.txt
@@ -0,0 +1,25 @@
+GPIO Power Switch
+-----------------
+
+This is the device tree binding for simple, GPIO-driven power load switches
+that do not have any control signals.
+
+Required properties:
+
+- compatible:           must be "gpio-power-switch"
+- power-gpios:          phandle for the GPIO driving the power load switch
+
+Optional properties:
+
+- power-switch-name:    the name of the power switch
+- power-switch-on:      the power switch GPIO is driven high by default
+
+Example
+-------
+
+acme_probe0_power_switch: gpio_power_switch@0 {
+	compatible = "gpio-power-switch";
+	power-switch-name = "acme_probe0_switch";
+	power-gpios = <&pca9535 1 GPIO_ACTIVE_HIGH>;
+	power-switch-on;
+};
-- 
2.9.3
