From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] power: max17042: Constify struct regmap_config
Date: Mon, 05 Jan 2015 09:50:17 +0100
Message-ID: <1420447817-4262-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:31190 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbbAEIvI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jan 2015 03:51:08 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/max17042_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 66da691c41cf..1da6c5fbdff5 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -658,7 +658,7 @@ max17042_get_pdata(struct device *dev)
 }
 #endif
 
-static struct regmap_config max17042_regmap_config = {
+static const struct regmap_config max17042_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-- 
1.9.1

