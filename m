From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v3 1/3] interconnect: Add generic on-chip interconnect API
Date: Fri,  8 Sep 2017 20:18:28 +0300
Message-ID: <20170908171830.13813-2-georgi.djakov@linaro.org>
References: <20170908171830.13813-1-georgi.djakov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908171830.13813-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, khilman@baylibre.com, mturquette@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

This patch introduce a new API to get requirements and configure the
interconnect buses across the entire chipset to fit with the current demand.

The API is using a consumer/provider-based model, where the providers are
the interconnect buses and the consumers could be various drivers.
The consumers request interconnect resources (path) between endpoints and
set the desired constraints on this data flow path. The providers receive
requests from consumers and aggregate these requests for all master-slave
pairs on that path. Then the providers configure each participating in the
topology node according to the requested data flow path, physical links and
constraints. The topology could be complicated and multi-tiered and is SoC
specific.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 Documentation/interconnect/interconnect.rst |  93 +++++++
 drivers/Kconfig                             |   2 +
 drivers/Makefile                            |   1 +
 drivers/interconnect/Kconfig                |  10 +
 drivers/interconnect/Makefile               |   1 +
 drivers/interconnect/interconnect.c         | 382 ++++++++++++++++++++++++++++
 include/linux/interconnect-consumer.h       |  73 ++++++
 include/linux/interconnect-provider.h       | 119 +++++++++
 8 files changed, 681 insertions(+)
 create mode 100644 Documentation/interconnect/interconnect.rst
 create mode 100644 drivers/interconnect/Kconfig
 create mode 100644 drivers/interconnect/Makefile
 create mode 100644 drivers/interconnect/interconnect.c
 create mode 100644 include/linux/interconnect-consumer.h
 create mode 100644 include/linux/interconnect-provider.h

diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/interconnect/interconnect.rst
new file mode 100644
index 000000000000..b057e9c12d70
--- /dev/null
+++ b/Documentation/interconnect/interconnect.rst
@@ -0,0 +1,93 @@
+=====================================
+GENERIC SYSTEM INTERCONNECT SUBSYSTEM
+=====================================
+
+Introduction
+------------
+
+This framework is designed to provide a standard kernel interface to control
+the settings of the interconnects on a SoC. These settings can be throughput,
+latency and priority between multiple interconnected devices. This can be
+controlled dynamically in order to save power or provide maximum performance.
+
+The interconnect bus is a hardware with configurable parameters, which can be
+set on a data path according to the requests received from various drivers.
+An example of interconnect buses are the interconnects between various
+components on chipsets. There can be multiple interconnects on a SoC that can
+be multi-tiered.
+
+Below is a simplified diagram of a real-world SoC interconnect bus topology.
+
+::
+
+ +----------------+    +----------------+
+ | HW Accelerator |--->|      M NoC     |<---------------+
+ +----------------+    +----------------+                |
+                         |      |                    +------------+
+  +-----+  +-------------+      V       +------+     |            |
+  | DDR |  |                +--------+  | PCIe |     |            |
+  +-----+  |                | Slaves |  +------+     |            |
+    ^ ^    |                +--------+     |         |   C NoC    |
+    | |    V                               V         |            |
+ +------------------+   +------------------------+   |            |   +-----+
+ |                  |-->|                        |-->|            |-->| CPU |
+ |                  |-->|                        |<--|            |   +-----+
+ |     Mem NoC      |   |         S NoC          |   +------------+
+ |                  |<--|                        |---------+    |
+ |                  |<--|                        |<------+ |    |   +--------+
+ +------------------+   +------------------------+       | |    +-->| Slaves |
+   ^  ^    ^    ^          ^                             | |        +--------+
+   |  |    |    |          |                             | V
+ +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
+ | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
+ +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
+           |
+       +-------+
+       | Modem |
+       +-------+
+
+Terminology
+-----------
+
+Interconnect provider is the software definition of the interconnect hardware.
+The interconnect providers on the above diagram are M NoC, S NoC, C NoC and Mem
+NoC.
+
+Interconnect node is the software definition of the interconnect hardware
+port. Each interconnect provider consists of multiple interconnect nodes,
+which are connected to other SoC components including other interconnect
+providers. The point on the diagram where the CPUs connects to the memory is
+called an interconnect node, which belongs to the Mem NoC interconnect provider.
+
+Interconnect endpoits are the first or the last element of the path. Every
+endpoint is a node, but not every node is an endpoint.
+
+Interconnect path is everything between two endpoints including all the nodes
+that have to be traversed to reach from a source to destination node. It may
+include multiple master-slave pairs across several interconnect providers.
+
+Interconnect consumers are the entities which make use of the data paths exposed
+by the providers. The consumers send requests to providers requesting various
+throughput, latency and priority. Usually the consumers are device drivers, that
+send request based on their needs. An example for a consumer is a a video
+decoder that supports various formats and image sizes.
+
+Interconnect providers
+----------------------
+
+Interconnect provider is an entity that implements methods to initialize and
+configure a interconnect bus hardware. The interconnect provider driver should
+be registered with the interconnect provider core.
+
+The interconnect framework provider API functions are documented in
+.. kernel-doc:: include/linux/interconnect-provider.h
+
+Interconnect consumers
+----------------------
+
+Interconnect consumers are the clients which use the interconnect APIs to
+get paths between endpoints and set their bandwidth/latency/QoS requirements
+for these interconnect paths.
+
+The interconnect framework consumer API functions are documented in
+.. kernel-doc:: include/linux/interconnect-consumer.h
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 505c676fa9c7..930ecde654d5 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -208,4 +208,6 @@ source "drivers/tee/Kconfig"
 
 source "drivers/mux/Kconfig"
 
