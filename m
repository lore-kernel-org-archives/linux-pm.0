From: Colin King <colin.king@canonical.com>
Subject: [PATCH] PM / clock_ops: initialize ret to avoid garbage being returned
Date: Thu,  8 Jan 2015 15:31:01 +0000
Message-ID: <1420731061-5029-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33798 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486AbbAHPcH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jan 2015 10:32:07 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

cppcheck detected an unitialised ret:
  [drivers/base/power/clock_ops.c:53]: (error) Uninitialized variable: ret

ret is only assigned if ce->status < PCE_STATUS_ERROR, if this is false
then __pm_clk_enable returns whatever garbage ret picks up from the stack.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/base/power/clock_ops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index d626576..5bd283d 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -39,7 +39,7 @@ struct pm_clock_entry {
  */
 static inline int __pm_clk_enable(struct device *dev, struct pm_clock_entry *ce)
 {
-	int ret;
+	int ret = 0;
 
 	if (ce->status < PCE_STATUS_ERROR) {
 		ret = clk_enable(ce->clk);
-- 
1.7.9.5

