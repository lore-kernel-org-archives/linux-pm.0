From: Saurabh Sengar <saurabh.truth@gmail.com>
Subject: [PATCH] drivers: power: always set IRQF_ONESHOT if no primary handler is specified
Date: Wed, 28 Oct 2015 10:34:35 +0530
Message-ID: <1446008675-12737-1-git-send-email-saurabh.truth@gmail.com>
References: <saurabh.truth@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:32845 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbJ1FEn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 01:04:43 -0400
In-Reply-To: <saurabh.truth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Saurabh Sengar <saurabh.truth@gmail.com>

If no primary handler is specified then a default one is assigned which
always returns IRQ_WAKE_THREAD. This handler requires the IRQF_ONESHOT,
because the source of interrupt is not disabled.

Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
---
 drivers/power/max8903_charger.c |  9 ++++++---
 drivers/power/wm831x_power.c    | 13 ++++++-------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index bf2b4b3..0488e74 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -301,7 +301,8 @@ static int max8903_probe(struct platform_device *pdev)
 	if (pdata->dc_valid) {
 		ret = request_threaded_irq(gpio_to_irq(pdata->dok),
 				NULL, max8903_dcin,
-				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING
+				| IRQF_ONESHOT,
 				"MAX8903 DC IN", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for DC (%d)\n",
@@ -313,7 +314,8 @@ static int max8903_probe(struct platform_device *pdev)
 	if (pdata->usb_valid) {
 		ret = request_threaded_irq(gpio_to_irq(pdata->uok),
 				NULL, max8903_usbin,
-				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING
+				| IRQF_ONESHOT,
 				"MAX8903 USB IN", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for USB (%d)\n",
@@ -325,7 +327,8 @@ static int max8903_probe(struct platform_device *pdev)
 	if (pdata->flt) {
 		ret = request_threaded_irq(gpio_to_irq(pdata->flt),
 				NULL, max8903_fault,
-				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING
+				| IRQF_ONESHOT,
 				"MAX8903 Fault", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for Fault (%d)\n",
diff --git a/drivers/power/wm831x_power.c b/drivers/power/wm831x_power.c
index db11ae6..f2f5bae 100644
--- a/drivers/power/wm831x_power.c
+++ b/drivers/power/wm831x_power.c
@@ -572,8 +572,8 @@ static int wm831x_power_probe(struct platform_device *pdev)
 
 	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "SYSLO"));
 	ret = request_threaded_irq(irq, NULL, wm831x_syslo_irq,
-				   IRQF_TRIGGER_RISING, "System power low",
-				   power);
+				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				   "System power low", power);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request SYSLO IRQ %d: %d\n",
 			irq, ret);
@@ -582,8 +582,8 @@ static int wm831x_power_probe(struct platform_device *pdev)
 
 	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "PWR SRC"));
 	ret = request_threaded_irq(irq, NULL, wm831x_pwr_src_irq,
-				   IRQF_TRIGGER_RISING, "Power source",
-				   power);
+				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				   "Power source", power);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request PWR SRC IRQ %d: %d\n",
 			irq, ret);
@@ -595,9 +595,8 @@ static int wm831x_power_probe(struct platform_device *pdev)
 				 platform_get_irq_byname(pdev,
 							 wm831x_bat_irqs[i]));
 		ret = request_threaded_irq(irq, NULL, wm831x_bat_irq,
-					   IRQF_TRIGGER_RISING,
-					   wm831x_bat_irqs[i],
-					   power);
+					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					   wm831x_bat_irqs[i], power);
 		if (ret != 0) {
 			dev_err(&pdev->dev,
 				"Failed to request %s IRQ %d: %d\n",
-- 
1.9.1

