From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/3] power: supply: sbs-battery: remove unchecked return var
Date: Sun, 29 Oct 2017 16:35:44 +0100
Message-ID: <20171029153545.3947-3-wsa@the-dreams.de>
References: <20171029153545.3947-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20171029153545.3947-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Phil Reid <preid@electromag.com.au>, sre@kernel.org, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-pm@vger.kernel.org

Since the return value is not checked anyhow, we don't need to store it.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/power/supply/sbs-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index fb61da370947f4..83d7b4115857e3 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -556,7 +556,7 @@ static int sbs_get_battery_serial_number(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = sprintf(sbs_serial, "%04x", ret);
+	sprintf(sbs_serial, "%04x", ret);
 	val->strval = sbs_serial;
 
 	return 0;
-- 
2.11.0
