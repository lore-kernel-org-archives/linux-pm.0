From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH 1/3] power: supply: bq24735-charger: simplify register update to stop charging
Date: Mon, 12 Dec 2016 12:00:22 +0100
Message-ID: <1481540424-19293-2-git-send-email-peda@axentia.se>
References: <1481540424-19293-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1481540424-19293-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Providing value bits outside of the mask is pointless.

Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 drivers/power/supply/bq24735-charger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index eb7783b42e0a..1d5c9206e0ed 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -111,8 +111,7 @@ static inline int bq24735_enable_charging(struct bq24735 *charger)
 		return 0;
 
 	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
-				   BQ24735_CHG_OPT_CHARGE_DISABLE,
-				   ~BQ24735_CHG_OPT_CHARGE_DISABLE);
+				   BQ24735_CHG_OPT_CHARGE_DISABLE, 0);
 }
 
 static inline int bq24735_disable_charging(struct bq24735 *charger)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
