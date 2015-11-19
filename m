From: Saurabh Sengar <saurabh.truth@gmail.com>
Subject: [PATCH] drivers: power: set IRQF_ONESHOT if no primary handler is specified
Date: Thu, 19 Nov 2015 12:42:59 +0530
Message-ID: <1447917179-9333-1-git-send-email-saurabh.truth@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34389 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691AbbKSHNJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 02:13:09 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Saurabh Sengar <saurabh.truth@gmail.com>

If no primary handler is specified for threaded_irq then a
default one is assigned which always returns IRQ_WAKE_THREAD.
This handler requires the IRQF_ONESHOT, because the source of
interrupt is not disabled.

Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
---
 drivers/power/max8903_charger.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 6d39d52..17876ca 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -291,10 +291,10 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (pdata->dc_valid) {
 		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->dok),
-						NULL, max8903_dcin,
-						IRQF_TRIGGER_FALLING |
-						IRQF_TRIGGER_RISING,
-						"MAX8903 DC IN", data);
+					NULL, max8903_dcin,
+					IRQF_TRIGGER_FALLING |
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"MAX8903 DC IN", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for DC (%d)\n",
 					gpio_to_irq(pdata->dok), ret);
@@ -304,10 +304,10 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (pdata->usb_valid) {
 		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->uok),
-						NULL, max8903_usbin,
-						IRQF_TRIGGER_FALLING |
-						IRQF_TRIGGER_RISING,
-						"MAX8903 USB IN", data);
+					NULL, max8903_usbin,
+					IRQF_TRIGGER_FALLING |
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"MAX8903 USB IN", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for USB (%d)\n",
 					gpio_to_irq(pdata->uok), ret);
@@ -317,10 +317,10 @@ static int max8903_probe(struct platform_device *pdev)
 
 	if (pdata->flt) {
 		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->flt),
-						NULL, max8903_fault,
-						IRQF_TRIGGER_FALLING |
-						IRQF_TRIGGER_RISING,
-						"MAX8903 Fault", data);
+					NULL, max8903_fault,
+					IRQF_TRIGGER_FALLING |
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"MAX8903 Fault", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for Fault (%d)\n",
 					gpio_to_irq(pdata->flt), ret);
-- 
1.9.1

