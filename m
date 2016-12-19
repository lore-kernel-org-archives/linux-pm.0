From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 12/14] power: supply: axp288_charger: Fix wrong regmap_update_bits
Date: Mon, 19 Dec 2016 01:07:29 +0100
Message-ID: <20161219000731.10188-13-hdegoede@redhat.com>
References: <20161219000731.10188-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219000731.10188-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

To set a bit to 1 one needs to pass the mask for the bit to set
as second argument into regmap_update_bits, not "1".

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index b489289..4a19666 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -705,7 +705,7 @@ static int charger_init_hw_regs(struct axp288_chrg_info *info)
 	/* Do not turn-off charger o/p after charge cycle ends */
 	ret = regmap_update_bits(info->regmap,
 				AXP20X_CHRG_CTRL2,
-				CNTL2_CHG_OUT_TURNON, 1);
+				CNTL2_CHG_OUT_TURNON, CNTL2_CHG_OUT_TURNON);
 	if (ret < 0) {
 		dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
 						AXP20X_CHRG_CTRL2, ret);
-- 
2.9.3
