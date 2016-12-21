From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/5] thermal: share get_ida()/release_ida() for other thermal ida users
Date: Wed, 21 Dec 2016 10:04:12 +0800
Message-ID: <1482285855-2974-3-git-send-email-rui.zhang@intel.com>
References: <1482285855-2974-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65334 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932778AbcLUCEU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Dec 2016 21:04:20 -0500
In-Reply-To: <1482285855-2974-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Zhang Rui <rui.zhang@intel.com>

CC: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c | 4 ++--
 drivers/thermal/thermal_core.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 1b6fde2..5849727 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -589,7 +589,7 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
  * - thermal zone devices lifecycle: registration, unregistration,
  *				     binding, and unbinding.
  */
-static int get_ida(struct ida *ida, struct mutex *lock, int *id)
+int get_ida(struct ida *ida, struct mutex *lock, int *id)
 {
 	int ret;
 
@@ -605,7 +605,7 @@ static int get_ida(struct ida *ida, struct mutex *lock, int *id)
 	return ret;
 }
 
-static void release_ida(struct ida *ida, struct mutex *lock, int id)
+void release_ida(struct ida *ida, struct mutex *lock, int id)
 {
 	if (!ida || !lock)
 		return;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 2412b37..e49f9f5 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -68,6 +68,8 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *,
 					  const char *, size_t);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
+int get_ida(struct ida *, struct mutex *, int *);
+void release_ida(struct ida *, struct mutex *, int);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
-- 
2.7.4

