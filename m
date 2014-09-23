From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v4 3/3] power: gpio-charger: do not use gpio value directly
Date: Tue, 23 Sep 2014 22:42:16 +0200
Message-ID: <1411504936-21026-4-git-send-email-heiko@sntech.de>
References: <1411504936-21026-1-git-send-email-heiko@sntech.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411504936-21026-1-git-send-email-heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Heiko Stuebner <heiko.stuebner-K3U4GQvHnyU@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner-K3U4GQvHnyU@public.gmane.org>

Some gpio implementations return interesting values for gpio_get_value when
the value is not 0 - as seen on a imx6sl board. Therefore do not use the
value returned from gpio_get_value directly but simply check for 0 or not 0.

Signed-off-by: Heiko Stuebner <heiko.stuebner-K3U4GQvHnyU@public.gmane.org>
Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Tested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/power/gpio-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/gpio-charger.c b/drivers/power/gpio-charger.c
index 22f084a..7d4eab2 100644
--- a/drivers/power/gpio-charger.c
+++ b/drivers/power/gpio-charger.c
@@ -57,7 +57,7 @@ static int gpio_charger_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = gpio_get_value_cansleep(pdata->gpio);
+		val->intval = !!gpio_get_value_cansleep(pdata->gpio);
 		val->intval ^= pdata->gpio_active_low;
 		break;
 	default:
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
