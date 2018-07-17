From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] power: supply: max77693_charger: fix unintentional
 fall-through
Date: Tue, 17 Jul 2018 16:47:39 -0500
Message-ID: <20180717214739.GA19410@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

It seems that a *break* is missing in order to avoid a fall-through.
Otherwise, the calculation of *data* makes no sense.

Addresses-Coverity-ID: 1271172 ("Missing break in switch")
Fixes: 87c2d9067893 ("power: max77693: Add charger driver for Maxim 77693")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/power/supply/max77693_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 6c78884..749c792 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -567,6 +567,7 @@ static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg
 	case 4800000:
 	case 4900000:
 		data = (uvolt - 4700000) / 100000;
+		break;
 	default:
 		dev_err(chg->dev, "Wrong value for charge input voltage regulation threshold\n");
 		return -EINVAL;
-- 
2.7.4
