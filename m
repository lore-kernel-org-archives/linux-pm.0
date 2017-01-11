From: Christian Mauderer <oss@c-mauderer.de>
Subject: [PATCH] mfd: axp20x: Add AXP288 volatile registers.
Date: Wed, 11 Jan 2017 20:49:41 +0100
Message-ID: <20170111194941.5425-1-oss@c-mauderer.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from dehamd084.servertools24.de ([31.47.243.162]:49853 "EHLO
        dehamd084.servertools24.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754646AbdAKTzp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2017 14:55:45 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christian Mauderer <oss@c-mauderer.de>

The axp288_fuelgauge driver and some other axp288_xxx are using a number
of the registers of the chip that are changed by hardware (for example
charge level). Because these registers are not marked as "volatile" in
the regmap, a cached version is used instead of the correct register
value. In case of the axp288_fuelgauge that leads to a battery level
that only changes on reboot. This patch adds the volatile registers of
the chip.

Signed-off-by: Christian Mauderer <oss@c-mauderer.de>
---
 drivers/mfd/axp20x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index ed918de84238..d74b3daca23f 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -118,7 +118,10 @@ static const struct regmap_range axp288_writeable_ranges[] = {
 };
 
 static const struct regmap_range axp288_volatile_ranges[] = {
+	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IPSOUT_V_HIGH_L),
+	regmap_reg_range(AXP20X_CC_CTRL, AXP288_FG_OCVL_REG),
+	regmap_reg_range(AXP288_FG_DES_CAP1_REG, AXP288_FG_CC_CAP_REG),
 };
 
 static const struct regmap_access_table axp288_writeable_table = {
-- 
2.11.0

