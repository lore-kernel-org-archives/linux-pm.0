From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 12/23] thermal: armada: get rid of the ->is_valid() pointer
Date: Thu,  5 Jul 2018 18:04:26 +0200
Message-ID: <20180705160437.12325-13-miquel.raynal@bootlin.com>
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

The implementation of armada_is_valid() is very simple and is the same
across all the versions of the IP since the ->is_valid_bit has been
introduced. Simplify the structure by getting rid of the function
pointer and calling directly the function.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 7f8185e5816e..a05ec01d6848 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -82,9 +82,6 @@ struct armada_thermal_data {
 	void (*init)(struct platform_device *pdev,
 		     struct armada_thermal_priv *priv);
 
-	/* Test for a valid sensor value (optional) */
-	bool (*is_valid)(struct armada_thermal_priv *);
-
 	/* Formula coeficients: temp = (b - m * reg) / div */
 	s64 coef_b;
 	s64 coef_m;
@@ -266,6 +263,9 @@ static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
 	u32 reg;
 
+	if (!priv->data->is_valid_bit)
+		return true;
+
 	regmap_read(priv->syscon, priv->data->syscon_status_off, &reg);
 
 	return reg & priv->data->is_valid_bit;
@@ -356,7 +356,7 @@ static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
 	int ret;
 
 	/* Valid check */
-	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
+	if (armada_is_valid(priv)) {
 		dev_err(priv->dev,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
@@ -410,7 +410,6 @@ static const struct armada_thermal_data armadaxp_data = {
 };
 
 static const struct armada_thermal_data armada370_data = {
-	.is_valid = armada_is_valid,
 	.init = armada370_init,
 	.is_valid_bit = BIT(9),
 	.temp_shift = 10,
@@ -423,7 +422,6 @@ static const struct armada_thermal_data armada370_data = {
 };
 
 static const struct armada_thermal_data armada375_data = {
-	.is_valid = armada_is_valid,
 	.init = armada375_init,
 	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
@@ -437,7 +435,6 @@ static const struct armada_thermal_data armada375_data = {
 };
 
 static const struct armada_thermal_data armada380_data = {
-	.is_valid = armada_is_valid,
 	.init = armada380_init,
 	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
@@ -452,7 +449,6 @@ static const struct armada_thermal_data armada380_data = {
 };
 
 static const struct armada_thermal_data armada_ap806_data = {
-	.is_valid = armada_is_valid,
 	.init = armada_ap806_init,
 	.is_valid_bit = BIT(16),
 	.temp_shift = 0,
@@ -469,7 +465,6 @@ static const struct armada_thermal_data armada_ap806_data = {
 };
 
 static const struct armada_thermal_data armada_cp110_data = {
-	.is_valid = armada_is_valid,
 	.init = armada_cp110_init,
 	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
-- 
2.14.1
