From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: [PATCH 2/4] extcon: Remove optional print_state() function pointer of struct extcon_dev
Date: Fri, 19 Jun 2015 15:35:49 +0900
Message-ID: <1434695751-25631-3-git-send-email-cw00.choi@samsung.com>
References: <1434695751-25631-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33408 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbbFSGgD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 02:36:03 -0400
Received: by padev16 with SMTP id ev16so78697544pad.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 23:36:03 -0700 (PDT)
In-Reply-To: <1434695751-25631-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cwchoi00@gmail.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com

This patch removes the optional print_state() function pointer which included
in 'struct extcon_dev' because the extcon must maintain the consistent name
of extcon device on sysfs instead of inconsistent state of external connectors.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-gpio.c | 18 ------------------
 drivers/extcon/extcon.c      |  8 --------
 include/linux/extcon.h       |  5 -----
 3 files changed, 31 deletions(-)

diff --git a/drivers/extcon/extcon-gpio.c b/drivers/extcon/extcon-gpio.c
index 355459a..57c24fa 100644
--- a/drivers/extcon/extcon-gpio.c
+++ b/drivers/extcon/extcon-gpio.c
@@ -65,22 +65,6 @@ static irqreturn_t gpio_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static ssize_t extcon_gpio_print_state(struct extcon_dev *edev, char *buf)
-{
-	struct device *dev = edev->dev.parent;
-	struct gpio_extcon_data *extcon_data = dev_get_drvdata(dev);
-	const char *state;
-
-	if (extcon_get_state(edev))
-		state = extcon_data->state_on;
-	else
-		state = extcon_data->state_off;
-
-	if (state)
-		return sprintf(buf, "%s\n", state);
-	return -EINVAL;
-}
-
 static int gpio_extcon_probe(struct platform_device *pdev)
 {
 	struct gpio_extcon_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -110,8 +94,6 @@ static int gpio_extcon_probe(struct platform_device *pdev)
 	extcon_data->state_on = pdata->state_on;
 	extcon_data->state_off = pdata->state_off;
 	extcon_data->check_on_resume = pdata->check_on_resume;
-	if (pdata->state_on && pdata->state_off)
-		extcon_data->edev->print_state = extcon_gpio_print_state;
 
 	ret = devm_gpio_request_one(&pdev->dev, extcon_data->gpio, GPIOF_DIR_IN,
 				    pdev->name);
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 76157ab..6f03ccf 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -162,14 +162,6 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 	int i, count = 0;
 	struct extcon_dev *edev = dev_get_drvdata(dev);
 
-	if (edev->print_state) {
-		int ret = edev->print_state(edev, buf);
-
-		if (ret >= 0)
-			return ret;
-		/* Use default if failed */
-	}
-
 	if (edev->max_supported == 0)
 		return sprintf(buf, "%u\n", edev->state);
 
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 1656c98..c0f8c4f 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -75,8 +75,6 @@ struct extcon_cable;
  *			be attached simulataneously. {0x7, 0} is equivalent to
  *			{0x3, 0x6, 0x5, 0}. If it is {0xFFFFFFFF, 0}, there
  *			can be no simultaneous connections.
- * @print_state:	An optional callback to override the method to print the
- *			status of the extcon device.
  * @dev:		Device of this extcon.
  * @state:		Attach/detach state of this extcon. Do not provide at
  *			register-time.
@@ -100,9 +98,6 @@ struct extcon_dev {
 	const unsigned int *supported_cable;
 	const u32 *mutually_exclusive;
 
-	/* Optional callbacks to override class functions */
-	ssize_t	(*print_state)(struct extcon_dev *edev, char *buf);
-
 	/* Internal data. Please do not set. */
 	struct device dev;
 	struct raw_notifier_head *nh;
-- 
2.2.0.GIT

