From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v4 3/7] interconnect: Add debugfs support
Date: Fri,  9 Mar 2018 23:09:54 +0200
Message-ID: <20180309210958.16672-4-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309210958.16672-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

Add a functionality to provide information about the current constraints
per each node and provider.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 6306e258b9b9..a06f752a6aaa 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -6,6 +6,7 @@
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -15,11 +16,13 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_provider_list);
 static DEFINE_MUTEX(icc_provider_list_mutex);
 static DEFINE_MUTEX(icc_path_mutex);
+static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -46,6 +49,73 @@ struct icc_path {
 	struct icc_req reqs[0];
 };
 
+#ifdef CONFIG_DEBUG_FS
+
+static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
+{
+	if (!n)
+		return;
+
+	seq_printf(s, "%-30s %12d %12d\n",
+		   n->name, n->avg_bw, n->peak_bw);
+}
+
+static int icc_summary_show(struct seq_file *s, void *data)
+{
+	struct icc_provider *provider;
+
+	seq_puts(s, " node                                   avg         peak\n");
+	seq_puts(s, "--------------------------------------------------------\n");
+
+	mutex_lock(&icc_provider_list_mutex);
+
+	list_for_each_entry(provider, &icc_provider_list, provider_list) {
+		struct icc_node *n;
+
+		mutex_lock(&provider->lock);
+		list_for_each_entry(n, &provider->nodes, node_list) {
+			icc_summary_show_one(s, n);
+		}
+		mutex_unlock(&provider->lock);
+	}
+
+	mutex_unlock(&icc_provider_list_mutex);
+
+	return 0;
+}
+
+static int icc_summary_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, icc_summary_show, inode->i_private);
+}
+
+static const struct file_operations icc_summary_fops = {
+	.open		= icc_summary_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init icc_debugfs_init(void)
+{
+	struct dentry *file;
+
+	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
+	if (!icc_debugfs_dir) {
+		pr_err("interconnect: error creating debugfs directory\n");
+		return -ENODEV;
+	}
+
+	file = debugfs_create_file("interconnect_summary", 0444,
+				   icc_debugfs_dir, NULL, &icc_summary_fops);
+	if (!file)
+		return -ENODEV;
+
+	return 0;
+}
+late_initcall(icc_debugfs_init);
+#endif
+
 static struct icc_node *node_find(const int id)
 {
 	struct icc_node *node;
