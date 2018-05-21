From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM: wakeup: Make the "aborting suspend" message debug
Date: Mon, 21 May 2018 13:12:12 +0200
Message-ID: <24631155.j0D4AbJmQY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The message printed by pm_wakeup_pending() on wakeup detection is
not very useful if someone is not interested specifically in
debugging wakeup, so turn it into a pm_debug() one.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/wakeup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -853,7 +853,7 @@ bool pm_wakeup_pending(void)
 	spin_unlock_irqrestore(&events_lock, flags);
 
 	if (ret) {
-		pr_info("PM: Wakeup pending, aborting suspend\n");
+		pr_debug("PM: Wakeup pending, aborting suspend\n");
 		pm_print_active_wakeup_sources();
 	}
 
