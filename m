From: Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH 3/4] PM / Domains: Add OF helpers for getting PM domains
Date: Tue, 28 Mar 2017 15:14:02 +0100
Message-ID: <1490710443-27425-4-git-send-email-jonathanh@nvidia.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, geert@linux-m68k.org, rnayak@codeaurora.org
Cc: stanimir.varbanov@linaro.org, sboyd@codeaurora.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Add helper functions for getting PM domains via device-tree that are to
be controlled explicitly via the pm_genpd_poweron/off() APIs. PM domains
can be retrieved by either index or name. Retrieving a PM domain by name
requires that the 'power-domain-names' property is present for the
consumer.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 72 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 17 +++++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4980ec157750..77516b2b3e58 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2285,6 +2285,78 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
+
+static struct generic_pm_domain *genpd_get(struct device_node *np, int index)
+{
+	struct of_phandle_args genpdspec;
+	struct generic_pm_domain *genpd;
+	int ret;
+
+	if (index < 0)
+		return ERR_PTR(-EINVAL);
+
+	ret = of_parse_phandle_with_args(np, "power-domains",
+					 "#power-domain-cells", index,
+					 &genpdspec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mutex_lock(&gpd_list_lock);
+
+	genpd = genpd_get_from_provider(&genpdspec);
+	of_node_put(genpdspec.np);
+
+	if (!IS_ERR(genpd)) {
+		genpd_lock(genpd);
+		genpd->device_count++;
+		genpd->suspended_count++;
+		genpd_unlock(genpd);
+	}
+
+	mutex_unlock(&gpd_list_lock);
+
+	return genpd;
+}
+
+/**
+ * of_genpd_get() - Get a PM domain by index using a device node
+ * @np: pointer to PM domain consumer node
+ * @index: index reference for a PM domain in the consumer node
+ *
+ * This function parses the 'power-domains' property using the index
+ * provided to look up a PM domain from the registered list of PM domain
+ * providers.
+ */
+struct generic_pm_domain *of_genpd_get(struct device_node *np, int index)
+{
+	return genpd_get(np, index);
+}
+EXPORT_SYMBOL(of_genpd_get);
+
+/**
+ * of_genpd_get_by_name() - Get a PM domain by name using a device node
+ * @np: pointer to PM domain consumer node
+ * @name: name reference for a PM domain in the consumer node
+ *
+ * This function parses the 'power-domains' and 'power-domain-names'
+ * properties, and uses them to look up a PM domain from the registered
+ * list of PM domain providers.
+ */
+struct generic_pm_domain *of_genpd_get_by_name(struct device_node *np,
+					       const char *name)
+{
+	int index;
+
+	if (!np || !name)
+		return ERR_PTR(-EINVAL);
+
+	index = of_property_match_string(np, "power-domain-names", name);
+	if (index < 0)
+		return ERR_PTR(index);
+
+	return genpd_get(np, index);
+}
+EXPORT_SYMBOL(of_genpd_get_by_name);
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b3aa1f237d96..d0183d96a1b3 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -240,6 +240,10 @@ extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
 extern struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 extern int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n);
+extern struct generic_pm_domain *of_genpd_get(struct device_node *np,
+					      int index);
+extern struct generic_pm_domain *of_genpd_get_by_name(struct device_node *np,
+						      const char *name);
 
 int genpd_dev_pm_attach(struct device *dev);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
@@ -285,6 +289,19 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline
+struct generic_pm_domain *of_genpd_get(struct device_node *np, int index)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline
+struct generic_pm_domain *of_genpd_get_by_name(struct device_node *np,
+					       const char *name)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 #ifdef CONFIG_PM
-- 
2.7.4
