From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v1 1/2] interconnect: Add support for path tags
Date: Fri,  8 Feb 2019 19:21:51 +0200
Message-ID: <20190208172152.1807-2-georgi.djakov@linaro.org>
References: <20190208172152.1807-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208172152.1807-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: daidavid1@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, evgreen@chromium.org, dianders@chromium.org, seansw@qti.qualcomm.com, mturquette@baylibre.com, abailon@baylibre.com, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, henryc.chen@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

Consumers may have use cases with different bandwidth requirements based
on the system or driver state. The consumer driver can append a specific
tag to the path and pass this information to the interconnect platform
driver to do the aggregation based on this state.

Introduce icc_set_tag() function that will allow the consumers to append
an optional tag to each path. The aggregation of these tagged paths is
platform specific.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 27 +++++++++++++++++++++++----
 drivers/interconnect/qcom/sdm845.c    |  2 +-
 include/linux/interconnect-provider.h |  4 ++--
 include/linux/interconnect.h          |  5 +++++
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 6005a1c189f6..31eacd0f5349 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -42,10 +42,12 @@ struct icc_req {
 
 /**
  * struct icc_path - interconnect path structure
+ * @tag: path tag (optional)
  * @num_nodes: number of hops (nodes)
  * @reqs: array of the requests applicable to this path of nodes
  */
 struct icc_path {
+	u32 tag;
 	size_t num_nodes;
 	struct icc_req reqs[];
 };
@@ -206,7 +208,7 @@ static struct icc_path *path_find(struct device *dev, struct icc_node *src,
  * implementing its own aggregate() function.
  */
 
-static int aggregate_requests(struct icc_node *node)
+static int aggregate_requests(struct icc_node *node, u32 tag)
 {
 	struct icc_provider *p = node->provider;
 	struct icc_req *r;
@@ -215,7 +217,7 @@ static int aggregate_requests(struct icc_node *node)
 	node->peak_bw = 0;
 
 	hlist_for_each_entry(r, &node->req_list, req_node)
-		p->aggregate(node, r->avg_bw, r->peak_bw,
+		p->aggregate(node, tag, r->avg_bw, r->peak_bw,
 			     &node->avg_bw, &node->peak_bw);
 
 	return 0;
@@ -396,6 +398,23 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 }
 EXPORT_SYMBOL_GPL(of_icc_get);
 
+/**
+ * icc_set_tag() - set an optional tag on a path
+ * @path: the path we want to tag
+ * @tag: the tag value
+ *
+ * This function allows consumers to append a tag to the path, so that a
+ * different aggregation could be done based on this tag.
+ */
+void icc_set_tag(struct icc_path *path, u32 tag)
+{
+	if (!path)
+		return;
+
+	path->tag = tag;
+}
+EXPORT_SYMBOL_GPL(icc_set_tag);
+
 /**
  * icc_set_bw() - set bandwidth constraints on an interconnect path
  * @path: reference to the path returned by icc_get()
@@ -434,7 +453,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 		path->reqs[i].peak_bw = peak_bw;
 
 		/* aggregate requests for this node */
-		aggregate_requests(node);
+		aggregate_requests(node, path->tag);
 	}
 
 	ret = apply_constraints(path);
@@ -446,7 +465,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 			node = path->reqs[i].node;
 			path->reqs[i].avg_bw = old_avg;
 			path->reqs[i].peak_bw = old_peak;
-			aggregate_requests(node);
+			aggregate_requests(node, path->tag);
 		}
 		apply_constraints(path);
 	}
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 4915b78da673..fb526004c82e 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -626,7 +626,7 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 	bcm->dirty = false;
 }
 
-static int qcom_icc_aggregate(struct icc_node *node, u32 avg_bw,
+static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
 {
 	size_t i;
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 63caccadc2db..4ee19fd41568 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -45,8 +45,8 @@ struct icc_provider {
 	struct list_head	provider_list;
 	struct list_head	nodes;
 	int (*set)(struct icc_node *src, struct icc_node *dst);
-	int (*aggregate)(struct icc_node *node, u32 avg_bw, u32 peak_bw,
-			 u32 *agg_avg, u32 *agg_peak);
+	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
+			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index dc25864755ba..d70a914cba11 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -30,6 +30,7 @@ struct icc_path *icc_get(struct device *dev, const int src_id,
 struct icc_path *of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
+void icc_set_tag(struct icc_path *path, u32 tag);
 
 #else
 
@@ -54,6 +55,10 @@ static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	return 0;
 }
 
+static inline void icc_set_tag(struct icc_path *path, u32 tag)
+{
+}
+
 #endif /* CONFIG_INTERCONNECT */
 
 #endif /* __LINUX_INTERCONNECT_H */
