From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Thu, 10 Nov 2016 10:07:07 -0800
Message-ID: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36712 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbcKJSHl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 13:07:41 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so150437392pfz.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2016 10:07:40 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Brian Norris <briannorris@chromium.org>

It's important that user space can figure out what device woke the
system from suspend -- e.g., for debugging, or for implementing
conditional wake behavior. Dedicated wakeup IRQs don't currently do
that.

Let's report the event (pm_wakeup_event()) and also allow drivers to
synchronize with these events in their resume path (hence, disable_irq()
instead of disable_irq_nosync()).

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/base/power/wakeirq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 0d77cd6fd8d1..c35b2db1194c 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -139,6 +139,8 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
 	struct wake_irq *wirq = _wirq;
 	int res;
 
+	pm_wakeup_event(wirq->dev, 0);
+
 	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
 	res = pm_runtime_resume(wirq->dev);
 	if (res < 0)
@@ -240,7 +242,7 @@ void dev_pm_disable_wake_irq(struct device *dev)
 	struct wake_irq *wirq = dev->power.wakeirq;
 
 	if (wirq && wirq->dedicated_irq)
-		disable_irq_nosync(wirq->irq);
+		disable_irq(wirq->irq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);
 
-- 
2.8.0.rc3.226.g39d4020

