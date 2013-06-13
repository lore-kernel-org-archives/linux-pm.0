From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH] pm: make device_prepare() use dpm_run_callback()
Date: Thu, 13 Jun 2013 16:20:39 +0200
Message-ID: <1371133239-12054-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49488 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757460Ab3FMOUp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2013 10:20:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

After looking at device_prepare() I was curious why the info parameter
isn't used. Then I noticed that others call dpm_run_callback() which
takes the info parameter and is actually doing something with it and it
does the same (cb) check as here.
So maybe, maybe the intention here was to use the function in the first
place.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/base/power/main.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 5a9b656..521029e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1223,7 +1223,7 @@ int dpm_suspend(pm_message_t state)
  */
 static int device_prepare(struct device *dev, pm_message_t state)
 {
-	int (*callback)(struct device *) = NULL;
+	pm_callback_t callback = NULL;
 	char *info = NULL;
 	int error = 0;
 
@@ -1261,10 +1261,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 		callback = dev->driver->pm->prepare;
 	}
 
-	if (callback) {
-		error = callback(dev);
-		suspend_report_result(callback, error);
-	}
+	error = dpm_run_callback(callback, dev, state, info);
 
 	device_unlock(dev);
 
-- 
1.7.10.4

