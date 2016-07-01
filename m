From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: [PATCH 1/4] mfd: axp20x: add adc volatile ranges for axp22x
Date: Fri,  1 Jul 2016 17:29:23 +0800
Message-ID: <20160701092926.32005-1-icenowy@aosc.xyz>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBKXQ3C5QKGQEJFTKXUA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

AXP22x has also some different register map than axp20x, they're also
added here.

Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
---
 drivers/mfd/axp20x.c       | 1 +
 include/linux/mfd/axp20x.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index d62209d..cee5288 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -96,6 +96,7 @@ static const struct regmap_range axp22x_volatile_ranges[] = {
 	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
+	regmap_reg_range(AXP22X_PMIC_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
 	regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
 };
 
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 0be4982..ad3d9c7 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -201,6 +201,10 @@ enum {
 #define AXP20X_OCV_MAX			0xf
 
 /* AXP22X specific registers */
+#define AXP22X_PMIC_ADC_H		0x56
+#define AXP22X_PMIC_ADC_L		0x57
+#define AXP22X_TS_ADC_H			0x58
+#define AXP22X_TS_ADC_L			0x59
 #define AXP22X_BATLOW_THRES1		0xe6
 
 /* AXP288 specific registers */
-- 
2.9.0
