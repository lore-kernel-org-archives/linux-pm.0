From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 02/27] thermal: armada: remove useless register accesses
Date: Sat, 21 Apr 2018 17:12:30 +0200
Message-ID: <20180421151255.29929-3-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Prepare the migration to use regmaps by first simplifying the
initialization functions: avoid unnecessary write/read cycles on
configuration registers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 077e8e562306..6fdb90b3c001 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -103,16 +103,13 @@ static void armadaxp_init_sensor(struct platform_device *pdev,
 
 	reg = readl_relaxed(priv->control1);
 	reg |= PMU_TDC0_OTF_CAL_MASK;
-	writel(reg, priv->control1);
 
 	/* Reference calibration value */
 	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
 	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
-	writel(reg, priv->control1);
 
 	/* Reset the sensor */
-	reg = readl_relaxed(priv->control1);
-	writel((reg | PMU_TDC0_SW_RST_MASK), priv->control1);
+	reg |= PMU_TDC0_SW_RST_MASK;
 
 	writel(reg, priv->control1);
 
@@ -129,14 +126,13 @@ static void armada370_init_sensor(struct platform_device *pdev,
 
 	reg = readl_relaxed(priv->control1);
 	reg |= PMU_TDC0_OTF_CAL_MASK;
-	writel(reg, priv->control1);
 
 	/* Reference calibration value */
 	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
 	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
-	writel(reg, priv->control1);
 
 	reg &= ~PMU_TDC0_START_CAL_MASK;
+
 	writel(reg, priv->control1);
 
 	msleep(10);
-- 
2.14.1
