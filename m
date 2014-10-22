From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 08/13] power: reset: ltc2952: cleanup control flow in poweroff_handler
Date: Wed, 22 Oct 2014 16:31:05 +0200
Message-ID: <1413988270-28092-9-git-send-email-frans.klaver@xsens.com>
References: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

ltc2952_poweroff_handler uses gotos to return from the function. Since
we don't do cleanups exiting this function, just return IRQ_HANDLED on
the spot and be done with it.

While at it, remove the variable 'ret'. It was never used very much.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/power/reset/ltc2952-poweroff.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index af3cb6e..70d8e3a 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -153,29 +153,21 @@ ltc2952_poweroff_timer_trigger(struct hrtimer *timer)
  */
 static irqreturn_t ltc2952_poweroff_handler(int irq, void *dev_id)
 {
-	int ret;
 	struct ltc2952_poweroff *data = dev_id;
 
-	if (data->kernel_panic)
-		goto irq_ok;
-
-	if (hrtimer_active(&data->timer_wde)) {
+	if (data->kernel_panic || hrtimer_active(&data->timer_wde)) {
 		/* shutdown is already triggered, nothing to do any more */
-		goto irq_ok;
+		return IRQ_HANDLED;
 	}
 
 	if (!hrtimer_active(&data->timer_trigger)) {
-		ret = hrtimer_start(&data->timer_trigger, data->trigger_delay,
-			HRTIMER_MODE_REL);
-
-		if (ret)
+		if (hrtimer_start(&data->timer_trigger, data->trigger_delay,
+				  HRTIMER_MODE_REL))
 			dev_err(data->dev, "unable to start the wait timer\n");
 	} else {
-		ret = hrtimer_cancel(&data->timer_trigger);
+		hrtimer_cancel(&data->timer_trigger);
 		/* omitting return value check, timer should have been valid */
 	}
-
-irq_ok:
 	return IRQ_HANDLED;
 }
 
-- 
2.1.0
