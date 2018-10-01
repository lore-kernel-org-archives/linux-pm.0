From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH RFC 3/5] power: supply: bq24190_charger: add of_match for usb-otg-vbus regulator
Date: Mon,  1 Oct 2018 01:30:03 -0400
Message-ID: <20181001053005.18906-4-masneyb@onstation.org>
References: <20181001053005.18906-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001053005.18906-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, jonathan@marek.ca
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
index e3836145286d..933d1cded697 100644
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
2.17.1
