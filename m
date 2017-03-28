From: Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH 2/4] PM / Domains: Add support for explicit control of PM domains
Date: Tue, 28 Mar 2017 15:14:01 +0100
Message-ID: <1490710443-27425-3-git-send-email-jonathanh@nvidia.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, geert@linux-m68k.org, rnayak@codeaurora.org
Cc: stanimir.varbanov@linaro.org, sboyd@codeaurora.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The current generic PM domain framework (GenDP) only allows a single
PM domain to be associated with a given device. There are several
use-cases for various system-on-chip devices where it is necessary for
a PM domain consumer to control more than one PM domain where the PM
domains:
i).  Do not conform to a parent-child relationship so are not nested
ii). May not be powered on and off at the same time so need independent
     control.

To support the above, add new APIs for GenPD to allow consumers to get,
power-on, power-off and put PM domains so that they can be explicitly
controlled by the consumer.

These new APIs for powering on and off the PM domains, call into the
existing internal functions, genpd_sync_power_on/off(), to power them
on and off. To ensure that PM domains that are both controlled
explicitly (via these new APIs) and implicitly (via runtime-pm
callbacks) do not conflict, the PM domain 'device_count' and
'suspended_count' counters are used to ensure the PM domain is in the
correct state.

For PM domains that are controlled explicitly, the debugfs 'summary'
node for GenPD will display an 'unknown (X)' under the 'device' column
to indicate that 'X' unknown device(s) are controlling the PM domain.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 123 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h   |  18 +++++++
 2 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0eb75954c087..4980ec157750 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -303,6 +303,9 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	if (atomic_read(&genpd->sd_count) > 0)
 		return -EBUSY;
 
+	if (genpd->device_count > genpd->suspended_count)
+		return -EBUSY;
+
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
 		enum pm_qos_flags_status stat;
 
@@ -1568,6 +1571,117 @@ int pm_genpd_remove(struct generic_pm_domain *genpd)
 }
 EXPORT_SYMBOL_GPL(pm_genpd_remove);
 
+/**
+ * pm_genpd_get - Get a generic I/O PM domain by name
+ * @name: Name of the PM domain.
+ *
+ * Look-ups a PM domain by name. If found, increment the device
+ * count for PM domain to ensure that the PM domain cannot be
+ * removed, increment the suspended count so that it can still
+ * be turned off (when not in-use) and return a pointer to its
+ * generic_pm_domain structure. If not found return ERR_PTR().
+ */
+struct generic_pm_domain *pm_genpd_get(const char *name)
+{
+	struct generic_pm_domain *gpd, *genpd = ERR_PTR(-EEXIST);
+
+	if (!name)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
+		if (!strcmp(gpd->name, name)) {
+			genpd_lock(gpd);
+			gpd->device_count++;
+			gpd->suspended_count++;
+			genpd_unlock(gpd);
+			genpd = gpd;
+			break;
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+
+	return genpd;
+}
+EXPORT_SYMBOL(pm_genpd_get);
+
+/**
+ * pm_genpd_put - Put a generic I/O PM domain
+ * @genpd: Pointer to a PM domain.
+ */
+void pm_genpd_put(struct generic_pm_domain *genpd)
+{
+	if (!genpd)
+		return;
+
+	genpd_lock(genpd);
+
+	if (WARN_ON(!genpd->device_count || !genpd->suspended_count))
+		goto out;
+
+	genpd->suspended_count--;
+	genpd->device_count--;
+
+out:
+	genpd_unlock(genpd);
+}
+EXPORT_SYMBOL(pm_genpd_put);
+
+/**
+ * pm_genpd_poweron - Power on a generic I/O PM domain
+ * @genpd: Pointer to a PM domain.
+ *
+ * Powers on a PM domain, if not already on, and decrements the
+ * 'suspended_count' to prevent the PM domain from being powered off.
+ */
+int pm_genpd_poweron(struct generic_pm_domain *genpd)
+{
+	if (!genpd)
+		return -EINVAL;
+
+	genpd_lock(genpd);
+
+	if (WARN_ON(!genpd->suspended_count))
+		goto out;
+
+	genpd->suspended_count--;
+	genpd_sync_power_on(genpd, true, 0);
+
+out:
+	genpd_unlock(genpd);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_poweron);
+
+/**
+ * pm_genpd_poweroff - Power off a generic I/O PM domain
+ * @genpd: Pointer to a PM domain.
+ *
+ * Increments the 'suspended_count' for a PM domain and if the
+ * 'suspended_count' equals the 'device_count' then will power
+ * off the PM domain.
+ */
+int pm_genpd_poweroff(struct generic_pm_domain *genpd)
+{
+	if (!genpd)
+		return -EINVAL;
+
+	genpd_lock(genpd);
+
+	if (WARN_ON(genpd->suspended_count >= genpd->device_count))
+		goto out;
+
+	genpd->suspended_count++;
+	genpd_sync_power_off(genpd, false, 0);
+
+out:
+	genpd_unlock(genpd);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_poweroff);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 
 typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
@@ -2171,7 +2285,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
-
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 
@@ -2223,7 +2336,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 	const char *kobj_path;
 	struct gpd_link *link;
 	char state[16];
-	int ret;
+	int ret, count;
 
 	ret = genpd_lock_interruptible(genpd);
 	if (ret)
@@ -2250,6 +2363,8 @@ static int pm_genpd_summary_one(struct seq_file *s,
 			seq_puts(s, ", ");
 	}
 
+	count = genpd->device_count;
+
 	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
 		kobj_path = kobject_get_path(&pm_data->dev->kobj,
 				genpd_is_irq_safe(genpd) ?
@@ -2260,8 +2375,12 @@ static int pm_genpd_summary_one(struct seq_file *s,
 		seq_printf(s, "\n    %-50s  ", kobj_path);
 		rtpm_status_str(s, pm_data->dev);
 		kfree(kobj_path);
+		count--;
 	}
 
+	if (count > 0)
+		seq_printf(s, "\n    unknown (%d)", count);
+
 	seq_puts(s, "\n");
 exit:
 	genpd_unlock(genpd);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5339ed5bd6f9..b3aa1f237d96 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -143,6 +143,10 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 extern int pm_genpd_init(struct generic_pm_domain *genpd,
 			 struct dev_power_governor *gov, bool is_off);
 extern int pm_genpd_remove(struct generic_pm_domain *genpd);
+extern struct generic_pm_domain *pm_genpd_get(const char *name);
+extern void pm_genpd_put(struct generic_pm_domain *genpd);
+extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
+extern int pm_genpd_poweroff(struct generic_pm_domain *genpd);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -182,6 +186,20 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 {
 	return -ENOTSUPP;
 }
+static inline struct generic_pm_domain *pm_genpd_get(const char *name)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void pm_genpd_put(struct generic_pm_domain *genpd) {}
+static inline int pm_genpd_poweron(struct generic_pm_domain *genpd)
+{
+	return -ENOTSUPP;
+}
+static inline int pm_genpd_poweroff(struct generic_pm_domain *genpd)
+{
+	return -ENOTSUPP;
+}
 
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
-- 
2.7.4
