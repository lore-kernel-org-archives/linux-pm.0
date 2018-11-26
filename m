From: Priit Laes <plaes@plaes.org>
Subject: [PATCH 04/14] regulator: axp20x: add support for set_ramp_delay for
 AXP209
Date: Mon, 26 Nov 2018 17:27:45 +0200
Message-ID: <314a16a39da769ef411a58f6fad45e5be65ec0e1.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Olliver Schinagl <oliver@schinagl.nl>, Priit Laes <plaes@plaes.org>
List-Id: linux-pm@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

The AXP209 supports ramping up voltages on several regulators such as
DCDC2 and LDO3.

This patch adds preliminary support for the regulator-ramp-delay property
for these 2 regulators. Note that the voltage ramp only works when
regulator is already enabled. E.g. when going from say 0.7 V to 3.6 V.

When turning on the regulator, no voltage ramp is performed in hardware.

What this means, is that if the bootloader brings up the voltage at 0.7 V,
the ramp delay property is properly applied. If however, the bootloader
leaves the power off, no ramp delay is applied when the power is
enabled by the regulator framework.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/regulator/axp20x-regulator.c | 85 +++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 9a2db28..1d9fa62 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -51,6 +51,17 @@
 #define AXP20X_PWR_OUT_DCDC2_MASK	BIT_MASK(4)
 #define AXP20X_PWR_OUT_LDO3_MASK	BIT_MASK(6)
 
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK	BIT_MASK(0)
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE(x) \
+	((x) << 0)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK		BIT_MASK(1)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(x) \
+	((x) << 1)
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK		BIT_MASK(2)
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN		BIT(2)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK		BIT_MASK(3)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN		BIT(3)
+
 #define AXP20X_LDO4_V_OUT_1250mV_START	0x0
 #define AXP20X_LDO4_V_OUT_1250mV_STEPS	0
 #define AXP20X_LDO4_V_OUT_1250mV_END	\
@@ -346,6 +357,79 @@
 		.ops		= &axp20x_ops_range,				\
 	}
 
+static const int axp209_dcdc2_ldo3_slew_rates[] = {
+	1600,
+	 800,
+};
+
+static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
+{
+	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
+	const struct regulator_desc *desc = rdev->desc;
+	u8 reg, mask, enable, cfg = 0xff;
+	const int *slew_rates;
+	int rate_count = 0;
+
+	if (!rdev)
+		return -EINVAL;
+
+	switch (axp20x->variant) {
+	case AXP209_ID:
+		if (desc->id == AXP20X_DCDC2) {
+			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
+			reg = AXP20X_DCDC2_LDO3_V_RAMP;
+			mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
+			       AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
+			enable = (ramp > 0) ?
+				 AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN :
+				 !AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN;
+			break;
+		}
+
+		if (desc->id == AXP20X_LDO3) {
+			slew_rates = axp209_dcdc2_ldo3_slew_rates;
+			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
+			reg = AXP20X_DCDC2_LDO3_V_RAMP;
+			mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
+			       AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
+			enable = (ramp > 0) ?
+				 AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN :
+				 !AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN;
+			break;
+		}
+
+		if (rate_count > 0)
+			break;
+
+		/* fall through */
+	default:
+		/* Not supported for this regulator */
+		return -ENOTSUPP;
+	}
+
+	if (ramp == 0) {
+		cfg = enable;
+	} else {
+		int i;
+
+		for (i = 0; i < rate_count; i++) {
+			if (ramp <= slew_rates[i])
+				cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
+			else
+				break;
+		}
+
+		if (cfg == 0xff) {
+			dev_err(axp20x->dev, "unsupported ramp value %d", ramp);
+			return -EINVAL;
+		}
+
+		cfg |= enable;
+	}
+
+	return regmap_update_bits(axp20x->regmap, reg, mask, cfg);
+}
+
 static const struct regulator_ops axp20x_ops_fixed = {
 	.list_voltage		= regulator_list_voltage_linear,
 };
@@ -366,6 +450,7 @@ static const struct regulator_ops axp20x_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
+	.set_ramp_delay		= axp20x_set_ramp_delay,
 };
 
 static const struct regulator_ops axp20x_ops_sw = {
-- 
git-series 0.9.1
