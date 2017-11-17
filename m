From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / runtime: Allow an irq-safe parent to be runtime suspended
Date: Fri, 17 Nov 2017 14:16:06 +0100
Message-ID: <1510924566-16112-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43230 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933291AbdKQNQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Nov 2017 08:16:17 -0500
Received: by mail-lf0-f66.google.com with SMTP id 73so2629844lfu.10
        for <linux-pm@vger.kernel.org>; Fri, 17 Nov 2017 05:16:16 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>

When pm_runtime_irq_safe() is a called for a child device, it's assumed
that the parent is never also irq-safe. Therefore, is the parent runtime
resumed and the usage counter increased for it, as to avoid having an
irq-safe child waiting for non-irq-safe parent.

Improve this behaviour by taking into account that the parent could also be
irq-safe. In such case let's allow it to be runtime suspended.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index ec059750..d44f520 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1370,13 +1370,13 @@ EXPORT_SYMBOL_GPL(pm_runtime_no_callbacks);
  * Set the power.irq_safe flag, which tells the PM core that the
  * ->runtime_suspend() and ->runtime_resume() callbacks for this device should
  * always be invoked with the spinlock held and interrupts disabled.  It also
- * causes the parent's usage counter to be permanently incremented, preventing
- * the parent from runtime suspending -- otherwise an irq-safe child might have
- * to wait for a non-irq-safe parent.
+ * causes the parent's usage counter to be permanently incremented, unless the
+ * parent is also irq-safe. This prevents the parent from runtime suspending,
+ * otherwise an irq-safe child might have to wait for a non-irq-safe parent.
  */
 void pm_runtime_irq_safe(struct device *dev)
 {
-	if (dev->parent)
+	if (dev->parent && !pm_runtime_is_irq_safe(dev->parent))
 		pm_runtime_get_sync(dev->parent);
 	spin_lock_irq(&dev->power.lock);
 	dev->power.irq_safe = 1;
@@ -1507,7 +1507,7 @@ void pm_runtime_reinit(struct device *dev)
 			spin_lock_irq(&dev->power.lock);
 			dev->power.irq_safe = 0;
 			spin_unlock_irq(&dev->power.lock);
-			if (dev->parent)
+			if (dev->parent && !pm_runtime_is_irq_safe(dev->parent))
 				pm_runtime_put(dev->parent);
 		}
 	}
-- 
2.7.4
