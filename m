From: Chen-Yu Tsai <wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 2/9] power: supply: axp20x_usb_power: Fix
 typo in VBUS current limit macros
Date: Thu, 21 Mar 2019 16:48:43 +0800
Message-ID: <20190321084850.20769-3-wens@kernel.org>
References: <20190321084850.20769-1-wens@kernel.org>
Reply-To: wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBAFAZXSAKGQEZCDPJ6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190321084850.20769-1-wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

The VBUS current limit value macros have VBUS typed as VBUC, while
the bitmask macro is named correctly. Fix it.

Fixes: 69fb4dcada77 ("power: Add an axp20x-usb-power driver")
Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/power/supply/axp20x_usb_power.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index f52fe77edb6f..cd9b90d79839 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -36,10 +36,10 @@
 #define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
 #define AXP20X_VBUS_VHOLD_OFFSET	3
 #define AXP20X_VBUS_CLIMIT_MASK		3
-#define AXP20X_VBUC_CLIMIT_900mA	0
-#define AXP20X_VBUC_CLIMIT_500mA	1
-#define AXP20X_VBUC_CLIMIT_100mA	2
-#define AXP20X_VBUC_CLIMIT_NONE		3
+#define AXP20X_VBUS_CLIMIT_900mA	0
+#define AXP20X_VBUS_CLIMIT_500mA	1
+#define AXP20X_VBUS_CLIMIT_100mA	2
+#define AXP20X_VBUS_CLIMIT_NONE		3
 
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
@@ -107,19 +107,19 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 			return ret;
 
 		switch (v & AXP20X_VBUS_CLIMIT_MASK) {
-		case AXP20X_VBUC_CLIMIT_100mA:
+		case AXP20X_VBUS_CLIMIT_100mA:
 			if (power->axp20x_id == AXP221_ID)
 				val->intval = -1; /* No 100mA limit */
 			else
 				val->intval = 100000;
 			break;
-		case AXP20X_VBUC_CLIMIT_500mA:
+		case AXP20X_VBUS_CLIMIT_500mA:
 			val->intval = 500000;
 			break;
-		case AXP20X_VBUC_CLIMIT_900mA:
+		case AXP20X_VBUS_CLIMIT_900mA:
 			val->intval = 900000;
 			break;
-		case AXP20X_VBUC_CLIMIT_NONE:
+		case AXP20X_VBUS_CLIMIT_NONE:
 			val->intval = -1;
 			break;
 		}
-- 
2.20.1
