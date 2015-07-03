From: SungEun Kim <cleaneye.kim@vger.kernel.org>
Subject: [PATCH v3] PM / Sleep: Use workqueue for user space wakeup sources garbage collector
Date: Fri,  3 Jul 2015 15:57:20 +0900
Message-ID: <1435906640-27641-1-git-send-email-cleaneye.kim@lge.com>
References: <1435739328-17021-1-git-send-email-cleaneye.kim@lge.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:50145 "EHLO
	lgemrelse7q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbbGCG5q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 02:57:46 -0400
In-Reply-To: <1435739328-17021-1-git-send-email-cleaneye.kim@lge.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "cleaeye.kim" <cleaneye.kim@lge.com>

From: "cleaeye.kim" <cleaneye.kim@lge.com>

The synchronous synchronize_rcu in wakeup_source_remove makes user process
which writes to /sys/kernel/wake_unlock blocked sometimes.

For example, when android eventhub tries to release wakelock,
this blocking process can occur, and eventhub can't get input event
for a while.

Using workqueue instead of direct function call at pm_wake_unlock
can prevent this unnecessary delay of an user space process.

Signed-off-by: SungEun Kim <cleaneye.kim@lge.com>
---
 kernel/power/wakelock.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 019069c..1896386 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include "power.h"
 
@@ -83,7 +84,9 @@ static inline void decrement_wakelocks_number(void) {}
 #define WL_GC_COUNT_MAX	100
 #define WL_GC_TIME_SEC	300
 
+static void __wakelocks_gc(struct work_struct *work);
 static LIST_HEAD(wakelocks_lru_list);
+static DECLARE_WORK(wakelock_work, __wakelocks_gc);
 static unsigned int wakelocks_gc_count;
 
 static inline void wakelocks_lru_add(struct wakelock *wl)
@@ -96,13 +99,12 @@ static inline void wakelocks_lru_most_recent(struct wakelock *wl)
 	list_move(&wl->lru, &wakelocks_lru_list);
 }
 
-static void wakelocks_gc(void)
+static void __wakelocks_gc(struct work_struct *work)
 {
 	struct wakelock *wl, *aux;
 	ktime_t now;
 
-	if (++wakelocks_gc_count <= WL_GC_COUNT_MAX)
-		return;
+	mutex_lock(&wakelocks_lock);
 
 	now = ktime_get();
 	list_for_each_entry_safe_reverse(wl, aux, &wakelocks_lru_list, lru) {
@@ -127,6 +129,16 @@ static void wakelocks_gc(void)
 		}
 	}
 	wakelocks_gc_count = 0;
+
+	mutex_unlock(&wakelocks_lock);
+}
+
+static void wakelocks_gc(void)
+{
+	if (++wakelocks_gc_count <= WL_GC_COUNT_MAX)
+		return;
+
+	schedule_work(&wakelock_work);
 }
 #else /* !CONFIG_PM_WAKELOCKS_GC */
 static inline void wakelocks_lru_add(struct wakelock *wl) {}
-- 
1.7.9.5

