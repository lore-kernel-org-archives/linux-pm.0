From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 2/2] PM / Runtime: use deferrable timer for autosuspend
Date: Tue, 12 Jan 2016 18:17:20 +0100
Message-ID: <1452619040-27137-2-git-send-email-l.stach@pengutronix.de>
References: <1452619040-27137-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41227 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933677AbcALRRZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 12:17:25 -0500
In-Reply-To: <1452619040-27137-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, patchwork-lst@pengutronix.de

The timeouts used in PM autosuspend are relatively coarse (the shortest
I could find in a quick search through the kernel is 50ms). As they are
already handled relaxed by saving the overhead of always rearming the
timer by opportunistically suspending a device a bit early, it should
not matter if the the timeout is missed slightly.

By using a deferrable timer the CPU will not be woken just to handle
the autosuspend timeout, but handling will be batched with other
wakeups in the system.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index e1a10a03df8e..975a282600ff 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1383,7 +1383,7 @@ void pm_runtime_init(struct device *dev)
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
-	setup_timer(&dev->power.suspend_timer, pm_suspend_timer_fn,
+	setup_deferrable_timer(&dev->power.suspend_timer, pm_suspend_timer_fn,
 			(unsigned long)dev);
 
 	init_waitqueue_head(&dev->power.wait_queue);
-- 
2.6.4

