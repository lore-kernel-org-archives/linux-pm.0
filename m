From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / core: fix kerneldoc comment for device_pm_wait_for_dev
Date: Fri, 15 Mar 2019 23:48:41 -0400
Message-ID: <20190316034841.31451-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

Rearrange comment to make the comment style consistent, the previous
function parameters are described first.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 0cff68bd7b4b..eddb54057ed6 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -2069,8 +2069,8 @@ EXPORT_SYMBOL_GPL(__suspend_report_result);
 
 /**
  * device_pm_wait_for_dev - Wait for suspend/resume of a device to complete.
- * @dev: Device to wait for.
  * @subordinate: Device that needs to wait for @dev.
+ * @dev: Device to wait for.
  */
 int device_pm_wait_for_dev(struct device *subordinate, struct device *dev)
 {
-- 
2.17.0
