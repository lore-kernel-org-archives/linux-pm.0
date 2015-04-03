From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v2 2/2] power: max17042_battery: add missed blank
Date: Fri, 03 Apr 2015 17:26:09 +0900
Message-ID: <1428049570-3295-3-git-send-email-beomho.seo@samsung.com>
References: <1428049570-3295-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56792 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809AbbDCI03 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 04:26:29 -0400
In-reply-to: <1428049570-3295-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, k.kozlowski@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, inki.dae@samsung.com, sangbae90.lee@samsung.com, Beomho Seo <beomho.seo@samsung.com>

This patch add missed blank line after decalations.

Cc: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/power/max17042_battery.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index bf5a82c..6cc5e87 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -268,6 +268,7 @@ static inline void max17042_override_por(struct regmap *map,
 static inline void max10742_unlock_model(struct max17042_chip *chip)
 {
 	struct regmap *map = chip->regmap;
+
 	regmap_write(map, MAX17042_MLOCKReg1, MODEL_UNLOCK1);
 	regmap_write(map, MAX17042_MLOCKReg2, MODEL_UNLOCK2);
 }
@@ -285,6 +286,7 @@ static inline void max17042_write_model_data(struct max17042_chip *chip,
 {
 	struct regmap *map = chip->regmap;
 	int i;
+
 	for (i = 0; i < size; i++)
 		regmap_write(map, addr + i,
 			chip->pdata->config_data->cell_char_tbl[i]);
-- 
1.7.9.5

