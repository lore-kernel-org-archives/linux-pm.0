From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH] power: supply: cpcap-charger: fix incorrect return value check
Date: Sun, 12 Nov 2017 23:52:02 +0800
Message-ID: <1510501922-19163-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m12-14.163.com ([220.181.12.14]:57846 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdKLPw0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Nov 2017 10:52:26 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>

Function platform_get_irq_byname() returns a negative error code on
failure, and a zero or positive number on success. However, in function
cpcap_usb_init_irq(), positive IRQ numbers are also taken as error
cases. Use "if (irq < 0)" instead of "if (!irq)" to validate the return
value of platform_get_irq_byname().

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/power/supply/cpcap-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 11a0763..e4905be 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -484,7 +484,7 @@ static int cpcap_usb_init_irq(struct platform_device *pdev,
 	int irq, error;
 
 	irq = platform_get_irq_byname(pdev, name);
-	if (!irq)
+	if (irq < 0)
 		return -ENODEV;
 
 	error = devm_request_threaded_irq(ddata->dev, irq, NULL,
-- 
1.9.1
