From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] power: supply: cpcap-battery: Fix platform_get_irq_byname's error checking
Date: Fri, 24 Nov 2017 22:31:40 +0530
Message-ID: <638d9bb5ac4c0ef44d3e83cc0f74d6e80cddcf7d.1511542695.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45190 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKXRB6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Nov 2017 12:01:58 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The platform_get_irq_byname() function returns -1 if an error occurs.
zero or positive number on success. platform_get_irq_byname() error
checking for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index ee71a2b..98ba078 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -586,8 +586,8 @@ static int cpcap_battery_init_irq(struct platform_device *pdev,
 	int irq, error;
 
 	irq = platform_get_irq_byname(pdev, name);
-	if (!irq)
-		return -ENODEV;
+	if (irq < 0)
+		return irq;
 
 	error = devm_request_threaded_irq(ddata->dev, irq, NULL,
 					  cpcap_battery_irq_thread,
-- 
2.7.4
