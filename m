From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 1/3] thermal: qcom-spmi: Allow to disable stage 2 shutdown
Date: Tue, 17 Jul 2018 14:08:13 -0700
Message-ID: <20180717210815.245639-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

When the temperature reaches stage 2 the PMIC performs by default a
'partial shutdown', unless software override is enabled. It is not well
defined which peripherals are affected by a 'partial shutdown'. Drivers
might be unhappy when their devices suddenly disappear and prevent an
orderly shutdown.

Add an optional device tree property that allows to disable stage 2
shutdown.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v4:
- patch added to the series
---
 .../bindings/thermal/qcom-spmi-temp-alarm.txt |  3 ++
 drivers/thermal/qcom-spmi-temp-alarm.c        | 28 +++++++++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
index 290ec06fa33a..377c94fa1821 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
@@ -15,6 +15,8 @@ Optional properties:
 - io-channels:     Should contain IIO channel specifier for the ADC channel,
                    which report chip die temperature.
 - io-channel-names: Should contain "thermal".
+- stage2-shutdown-disabled: boolean to disable a partial shutdown of the PMIC
+                            when the temperature reaches stage 2
 
 Example:
 
@@ -23,6 +25,7 @@ Example:
 		reg = <0x2400 0x100>;
 		interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
 		#thermal-sensor-cells = <0>;
+		stage2-shutdown-disabled;
 
 		io-channels = <&pm8941_vadc VADC_DIE_TEMP>;
 		io-channel-names = "thermal";
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index ad4f3a8d6560..acbb0dbec79e 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -37,7 +37,9 @@
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
 #define STATUS_GEN2_STATE_SHIFT		4
 
-#define SHUTDOWN_CTRL1_OVERRIDE_MASK	GENMASK(7, 6)
+#define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
+#define SHUTDOWN_CTRL1_OVERRIDE_S2_MASK	GENMASK(6, 6)
+#define SHUTDOWN_CTRL1_OVERRIDE_S3_MASK	GENMASK(7, 7)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
 #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
@@ -198,7 +200,8 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
  * current thermal stage and threshold. Setup threshold control and
  * disable shutdown override.
  */
-static int qpnp_tm_init(struct qpnp_tm_chip *chip)
+static int qpnp_tm_init(struct qpnp_tm_chip *chip,
+			bool disable_stage2_shutdown)
 {
 	unsigned int stage;
 	int ret;
@@ -224,13 +227,18 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 			     (stage - 1) * TEMP_STAGE_STEP +
 			     TEMP_THRESH_MIN;
 
-	/*
-	 * Set threshold and disable software override of stage 2 and 3
-	 * shutdowns.
-	 */
+	/* Set threshold and disable software override of stage 3 shutdown. */
 	chip->thresh = THRESH_MIN;
-	reg &= ~(SHUTDOWN_CTRL1_OVERRIDE_MASK | SHUTDOWN_CTRL1_THRESHOLD_MASK);
+	reg &= ~(SHUTDOWN_CTRL1_OVERRIDE_S3_MASK |
+		 SHUTDOWN_CTRL1_THRESHOLD_MASK);
 	reg |= chip->thresh & SHUTDOWN_CTRL1_THRESHOLD_MASK;
+
+	/* Disable stage 2 shutdown if requested */
+	if (disable_stage2_shutdown)
+		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
+	else
+		reg &= ~SHUTDOWN_CTRL1_OVERRIDE_S2_MASK;
+
 	ret = qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 	if (ret < 0)
 		return ret;
@@ -248,6 +256,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	struct device_node *node;
 	u8 type, subtype;
 	u32 res;
+	bool stage2_shutdown_disabled;
 	int ret, irq;
 
 	node = pdev->dev.of_node;
@@ -302,7 +311,10 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 
 	chip->subtype = subtype;
 
-	ret = qpnp_tm_init(chip);
+	stage2_shutdown_disabled = of_property_read_bool(node,
+						"stage2-shutdown-disabled");
+
+	ret = qpnp_tm_init(chip, stage2_shutdown_disabled);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "init failed\n");
 		return ret;
-- 
2.18.0.203.gfac676dfb9-goog
