From: Colin King <colin.king@canonical.com>
Subject: [PATCH] PM / clk: don't return int on __pm_clk_enable
Date: Mon, 29 Jun 2015 22:13:38 +0100
Message-ID: <1435612418-23012-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Static analysis by cppcheck found an issue that was recently introduced by
commit 471f7707b6f0b1 ("PM / clock_ops: make __pm_clk_enable more generic")
where a return status in ret was not being initialised and garbage
being returned when ce->status >= PCE_STATUS_ERROR.

The fact that ret is not being checked by the caller and that
ret is only used internally __pm_clk_enable to check if clk_enable
was OK means we can ignore returning it instead turn
__pm_clk_enable into function with a void return.

Fixes: 471f7707b6f0b1 ("PM / clock_ops: make __pm_clk_enable more generic")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/base/power/clock_ops.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index acef9f9..652b5a3 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -38,7 +38,7 @@ struct pm_clock_entry {
  * @dev: The device for the given clock
  * @ce: PM clock entry corresponding to the clock.
  */
-static inline int __pm_clk_enable(struct device *dev, struct pm_clock_entry *ce)
+static inline void __pm_clk_enable(struct device *dev, struct pm_clock_entry *ce)
 {
 	int ret;
 
@@ -50,8 +50,6 @@ static inline int __pm_clk_enable(struct device *dev, struct pm_clock_entry *ce)
 			dev_err(dev, "%s: failed to enable clk %p, error %d\n",
 				__func__, ce->clk, ret);
 	}
-
-	return ret;
 }
 
 /**
-- 
2.1.4
