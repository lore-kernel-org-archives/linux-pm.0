From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] PM-wakeup: Delete unnecessary checks before three function
 calls
Date: Sat, 23 Jul 2016 17:14:00 +0200
Message-ID: <88d6d524-c093-4fcd-35ba-ff19f7b21fe2@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <5786434.e97HVzPjpI@vostro.rjw.lan>
 <b243d2ba-a359-998d-1dd8-43ff444074a8@users.sourceforge.net>
 <1722549.jyvuK0dZRm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:64757 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbcGWPO3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 23 Jul 2016 11:14:29 -0400
In-Reply-To: <1722549.jyvuK0dZRm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Jul 2016 17:04:00 +0200

The following functions test whether their argument is NULL
and then return immediately.
* dev_pm_arm_wake_irq
* dev_pm_disarm_wake_irq
* wakeup_source_unregister

Thus the test around the calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/base/power/wakeup.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5fb7718..c35d3f5 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -334,10 +334,8 @@ void device_wakeup_arm_wake_irqs(void)
 	struct wakeup_source *ws;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
-		if (ws->wakeirq)
-			dev_pm_arm_wake_irq(ws->wakeirq);
-	}
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
+		dev_pm_arm_wake_irq(ws->wakeirq);
 	rcu_read_unlock();
 }
 
@@ -351,10 +349,8 @@ void device_wakeup_disarm_wake_irqs(void)
 	struct wakeup_source *ws;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
-		if (ws->wakeirq)
-			dev_pm_disarm_wake_irq(ws->wakeirq);
-	}
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
+		dev_pm_disarm_wake_irq(ws->wakeirq);
 	rcu_read_unlock();
 }
 
@@ -390,9 +386,7 @@ int device_wakeup_disable(struct device *dev)
 		return -EINVAL;
 
 	ws = device_wakeup_detach(dev);
-	if (ws)
-		wakeup_source_unregister(ws);
-
+	wakeup_source_unregister(ws);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(device_wakeup_disable);
-- 
2.9.2

