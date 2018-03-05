From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
Date: Mon,  5 Mar 2018 16:47:46 +0800
Message-ID: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, rafael@kernel.org, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ganesh Mahendran <opensource.ganesh@gmail.com>
List-Id: linux-pm@vger.kernel.org

single_open() interface requires that the whole output must
fit into a single buffer. This will lead to timeout when
system memory is not in a good situation.

This patch use seq_open() to show wakeup stats. This method
need only one page, so timeout will not be observed.

Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
----
v2: use srcu_read_lock instead of rcu_read_lock
---
 drivers/base/power/wakeup.c | 77 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index ea01621..3bcab7d 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1029,32 +1029,77 @@ static int print_wakeup_source_stats(struct seq_file *m,
 	return 0;
 }
 
-/**
- * wakeup_sources_stats_show - Print wakeup sources statistics information.
- * @m: seq_file to print the statistics into.
- */
-static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
+static void *wakeup_sources_stats_seq_start(struct seq_file *m,
+					loff_t *pos)
 {
 	struct wakeup_source *ws;
-	int srcuidx;
+	loff_t n = *pos;
+	int *srcuidx = m->private;
 
-	seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
-		"expire_count\tactive_since\ttotal_time\tmax_time\t"
-		"last_change\tprevent_suspend_time\n");
+	if (n == 0) {
+		seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
+			"expire_count\tactive_since\ttotal_time\tmax_time\t"
+			"last_change\tprevent_suspend_time\n");
+	}
 
-	srcuidx = srcu_read_lock(&wakeup_srcu);
-	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
-		print_wakeup_source_stats(m, ws);
-	srcu_read_unlock(&wakeup_srcu, srcuidx);
+	*srcuidx = srcu_read_lock(&wakeup_srcu);
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+		if (n-- > 0)
+			continue;
+		goto out;
+	}
+	ws = NULL;
+out:
+	return ws;
+}
+
+static void *wakeup_sources_stats_seq_next(struct seq_file *m,
+					void *v, loff_t *pos)
+{
+	struct wakeup_source *ws = v;
+	struct wakeup_source *next_ws = NULL;
+
+	++(*pos);
 
-	print_wakeup_source_stats(m, &deleted_ws);
+	list_for_each_entry_continue_rcu(ws, &wakeup_sources, entry) {
+		next_ws = ws;
+		break;
+	}
+
+	return next_ws;
+}
+
+static void wakeup_sources_stats_seq_stop(struct seq_file *m, void *v)
+{
+	int *srcuidx = m->private;
+
+	srcu_read_unlock(&wakeup_srcu, *srcuidx);
+}
+
+/**
+ * wakeup_sources_stats_seq_show - Print wakeup sources statistics information.
+ * @m: seq_file to print the statistics into.
+ * @v: wakeup_source of each iteration
+ */
+static int wakeup_sources_stats_seq_show(struct seq_file *m, void *v)
+{
+	struct wakeup_source *ws = v;
+
+	print_wakeup_source_stats(m, ws);
 
 	return 0;
 }
 
+static const struct seq_operations wakeup_sources_stats_seq_ops = {
+	.start = wakeup_sources_stats_seq_start,
+	.next  = wakeup_sources_stats_seq_next,
+	.stop  = wakeup_sources_stats_seq_stop,
+	.show  = wakeup_sources_stats_seq_show,
+};
+
 static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, wakeup_sources_stats_show, NULL);
+	return seq_open_private(file, &wakeup_sources_stats_seq_ops, sizeof(int));
 }
 
 static const struct file_operations wakeup_sources_stats_fops = {
@@ -1062,7 +1107,7 @@ static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
 	.open = wakeup_sources_stats_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = single_release,
+	.release = seq_release_private,
 };
 
 static int __init wakeup_sources_debugfs_init(void)
-- 
1.9.1
