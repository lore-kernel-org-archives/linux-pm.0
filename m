From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v2 1/2] power: gpio-charger: balance enable/disable_irq_wake calls
Date: Tue, 23 Dec 2014 13:12:48 +0300
Message-ID: <1419329569-5696-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:50586 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677AbaLWKMy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Dec 2014 05:12:54 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, stable@vger.kernel.org

enable_irq_wakeup returns 0 in case it correctly enabled the IRQ to
generate the wakeup event (and thus resume should call disable_irq_wake).
Currently gpio-charger driver has this logic inverted. Correct that thus
correcting enable/disable_irq_wake() calls balance.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
[Changes since V1: fix another possible imbalance.]

 drivers/power/gpio-charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/gpio-charger.c b/drivers/power/gpio-charger.c
index 7536933..e5deb11 100644
--- a/drivers/power/gpio-charger.c
+++ b/drivers/power/gpio-charger.c
@@ -168,7 +168,7 @@ static int gpio_charger_suspend(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		gpio_charger->wakeup_enabled =
-			enable_irq_wake(gpio_charger->irq);
+			!enable_irq_wake(gpio_charger->irq);
 
 	return 0;
 }
@@ -178,7 +178,7 @@ static int gpio_charger_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_charger *gpio_charger = platform_get_drvdata(pdev);
 
-	if (gpio_charger->wakeup_enabled)
+	if (device_may_wakeup(dev) && gpio_charger->wakeup_enabled)
 		disable_irq_wake(gpio_charger->irq);
 	power_supply_changed(&gpio_charger->charger);
 
-- 
2.1.3

