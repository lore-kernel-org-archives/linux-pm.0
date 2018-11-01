From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH v2 3/7] power: supply: bq24190_charger: add of_match for usb-otg-vbus regulator
Date: Wed, 31 Oct 2018 20:11:45 -0400
Message-ID: <20181101001149.13453-4-masneyb@onstation.org>
References: <20181101001149.13453-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101001149.13453-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org, jonathan@marek.ca, masneyb@onstation.org
List-Id: linux-pm@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

This patch adds an of_match for the usb-otg-vbus regulator to
bq24190_charger.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/power/supply/bq24190_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 44d3aff32885..9e7f3e33458a 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -577,6 +577,7 @@ static const struct regulator_ops bq24190_vbus_ops = {
 
 static const struct regulator_desc bq24190_vbus_desc = {
 	.name = "usb_otg_vbus",
+	.of_match = "usb-otg-vbus",
 	.type = REGULATOR_VOLTAGE,
 	.owner = THIS_MODULE,
 	.ops = &bq24190_vbus_ops,
-- 
2.17.2
