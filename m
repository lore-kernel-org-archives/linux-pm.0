From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Subject: [PATCH] PM: fix typo
Date: Thu, 20 Feb 2014 13:30:32 +0530
Message-ID: <1392883232-24738-1-git-send-email-prabhakar.csengg@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:62949 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbaBTIAm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 03:00:42 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so1591216pad.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2014 00:00:42 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 include/linux/pm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 8c6583a..b051ba9 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -352,7 +352,7 @@ const struct dev_pm_ops name = { \
 
 /*
  * Use this for defining a set of PM operations to be used in all situations
- * (sustem suspend, hibernation or runtime PM).
+ * (system suspend, hibernation or runtime PM).
  * NOTE: In general, system suspend callbacks, .suspend() and .resume(), should
  * be different from the corresponding runtime PM callbacks, .runtime_suspend(),
  * and .runtime_resume(), because .runtime_suspend() always works on an already
-- 
1.7.9.5

