From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 01/10] PM / Domains: Add new helper functions for device-tree
Date: Tue, 16 Aug 2016 10:49:27 +0100
Message-ID: <1471340976-5379-2-git-send-email-jonathanh@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Ideally, if we are returning a reference to a PM domain via a call to
of_genpd_get_from_provider(), then we should keep track of such
references via a reference count. The reference count could then be used
to determine if a PM domain can be safely removed. Alternatively, it is
possible to avoid such external references by providing APIs to access
the PM domain and hence, eliminate any calls to
of_genpd_get_from_provider().

Add new helper functions for adding a device and a subdomain to a PM
domain when using device-tree, so that external calls to
of_genpd_get_from_provider() can be removed.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 16 ++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a1f2aff33997..43c2a959a7bf 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1502,6 +1502,52 @@ struct generic_pm_domain *of_genpd_get_from_provider(
 EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 
 /**
+ * of_genpd_add_device() - Add a device to an I/O PM domain
+ * @genpdspec: OF phandle args to use for look-up PM domain
+ * @dev: Device to be added.
+ *
+ * Looks-up an I/O PM domain based upon phandle args provided and adds
+ * the device to the PM domain. Returns a negative error code on failure.
+ */
+int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = of_genpd_get_from_provider(genpdspec);
+	if (IS_ERR(genpd))
+		return PTR_ERR(genpd);
+
+	return pm_genpd_add_device(genpd, dev);
+}
+EXPORT_SYMBOL_GPL(of_genpd_add_device);
+
+/**
+ * of_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
+ * @parent_spec: OF phandle args to use for parent PM domain look-up
+ * @subdomain_spec: OF phandle args to use for subdomain look-up
+ *
+ * Looks-up a parent PM domain and subdomain based upon phandle args
+ * provided and adds the subdomain to the parent PM domain. Returns a
+ * negative error code on failure.
+ */
+int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
+			   struct of_phandle_args *subdomain_spec)
+{
+	struct generic_pm_domain *parent, *subdomain;
+
+	parent = of_genpd_get_from_provider(parent_spec);
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
+
+	subdomain = of_genpd_get_from_provider(subdomain_spec);
+	if (IS_ERR(subdomain))
+		return PTR_ERR(subdomain);
+
+	return pm_genpd_add_subdomain(parent, subdomain);
+}
+EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
+
+/**
  * genpd_dev_pm_detach - Detach a device from its PM domain.
  * @dev: Device to detach.
  * @power_off: Currently not used
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 31fec858088c..e1964a242389 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -208,6 +208,10 @@ struct generic_pm_domain *__of_genpd_xlate_simple(
 struct generic_pm_domain *__of_genpd_xlate_onecell(
 					struct of_phandle_args *genpdspec,
 					void *data);
+extern int of_genpd_add_device(struct of_phandle_args *args,
+			       struct device *dev);
+extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
+				  struct of_phandle_args *new_subdomain);
 
 int genpd_dev_pm_attach(struct device *dev);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
@@ -227,6 +231,18 @@ static inline struct generic_pm_domain *of_genpd_get_from_provider(
 #define __of_genpd_xlate_simple		NULL
 #define __of_genpd_xlate_onecell	NULL
 
+static inline int of_genpd_add_device(struct of_phandle_args *args,
+				      struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline int of_genpd_add_subdomain(struct of_phandle_args *parent,
+					 struct of_phandle_args *new_subdomain)
+{
+	return -ENODEV;
+}
+
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return -ENODEV;
-- 
2.1.4
