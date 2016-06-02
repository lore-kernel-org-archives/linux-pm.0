From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/4] mfd: axp20x: Extend axp22x_volatile_ranges
Date: Thu,  2 Jun 2016 19:18:54 +0200
Message-ID: <1464887936-17020-2-git-send-email-hdegoede@redhat.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48818 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168AbcFBRTD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 Jun 2016 13:19:03 -0400
In-Reply-To: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

The axp22x pmic has a bunch of volatile registers besides the interrupt
ones, extend axp22x_volatile_ranges with these.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v2:
-Added Chen-Yu's Acked-by
---
 drivers/mfd/axp20x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index e4e3297..ca04361 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -93,7 +93,10 @@ static const struct regmap_range axp22x_writeable_ranges[] = {
 };
 
 static const struct regmap_range axp22x_volatile_ranges[] = {
+	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
+	regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
 };
 
 static const struct regmap_access_table axp22x_writeable_table = {
-- 
2.7.4

