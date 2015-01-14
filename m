From: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH RESEND 02/13] power: reset: ltc2952: prefer devm_request_irq over request_irq
Date: Wed, 14 Jan 2015 09:15:35 +0100
Message-ID: <1421223346-27410-3-git-send-email-frans.klaver@xsens.com>
References: <1421223346-27410-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421223346-27410-1-git-send-email-frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux-93MfrKQ0iTlmR6Xm/wNWPw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Make use of the fact that we allocated resources can be automatically
deallocated. This reduces cleanup code and chance of errors. It also
removes the need for the virq member of the ltc2952_poweroff_data
struct.

Signed-off-by: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
