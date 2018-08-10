From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v8 4/8] interconnect: Add debugfs support
Date: Fri, 10 Aug 2018 17:52:29 +0300
Message-ID: <20180810145233.16466-5-georgi.djakov@linaro.org>
References: <20180810145233.16466-1-georgi.djakov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810145233.16466-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

Add a functionality to provide information about the current constraints
per each node and provider.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/interconnect/core.c | 78 +++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8f874d1b0a0f..288ef83c3bc0 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -6,6 +6,7 @@
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -17,10 +18,12 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/overflow.h>
+#include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_provider_list);
 static DEFINE_MUTEX(icc_lock);
+static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -49,6 +52,62 @@ struct icc_path {
 	struct icc_req reqs[];
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
+	mutex_lock(&icc_lock);
+
+	list_for_each_entry(provider, &icc_provider_list, provider_list) {
+		struct icc_node *n;
+
+		list_for_each_entry(n, &provider->nodes, node_list) {
+			struct icc_req *r;
+
+			icc_summary_show_one(s, n);
+			hlist_for_each_entry(r, &n->req_list, req_node) {
+				if (!r->dev)
+					continue;
+
+				seq_printf(s, "    %-26s %12d %12d\n",
+					   dev_name(r->dev), r->avg_bw,
+					   r->peak_bw);
+			}
+		}
+	}
+
+	mutex_unlock(&icc_lock);
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
+#endif
+
 static struct icc_node *node_find(const int id)
 {
 	return idr_find(&icc_idr, id);
@@ -646,6 +705,25 @@ int icc_provider_del(struct icc_provider *provider)
 }
 EXPORT_SYMBOL_GPL(icc_provider_del);
 
+static int __init icc_init(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
+	debugfs_create_file("interconnect_summary", 0444,
+			    icc_debugfs_dir, NULL, &icc_summary_fops);
+#endif
+	return 0;
+}
+
+static void __exit icc_exit(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(icc_debugfs_dir);
+#endif
+}
+module_init(icc_init);
+module_exit(icc_exit);
+
 MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
 MODULE_DESCRIPTION("Interconnect Driver Core");
 MODULE_LICENSE("GPL v2");
