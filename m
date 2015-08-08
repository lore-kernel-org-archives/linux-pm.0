From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 1/2] mfd: axp20x: Add missing registers, and mark more registers volatile
Date: Sat,  8 Aug 2015 17:58:40 +0200
Message-ID: <1439049521-30766-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58121 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946068AbbHHP6p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 8 Aug 2015 11:58:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>

=46rom: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

Add an extra set of registers which is necessary tu support the PMICs
battery charger function, and mark registers which contain status bits,
gpio status, and adc readings as volatile.

Cc: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Changes in v2:
-Add a AXP20X_OCV_MAX define
Changes in v3:
-Add Bruno's S-o-b
Changes in v4:
-Consistently use AXP20X_OCV_MAX everywhere
---
 drivers/mfd/axp20x.c       | 8 +++++++-
 include/linux/mfd/axp20x.h | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index b369cfc..d9f2f96 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -61,10 +61,16 @@ static const struct regmap_access_table axp152_vola=
tile_table =3D {
 static const struct regmap_range axp20x_writeable_ranges[] =3D {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
+	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
 };
=20
 static const struct regmap_range axp20x_volatile_ranges[] =3D {
+	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_USB_OTG_STATUS),
+	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP20X_ACIN_V_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
+	regmap_reg_range(AXP20X_GPIO20_SS, AXP20X_GPIO3_CTRL),
+	regmap_reg_range(AXP20X_FG_RES, AXP20X_RDC_L),
 };
=20
 static const struct regmap_access_table axp20x_writeable_table =3D {
@@ -195,7 +201,7 @@ static const struct regmap_config axp20x_regmap_con=
fig =3D {
 	.val_bits	=3D 8,
 	.wr_table	=3D &axp20x_writeable_table,
 	.volatile_table	=3D &axp20x_volatile_table,
-	.max_register	=3D AXP20X_FG_RES,
+	.max_register	=3D AXP20X_OCV(AXP20X_OCV_MAX),
 	.cache_type	=3D REGCACHE_RBTREE,
 };
=20
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 52203d5..cc8ad1e 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -190,6 +190,12 @@ enum {
 #define AXP20X_CC_CTRL			0xb8
 #define AXP20X_FG_RES			0xb9
=20
+/* OCV */
+#define AXP20X_RDC_H			0xba
+#define AXP20X_RDC_L			0xbb
+#define AXP20X_OCV(m)			(0xc0 + (m))
+#define AXP20X_OCV_MAX			0xf
+
 /* AXP22X specific registers */
 #define AXP22X_BATLOW_THRES1		0xe6
=20
--=20
2.4.3

