From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH RFC 2/5] power: supply: bq24190_charger: add support for bq24192 variant
Date: Mon,  1 Oct 2018 01:30:02 -0400
Message-ID: <20181001053005.18906-3-masneyb@onstation.org>
References: <20181001053005.18906-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001053005.18906-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, jonathan@marek.ca
List-Id: linux-pm@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

This patch adds support for the bq24192 variant to bq24190_charger.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/power/supply/bq24190_charger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index b58df04d03b3..e3836145286d 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1638,7 +1638,8 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 		return ret;
 
 	if (v != BQ24190_REG_VPRS_PN_24190 &&
-	    v != BQ24190_REG_VPRS_PN_24192I) {
+		v != BQ24190_REG_VPRS_PN_24192 &&
+		v != BQ24190_REG_VPRS_PN_24192I) {
 		dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
 		return -ENODEV;
 	}
@@ -1931,6 +1932,7 @@ static const struct dev_pm_ops bq24190_pm_ops = {
 
 static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24190" },
+	{ "bq24192" },
 	{ "bq24192i" },
 	{ },
 };
@@ -1939,6 +1941,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
 #ifdef CONFIG_OF
 static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", },
+	{ .compatible = "ti,bq24192", },
 	{ .compatible = "ti,bq24192i", },
 	{ },
 };
-- 
2.17.1
