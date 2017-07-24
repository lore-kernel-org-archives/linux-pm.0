From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 4/5] firmware: tegra: Add stubs when BPMP not enabled
Date: Mon, 24 Jul 2017 19:29:17 +0300
Message-ID: <20170724162918.21050-4-mperttunen@nvidia.com>
References: <20170724162918.21050-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170724162918.21050-1-mperttunen@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rui.zhang@intel.com, edubezval@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add static inline stubs to bpmp.h when CONFIG_BPMP is not enabled.
This allows building BPMP-related drivers with COMPILE_TEST.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
- added patch

 include/soc/tegra/bpmp.h | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
index 16d36dfe9fcd..4f9adb7790cc 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -96,9 +96,6 @@ struct tegra_bpmp {
 	struct genpd_onecell_data genpd;
 };
 
-struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
-void tegra_bpmp_put(struct tegra_bpmp *bpmp);
-
 struct tegra_bpmp_message {
 	unsigned int mrq;
 
@@ -113,6 +110,9 @@ struct tegra_bpmp_message {
 	} rx;
 };
 
+#if IS_ENABLED(CONFIG_TEGRA_BPMP)
+struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
+void tegra_bpmp_put(struct tegra_bpmp *bpmp);
 int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 			       struct tegra_bpmp_message *msg);
 int tegra_bpmp_transfer(struct tegra_bpmp *bpmp,
@@ -124,6 +124,42 @@ int tegra_bpmp_request_mrq(struct tegra_bpmp *bpmp, unsigned int mrq,
 			   tegra_bpmp_mrq_handler_t handler, void *data);
 void tegra_bpmp_free_mrq(struct tegra_bpmp *bpmp, unsigned int mrq,
 			 void *data);
+#else
+static inline struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+static inline void tegra_bpmp_put(struct tegra_bpmp *bpmp)
+{
+}
+static inline int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
+					     struct tegra_bpmp_message *msg)
+{
+	return -ENOTSUPP;
+}
+static inline int tegra_bpmp_transfer(struct tegra_bpmp *bpmp,
+				      struct tegra_bpmp_message *msg)
+{
+	return -ENOTSUPP;
+}
+static inline void tegra_bpmp_mrq_return(struct tegra_bpmp_channel *channel,
+					 int code, const void *data,
+					 size_t size)
+{
+}
+
+static inline int tegra_bpmp_request_mrq(struct tegra_bpmp *bpmp,
+					 unsigned int mrq,
+					 tegra_bpmp_mrq_handler_t handler,
+					 void *data)
+{
+	return -ENOTSUPP;
+}
+static inline void tegra_bpmp_free_mrq(struct tegra_bpmp *bpmp,
+				       unsigned int mrq, void *data)
+{
+}
+#endif
 
 #if IS_ENABLED(CONFIG_CLK_TEGRA_BPMP)
 int tegra_bpmp_init_clocks(struct tegra_bpmp *bpmp);
-- 
2.13.3
