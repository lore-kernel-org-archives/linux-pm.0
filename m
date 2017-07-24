From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] PM / runtime: Document new pm_runtime_set_suspended constraint
Date: Mon, 24 Jul 2017 11:53:56 +0200
Message-ID: <20170724095356.21667-1-johan@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32977 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbdGXJyR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 05:54:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>

Since commit a8636c89648a ("PM / Runtime: Don't allow to suspend a
device with an active child") it is no longer permitted to set
RPM_SUSPENDED state for a device with active children unless
power.ignore_children is set.

Update the documentation to reflect this.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 Documentation/power/runtime_pm.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 0fde3dcf077a..625549d4c74a 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -435,7 +435,8 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       PM status to 'suspended' and update its parent's counter of 'active'
       children as appropriate (it is only valid to use this function if
       'power.runtime_error' is set or 'power.disable_depth' is greater than
-      zero)
+      zero); it will fail and return an error code if the device has a child
+      which is active and the 'power.ignore_children' flag is unset
 
   bool pm_runtime_active(struct device *dev);
     - return true if the device's runtime PM status is 'active' or its
-- 
2.13.3
