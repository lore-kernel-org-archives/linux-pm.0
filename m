From: Sungeun Kim <cleaneye.kim@lge.com>
Subject: [PATCH] PM / Sleep: Use workqueue for user space wakeup sources garbage collector
Date: Wed,  1 Jul 2015 09:50:07 +0900
Message-ID: <1435711807-19861-1-git-send-email-cleaneye.kim@lge.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lgeamrelo01.lge.com ([156.147.1.125]:47644 "EHLO
	lgeamrelo01.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbbGAAub (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 20:50:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, "cleaeye.kim" <cleaneye.kim@lge.com>

From: "cleaeye.kim" <cleaneye.kim@lge.com>

The synchronous synchronize_rcu in wakeup_source_remove makes user process
which writes to /sys/kernel/wake_unlock blocked sometimes.

For example, when android eventhub tries to release wakelock,
this blocking process can occur, and eventhub can't get input event
for a while.

Using workqueue instead of direct function call at pm_wake_unlock
can prevent this unnecessary delay of an user space process.

Signed-off-by: cleaeye.kim <cleaneye.kim@lge.com>
---
 kernel/power/wakelock.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 019069c..ea10baa 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include "power.h"
 
@@ -96,7 +97,7 @@ static inline void wakelocks_lru_most_recent(struct wakelock *wl)
 	list_move(&wl->lru, &wakelocks_lru_list);
 }
 
-static void wakelocks_gc(void)
+static void wakelocks_gc(struct work_struct *work)
 {
 	struct wakelock *wl, *aux;
 	ktime_t now;
@@ -105,6 +106,7 @@ static void wakelocks_gc(void)
 		return;
 
 	now = ktime_get();
+	mutex_lock(&wakelocks_lock);
 	list_for_each_entry_safe_reverse(wl, aux, &wakelocks_lru_list, lru) {
 		u64 idle_time_ns;
 		bool active;
@@ -126,12 +128,15 @@ static void wakelocks_gc(void)
 			decrement_wakelocks_number();
 		}
 	}
+	mutex_unlock(&wakelocks_lock);
 	wakelocks_gc_count = 0;
 }
+
+static DECLARE_WORK(wakelock_work, wakelocks_gc);
 #else /* !CONFIG_PM_WAKELOCKS_GC */
 static inline void wakelocks_lru_add(struct wakelock *wl) {}
 static inline void wakelocks_lru_most_recent(struct wakelock *wl) {}
-static inline void wakelocks_gc(void) {}
+static void wakelocks_gc(struct worksturct) {}
 #endif /* !CONFIG_PM_WAKELOCKS_GC */
 
 static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
@@ -260,7 +265,7 @@ int pm_wake_unlock(const char *buf)
 	__pm_relax(&wl->ws);
 
 	wakelocks_lru_most_recent(wl);
-	wakelocks_gc();
+	schedule_work(&wakelock_work);
 
  out:
 	mutex_unlock(&wakelocks_lock);
-- 
1.7.9.5

