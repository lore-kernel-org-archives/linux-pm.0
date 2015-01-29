From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] PM: Update function header for dev_pm_get_subsys_data()
Date: Thu, 29 Jan 2015 18:39:04 +0100
Message-ID: <1422553145-14798-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34463 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbbA2RjO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 12:39:14 -0500
Received: by mail-lb0-f172.google.com with SMTP id l4so30810418lbv.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2015 09:39:13 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>

The commit "PM: Make dev_pm_get_subsys_data() always return 0 on success"
changed the return value from dev_pm_get_subsys_data(). Let's update the
comment in the function header to reflect this change as well.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index b0f1388..a1ee51d 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -19,8 +19,8 @@
  * @dev: Device to handle.
  *
  * If power.subsys_data is NULL, point it to a new object, otherwise increment
- * its reference counter.  Return 1 if a new object has been created, otherwise
- * return 0 or error code.
+ * its reference counter.  Return 0 if new object has been created or refcount
+ * increased, otherwise negative error code.
  */
 int dev_pm_get_subsys_data(struct device *dev)
 {
-- 
1.9.1

