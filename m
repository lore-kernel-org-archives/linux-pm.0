From: Chris Zhong <zyw@rock-chips.com>
Subject: [PATCH 2/2] power: gpio-charger: support disable the wakeup event
Date: Tue, 10 Feb 2015 16:12:25 +0800
Message-ID: <1423555945-24289-3-git-send-email-zyw@rock-chips.com>
References: <1423555945-24289-1-git-send-email-zyw@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423555945-24289-1-git-send-email-zyw@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, dianders@chromium.org, dtor@chromium.org, djkurtz@chromium.org, sonnyrao@chromium.org
Cc: linux-rockchip@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Support disable the wakeup event of gpio-charger by setting device tree.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

 drivers/power/gpio-charger.c       | 5 ++++-
 include/linux/power/gpio-charger.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/gpio-charger.c b/drivers/power/gpio-charger.c
index b7424c8..06ed22e 100644
--- a/drivers/power/gpio-charger.c
+++ b/drivers/power/gpio-charger.c
@@ -98,6 +98,9 @@ struct gpio_charger_platform_data *gpio_charger_parse_dt(struct device *dev)
 
 	pdata->gpio_active_low = !!(flags & OF_GPIO_ACTIVE_LOW);
 
+	pdata->wakeup = !of_get_property(np, "gpio-charger,disable-wakeup",
+					 NULL);
+
 	pdata->type = POWER_SUPPLY_TYPE_UNKNOWN;
 	ret = of_property_read_string(np, "charger-type", &chargetype);
 	if (ret >= 0) {
@@ -198,7 +201,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpio_charger);
 
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(&pdev->dev, pdata->wakeup);
 
 	return 0;
 
diff --git a/include/linux/power/gpio-charger.h b/include/linux/power/gpio-charger.h
index de1dfe0..a5fdef3 100644
--- a/include/linux/power/gpio-charger.h
+++ b/include/linux/power/gpio-charger.h
@@ -33,6 +33,7 @@ struct gpio_charger_platform_data {
 
 	int gpio;
 	int gpio_active_low;
+	int wakeup;
 
 	char **supplied_to;
 	size_t num_supplicants;
-- 
1.9.1
