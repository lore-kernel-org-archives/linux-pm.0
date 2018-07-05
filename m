From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 10/23] thermal: armada: remove sensors validity from the IP
 initialization
Date: Thu,  5 Jul 2018 18:04:24 +0200
Message-ID: <20180705160437.12325-11-miquel.raynal@bootlin.com>
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

When using new bindings with multiple sensors, sensor validity is
checked twice because sensor selection also checks for the validity.

Remove the redundant call from the IP initialization helper and move it
to the legacy probe section where it is still needed.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index eef8947b9b20..7eafc9400fbe 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -221,9 +221,6 @@ static void armada380_init(struct platform_device *pdev,
 	reg &= ~CONTROL0_TSEN_TC_TRIM_MASK;
 	reg |= CONTROL0_TSEN_TC_TRIM_VAL;
 	regmap_write(priv->syscon, data->syscon_control0_off, reg);
-
-	/* Wait the sensors to be valid or the core will warn the user */
-	armada_wait_sensor_validity(priv);
 }
 
 static void armada_ap806_init(struct platform_device *pdev,
@@ -243,9 +240,6 @@ static void armada_ap806_init(struct platform_device *pdev,
 	reg &= ~CONTROL0_TSEN_AVG_BYPASS;
 
 	regmap_write(priv->syscon, data->syscon_control0_off, reg);
-
-	/* Wait the sensors to be valid or the core will warn the user */
-	armada_wait_sensor_validity(priv);
 }
 
 static void armada_cp110_init(struct platform_device *pdev,
@@ -650,6 +644,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
 
 		priv->data->init(pdev, priv);
 
+		/* Wait the sensors to be valid */
+		armada_wait_sensor_validity(priv);
+
 		tz = thermal_zone_device_register(priv->zone_name, 0, 0, priv,
 						  &legacy_ops, NULL, 0, 0);
 		if (IS_ERR(tz)) {
-- 
2.14.1
