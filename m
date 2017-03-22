From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [RFC 5/8] regulator: anatop: fix min dropout for bypass mode
Date: Wed, 22 Mar 2017 18:53:07 +0200
Message-ID: <cd944a7223cfe68788c299082a5f262e8bea2136.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1490199005.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Irina Tirdea <irina.tirdea@nxp.com>

In bypass mode, the anatop digital regulators do not have any minimum
dropout value (the input voltage is equal to the output voltage according
to documentation).

Having a min dropout value of 125mV will lead to an increased voltage
for PMIC supplies.

Only set minimum dropout value for ldo enabled mode.

Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/regulator/anatop-regulator.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index b041f27..64554e8 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -38,6 +38,8 @@
 #define LDO_POWER_GATE			0x00
 #define LDO_FET_FULL_ON			0x1f
 
+#define LDO_MIN_DROPOUT_UV		125000
+
 struct anatop_regulator {
 	const char *name;
 	u32 control_reg;
@@ -153,6 +155,10 @@ static int anatop_regmap_set_bypass(struct regulator_dev *reg, bool enable)
 
 	sel = enable ? LDO_FET_FULL_ON : anatop_reg->sel;
 	anatop_reg->bypass = enable;
+	if (anatop_reg->bypass)
+		anatop_reg->rdesc.min_dropout_uV = 0;
+	else
+		anatop_reg->rdesc.min_dropout_uV = LDO_MIN_DROPOUT_UV;
 
 	return regulator_set_voltage_sel_regmap(reg, sel);
 }
@@ -264,7 +270,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	rdesc->vsel_reg = sreg->control_reg;
 	rdesc->vsel_mask = ((1 << sreg->vol_bit_width) - 1) <<
 			   sreg->vol_bit_shift;
-	rdesc->min_dropout_uV = 125000;
+	rdesc->min_dropout_uV = LDO_MIN_DROPOUT_UV;
 
 	config.dev = &pdev->dev;
 	config.init_data = initdata;
@@ -286,6 +292,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 		if (sreg->sel == LDO_FET_FULL_ON) {
 			sreg->sel = 0;
 			sreg->bypass = true;
+			rdesc->min_dropout_uV = 0;
 		}
 
 		/*
-- 
2.7.4
