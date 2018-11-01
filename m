From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH v2 2/7] power: supply: bq24190_charger: add support for bq24192 variant
Date: Wed, 31 Oct 2018 20:11:44 -0400
Message-ID: <20181101001149.13453-3-masneyb@onstation.org>
References: <20181101001149.13453-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101001149.13453-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org, jonathan@marek.ca, masneyb@onstation.org
List-Id: linux-pm@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

This patch adds support for the bq24192 variant to bq24190_charger.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
[masneyb@onstation.org: Changed if statement to a switch based on
feedback from Sebastian Reichel.]
Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/power/supply/bq24190_charger.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index b58df04d03b3..44d3aff32885 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1637,8 +1637,12 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 	if (ret < 0)
 		return ret;
 
-	if (v != BQ24190_REG_VPRS_PN_24190 &&
-	    v != BQ24190_REG_VPRS_PN_24192I) {
+	switch (v) {
+	case BQ24190_REG_VPRS_PN_24190:
+	case BQ24190_REG_VPRS_PN_24192:
+	case BQ24190_REG_VPRS_PN_24192I:
+		break;
+	default:
 		dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
 		return -ENODEV;
 	}
@@ -1931,6 +1935,7 @@ static const struct dev_pm_ops bq24190_pm_ops = {
 
 static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24190" },
+	{ "bq24192" },
 	{ "bq24192i" },
 	{ },
 };
@@ -1939,6 +1944,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
 #ifdef CONFIG_OF
 static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", },
+	{ .compatible = "ti,bq24192", },
 	{ .compatible = "ti,bq24192i", },
 	{ },
 };
-- 
2.17.2
