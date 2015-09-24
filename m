From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] PM / OPP: Fix typo modifcation -> modification
Date: Thu, 24 Sep 2015 12:28:44 -0700
Message-ID: <1443122924-17017-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45953 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbbIXT2r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2015 15:28:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 8a72f0e586e8..62b918144b5b 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -961,7 +961,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_add);
  * share a common logic which is isolated here.
  *
  * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
- * copy operation, returns 0 if no modifcation was done OR modification was
+ * copy operation, returns 0 if no modification was done OR modification was
  * successful.
  *
  * Locking: The internal device_opp and opp structures are RCU protected.
@@ -1049,7 +1049,7 @@ unlock:
  * mutex locking or synchronize_rcu() blocking calls cannot be used.
  *
  * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
- * copy operation, returns 0 if no modifcation was done OR modification was
+ * copy operation, returns 0 if no modification was done OR modification was
  * successful.
  */
 int dev_pm_opp_enable(struct device *dev, unsigned long freq)
@@ -1075,7 +1075,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_enable);
  * mutex locking or synchronize_rcu() blocking calls cannot be used.
  *
  * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
- * copy operation, returns 0 if no modifcation was done OR modification was
+ * copy operation, returns 0 if no modification was done OR modification was
  * successful.
  */
 int dev_pm_opp_disable(struct device *dev, unsigned long freq)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

