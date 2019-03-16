From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / core: fix kerneldoc comment for dpm_watchdog_handler()
Date: Fri, 15 Mar 2019 23:37:51 -0400
Message-ID: <20190316033751.31323-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

This brings the kernel doc in line with the function signature.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f80d298de3fa..0cff68bd7b4b 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -478,7 +478,7 @@ struct dpm_watchdog {
 
 /**
  * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
- * @data: Watchdog object address.
+ * @t: The timer that pm watchdog depends on.
  *
  * Called when a driver has timed out suspending or resuming.
  * There's not much we can do here to recover so panic() to
-- 
2.17.0
