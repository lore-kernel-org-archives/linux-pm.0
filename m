From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 06/23] thermal: armada: average over samples to avoid
 glitches
Date: Thu,  5 Jul 2018 18:04:20 +0200
Message-ID: <20180705160437.12325-7-miquel.raynal@bootlin.com>
References: <20180705160437.12325-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180705160437.12325-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Configure the sample frequency and number of averaged samples.

This is needed for two reasons:
1/ To be bootloader independent.
2/ To prepare the introduction of multi-sensors support by preventing
   inconsistencies when reading temperatures that could be a mean of
   samples took from different sensors.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 9291ea3ad2f7..1f9706d96a0d 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -54,7 +54,12 @@
 #define CONTROL0_TSEN_START		BIT(0)
 #define CONTROL0_TSEN_RESET		BIT(1)
 #define CONTROL0_TSEN_ENABLE		BIT(2)
+#define CONTROL0_TSEN_AVG_BYPASS	BIT(6)
+#define CONTROL0_TSEN_OSR_SHIFT		24
+#define CONTROL0_TSEN_OSR_MAX		0x3
 
+#define CONTROL1_TSEN_AVG_SHIFT		0
+#define CONTROL1_TSEN_AVG_MASK		0x7
 #define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
 #define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)
 
@@ -194,6 +199,13 @@ static void armada_ap806_init(struct platform_device *pdev,
 	reg = readl_relaxed(priv->control0);
 	reg &= ~CONTROL0_TSEN_RESET;
 	reg |= CONTROL0_TSEN_START | CONTROL0_TSEN_ENABLE;
+
+	/* Sample every ~2ms */
+	reg |= CONTROL0_TSEN_OSR_MAX << CONTROL0_TSEN_OSR_SHIFT;
+
+	/* Enable average (2 samples by default) */
+	reg &= ~CONTROL0_TSEN_AVG_BYPASS;
+
 	writel(reg, priv->control0);
 
 	/* Wait the sensors to be valid or the core will warn the user */
@@ -203,7 +215,20 @@ static void armada_ap806_init(struct platform_device *pdev,
 static void armada_cp110_init(struct platform_device *pdev,
 			      struct armada_thermal_priv *priv)
 {
+	u32 reg;
+
 	armada380_init(pdev, priv);
+
+	/* Sample every ~2ms */
+	reg = readl_relaxed(priv->control0);
+	reg |= CONTROL0_TSEN_OSR_MAX << CONTROL0_TSEN_OSR_SHIFT;
+	writel(reg, priv->control0);
+
+	/* Average the output value over 2^1 = 2 samples */
+	reg = readl_relaxed(priv->control1);
+	reg &= ~CONTROL1_TSEN_AVG_MASK << CONTROL1_TSEN_AVG_SHIFT;
+	reg |= 1 << CONTROL1_TSEN_AVG_SHIFT;
+	writel(reg, priv->control1);
 }
 
 static bool armada_is_valid(struct armada_thermal_priv *priv)
-- 
2.14.1
