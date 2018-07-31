From: "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v4 3/4] power: bq25890_charger.c: Add the BQ25896 part
Date: Tue, 31 Jul 2018 11:49:08 -0600
Message-ID: <20180731174909.9392-4-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731174909.9392-1-angus@akkea.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731174909.9392-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Angus Ainslie (Purism)" <angus@akkea.ca>
List-Id: linux-pm@vger.kernel.org

The BQ25896 is almost identical to the BQ25890.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../bindings/power/supply/bq25890.txt         |  3 +++
 drivers/power/supply/bq25890_charger.c        | 24 +++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
index c9dd17d142ad..dc0568933359 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
@@ -1,5 +1,8 @@
 Binding for TI bq25890 Li-Ion Charger
 
+This driver will support the bq25896 and the bq25890. There are other ICs
+in the same family but those have not been tested.
+
 Required properties:
 - compatible: Should contain one of the following:
     * "ti,bq25890"
diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index ca61278e932e..23b39da07e56 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -32,6 +32,7 @@
 #define BQ25890_IRQ_PIN			"bq25890_irq"
 
 #define BQ25890_ID			3
+#define BQ25896_ID			0
 
 enum bq25890_fields {
 	F_EN_HIZ, F_EN_ILIM, F_IILIM,				     /* Reg00 */
@@ -153,8 +154,8 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_CONV_RATE]		= REG_FIELD(0x02, 6, 6),
 	[F_BOOSTF]		= REG_FIELD(0x02, 5, 5),
 	[F_ICO_EN]		= REG_FIELD(0x02, 4, 4),
-	[F_HVDCP_EN]		= REG_FIELD(0x02, 3, 3),
-	[F_MAXC_EN]		= REG_FIELD(0x02, 2, 2),
+	[F_HVDCP_EN]		= REG_FIELD(0x02, 3, 3),  // reserved on BQ25896
+	[F_MAXC_EN]		= REG_FIELD(0x02, 2, 2),  // reserved on BQ25896
 	[F_FORCE_DPM]		= REG_FIELD(0x02, 1, 1),
 	[F_AUTO_DPDM_EN]	= REG_FIELD(0x02, 0, 0),
 	/* REG03 */
@@ -163,6 +164,7 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_OTG_CFG]		= REG_FIELD(0x03, 5, 5),
 	[F_CHG_CFG]		= REG_FIELD(0x03, 4, 4),
 	[F_SYSVMIN]		= REG_FIELD(0x03, 1, 3),
+	/* MIN_VBAT_SEL on BQ25896 */
 	/* REG04 */
 	[F_PUMPX_EN]		= REG_FIELD(0x04, 7, 7),
 	[F_ICHG]		= REG_FIELD(0x04, 0, 6),
@@ -181,7 +183,7 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_CHG_TMR]		= REG_FIELD(0x07, 1, 2),
 	[F_JEITA_ISET]		= REG_FIELD(0x07, 0, 0),
 	/* REG08 */
-	[F_BATCMP]		= REG_FIELD(0x08, 6, 7),
+	[F_BATCMP]		= REG_FIELD(0x08, 6, 7), // 5-7 on BQ25896
 	[F_VCLAMP]		= REG_FIELD(0x08, 2, 4),
 	[F_TREG]		= REG_FIELD(0x08, 0, 1),
 	/* REG09 */
@@ -195,12 +197,13 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_PUMPX_DN]		= REG_FIELD(0x09, 0, 0),
 	/* REG0A */
 	[F_BOOSTV]		= REG_FIELD(0x0A, 4, 7),
+	/* PFM_OTG_DIS 3 on BQ25896 */
 	[F_BOOSTI]		= REG_FIELD(0x0A, 0, 2),
 	/* REG0B */
 	[F_VBUS_STAT]		= REG_FIELD(0x0B, 5, 7),
 	[F_CHG_STAT]		= REG_FIELD(0x0B, 3, 4),
 	[F_PG_STAT]		= REG_FIELD(0x0B, 2, 2),
-	[F_SDP_STAT]		= REG_FIELD(0x0B, 1, 1),
+	[F_SDP_STAT]		= REG_FIELD(0x0B, 1, 1), // reserved on BQ25896
 	[F_VSYS_STAT]		= REG_FIELD(0x0B, 0, 0),
 	/* REG0C */
 	[F_WD_FAULT]		= REG_FIELD(0x0C, 7, 7),
@@ -396,6 +399,16 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->strval = BQ25890_MANUFACTURER;
 		break;
 
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		if (bq->chip_id == BQ25890_ID)
+			val->strval = "BQ25890";
+		else if (bq->chip_id == BQ25896_ID)
+			val->strval = "BQ25896";
+		else
+			val->strval = "UNKNOWN";
+
+		break;
+
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = state.online;
 		break;
@@ -647,6 +660,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 
 static enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -848,7 +862,7 @@ static int bq25890_probe(struct i2c_client *client,
 		return bq->chip_id;
 	}
 
-	if (bq->chip_id != BQ25890_ID) {
+	if ((bq->chip_id != BQ25890_ID) && (bq->chip_id != BQ25896_ID)) {
 		dev_err(dev, "Chip with ID=%d, not supported!\n", bq->chip_id);
 		return -ENODEV;
 	}
-- 
2.17.1
