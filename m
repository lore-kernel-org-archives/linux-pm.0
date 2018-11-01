From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH v2 5/7] pinctrl: qcom: spmi-gpio: fix gpio-hog related boot issues
Date: Wed, 31 Oct 2018 20:11:47 -0400
Message-ID: <20181101001149.13453-6-masneyb@onstation.org>
References: <20181101001149.13453-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101001149.13453-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org, jonathan@marek.ca, masneyb@onstation.org
List-Id: linux-pm@vger.kernel.org

When attempting to setup up a gpio hog, device probing would repeatedly
fail with -EPROBE_DEFERED errors. It was caused by a circular dependency
between the gpio and pinctrl frameworks. If the gpio-ranges property is
present in device tree, then the gpio framework will handle the gpio pin
registration and eliminate the circular dependency.

See Christian Lamparter's commit a86caa9ba5d7 ("pinctrl: msm: fix
gpio-hog related boot issues") for a detailed commit message that
explains the issue in much more detail. The code comment in this commit
came from Christian's commit.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index a29efbe08f48..4c1ff9a1d156 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1028,10 +1028,23 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = gpiochip_add_pin_range(&state->chip, dev_name(dev), 0, 0, npins);
-	if (ret) {
-		dev_err(dev, "failed to add pin range\n");
-		goto err_range;
+	/*
+	 * For DeviceTree-supported systems, the gpio core checks the
+	 * pinctrl's device node for the "gpio-ranges" property.
+	 * If it is present, it takes care of adding the pin ranges
+	 * for the driver. In this case the driver can skip ahead.
+	 *
+	 * In order to remain compatible with older, existing DeviceTree
+	 * files which don't set the "gpio-ranges" property or systems that
+	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
+	 */
+	if (!of_property_read_bool(dev->of_node, "gpio-ranges")) {
+		ret = gpiochip_add_pin_range(&state->chip, dev_name(dev), 0, 0,
+					     npins);
+		if (ret) {
+			dev_err(dev, "failed to add pin range\n");
+			goto err_range;
+		}
 	}
 
 	return 0;
-- 
2.17.2
