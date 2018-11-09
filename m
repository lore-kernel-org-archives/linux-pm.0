From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] power: supply: bq24190_charger: add support for bq24196 variant
Date: Fri,  9 Nov 2018 13:53:35 +0100
Message-ID: <20181109125335.1219-1-heiko@sntech.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, heiko@sntech.de, Heiko Stuebner <heiko.stuebner@bq.com>
List-Id: linux-pm@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

The bq24196 is another variant of the bq24190 charger ic.
Its register set is identical to the bq24192 and it even reuses
the same part number (0x5).

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
This should go on top of the bq24192 support patches from Brian Masney /
Jonathan Marek [0]

[0] https://patchwork.kernel.org/patch/10663409/

 drivers/power/supply/bq24190_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 4e64e6ac95c5..effa7c3c21e6 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -143,7 +143,7 @@
 #define BQ24190_REG_VPRS_PN_MASK		(BIT(5) | BIT(4) | BIT(3))
 #define BQ24190_REG_VPRS_PN_SHIFT		3
 #define BQ24190_REG_VPRS_PN_24190			0x4
-#define BQ24190_REG_VPRS_PN_24192			0x5 /* Also 24193 */
+#define BQ24190_REG_VPRS_PN_24192			0x5 /* Also 24193, 24196 */
 #define BQ24190_REG_VPRS_PN_24192I			0x3
 #define BQ24190_REG_VPRS_TS_PROFILE_MASK	BIT(2)
 #define BQ24190_REG_VPRS_TS_PROFILE_SHIFT	2
@@ -1973,6 +1973,7 @@ static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24190" },
 	{ "bq24192" },
 	{ "bq24192i" },
+	{ "bq24196" },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
@@ -1982,6 +1983,7 @@ static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", },
 	{ .compatible = "ti,bq24192", },
 	{ .compatible = "ti,bq24192i", },
+	{ .compatible = "ti,bq24196", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq24190_of_match);
-- 
2.18.0
