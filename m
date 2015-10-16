From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/3] power: bq27xxx_battery: fix platform probe
Date: Fri, 16 Oct 2015 15:44:10 +0200
Message-ID: <1445003052-31373-2-git-send-email-sre@kernel.org>
References: <1445003052-31373-1-git-send-email-sre@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:34720 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbbJPNow (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 09:44:52 -0400
In-Reply-To: <1445003052-31373-1-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Add missing initialization of register mapping table to
platform probe function.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/bq27xxx_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 994c78d9f426..69e6b371a51c 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -1292,6 +1292,7 @@ static int bq27xxx_battery_platform_probe(struct platform_device *pdev)
 
 	di->dev = &pdev->dev;
 	di->chip = pdata->chip;
+	di->regs = bq27xxx_regs[di->chip];
 
 	name = pdata->name ?: dev_name(&pdev->dev);
 	di->bus.read = &bq27xxx_battery_platform_read;
-- 
2.6.1

