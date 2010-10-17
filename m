From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / Wakeup: Show wakeup sources statistics in
	debugfs
Date: Mon, 18 Oct 2010 01:22:35 +0200
Message-ID: <201010180122.35382.rjw__41878.2491623007$1287358049$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There may be wakeup sources that aren't associated with any devices
and their statistics information won't be available from sysfs. Also,
for debugging purposes it is convenient to have all of the wakeup
sources statistics available from one place.  For these reasons,
introduce new file "wakeup_sources" in debugfs containing those
statistics.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

The patch is on top of suspend-2.6/linux-next.

Thanks,
Rafael

---
 drivers/base/power/wakeup.c |   85 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

Index: linux-2.6/drivers/base/power/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/base/power/wakeup.c
+++ linux-2.6/drivers/base/power/wakeup.c
@@ -11,6 +11,8 @@
 #include <linux/sched.h>
 #include <linux/capability.h>
 #include <linux/suspend.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
 
 #include "power.h"
 
@@ -617,3 +619,86 @@ bool pm_save_wakeup_count(unsigned int c
 		pm_wakeup_update_hit_counts();
 	return ret;
 }
+
+static struct dentry *wakeup_sources_stats_dentry;
+
+/**
+ * print_wakeup_source_stats - Print wakeup source statistics information.
+ * @m: seq_file to print the statistics into.
+ * @ws: Wakeup source object to print the statistics for.
+ */
+static int print_wakeup_source_stats(struct seq_file *m,
+				     struct wakeup_source *ws)
+{
+	unsigned long flags;
+	ktime_t total_time;
+	ktime_t max_time;
+	unsigned long active_count;
+	ktime_t active_time;
+	int ret;
+
+	spin_lock_irqsave(&ws->lock, flags);
+
+	total_time = ws->total_time;
+	max_time = ws->max_time;
+	active_count = ws->active_count;
+	if (ws->active) {
+		active_time = ktime_sub(ktime_get(), ws->last_time);
+		total_time = ktime_add(total_time, active_time);
+		if (active_time.tv64 > max_time.tv64)
+			max_time = active_time;
+	} else {
+		active_time = ktime_set(0, 0);
+	}
+
+	ret = seq_printf(m, "%-12s\t%lu\t\t%lu\t\t%lu\t\t"
+			"%lld\t\t%lld\t\t%lld\t\t%lld\n",
+			ws->name, active_count, ws->event_count, ws->hit_count,
+			ktime_to_ms(active_time), ktime_to_ms(total_time),
+			ktime_to_ms(max_time), ktime_to_ms(ws->last_time));
+
+	spin_unlock_irqrestore(&ws->lock, flags);
+
+	return ret;
+}
+
+/**
+ * wakeup_sources_stats_show - Print wakeup sources statistics information.
+ * @m: seq_file to print the statistics into.
+ */
+static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
+{
+	struct wakeup_source *ws;
+
+	seq_puts(m, "name\t\tactive_count\tevent_count\thit_count\t"
+		"active_since\ttotal_time\tmax_time\tlast_change\n");
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
+		print_wakeup_source_stats(m, ws);
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, wakeup_sources_stats_show, NULL);
+}
+
+static const struct file_operations wakeup_sources_stats_fops = {
+	.owner = THIS_MODULE,
+	.open = wakeup_sources_stats_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int __init wakeup_sources_debugfs_init(void)
+{
+	wakeup_sources_stats_dentry = debugfs_create_file("wakeup_sources",
+			S_IRUGO, NULL, NULL, &wakeup_sources_stats_fops);
+	return 0;
+}
+
+postcore_initcall(wakeup_sources_debugfs_init);
