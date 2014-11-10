From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 29/48] power/reset: ltc2952-poweroff: Register with kernel power-off handler
Date: Sun,  9 Nov 2014 17:42:46 -0800
Message-ID: <1415583785-6980-30-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
sets pm_power_off only if it was not already set.

Acked-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- This patch: No change.
  Global: Replaced priority defines with enum.
v5:
- Rebase to v3.18-rc3
v4:
- Do not use notifiers but internal functions and data structures to manage
  the list of power-off handlers. Drop unused parameters from callbacks, and
  make the power-off function type void
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Added patch

 drivers/power/reset/ltc2952-poweroff.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 116a1ce..e622824 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -80,6 +80,8 @@ struct ltc2952_poweroff_data {
 	 * 2: kill
 	 */
 	struct gpio_desc *gpio[3];
+
+	struct power_off_handler_block power_off_hb;
 };
 
 static int ltc2952_poweroff_panic;
@@ -180,7 +182,8 @@ irq_ok:
 	return IRQ_HANDLED;
 }
 
-static void ltc2952_poweroff_kill(void)
+static void ltc2952_poweroff_kill(struct power_off_handler_block *this)
+
 {
 	gpiod_set_value(ltc2952_data->gpio[POWERPATH_IO_KILL], 1);
 }
@@ -285,12 +288,7 @@ err_io:
 
 static int ltc2952_poweroff_probe(struct platform_device *pdev)
 {
-	int ret;
-
-	if (pm_power_off) {
-		dev_err(&pdev->dev, "pm_power_off already registered");
-		return -EBUSY;
-	}
+	int i, ret;
 
 	ltc2952_data = kzalloc(sizeof(*ltc2952_data), GFP_KERNEL);
 	if (!ltc2952_data)
@@ -302,12 +300,20 @@ static int ltc2952_poweroff_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	pm_power_off = &ltc2952_poweroff_kill;
+	ltc2952_data->power_off_hb.handler = ltc2952_poweroff_kill;
+	ltc2952_data->power_off_hb.priority = POWER_OFF_PRIORITY_LOW;
+	ret = register_power_off_handler(&ltc2952_data->power_off_hb);
+	if (ret)
+		goto err_power;
 
 	dev_info(&pdev->dev, "probe successful\n");
 
 	return 0;
 
+err_power:
+	free_irq(ltc2952_data->virq, ltc2952_data);
+	for (i = 0; i < ARRAY_SIZE(ltc2952_data->gpio); i++)
+		gpiod_put(ltc2952_data->gpio[i]);
 err:
 	kfree(ltc2952_data);
 	return ret;
@@ -317,7 +323,7 @@ static int ltc2952_poweroff_remove(struct platform_device *pdev)
 {
 	unsigned int i;
 
-	pm_power_off = NULL;
+	unregister_power_off_handler(&ltc2952_data->power_off_hb);
 
 	if (ltc2952_data) {
 		free_irq(ltc2952_data->virq, ltc2952_data);
-- 
1.9.1
