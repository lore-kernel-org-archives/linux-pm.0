From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v2 5/9] power: supply: axp20x_usb_power: add
 function to get max current
Date: Mon, 25 Feb 2019 11:31:03 +0800
Message-ID: <20190225033107.17326-6-wens@csie.org>
References: <20190225033107.17326-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBB6DZXRQKGQE6EGLVVA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190225033107.17326-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>

To prepare for a new PMIC, factor out the code responsible of returning
the maximum current to axp20x_get_current_max.

Signed-off-by: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/power/supply/axp20x_usb_power.c | 52 ++++++++++++++-----------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index ac061bcdc056..90d06027bf98 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -102,6 +102,35 @@ static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
 	return false;
 }
 
+static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
+{
+	unsigned int v;
+	int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
+
+	if (ret)
+		return ret;
+
+	switch (v & AXP20X_VBUS_CLIMIT_MASK) {
+	case AXP20X_VBUS_CLIMIT_100mA:
+		if (power->axp20x_id == AXP221_ID)
+			*val = -1; /* No 100mA limit */
+		else
+			*val = 100000;
+		break;
+	case AXP20X_VBUS_CLIMIT_500mA:
+		*val = 500000;
+		break;
+	case AXP20X_VBUS_CLIMIT_900mA:
+		*val = 900000;
+		break;
+	case AXP20X_VBUS_CLIMIT_NONE:
+		*val = -1;
+		break;
+	}
+
+	return 0;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -140,28 +169,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		val->intval = ret * 1700; /* 1 step = 1.7 mV */
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
-		if (ret)
-			return ret;
-
-		switch (v & AXP20X_VBUS_CLIMIT_MASK) {
-		case AXP20X_VBUS_CLIMIT_100mA:
-			if (power->axp20x_id == AXP221_ID)
-				val->intval = -1; /* No 100mA limit */
-			else
-				val->intval = 100000;
-			break;
-		case AXP20X_VBUS_CLIMIT_500mA:
-			val->intval = 500000;
-			break;
-		case AXP20X_VBUS_CLIMIT_900mA:
-			val->intval = 900000;
-			break;
-		case AXP20X_VBUS_CLIMIT_NONE:
-			val->intval = -1;
-			break;
-		}
-		return 0;
+		return axp20x_get_current_max(power, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
 			ret = iio_read_channel_processed(power->vbus_i,
-- 
2.20.1
