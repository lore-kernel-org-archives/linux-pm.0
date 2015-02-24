From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 4/5] power_supply: max17040: Use system efficient workqueues
Date: Tue, 24 Feb 2015 10:54:46 +0100
Message-ID: <1424771687-7976-4-git-send-email-k.kozlowski@samsung.com>
References: <1424771687-7976-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1424771687-7976-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

The scheduled work in max17040_battery driver reads device parameters
and stores them in memory. Any CPU could do that so use system efficient
workqueues to limit unnecessary CPU wake ups.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/max17040_battery.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/max17040_battery.c b/drivers/power/max17040_battery.c
index 14d44706327b..63ff3f705154 100644
--- a/drivers/power/max17040_battery.c
+++ b/drivers/power/max17040_battery.c
@@ -188,7 +188,8 @@ static void max17040_work(struct work_struct *work)
 	max17040_get_online(chip->client);
 	max17040_get_status(chip->client);
 
-	schedule_delayed_work(&chip->work, MAX17040_DELAY);
+	queue_delayed_work(system_power_efficient_wq, &chip->work,
+			   MAX17040_DELAY);
 }
 
 static enum power_supply_property max17040_battery_props[] = {
@@ -233,7 +234,8 @@ static int max17040_probe(struct i2c_client *client,
 	max17040_get_version(client);
 
 	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
-	schedule_delayed_work(&chip->work, MAX17040_DELAY);
+	queue_delayed_work(system_power_efficient_wq, &chip->work,
+			   MAX17040_DELAY);
 
 	return 0;
 }
@@ -263,7 +265,8 @@ static int max17040_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct max17040_chip *chip = i2c_get_clientdata(client);
 
-	schedule_delayed_work(&chip->work, MAX17040_DELAY);
+	queue_delayed_work(system_power_efficient_wq, &chip->work,
+			   MAX17040_DELAY);
 	return 0;
 }
 
-- 
1.9.1
