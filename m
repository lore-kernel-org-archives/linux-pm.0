From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 2/2] power: gpio-charger: balance enable/disable_irq_wake calls
Date: Tue, 23 Dec 2014 12:51:26 +0300
Message-ID: <1419328286-29729-2-git-send-email-dbaryshkov@gmail.com>
References: <1419328286-29729-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34487 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaLWJvo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Dec 2014 04:51:44 -0500
In-Reply-To: <1419328286-29729-1-git-send-email-dbaryshkov@gmail.com>
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
 drivers/power/gpio-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/gpio-charger.c b/drivers/power/gpio-charger.c
index 7536933..cc98763 100644
--- a/drivers/power/gpio-charger.c
+++ b/drivers/power/gpio-charger.c
@@ -168,7 +168,7 @@ static int gpio_charger_suspend(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		gpio_charger->wakeup_enabled =
-			enable_irq_wake(gpio_charger->irq);
+			!enable_irq_wake(gpio_charger->irq);
 
 	return 0;
 }
-- 
2.1.3

