From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2] PM / Domains: Add pm_genpd_lookup() API to lookup domain by firmware node
Date: Fri, 28 Nov 2014 11:38:35 +0100
Message-ID: <1417171115-5789-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

In a step to move away from using genpd's name based APIs, such as the
pm_genpd_add_subdomain_names(), provide an API to lookup an already
initialized generic PM domain by its firmware node.

This API would typically be a called from SOC specific code, to fetch a
handle to the domain. Especially convenient to configure subdomains and
when the hierarchy of the domains are described in DT.

Do note, before pm_genpd_init() is invoked to initialize a generic PM
domain, it's the callers responsibility to assign the new ->fwnode
pointer in the struct generic_pm_domain, to enable pm_genpd_lookup() to
find the domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Change from using struct device_node to struct fwnode_handle.
	Updated commit header accordingly.

---
 drivers/base/power/domain.c | 27 +++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 735c473..2d881d5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -75,6 +75,33 @@ struct generic_pm_domain *dev_to_genpd(struct device *dev)
 	return pd_to_genpd(dev->pm_domain);
 }
 
+/**
+ * pm_genpd_lookup - Fetch a generic PM domain object by firmware node.
+ * @node: Firmware node to a corresponding genpd.
+ *
+ * Returns a valid pointer to struct generic_pm_domain on success or ERR_PTR()
+ * on failure.
+ */
+struct generic_pm_domain *pm_genpd_lookup(struct fwnode_handle *node)
+{
+	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT), *gpd;
+
+	if (IS_ERR_OR_NULL(node))
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
+		if (gpd->fwnode == node) {
+			genpd = gpd;
+			break;
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+
+	return genpd;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_lookup);
+
 static int genpd_stop_dev(struct generic_pm_domain *genpd, struct device *dev)
 {
 	return GENPD_DEV_TIMED_CALLBACK(genpd, int, stop, dev,
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 8cbd32e..aa01050 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -43,6 +43,8 @@ struct gpd_cpuidle_data {
 	struct cpuidle_state *idle_state;
 };
 
+struct fwnode_handle;
+
 struct generic_pm_domain {
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
@@ -53,6 +55,7 @@ struct generic_pm_domain {
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
 	const char *name;
+	struct fwnode_handle *fwnode;	/* Firware node for the PM domain */
 	unsigned int in_progress;	/* Number of devices being suspended now */
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
@@ -126,6 +129,7 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 }
 
 extern struct generic_pm_domain *dev_to_genpd(struct device *dev);
+extern struct generic_pm_domain *pm_genpd_lookup(struct fwnode_handle *node);
 extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 				 struct device *dev,
 				 struct gpd_timing_data *td);
-- 
1.9.1
