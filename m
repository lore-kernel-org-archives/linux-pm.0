From: Jin Qian <jinqian@android.com>
Subject: [PATCH 2/3] power: increment wakeup_count when save_wakeup_count failed.
Date: Wed, 22 Apr 2015 17:50:11 -0700
Message-ID: <1429750212-28659-3-git-send-email-jinqian@android.com>
References: <1429750212-28659-1-git-send-email-jinqian@android.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429750212-28659-1-git-send-email-jinqian@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jin Qian <jinqian@android.com>
List-Id: linux-pm@vger.kernel.org

user-space aborts suspend attempt if writing wakeup_count failed.
Count the write failure towards wakeup_count.

Signed-off-by: Jin Qian <jinqian@android.com>
---
 drivers/base/power/wakeup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index f24c622..bdb45f3 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -57,6 +57,8 @@ static LIST_HEAD(wakeup_sources);
 
 static DECLARE_WAIT_QUEUE_HEAD(wakeup_count_wait_queue);
 
+static ktime_t last_read_time;
+
 /**
  * wakeup_source_prepare - Prepare a new wakeup source for initialization.
  * @ws: Wakeup source to prepare.
@@ -771,10 +773,15 @@ void pm_wakeup_clear(void)
 bool pm_get_wakeup_count(unsigned int *count, bool block)
 {
 	unsigned int cnt, inpr;
+	unsigned long flags;
 
 	if (block) {
 		DEFINE_WAIT(wait);
 
+		spin_lock_irqsave(&events_lock, flags);
+		last_read_time = ktime_get();
+		spin_unlock_irqrestore(&events_lock, flags);
+
 		for (;;) {
 			prepare_to_wait(&wakeup_count_wait_queue, &wait,
 					TASK_INTERRUPTIBLE);
@@ -806,6 +813,7 @@ bool pm_save_wakeup_count(unsigned int count)
 {
 	unsigned int cnt, inpr;
 	unsigned long flags;
+	struct wakeup_source *ws;
 
 	events_check_enabled = false;
 	spin_lock_irqsave(&events_lock, flags);
@@ -813,6 +821,15 @@ bool pm_save_wakeup_count(unsigned int count)
 	if (cnt == count && inpr == 0) {
 		saved_count = count;
 		events_check_enabled = true;
+	} else {
+		rcu_read_lock();
+		list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+			if (ws->active ||
+			    ktime_compare(ws->last_time, last_read_time) > 0) {
+				ws->wakeup_count++;
+			}
+		}
+		rcu_read_unlock();
 	}
 	spin_unlock_irqrestore(&events_lock, flags);
 	return events_check_enabled;
-- 
2.2.0.rc0.207.ga3a616c
