From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 02/11] mfd: axp20x: add volatile and writeable reg ranges for VBUS power supply driver
Date: Fri,  9 Dec 2016 12:04:10 +0100
Message-ID: <20161209110419.28981-3-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38689 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933092AbcLILE3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2016 06:04:29 -0500
In-Reply-To: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com

The X-Powers AXP20X and AXP22X PMICs allow to choose the maximum voltage
and minimum current delivered by the VBUS power supply.

This adds the register used by the VBUS power supply driver to the range
of volatile and writeable regs ranges.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2

 drivers/mfd/axp20x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index ba130be..6ee2cc6 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -65,12 +65,14 @@ static const struct regmap_access_table axp152_volatile_table = {
 
 static const struct regmap_range axp20x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
 	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
 };
 
 static const struct regmap_range axp20x_volatile_ranges[] = {
 	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_USB_OTG_STATUS),
+	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
 	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP20X_ACIN_V_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
@@ -91,11 +93,13 @@ static const struct regmap_access_table axp20x_volatile_table = {
 /* AXP22x ranges are shared with the AXP809, as they cover the same range */
 static const struct regmap_range axp22x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
 };
 
 static const struct regmap_range axp22x_volatile_ranges[] = {
 	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
+	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
 	regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
-- 
2.9.3

