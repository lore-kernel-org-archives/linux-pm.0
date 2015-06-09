From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/8] mfd: axp20x: Add missing registers, and mark more registers volatile
Date: Tue,  9 Jun 2015 23:37:54 +0200
Message-ID: <1433885881-19809-2-git-send-email-hdegoede@redhat.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49073 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813AbbFIViT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Jun 2015 17:38:19 -0400
In-Reply-To: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>

=46rom: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

Add an extra set of registers which is necessary tu support the PMICs
battery charger function, and mark registers which contain status bits,
gpio status, and adc readings as volatile.

Cc: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/axp20x.c       | 6 ++++++
 include/linux/mfd/axp20x.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 6df9155..6ffbc11 100644
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
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 95568eb..f4290ae 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -151,6 +151,11 @@ enum {
 #define AXP20X_CC_CTRL			0xb8
 #define AXP20X_FG_RES			0xb9
=20
+/* OCV */
+#define AXP20X_RDC_H			0xba
+#define AXP20X_RDC_L			0xbb
+#define AXP20X_OCV(m)			(0xc0 + (m))
+
 /* AXP22X specific registers */
 #define AXP22X_BATLOW_THRES1		0xe6
=20
--=20
2.3.6

