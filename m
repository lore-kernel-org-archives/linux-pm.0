From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [RESEND PATCH v4 9/9] mfd: axp20x: add CHRG_CTRL1/2/3
 to writeable regs for AXP20X/AXP22X
Date: Mon, 20 Mar 2017 09:16:53 +0100
Message-ID: <20170320081653.8884-10-quentin.schulz@free-electrons.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBFFAX3DAKGQEBMCUZJA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170320081653.8884-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The CHRG_CTRL1 and CHRG_CTRL2 registers are made for controlling
different battery charging settings such as the constant current charge
value.

The AXP22X also have a third register CHRG_CTRL3 which has settings for
battery charging too.

This adds the CHRG_CTRL1, CHRG_CTRL2 and CHRG_CTRL3 registers to the
list of writeable registers for AXP20X and AXP22X PMICs.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Acked-for-MFD-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

v2:
 - added AXP20X_CHRG_CTRL2 and AXP20X_CHRG_CTRL3 to the writeable
 registers table,
 - removed added reg range for ADC data in volatile regs range,

 drivers/mfd/axp20x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 37643b1..5ba3b04 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -68,6 +68,7 @@ static const struct regmap_access_table axp152_volatile_table = {
 
 static const struct regmap_range axp20x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
 	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
 };
@@ -94,6 +95,7 @@ static const struct regmap_access_table axp20x_volatile_table = {
 /* AXP22x ranges are shared with the AXP809, as they cover the same range */
 static const struct regmap_range axp22x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP22X_CHRG_CTRL3),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
 };
 
-- 
2.9.3
