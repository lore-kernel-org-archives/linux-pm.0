From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 05/10] mfd: axp20x: add separate MFD cell for AXP223
Date: Fri, 25 Nov 2016 10:09:16 +0100
Message-ID: <20161125090921.23138-6-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58740 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754586AbcKYJLj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2016 04:11:39 -0500
In-Reply-To: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com

The AXP223 shares most of its logic with the AXP221 but has some
differences for the VBUS power supply driver. Thus, to probe the driver
with the correct compatible, the AXP221 and the AXP223 now have separate
MFD cells.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index ba130be..989d568 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -602,6 +602,21 @@ static struct mfd_cell axp22x_cells[] = {
 	},
 };
 
+static struct mfd_cell axp223_cells[] = {
+	{
+		.name			= "axp20x-pek",
+		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
+		.resources		= axp22x_pek_resources,
+	}, {
+		.name			= "axp20x-regulator",
+	}, {
+		.name		= "axp20x-usb-power-supply",
+		.of_compatible	= "x-powers,axp223-usb-power-supply",
+		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
+		.resources	= axp22x_usb_power_supply_resources,
+	},
+};
+
 static struct mfd_cell axp152_cells[] = {
 	{
 		.name			= "axp20x-pek",
@@ -789,12 +804,17 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_irq_chip = &axp20x_regmap_irq_chip;
 		break;
 	case AXP221_ID:
-	case AXP223_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp22x_cells);
 		axp20x->cells = axp22x_cells;
 		axp20x->regmap_cfg = &axp22x_regmap_config;
 		axp20x->regmap_irq_chip = &axp22x_regmap_irq_chip;
 		break;
+	case AXP223_ID:
+		axp20x->nr_cells = ARRAY_SIZE(axp223_cells);
+		axp20x->cells = axp223_cells;
+		axp20x->regmap_cfg = &axp22x_regmap_config;
+		axp20x->regmap_irq_chip = &axp22x_regmap_irq_chip;
+		break;
 	case AXP288_ID:
 		axp20x->cells = axp288_cells;
 		axp20x->nr_cells = ARRAY_SIZE(axp288_cells);
-- 
2.9.3

