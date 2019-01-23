From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / wakeup: fix comment of pm_wakeup_dev_event()
Date: Wed, 23 Jan 2019 11:22:01 -0500
Message-ID: <20190123162201.26366-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

This brings the kernel doc in line with the function signature.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/wakeup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5fa1898755a3..f1fee72ed970 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -783,7 +783,7 @@ void pm_wakeup_ws_event(struct wakeup_source *ws, unsigned int msec, bool hard)
 EXPORT_SYMBOL_GPL(pm_wakeup_ws_event);
 
 /**
- * pm_wakeup_event - Notify the PM core of a wakeup event.
+ * pm_wakeup_dev_event - Notify the PM core of a wakeup event.
  * @dev: Device the wakeup event is related to.
  * @msec: Anticipated event processing time (in milliseconds).
  * @hard: If set, abort suspends in progress and wake up from suspend-to-idle.
-- 
2.17.0
