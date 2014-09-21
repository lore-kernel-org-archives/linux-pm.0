From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 3/3] power: gpio-charger: do not use gpio value directly
Date: Sun, 21 Sep 2014 22:05:23 +0200
Message-ID: <1411329923-15912-4-git-send-email-heiko@sntech.de>
References: <1411329923-15912-1-git-send-email-heiko@sntech.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411329923-15912-1-git-send-email-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dianders@chromium.org, heiko@sntech.de, Heiko Stuebner <heiko.stuebner@bq.com>
List-Id: linux-pm@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

Some gpio implementations return interesting values for gpio_get_value when
the value is not 0 - as seen on a imx6sl board. Therefore do not use the
value returned from gpio_get_value directly but simply check for 0 or not 0.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 drivers/power/gpio-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/gpio-charger.c b/drivers/power/gpio-charger.c
index 5fe6879..ce99a29 100644
--- a/drivers/power/gpio-charger.c
+++ b/drivers/power/gpio-charger.c
@@ -57,7 +57,7 @@ static int gpio_charger_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = gpio_get_value_cansleep(pdata->gpio);
+		val->intval = gpio_get_value_cansleep(pdata->gpio) ? 1 : 0;
 		val->intval ^= pdata->gpio_active_low;
 		break;
 	default:
-- 
1.9.0
