From: Sriram Dash <dash.sriram@gmail.com>
Subject: [PATCH 2/2] base: power : opp.c: fixed a typo error
Date: Wed, 27 May 2015 00:00:10 +0530
Message-ID: <1432665010-24464-1-git-send-email-dash.sriram@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33642 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbbEZSaY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2015 14:30:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, dashsriram <dash.sriram@gmail.com>

From: dashsriram <dash.sriram@gmail.com>

Fixed a typo error in the file

Signed-off-by: Sriram Dash <dash.sriram@gmail.com>
---
 drivers/base/power/opp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 677fb28..300941b 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -675,7 +675,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
  * share a common logic which is isolated here.
  *
  * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
- * copy operation, returns 0 if no modifcation was done OR modification was
+ * copy operation, returns 0 if no modification was done OR modification was
  * successful.
  *
  * Locking: The internal device_opp and opp structures are RCU protected.
@@ -763,7 +763,7 @@ unlock:
  * mutex locking or synchronize_rcu() blocking calls cannot be used.
  *
  * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
- * copy operation, returns 0 if no modifcation was done OR modification was
+ * copy operation, returns 0 if no modification was done OR modification was
  * successful.
  */
 int dev_pm_opp_enable(struct device *dev, unsigned long freq)
@@ -789,7 +789,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_enable);
  * mutex locking or synchronize_rcu() blocking calls cannot be used.
  *
  * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
- * copy operation, returns 0 if no modifcation was done OR modification was
+ * copy operation, returns 0 if no modification was done OR modification was
  * successful.
  */
 int dev_pm_opp_disable(struct device *dev, unsigned long freq)
-- 
2.4.1

