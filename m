From: Jonathan Tinkham <sctincman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] power: bq24735-charger: add 'ti,external-control' option
Date: Tue,  2 Feb 2016 23:03:45 -0700
Message-ID: <1454479426-6437-3-git-send-email-sctincman@gmail.com>
References: <1454479426-6437-1-git-send-email-sctincman@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454479426-6437-1-git-send-email-sctincman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Jonathan Tinkham <sctincman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Implement an 'ti,external-control' option for when the charger
shouldn't be configured by the host.

Signed-off-by: Jonathan Tinkham <sctincman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/power/bq24735-charger.c       | 11 +++++++++++
 include/linux/power/bq24735-charger.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-charger.c
index f041c16..96afcc1 100644
--- a/drivers/power/bq24735-charger.c
+++ b/drivers/power/bq24735-charger.c
@@ -90,6 +90,9 @@ static int bq24735_update_word(struct i2c_client *client, u8 reg,
 
 static inline int bq24735_enable_charging(struct bq24735 *charger)
 {
+	if (charger->pdata->ext_control)
+		return 0;
+
 	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
 				   BQ24735_CHG_OPT_CHARGE_DISABLE,
 				   ~BQ24735_CHG_OPT_CHARGE_DISABLE);
@@ -97,6 +100,9 @@ static inline int bq24735_enable_charging(struct bq24735 *charger)
 
 static inline int bq24735_disable_charging(struct bq24735 *charger)
 {
+	if (charger->pdata->ext_control)
+		return 0;
+
 	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
 				   BQ24735_CHG_OPT_CHARGE_DISABLE,
 				   BQ24735_CHG_OPT_CHARGE_DISABLE);
@@ -108,6 +114,9 @@ static int bq24735_config_charger(struct bq24735 *charger)
 	int ret;
 	u16 value;
 
+	if (pdata->ext_control)
+		return 0;
+
 	if (pdata->charge_current) {
 		value = pdata->charge_current & BQ24735_CHARGE_CURRENT_MASK;
 
@@ -239,6 +248,8 @@ static struct bq24735_platform *bq24735_parse_dt_data(struct i2c_client *client)
 	if (!ret)
 		pdata->input_current = val;
 
+	pdata->ext_control = of_property_read_bool(np, "ti,external-control");
+
 	return pdata;
 }
 
diff --git a/include/linux/power/bq24735-charger.h b/include/linux/power/bq24735-charger.h
index f536164..6b750c1a 100644
--- a/include/linux/power/bq24735-charger.h
+++ b/include/linux/power/bq24735-charger.h
@@ -32,6 +32,8 @@ struct bq24735_platform {
 	int status_gpio_active_low;
 	bool status_gpio_valid;
 
+	bool ext_control;
+
 	char **supplied_to;
 	size_t num_supplicants;
 };
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
