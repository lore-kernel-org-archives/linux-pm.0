From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] thermal: clock_cooling: Fix missing mutex_init()
Date: Mon, 25 Jul 2016 07:01:19 +0000
Message-ID: <1469430079-8533-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32835 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbcGYHBa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2016 03:01:30 -0400
Received: by mail-pa0-f66.google.com with SMTP id q2so10934635pap.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2016 00:01:30 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-pm@vger.kernel.org

The driver allocates the mutex but not initialize it.
Use mutex_init() on it to initialize it correctly.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/thermal/clock_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/clock_cooling.c b/drivers/thermal/clock_cooling.c
index 1b4ff0f..ed5dd0e 100644
--- a/drivers/thermal/clock_cooling.c
+++ b/drivers/thermal/clock_cooling.c
@@ -426,6 +426,7 @@ clock_cooling_register(struct device *dev, const char *clock_name)
 	if (!ccdev)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_init(&ccdev->lock);
 	ccdev->dev = dev;
 	ccdev->clk = devm_clk_get(dev, clock_name);
 	if (IS_ERR(ccdev->clk))

