From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] PM / wakeup: Remove timer from wakeup_source_remove()
Date: Fri,  8 Mar 2019 15:23:11 +0530
Message-ID: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sunzhaosheng@hisilicon.com, jean.xupeng@hisilicon.com, yuwei3@hisilicon.com, gengyanping@hisilicon.com, peter.panshilin@hisilicon.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

wakeup_source_remove() is the counterpart of wakeup_source_add() helper
and must undo the initializations done by wakeup_source_add(). Currently
the timer is initialized by wakeup_source_add() but removed from
wakeup_source_drop(), which doesn't look logically correct. Also it
should be okay to call wakeup_source_add() right after calling
wakeup_source_remove(), and in that case we may end up calling
timer_setup() for a potentially scheduled timer which is surely
incorrect.

Move the timer removal part to wakeup_source_remove() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/wakeup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index f1fee72ed970..18333962e3da 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -118,7 +118,6 @@ void wakeup_source_drop(struct wakeup_source *ws)
 	if (!ws)
 		return;
 
-	del_timer_sync(&ws->timer);
 	__pm_relax(ws);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_drop);
@@ -205,6 +204,8 @@ void wakeup_source_remove(struct wakeup_source *ws)
 	list_del_rcu(&ws->entry);
 	raw_spin_unlock_irqrestore(&events_lock, flags);
 	synchronize_srcu(&wakeup_srcu);
+
+	del_timer_sync(&ws->timer);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_remove);
 
-- 
2.21.0.rc0.269.g1a574e7a288b
