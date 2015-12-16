From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] PM / sleep: define inline functions
Date: Wed, 16 Dec 2015 17:11:39 +0530
Message-ID: <1450266099-4352-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33384 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932530AbbLPLll (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 06:41:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Eric Anholt <eric@anholt.net>

If CONFIG_PM_SLEEP is not defined then the functions are defined as
NULL. And as a result we are getting build failure with
alpha allmodconfig with the error:

drivers/gpu/drm/vc4/vc4_v3d.c: In function 'vc4_v3d_set_power':
include/linux/stddef.h:7:14: error: called object is not a function or function pointer
 #define NULL ((void *)0)
              ^
include/linux/pm.h:776:30: note: in expansion of macro 'NULL'
 #define pm_generic_poweroff  NULL
                              ^
drivers/gpu/drm/vc4/vc4_v3d.c:157:10: note: in expansion of macro 'pm_generic_poweroff'
   return pm_generic_poweroff(&vc4->v3d->pdev->dev);
          ^
include/linux/stddef.h:7:14: error: called object is not a function or function pointer
 #define NULL ((void *)0)
              ^
include/linux/pm.h:764:28: note: in expansion of macro 'NULL'
 #define pm_generic_resume  NULL
                            ^
drivers/gpu/drm/vc4/vc4_v3d.c:159:10: note: in expansion of macro 'pm_generic_resume'
   return pm_generic_resume(&vc4->v3d->pdev->dev);
          ^

Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
Cc: Eric Anholt <eric@anholt.net>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/97149763

Also tested with x86_64 allmodconfig.

 include/linux/pm.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 528be67..5fe5dbb 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -755,13 +755,22 @@ static inline void dpm_for_each_dev(void *data, void (*fn)(struct device *, void
 {
 }
 
+static inline int pm_generic_resume(struct device *dev)
+{
+	return 0;
+}
+
+static inline int pm_generic_poweroff(struct device *dev)
+{
+	return 0;
+}
+
 #define pm_generic_prepare		NULL
 #define pm_generic_suspend_late		NULL
 #define pm_generic_suspend_noirq	NULL
 #define pm_generic_suspend		NULL
 #define pm_generic_resume_early		NULL
 #define pm_generic_resume_noirq		NULL
-#define pm_generic_resume		NULL
 #define pm_generic_freeze_noirq		NULL
 #define pm_generic_freeze_late		NULL
 #define pm_generic_freeze		NULL
@@ -773,7 +782,6 @@ static inline void dpm_for_each_dev(void *data, void (*fn)(struct device *, void
 #define pm_generic_restore		NULL
 #define pm_generic_poweroff_noirq	NULL
 #define pm_generic_poweroff_late	NULL
-#define pm_generic_poweroff		NULL
 #define pm_generic_complete		NULL
 #endif /* !CONFIG_PM_SLEEP */
 
-- 
1.9.1

