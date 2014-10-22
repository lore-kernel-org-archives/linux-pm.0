From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 12/13] power: reset: ltc2952: make trigger input optional
Date: Wed, 22 Oct 2014 16:31:09 +0200
Message-ID: <1413988270-28092-13-git-send-email-frans.klaver@xsens.com>
References: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently the ltc2952 supports only one button sequence to initiate
powerdown. This is not always desirable, as even prolonged button
presses can happen in use.

Allow ltc2952 users to pick their own power down sequence, by making the
trigger input optional. Since this still means that the ltc2952 may
power down the platform if the power button is pressed for about 5
seconds, we still need to make sure to start the watchdog toggle to
prolong the system power for as long as we need it.

This will still allow the system to control power using the kill signal.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/power/reset/ltc2952-poweroff.c | 87 +++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index fda2735..72e3d7f 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -32,7 +32,9 @@
  * - trigger (input)
  *     A level change indicates the shut-down trigger. If it's state reverts
  *     within the time-out defined by trigger_delay, the shut down is not
- *     executed.
+ *     executed. If no pin is assigned to this input, the driver will start the
+ *     watchdog toggle immediately. The chip will only power off the system if
+ *     it is requested to do so through the kill line.
  *
  * - watchdog (output)
  *     Once a shut down is triggered, the driver will toggle this signal,
@@ -116,15 +118,10 @@ static enum hrtimer_restart ltc2952_poweroff_timer_wde(struct hrtimer *timer)
 	return HRTIMER_RESTART;
 }
 
-static enum hrtimer_restart
-ltc2952_poweroff_timer_trigger(struct hrtimer *timer)
+static void ltc2952_poweroff_start_wde(struct ltc2952_poweroff *data)
 {
-	struct ltc2952_poweroff *data = to_ltc2952(timer, timer_trigger);
-	int ret = hrtimer_start(&data->timer_wde,
-				data->wde_interval, HRTIMER_MODE_REL);
-
-	if (ret) {
-		dev_err(data->dev, "unable to start the timer\n");
+	if (hrtimer_start(&data->timer_wde, data->wde_interval,
+			  HRTIMER_MODE_REL)) {
 		/*
 		 * The device will not toggle the watchdog reset,
 		 * thus shut down is only safe if the PowerPath controller
@@ -133,10 +130,17 @@ ltc2952_poweroff_timer_trigger(struct hrtimer *timer)
 		 *
 		 * Only sending a warning as the system will power-off anyway
 		 */
+		dev_err(data->dev, "unable to start the timer\n");
 	}
+}
 
-	dev_info(data->dev, "executing shutdown\n");
+static enum hrtimer_restart
+ltc2952_poweroff_timer_trigger(struct hrtimer *timer)
+{
+	struct ltc2952_poweroff *data = to_ltc2952(timer, timer_trigger);
 
+	ltc2952_poweroff_start_wde(data);
+	dev_info(data->dev, "executing shutdown\n");
 	orderly_poweroff(true);
 
 	return HRTIMER_NORESTART;
@@ -190,7 +194,7 @@ static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
 
 static int ltc2952_poweroff_init(struct platform_device *pdev)
 {
-	int ret, virq;
+	int ret;
 	struct ltc2952_poweroff *data = platform_get_drvdata(pdev);
 
 	ltc2952_poweroff_default(data);
@@ -210,29 +214,48 @@ static int ltc2952_poweroff_init(struct platform_device *pdev)
 		return ret;
 	}
 
-	data->gpio_trigger = devm_gpiod_get(&pdev->dev, "trigger",
-					    GPIOD_IN);
-	if (IS_ERR(ltc2952_data->gpio_trigger)) {
-		ret = PTR_ERR(ltc2952_data->gpio_trigger);
-		dev_err(&pdev->dev, "unable to claim gpio \"trigger\"\n");
-		return ret;
-	}
-
-	virq = gpiod_to_irq(data->gpio_trigger);
-	if (virq < 0) {
-		dev_err(&pdev->dev, "cannot map GPIO as interrupt");
-		return ret;
+	data->gpio_trigger = devm_gpiod_get(&pdev->dev, "trigger", GPIOD_IN);
+	if (IS_ERR(data->gpio_trigger)) {
+		/*
+		 * It's not a problem if the trigger gpio isn't available, but
+		 * it is worth a warning if its use was defined in the device
+		 * tree.
+		 */
+		if (PTR_ERR(data->gpio_trigger) != -ENOENT)
+			dev_err(&pdev->dev,
+				"unable to claim gpio \"trigger\"\n");
+		data->gpio_trigger = NULL;
 	}
 
-	ret = devm_request_irq(&pdev->dev, virq,
-			       ltc2952_poweroff_handler,
-			       (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
-			       "ltc2952-poweroff",
-			       data);
-
-	if (ret) {
-		dev_err(&pdev->dev, "cannot configure an interrupt handler\n");
-		return ret;
+	if (devm_request_irq(&pdev->dev, gpiod_to_irq(data->gpio_trigger),
+			     ltc2952_poweroff_handler,
+			     (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
+			     "ltc2952-poweroff",
+			     data)) {
+		/*
+		 * Some things may have happened:
+		 * - No trigger input was defined
+		 * - Claiming the GPIO failed
+		 * - We could not map to an IRQ
+		 * - We couldn't register an interrupt handler
+		 *
+		 * None of these really are problems, but all of them
+		 * disqualify the push button from controlling the power.
+		 *
+		 * It is therefore important to note that if the ltc2952
+		 * detects a button press for long enough, it will still start
+		 * its own powerdown window and cut the power on us if we don't
+		 * start the watchdog trigger.
+		 */
+		if (data->gpio_trigger) {
+			dev_warn(&pdev->dev,
+				 "unable to configure the trigger interrupt\n");
+			devm_gpiod_put(&pdev->dev, data->gpio_trigger);
+			data->gpio_trigger = NULL;
+		}
+		dev_info(&pdev->dev,
+			 "power down trigger input will not be used\n");
+		ltc2952_poweroff_start_wde(data);
 	}
 
 	return 0;
-- 
2.1.0
