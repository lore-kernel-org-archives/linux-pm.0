From: a@samsung.com
Subject: [PATCH 3/3] power: max17042_battery: add missed blank
Date: Tue, 31 Mar 2015 22:35:12 +0900
Message-ID: <1427808912-19562-2-git-send-email-a@samsung.com>
References: <1427808912-19562-1-git-send-email-a@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46670 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbbCaNfP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2015 09:35:15 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NM200COIWEPCRD0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 31 Mar 2015 22:35:13 +0900 (KST)
In-reply-to: <1427808912-19562-1-git-send-email-a@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Beomho Seo <beomho.seo@samsung.com>, Sebastian Reichel <sre@kernel.org>

From: Beomho Seo <beomho.seo@samsung.com>

This patch add missed blank line after decalations.

Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/power/max17042_battery.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 806ac2e..c05f1e7 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -269,6 +269,7 @@ static inline void max17042_override_por(struct regmap *map,
 static inline void max10742_unlock_model(struct max17042_chip *chip)
 {
 	struct regmap *map = chip->regmap;
+
 	regmap_write(map, MAX17042_MLOCKReg1, MODEL_UNLOCK1);
 	regmap_write(map, MAX17042_MLOCKReg2, MODEL_UNLOCK2);
 }
@@ -286,6 +287,7 @@ static inline void max17042_write_model_data(struct max17042_chip *chip,
 {
 	struct regmap *map = chip->regmap;
 	int i;
+
 	for (i = 0; i < size; i++)
 		regmap_write(map, addr + i,
 			chip->pdata->config_data->cell_char_tbl[i]);
-- 
1.7.9.5

