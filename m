From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 02/13] power: reset: ltc2952: prefer devm_request_irq over request_irq
Date: Wed, 22 Oct 2014 16:30:59 +0200
Message-ID: <1413988270-28092-3-git-send-email-frans.klaver@xsens.com>
References: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Make use of the fact that we allocated resources can be automatically
deallocated. This reduces cleanup code and chance of errors. It also
removes the need for the virq member of the ltc2952_poweroff_data
struct.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/power/reset/ltc2952-poweroff.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 951a90d..2c11316 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -72,8 +72,6 @@ struct ltc2952_poweroff_data {
 
 	struct device *dev;
 
-	unsigned int virq;
-
 	/**
 	 * 0: trigger
 	 * 1: watchdog
@@ -260,13 +258,11 @@ static int ltc2952_poweroff_init(struct platform_device *pdev)
 		goto err_io;
 	}
 
-	ltc2952_data->virq = virq;
-	ret = request_irq(virq,
-		ltc2952_poweroff_handler,
-		(IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
-		"ltc2952-poweroff",
-		ltc2952_data
-	);
+	ret = devm_request_irq(&pdev->dev, virq,
+			       ltc2952_poweroff_handler,
+			       (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
+			       "ltc2952-poweroff",
+			       ltc2952_data);
 
 	if (ret) {
 		dev_err(&pdev->dev, "cannot configure an interrupt handler\n");
@@ -316,12 +312,9 @@ static int ltc2952_poweroff_remove(struct platform_device *pdev)
 
 	pm_power_off = NULL;
 
-	if (ltc2952_data) {
-		free_irq(ltc2952_data->virq, ltc2952_data);
-
+	if (ltc2952_data)
 		for (i = 0; i < ARRAY_SIZE(ltc2952_data->gpio); i++)
 			gpiod_put(ltc2952_data->gpio[i]);
-	}
 
 	return 0;
 }
-- 
2.1.0
