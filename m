From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Sleep: Set pm_generic functions to NULL for !CONFIG_PM_SLEEP
Date: Wed, 19 Feb 2014 13:09:21 +0100
Message-ID: <1392811761-28201-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:58552 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbaBSMJ1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2014 07:09:27 -0500
Received: by mail-la0-f44.google.com with SMTP id hr13so225270lab.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2014 04:09:26 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>

Previously only a subset of the functions were defined and set to NULL
while !CONFIG_PM_SLEEP. Let's make them all available so they can be
used no matter of CONFIG_PM_SLEEP or not.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm.h |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index db2be5f..a81b558 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -718,14 +718,26 @@ static inline void dpm_for_each_dev(void *data, void (*fn)(struct device *, void
 {
 }
 
-#define pm_generic_prepare	NULL
-#define pm_generic_suspend	NULL
-#define pm_generic_resume	NULL
-#define pm_generic_freeze	NULL
-#define pm_generic_thaw		NULL
-#define pm_generic_restore	NULL
-#define pm_generic_poweroff	NULL
-#define pm_generic_complete	NULL
+#define pm_generic_prepare		NULL
+#define pm_generic_suspend_late		NULL
+#define pm_generic_suspend_noirq	NULL
+#define pm_generic_suspend		NULL
+#define pm_generic_resume_early		NULL
+#define pm_generic_resume_noirq		NULL
+#define pm_generic_resume		NULL
+#define pm_generic_freeze_noirq		NULL
+#define pm_generic_freeze_late		NULL
+#define pm_generic_freeze		NULL
+#define pm_generic_thaw_noirq		NULL
+#define pm_generic_thaw_early		NULL
+#define pm_generic_thaw			NULL
+#define pm_generic_restore_noirq	NULL
+#define pm_generic_restore_early	NULL
+#define pm_generic_restore		NULL
+#define pm_generic_poweroff_noirq	NULL
+#define pm_generic_poweroff_late	NULL
+#define pm_generic_poweroff		NULL
+#define pm_generic_complete		NULL
 #endif /* !CONFIG_PM_SLEEP */
 
 /* How to reorder dpm_list after device_move() */
-- 
1.7.9.5

