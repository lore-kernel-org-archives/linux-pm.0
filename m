From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] power_supply: rt5033: Constify struct regmap_config
Date: Tue, 24 Feb 2015 10:52:13 +0100
Message-ID: <1424771533-7833-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34984 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbbBXJwW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 04:52:22 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/rt5033_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/rt5033_battery.c b/drivers/power/rt5033_battery.c
index 7b898f41c595..995247af14fc 100644
--- a/drivers/power/rt5033_battery.c
+++ b/drivers/power/rt5033_battery.c
@@ -102,7 +102,7 @@ static enum power_supply_property rt5033_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
 };
 
-static struct regmap_config rt5033_battery_regmap_config = {
+static const struct regmap_config rt5033_battery_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
 	.max_register	= RT5033_FUEL_REG_END,
-- 
1.9.1

