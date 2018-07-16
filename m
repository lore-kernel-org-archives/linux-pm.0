From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 11/23] thermal: armada: move validity check out of the read
 function
Date: Mon, 16 Jul 2018 16:41:54 +0200
Message-ID: <20180716144206.30985-12-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180716144206.30985-1-miquel.raynal@bootlin.com>
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

Sensor selection when using multiple sensors already checks for the
sensor validity. Move it to the legacy ->get_temp() hook, where it is
still needed.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 7eafc9400fbe..7f8185e5816e 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -328,13 +328,6 @@ static int armada_read_sensor(struct armada_thermal_priv *priv, int *temp)
 	u32 reg, div;
 	s64 sample, b, m;
 
-	/* Valid check */
-	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
-		dev_err(priv->dev,
-			"Temperature sensor reading not valid\n");
-		return -EIO;
-	}
-
 	regmap_read(priv->syscon, priv->data->syscon_status_off, &reg);
 	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
 	if (priv->data->signed_sample)
@@ -362,6 +355,13 @@ static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
 	struct armada_thermal_priv *priv = thermal->devdata;
 	int ret;
 
+	/* Valid check */
+	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
+		dev_err(priv->dev,
+			"Temperature sensor reading not valid\n");
+		return -EIO;
+	}
+
 	/* Do the actual reading */
 	ret = armada_read_sensor(priv, temp);
 
-- 
2.14.1
