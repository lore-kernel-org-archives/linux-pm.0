From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: [PATCH 2/2] power: bq24735-charger: Assume not charging when charger is missing
Date: Sun, 28 Aug 2016 19:34:46 +0200
Message-ID: <20160828173446.32728-2-contact@paulk.fr>
References: <20160828173446.32728-1-contact@paulk.fr>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160828173446.32728-1-contact-W9ppeneeCTY@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

When the charger is missing (disconnected), it is safe to assume that
the charger chip is no charging.

This is especially relevant when a status GPIO is present and the
charger is getting disconnected. bq24735_charger_is_charging will be
triggered due to the interrupt then, it will attempt to read whether it
is charging through i2c, which will fail as the charger is disconnected.

This also fixes that specific issue.

Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
---
 drivers/power/bq24735-charger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-charger.c
index 361a047..0b5b247 100644
--- a/drivers/power/bq24735-charger.c
+++ b/drivers/power/bq24735-charger.c
@@ -201,8 +201,12 @@ static bool bq24735_charger_is_present(struct bq24735 *charger)
 
 static int bq24735_charger_is_charging(struct bq24735 *charger)
 {
-	int ret = bq24735_read_word(charger->client, BQ24735_CHG_OPT);
+	int ret;
+
+	if (!bq24735_charger_is_present(charger))
+		return 0;
 
+	ret  = bq24735_read_word(charger->client, BQ24735_CHG_OPT);
 	if (ret < 0)
 		return ret;
 
-- 
2.9.3
