From: Jin Qian <jinqian@android.com>
Subject: [PATCH 3/3] power: add a dummy wakeup_source to record statistics
Date: Wed, 22 Apr 2015 17:50:12 -0700
Message-ID: <1429750212-28659-4-git-send-email-jinqian@android.com>
References: <1429750212-28659-1-git-send-email-jinqian@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33559 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966198AbbDWAur (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 20:50:47 -0400
Received: by igbpi8 with SMTP id pi8so1385456igb.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 17:50:46 -0700 (PDT)
In-Reply-To: <1429750212-28659-1-git-send-email-jinqian@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jin Qian <jinqian@android.com>

After a wakeup_source is destroyed, we lost all information such as how
long this wakeup_source has been active. Add a dummy wakeup_source to
record such info.

Signed-off-by: Jin Qian <jinqian@android.com>
---
 drivers/base/power/wakeup.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index bdb45f3..732683c 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -59,6 +59,11 @@ static DECLARE_WAIT_QUEUE_HEAD(wakeup_count_wait_queue);
 
 static ktime_t last_read_time;
 
+static struct wakeup_source deleted_ws = {
+	.name = "deleted",
+	.lock =  __SPIN_LOCK_UNLOCKED(deleted_ws.lock),
+};
+
 /**
  * wakeup_source_prepare - Prepare a new wakeup source for initialization.
  * @ws: Wakeup source to prepare.
@@ -110,6 +115,33 @@ void wakeup_source_drop(struct wakeup_source *ws)
 }
 EXPORT_SYMBOL_GPL(wakeup_source_drop);
 
+/*
+ * Record wakeup_source statistics being deleted into a dummy wakeup_source.
+ */
+static void wakeup_source_record(struct wakeup_source *ws)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&deleted_ws.lock, flags);
+
+	if (ws->event_count) {
+		deleted_ws.total_time =
+			ktime_add(deleted_ws.total_time, ws->total_time);
+		deleted_ws.max_time =
+			ktime_add(deleted_ws.max_time, ws->max_time);
+		deleted_ws.prevent_sleep_time =
+			ktime_add(deleted_ws.prevent_sleep_time,
+				  ws->prevent_sleep_time);
+		deleted_ws.event_count += ws->event_count;
+		deleted_ws.active_count += ws->active_count;
+		deleted_ws.relax_count += ws->relax_count;
+		deleted_ws.expire_count += ws->expire_count;
+		deleted_ws.wakeup_count += ws->wakeup_count;
+	}
+
+	spin_unlock_irqrestore(&deleted_ws.lock, flags);
+}
+
 /**
  * wakeup_source_destroy - Destroy a struct wakeup_source object.
  * @ws: Wakeup source to destroy.
@@ -122,6 +154,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)
 		return;
 
 	wakeup_source_drop(ws);
+	wakeup_source_record(ws);
 	kfree(ws->name);
 	kfree(ws);
 }
@@ -930,6 +963,8 @@ static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
 		print_wakeup_source_stats(m, ws);
 	rcu_read_unlock();
 
+	print_wakeup_source_stats(m, &deleted_ws);
+
 	return 0;
 }
 
-- 
2.2.0.rc0.207.ga3a616c

