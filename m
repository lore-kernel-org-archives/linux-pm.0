From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v4 7/7] interconnect: Allow endpoints translation via DT
Date: Fri,  9 Mar 2018 23:09:58 +0200
Message-ID: <20180309210958.16672-8-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309210958.16672-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

Currently we support only platform data for specifying the interconnect
endpoints. As now the endpoints are hard-coded into the consumer driver
this may leed to complications when a single driver is used by multiple
SoCs, which may have different interconnect topology.
To avoid cluttering the consumer drivers, introduce a translation function
to help us get the board specific interconnect data from device-tree.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c  | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h |  6 ++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index a06f752a6aaa..014993473763 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
@@ -297,6 +298,43 @@ static int constraints_apply(struct icc_path *path)
 	return 0;
 }
 
+struct icc_path *of_icc_get(struct device *dev, const char *name)
+{
+	struct device_node *np;
+	u32 src_id, dst_id;
+	int index, ret;
+
+	if (!dev || !name)
+		return NULL;
+
+	np = dev->of_node;
+
+	index = of_property_match_string(np, "interconnect-names", name);
+	if (index < 0)
+		return ERR_PTR(index);
+
+	/*
+	 * We use a combination of phandle and specifier for endpoint. For now
+	 * lets support only global ids and extend this is the future if needed
+	 * without breaking DT compatibility.
+	 */
+	ret = of_property_read_u32_index(np, "interconnects", index * 2 + 1,
+					 &src_id);
+	if (ret) {
+		dev_err(dev, "interconnect src port is invalid (%d)\n", ret);
+		return ERR_PTR(ret);
+	}
+	ret = of_property_read_u32_index(np, "interconnects", index * 2 + 3,
+					 &dst_id);
+	if (ret) {
+		dev_err(dev, "interconnect dst port is invalid (%d)\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	return icc_get(src_id, dst_id);
+}
+EXPORT_SYMBOL_GPL(of_icc_get);
+
 /**
  * icc_set() - set constraints on an interconnect path between two endpoints
  * @path: reference to the path returned by icc_get()
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 5a7cf72b76a5..996c48ea67d5 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -16,6 +16,7 @@ struct device;
 #if IS_ENABLED(CONFIG_INTERCONNECT)
 
 struct icc_path *icc_get(const int src_id, const int dst_id);
+struct icc_path *of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
 int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 
@@ -26,6 +27,11 @@ static inline struct icc_path *icc_get(const int src_id, const int dst_id)
 	return NULL;
 }
 
+static inline struct icc_path *of_icc_get(struct device *dev, const char *name)
+{
+	return NULL;
+}
+
 static inline void icc_put(struct icc_path *path)
 {
 }