+source "drivers/interconnect/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index dfdcda00bfe3..a114b679bb5b 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -182,3 +182,4 @@ obj-$(CONFIG_FPGA)		+= fpga/
 obj-$(CONFIG_FSI)		+= fsi/
 obj-$(CONFIG_TEE)		+= tee/
 obj-$(CONFIG_MULTIPLEXER)	+= mux/
+obj-$(CONFIG_INTERCONNECT)	+= interconnect/
diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
new file mode 100644
index 000000000000..1e50e951cdc1
--- /dev/null
+++ b/drivers/interconnect/Kconfig
@@ -0,0 +1,10 @@
+menuconfig INTERCONNECT
+	tristate "On-Chip Interconnect management support"
+	help
+	  Support for management of the on-chip interconnects.
+
+	  This framework is designed to provide a generic interface for
+          managing the interconnects in a SoC.
+
+	  If unsure, say no.
+
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
new file mode 100644
index 000000000000..d9da6a6c3560
--- /dev/null
+++ b/drivers/interconnect/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_INTERCONNECT)  += interconnect.o
diff --git a/drivers/interconnect/interconnect.c b/drivers/interconnect/interconnect.c
new file mode 100644
index 000000000000..94e2a9f01545
--- /dev/null
+++ b/drivers/interconnect/interconnect.c
@@ -0,0 +1,382 @@
+/*
+ * Copyright (c) 2017, Linaro Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/interconnect-consumer.h>
+#include <linux/interconnect-provider.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+static DEFINE_MUTEX(interconnect_provider_list_mutex);
+static LIST_HEAD(interconnect_provider_list);
+
+/**
+ * struct interconnect_path - interconnect path structure
+ * @num_nodes: number of hops (nodes)
+ * @reqs: array of the requests applicable to this path of nodes
+ */
+struct interconnect_path {
+	size_t num_nodes;
+	struct interconnect_req reqs[0];
+};
+
+static struct interconnect_node *node_find(const char *dev_id, int con_id)
+{
+	struct interconnect_node *node = ERR_PTR(-EPROBE_DEFER);
+	struct icp *icp;
+
+	mutex_lock(&interconnect_provider_list_mutex);
+
+	list_for_each_entry(icp, &interconnect_provider_list, icp_list) {
+		struct interconnect_node *n;
+
+		list_for_each_entry(n, &icp->nodes, icn_list) {
+			if (!strcmp(n->dev_id, dev_id) && n->con_id == con_id) {
+				node = n;
+				goto out;
+			}
+		}
+	}
+
+out:
+	mutex_unlock(&interconnect_provider_list_mutex);
+
+	return node;
+}
+
+static struct interconnect_path *path_allocate(struct interconnect_node *node,
+					       ssize_t num_nodes)
+{
+	struct interconnect_path *path;
+	size_t i;
+
+	path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),
+		       GFP_KERNEL);
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	path->num_nodes = num_nodes;
+
+	for (i = 0; i < num_nodes; i++) {
+		hlist_add_head(&path->reqs[i].req_node, &node->req_list);
+
+		path->reqs[i].node = node;
+		node = node->reverse;
+	}
+
+	return path;
+}
+
+static struct interconnect_path *path_find(struct interconnect_node *src,
+					   struct interconnect_node *dst)
+{
+	struct interconnect_node *node = NULL;
+	struct list_head traverse_list;
+	struct list_head edge_list;
+	struct list_head tmp_list;
+	size_t i, number = 1;
+	bool found = false;
+
+	INIT_LIST_HEAD(&traverse_list);
+	INIT_LIST_HEAD(&edge_list);
+	INIT_LIST_HEAD(&tmp_list);
+
+	list_add_tail(&src->search_list, &traverse_list);
+
+	do {
+		list_for_each_entry(node, &traverse_list, search_list) {
+			if (node == dst) {
+				found = true;
+				list_add(&node->search_list, &tmp_list);
+				break;
+			}
+			for (i = 0; i < node->num_links; i++) {
+				struct interconnect_node *tmp = node->links[i];
+
+				if (!tmp) {
+					WARN_ON(1);
+					return ERR_PTR(-ENOENT);
+				}
+
+				if (tmp->is_traversed)
+					continue;
+
+				tmp->is_traversed = true;
+				tmp->reverse = node;
+				list_add_tail(&tmp->search_list, &edge_list);
+			}
+		}
+		if (found)
+			break;
+
+		list_splice_init(&traverse_list, &tmp_list);
+		list_splice_init(&edge_list, &traverse_list);
+
+		/* count the number of nodes */
+		number++;
+
+	} while (!list_empty(&traverse_list));
+
+	/* reset the traversed state */
+	list_for_each_entry(node, &tmp_list, search_list) {
+		node->is_traversed = false;
+	}
+
+	if (found)
+		return path_allocate(dst, number);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int path_init(struct interconnect_path *path)
+{
+	struct interconnect_node *node;
+	size_t i;
+
+	for (i = 0; i < path->num_nodes; i++) {
+		node = path->reqs[i].node;
+
+		mutex_lock(&node->icp->lock);
+		node->icp->users++;
+		mutex_unlock(&node->icp->lock);
+	}
+
+	return 0;
+}
+
+static void interconnect_aggregate_icn(struct interconnect_node *node)
+{
+	struct interconnect_req *r;
+	u32 avg_bw = 0;
+	u32 peak_bw = 0;
+
+	hlist_for_each_entry(r, &node->req_list, req_node) {
+		/* sum(averages) and max(peaks) */
+		avg_bw += r->avg_bw;
+		peak_bw = max(peak_bw, r->peak_bw);
+	}
+
+	node->creq.avg_bw = avg_bw;
+	node->creq.peak_bw = peak_bw;
+}
+
+static void interconnect_aggregate_icp(struct icp *icp)
+{
+	struct interconnect_node *n;
+	u32 avg_bw = 0;
+	u32 peak_bw = 0;
+
+	/* aggregate for the interconnect provider */
+	list_for_each_entry(n, &icp->nodes, icn_list) {
+		/* sum the average and max the peak */
+		avg_bw += n->creq.avg_bw;
+		peak_bw = max(peak_bw, n->creq.peak_bw);
+	}
+
+	/* save the aggregated values */
+	icp->creq.avg_bw = avg_bw;
+	icp->creq.peak_bw = peak_bw;
+}
+
+/**
+ * interconnect_set() - set constraints on a path between two endpoints
+ * @path: reference to the path returned by interconnect_get()
+ * @creq: request from the consumer, containing its requirements
+ *
+ * This function is used by an interconnect consumer to express its own needs
+ * in term of bandwidth and QoS for a previously requested path between two
+ * endpoints. The requests are aggregated and each node is updated accordingly.
+ *
+ * Returns 0 on success, or an approproate error code otherwise.
+ */
+int interconnect_set(struct interconnect_path *path,
+		     struct interconnect_creq *creq)
+{
+	struct interconnect_node *next, *prev = NULL;
+	size_t i;
+	int ret = 0;
+
+	for (i = 0; i < path->num_nodes; i++, prev = next) {
+		next = path->reqs[i].node;
+
+		/*
+		 * Both endpoints should be valid and master-slave pairs of
+		 * the same interconnect provider that will be configured.
+		 */
+		if (!next || !prev)
+			continue;
+		if (next->icp != prev->icp)
+			continue;
+
+		mutex_lock(&next->icp->lock);
+
+		/* update the consumer request for this path */
+		path->reqs[i].avg_bw = creq->avg_bw;
+		path->reqs[i].peak_bw = creq->peak_bw;
+
+		/* aggregate all requests */
+		interconnect_aggregate_icn(next);
+		interconnect_aggregate_icp(next->icp);
+
+		if (next->icp->ops->set) {
+			/* commit the aggregated constraints */
+			ret = next->icp->ops->set(prev, next, &next->icp->creq);
+		}
+
+		mutex_unlock(&next->icp->lock);
+		if (ret)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
+/**
+ * interconnect_get() - return a handle for path between two endpoints
+ * @sdev: source device identifier
+ * @sid: source device port id
+ * @ddev: destination device identifier
+ * @did: destination device port id
+ *
+ * This function will search for a path between two endpoints and return an
+ * interconnect_path handle on success. Use interconnect_put() to release
+ * constraints when the they are not needed anymore.
+ *
+ * Return: interconnect_path pointer on success, or ERR_PTR() on error
+ */
+struct interconnect_path *interconnect_get(const char *sdev, const int sid,
+					   const char *ddev, const int did)
+{
+	struct interconnect_node *src, *dst;
+	struct interconnect_path *path;
+	int ret;
+
+	src = node_find(sdev, sid);
+	if (IS_ERR(src))
+		return ERR_CAST(src);
+
+	dst = node_find(ddev, did);
+	if (IS_ERR(dst))
+		return ERR_CAST(dst);
+
+	/* TODO: cache the path */
+	path = path_find(src, dst);
+	if (IS_ERR(path)) {
+		pr_err("error finding path between %p and %p (%ld)\n",
+		       src, dst, PTR_ERR(path));
+		return path;
+	}
+
+	ret = path_init(path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return path;
+}
+EXPORT_SYMBOL_GPL(interconnect_get);
+
+/**
+ * interconnect_put() - release the reference to the interconnect_path
+ *
+ * @path: interconnect path
+ *
+ * Use this function to release the path and free the memory when setting
+ * constraints on the path is no longer needed.
+ */
+void interconnect_put(struct interconnect_path *path)
+{
+	struct interconnect_creq creq = { 0, 0 };
+	struct interconnect_node *node;
+	size_t i;
+	int ret;
+
+	if (!path || WARN_ON_ONCE(IS_ERR(path)))
+		return;
+
+	for (i = 0; i < path->num_nodes; i++) {
+		node = path->reqs[i].node;
+
+		/*
+		 * Remove the constraints from the path,
+		 * update the nodes and free the memory
+		 */
+		ret = interconnect_set(path, &creq);
+		if (ret)
+			pr_err("%s error %d\n", __func__, ret);
+
+		mutex_lock(&node->icp->lock);
+		node->icp->users--;
+		mutex_unlock(&node->icp->lock);
+	}
+
+	kfree(path);
+}
+EXPORT_SYMBOL_GPL(interconnect_put);
+
+/**
+ * interconnect_add_provider() - add a new interconnect provider
+ * @icp: the interconnect provider that will be added into topology
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int interconnect_add_provider(struct icp *icp)
+{
+	if (!icp)
+		return -EINVAL;
+
+	if (!icp->ops->set) {
+		dev_err(icp->dev, "%s: .set is not implemented\n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&interconnect_provider_list_mutex);
+	mutex_init(&icp->lock);
+	list_add(&icp->icp_list, &interconnect_provider_list);
+	mutex_unlock(&interconnect_provider_list_mutex);
+
+	dev_info(icp->dev, "interconnect provider is added to topology\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(interconnect_add_provider);
+
+/**
+ * interconnect_del_provider() - delete previously added interconnect provider
+ * @icp: the interconnect provider that will be removed from topology
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int interconnect_del_provider(struct icp *icp)
+{
+	mutex_lock(&icp->lock);
+	if (icp->users) {
+		mutex_unlock(&icp->lock);
+		return -EBUSY;
+	}
+	mutex_unlock(&icp->lock);
+
+	mutex_lock(&interconnect_provider_list_mutex);
+	list_del(&icp->icp_list);
+	mutex_unlock(&interconnect_provider_list_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(interconnect_del_provider);
+
+MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
+MODULE_DESCRIPTION("Interconnect Driver Core");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/interconnect-consumer.h b/include/linux/interconnect-consumer.h
new file mode 100644
index 000000000000..6e71bf7a63c0
--- /dev/null
+++ b/include/linux/interconnect-consumer.h
@@ -0,0 +1,73 @@
+/*
+ * Copyright (c) 2017, Linaro Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LINUX_INTERCONNECT_CONSUMER_H
+#define _LINUX_INTERCONNECT_CONSUMER_H
+
+struct interconnect_node;
+struct interconnect_path;
+
+#if IS_ENABLED(CONFIG_INTERCONNECT)
+
+struct interconnect_path *interconnect_get(const char *sdev, const int sid,
+					   const char *ddev, const int did);
+
+void interconnect_put(struct interconnect_path *path);
+
+/**
+ * struct creq - interconnect consumer request
+ * @avg_bw: the average requested bandwidth (over longer period of time) in kbps
+ * @peak_bw: the peak (maximum) bandwidth in kpbs
+ */
+struct interconnect_creq {
+	u32 avg_bw;
+	u32 peak_bw;
+};
+
+/**
+ * interconnect_set() - set constraints on a path between two endpoints
+ * @path: reference to the path returned by interconnect_get()
+ * @creq: request from the consumer, containing its requirements
+ *
+ * This function is used by an interconnect consumer to express its own needs
+ * in term of bandwidth and QoS for a previously requested path between two
+ * endpoints. The requests are aggregated and each node is updated accordingly.
+ *
+ * Returns 0 on success, or an approproate error code otherwise.
+ */
+int interconnect_set(struct interconnect_path *path,
+		     struct interconnect_creq *creq);
+
+#else
+
+inline struct interconnect_path *interconnect_get(const char *sdev,
+							 const int sid,
+							 const char *ddev,
+							 const int did)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+inline void interconnect_put(struct interconnect_path *path)
+{
+}
+
+inline int interconnect_set(struct interconnect_path *path,
+			    struct interconnect_creq *creq);
+{
+	return -ENOTSUPP
+}
+
+#endif /* CONFIG_INTERCONNECT */
+
+#endif /* _LINUX_INTERCONNECT_CONSUMER_H */
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
new file mode 100644
index 000000000000..6cf6f6a79846
--- /dev/null
+++ b/include/linux/interconnect-provider.h
@@ -0,0 +1,119 @@
+/*
+ * Copyright (c) 2017, Linaro Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LINUX_INTERCONNECT_PROVIDER_H
+#define _LINUX_INTERCONNECT_PROVIDER_H
+
+#include <linux/interconnect-consumer.h>
+
+/**
+ * struct icp_ops - platform specific callback operations for interconnect
+ * providers that will be called from drivers
+ *
+ * @set: set constraints on interconnect
+ */
+struct icp_ops {
+	int (*set)(struct interconnect_node *src, struct interconnect_node *dst,
+		   struct interconnect_creq *creq);
+};
+
+/**
+ * struct icp - interconnect provider (controller) entity that might
+ * provide multiple interconnect controls
+ *
+ * @icp_list: list of the registered interconnect providers
+ * @nodes: internal list of the interconnect provider nodes
+ * @ops: pointer to device specific struct icp_ops
+ * @dev: the device this interconnect provider belongs to
+ * @lock: a lock to protect creq and users
+ * @creq: the actual state of constraints for this interconnect provider
+ * @users: count of active users
+ * @data: pointer to private data
+ */
+struct icp {
+	struct list_head	icp_list;
+	struct list_head	nodes;
+	const struct icp_ops	*ops;
+	struct device		*dev;
+	struct mutex		lock;
+	struct interconnect_creq creq;
+	int			users;
+	void			*data;
+};
+
+/**
+ * struct interconnect_node - entity that is part of the interconnect topology
+ *
+ * @links: links to other interconnect nodes
+ * @num_links: number of links to other interconnect nodes
+ * @icp: points to the interconnect provider of this node
+ * @icn_list: list of interconnect nodes
+ * @search_list: list used when walking the nodes graph
+ * @reverse: pointer to previous node when walking the nodes graph
+ * @is_traversed: flag that is used when walking the nodes graph
+ * @req_list: a list of QoS constraint requests
+ * @creq: aggregated values of all constraint requests
+ * @dev_id: device id
+ * @con_id: connection id
+ */
+struct interconnect_node {
+	struct interconnect_node **links;
+	size_t			num_links;
+
+	struct icp		*icp;
+	struct list_head	icn_list;
+	struct list_head	search_list;
+	struct interconnect_node *reverse;
+	bool			is_traversed;
+	struct hlist_head	req_list;
+	struct interconnect_creq creq;
+
+	const char		*dev_id;
+	int			con_id;
+};
+
+/**
+ * struct interconnect_req - constraints that are attached to each node
+ *
+ * @req_node: the linked list node
+ * @node: the interconnect node to which this constraint applies
+ * @avg_bw: an integer describing the average bandwidth in kbps
+ * @peak_bw: an integer describing the peak bandwidth in kbps
+ */
+struct interconnect_req {
+	struct hlist_node req_node;
+	struct interconnect_node *node;
+	u32 avg_bw;
+	u32 peak_bw;
+};
+
+#if IS_ENABLED(CONFIG_INTERCONNECT)
+
+int interconnect_add_provider(struct icp *icp);
+int interconnect_del_provider(struct icp *icp);
+
+#else
+
+static inline int interconnect_add_provider(struct icp *icp)
+{
+	return -ENOTSUPP;
+}
+
+static inline int interconnect_del_provider(struct icp *icp)
+{
+	return -ENOTSUPP;
+}
+
+#endif /* CONFIG_INTERCONNECT */
+
+#endif /* _LINUX_INTERCONNECT_PROVIDER_H */
