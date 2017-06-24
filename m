From: Thomas Gleixner <tglx@linutronix.de>
Subject: PM / wakeirq: Convert to SRCU
Date: Sat, 24 Jun 2017 11:56:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706241153260.1941@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

The wakeirq infrastructure uses RCU to protect the list of wakeirqs. That
breaks the irq bus locking infrastructure, which allows sleeping functions
to be called so interrupt controllers behind slow busses, e.g. i2c, can be
handled.

The wakeirq functions hold rcu_read_lock and call into irq functions, which
in case of interrupts using the irq bus locking will trigger a
might_sleep() splat.

Convert the wakeirq infrastructure to Sleepable RCU and unbreak it.

Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ handling")
Reported-by: Brian Norris <briannorris@chromium.org>
Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org

---
 drivers/base/power/wakeup.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -60,6 +60,8 @@ static LIST_HEAD(wakeup_sources);
 
 static DECLARE_WAIT_QUEUE_HEAD(wakeup_count_wait_queue);
 
+static struct srcu_struct wakeup_srcu;
+
 static struct wakeup_source deleted_ws = {
 	.name = "deleted",
 	.lock =  __SPIN_LOCK_UNLOCKED(deleted_ws.lock),
@@ -198,7 +200,7 @@ void wakeup_source_remove(struct wakeup_
 	spin_lock_irqsave(&events_lock, flags);
 	list_del_rcu(&ws->entry);
 	spin_unlock_irqrestore(&events_lock, flags);
-	synchronize_rcu();
+	synchronize_srcu(&wakeup_srcu);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_remove);
 
@@ -804,10 +806,10 @@ EXPORT_SYMBOL_GPL(pm_wakeup_dev_event);
 void pm_print_active_wakeup_sources(void)
 {
 	struct wakeup_source *ws;
-	int active = 0;
+	int srcuidx, active = 0;
 	struct wakeup_source *last_activity_ws = NULL;
 
-	rcu_read_lock();
+	srcuidx = srcu_read_lock(&wakeup_srcu);
 	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
 		if (ws->active) {
 			pr_debug("active wakeup source: %s\n", ws->name);
@@ -823,7 +825,7 @@ void pm_print_active_wakeup_sources(void
 	if (!active && last_activity_ws)
 		pr_debug("last active wakeup source: %s\n",
 			last_activity_ws->name);
-	rcu_read_unlock();
+	srcu_read_unlock(&wakeup_srcu, srcuidx);
 }
 EXPORT_SYMBOL_GPL(pm_print_active_wakeup_sources);
 
@@ -950,8 +952,9 @@ void pm_wakep_autosleep_enabled(bool set
 {
 	struct wakeup_source *ws;
 	ktime_t now = ktime_get();
+	int srcuidx;
 
-	rcu_read_lock();
+	srcuidx = srcu_read_lock(&wakeup_srcu);
 	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
 		spin_lock_irq(&ws->lock);
 		if (ws->autosleep_enabled != set) {
@@ -965,7 +968,7 @@ void pm_wakep_autosleep_enabled(bool set
 		}
 		spin_unlock_irq(&ws->lock);
 	}
-	rcu_read_unlock();
+	srcu_read_unlock(&wakeup_srcu, srcuidx);
 }
 #endif /* CONFIG_PM_AUTOSLEEP */
 
@@ -1026,15 +1029,16 @@ static int print_wakeup_source_stats(str
 static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
 {
 	struct wakeup_source *ws;
+	int srcuidx;
 
 	seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
 		"expire_count\tactive_since\ttotal_time\tmax_time\t"
 		"last_change\tprevent_suspend_time\n");
 
-	rcu_read_lock();
+	srcuidx = srcu_read_lock(&wakeup_srcu);
 	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
 		print_wakeup_source_stats(m, ws);
-	rcu_read_unlock();
+	srcu_read_unlock(&wakeup_srcu, srcuidx);
 
 	print_wakeup_source_stats(m, &deleted_ws);
 
