From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/4] mfd: axp20x: Add missing registers, and mark more registers volatile
Date: Sat, 13 Jun 2015 18:09:06 +0200
Message-ID: <1434211748-25572-3-git-send-email-hdegoede@redhat.com>
References: <1434211748-25572-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434211748-25572-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

=46rom: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>

Add an extra set of registers which is necessary tu support the PMICs
battery charger function, and mark registers which contain status bits,
gpio status, and adc readings as volatile.

Cc: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
Changes in v2:
-Add a AXP20X_OCV_MAX define
---
 drivers/mfd/axp20x.c       | 8 +++++++-
 include/linux/mfd/axp20x.h | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 6df9155..f9a3c2d 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -39,10 +39,16 @@ static const char * const axp20x_model_names[] =3D =
{
 static const struct regmap_range axp20x_writeable_ranges[] =3D {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
+	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(15)),
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
@@ -159,7 +165,7 @@ static const struct regmap_config axp20x_regmap_con=
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
index 5275423..6d8b39a 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -151,6 +151,12 @@ enum {
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
