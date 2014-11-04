From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [RFC PATCH] pm: Add PM domain state transition notifications
Date: Tue, 04 Nov 2014 19:10:58 +0100
Message-ID: <1415124658-15454-1-git-send-email-s.nawrocki@samsung.com>
References: <5458C1C1.1040307@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <5458C1C1.1040307@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, amit.daniel@samsung.com
Cc: rafael.j.wysocki@intel.com, pankaj.dubey@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Beata Michalska <b.michalska@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds support for the power domain state transition notifiers.
The notifiers are mostly intended to be used in SoC-specific subsystem,
e.g. clock controller, power management unit, etc. drivers.

It is an attempt to address dependencies between power domains in an SoC
and other subsystems like clocks controller, where the power domain on/off
sequences are relatively complex and involve subsystems which are split
in the kernel across various frameworks/subsystems.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Beata Michalska <b.michalska@samsung.com>
---
The deferred notifier registration is not included in this patch.
---
 Documentation/power/notifiers.txt |   14 ++++
 drivers/base/power/domain.c       |  136 +++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h         |   46 +++++++++++++
 3 files changed, 192 insertions(+), 4 deletions(-)

diff --git a/Documentation/power/notifiers.txt b/Documentation/power/notifiers.txt
index a81fa25..e70957d 100644
--- a/Documentation/power/notifiers.txt
+++ b/Documentation/power/notifiers.txt
@@ -53,3 +53,17 @@ NULL).  To register and/or unregister a suspend notifier use the functions
 register_pm_notifier() and unregister_pm_notifier(), respectively, defined in
 include/linux/suspend.h .  If you don't need to unregister the notifier, you can
 also use the pm_notifier() macro defined in include/linux/suspend.h .
+
+Power Domain notifiers
+----------------------
+
+The power domain notifiers allow subsystems or drivers to register for power
+domain on/off notifications, should they need to perform any actions right
+before or right after the power domain on/off.  The device must be already
+added to a power domain before its subsystem or driver registers the notifier.
+Following events are supported:
+
+GPD_NOTIFY_POWER_ON_PREPARE	The power domain is about to turn on.
+GPD_NOTIFY_POST_POWER_ON	The power domain has just turned on.
+GPD_NOTIFY_POWER_OFF_PREPARE	The power domain is about to turn off.
+GPD_NOTIFY_POST_POWER_OFF	The power domain has just turned off.
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 40bc2f4..2cf1b88 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -67,6 +67,110 @@ static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
 	return genpd;
 }
 
+static int __pm_genpd_do_register_notifier(struct generic_pm_domain *genpd,
+				   struct gpd_notifier_block *gpd_nb)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(genpd) || gpd_nb == NULL)
+		return -EINVAL;
+
+	mutex_lock(&genpd->lock);
+	ret = blocking_notifier_chain_cond_register(&genpd->notify_chain_head,
+						&gpd_nb->nb);
+	mutex_unlock(&genpd->lock);
+	return ret;
+}
+
+/**
+ * pm_genpd_register_notifier - Register notifier for the power domain
+ *				state transitions.
+ *
+ * @dev: Device attached to a power domain the state transitions are to be
+ *	 notified for.
+ * @gpd_nb: The notifier chain entry to be registered
+ */
+int pm_genpd_register_notifier(struct device *dev,
+			       struct gpd_notifier_block *gpd_nb)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+
+	return __pm_genpd_do_register_notifier(genpd, gpd_nb);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_register_notifier);
+
+/**
+ * pm_genpd_name_register_notifier - Register a notifier for the power domain
+ *				     state transitions.
+ *
+ * @domain_name: Name of the power domain the notifier is to be registered for.
+ * @gpd_nb: The notifier chain entry to be registered.
+ *
+ */
+int pm_genpd_name_register_notifier(const char *domain_name,
+				    struct gpd_notifier_block *gpd_nb)
+{
+	struct generic_pm_domain *genpd = pm_genpd_lookup_name(domain_name);
+
+	return __pm_genpd_do_register_notifier(genpd, gpd_nb);
+}
+EXPORT_SYMBOL(pm_genpd_name_register_notifier);
+
+static void __pm_genpd_unregister_notifier(struct generic_pm_domain *genpd,
+					   struct gpd_notifier_block *gpd_nb)
+{
+	if (IS_ERR_OR_NULL(genpd) || gpd_nb == NULL)
+		return;
+
+	mutex_lock(&genpd->lock);
+	blocking_notifier_chain_unregister(&genpd->notify_chain_head,
+					  &gpd_nb->nb);
+	mutex_unlock(&genpd->lock);
+}
+
+/**
+ * pm_genpd_unregister_notifier - Unregister a power domain state notifier
+ *
+ * @dev: Device bound to a power domain the notifier is to be unregistered for.
+ * @gpd_nb: The notifier chain entry to be unregistered.
+ */
+void pm_genpd_unregister_notifier(struct device *dev,
+				  struct gpd_notifier_block *gpd_nb)
+{
+	struct generic_pm_domain *genpd =  dev_to_genpd(dev);
+
+	__pm_genpd_unregister_notifier(genpd, gpd_nb);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_unregister_notifier);
+
+/**
+ * pm_genpd_name_unregister_notifier - Unregister a power domain state notifier
+ *
+ * @domain_name: Name of a power domain of which notifier is to be
+ *		 unregistered.
+ * @gpd_nb: The notifier chain entry to be unregistered.
+ */
+void pm_genpd_name_unregister_notifier(const char *domain_name,
+				       struct gpd_notifier_block *gpd_nb)
+{
+	struct generic_pm_domain *genpd = pm_genpd_lookup_name(domain_name);
+
+	__pm_genpd_unregister_notifier(genpd, gpd_nb);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_name_unregister_notifier);
+
+/**
+ * pm_genpd_notifier_call - Call the power domain state transition notify chain
+ *
+ * @event: The state transition event type.
+ * @genpd: The power domain to notify state transition for.
+ */
+static inline void pm_genpd_notifier_call(unsigned long event,
+				   struct generic_pm_domain *genpd)
+{
+	blocking_notifier_call_chain(&genpd->notify_chain_head, event, genpd);
+}
+
 struct generic_pm_domain *dev_to_genpd(struct device *dev)
 {
 	if (IS_ERR_OR_NULL(dev->pm_domain))
@@ -226,10 +330,14 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 		ktime_t time_start = ktime_get();
 		s64 elapsed_ns;
 
+		pm_genpd_notifier_call(GPD_NOTIFY_POWER_ON_PREPARE, genpd);
+
 		ret = genpd->power_on(genpd);
 		if (ret)
 			goto err;
 
+		pm_genpd_notifier_call(GPD_NOTIFY_POST_POWER_ON, genpd);
+
 		elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 		if (elapsed_ns > genpd->power_on_latency_ns) {
 			genpd->power_on_latency_ns = elapsed_ns;
@@ -547,6 +655,8 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		 * the pm_genpd_poweron() restore power for us (this shouldn't
 		 * happen very often).
 		 */
+		pm_genpd_notifier_call(GPD_NOTIFY_POWER_OFF_PREPARE, genpd);
+
 		ret = genpd->power_off(genpd);
 		if (ret == -EBUSY) {
 			genpd_set_active(genpd);
@@ -554,6 +664,9 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		}
 
 		elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
+
+		pm_genpd_notifier_call(GPD_NOTIFY_POST_POWER_OFF, genpd);
+
 		if (elapsed_ns > genpd->power_off_latency_ns) {
 			genpd->power_off_latency_ns = elapsed_ns;
 			genpd->max_off_time_changed = true;
@@ -796,9 +909,13 @@ static void pm_genpd_sync_poweroff(struct generic_pm_domain *genpd)
 	    || atomic_read(&genpd->sd_count) > 0)
 		return;
 
-	if (genpd->power_off)
+	if (genpd->power_off) {
+		pm_genpd_notifier_call(GPD_NOTIFY_POWER_OFF_PREPARE, genpd);
 		genpd->power_off(genpd);
 
+		pm_genpd_notifier_call(GPD_NOTIFY_POST_POWER_OFF, genpd);
+	}
+
 	genpd->status = GPD_STATE_POWER_OFF;
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
@@ -828,8 +945,11 @@ static void pm_genpd_sync_poweron(struct generic_pm_domain *genpd)
 		genpd_sd_counter_inc(link->master);
 	}
 
-	if (genpd->power_on)
+	if (genpd->power_on) {
+		pm_genpd_notifier_call(GPD_NOTIFY_POWER_ON_PREPARE, genpd);
 		genpd->power_on(genpd);
+		pm_genpd_notifier_call(GPD_NOTIFY_POST_POWER_ON, genpd);
+	}
 
 	genpd->status = GPD_STATE_ACTIVE;
 }
@@ -1251,9 +1371,16 @@ static int pm_genpd_restore_noirq(struct device *dev)
 			 * If the domain was off before the hibernation, make
 			 * sure it will be off going forward.
 			 */
-			if (genpd->power_off)
-				genpd->power_off(genpd);
+			if (!genpd->power_off)
+				return 0;
+
+			pm_genpd_notifier_call(GPD_NOTIFY_POWER_OFF_PREPARE,
+					       genpd);
+
+			genpd->power_off(genpd);
 
+			pm_genpd_notifier_call(GPD_NOTIFY_POST_POWER_OFF,
+					       genpd);
 			return 0;
 		}
 	}
@@ -1867,6 +1994,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
+	BLOCKING_INIT_NOTIFIER_HEAD(&genpd->notify_chain_head);
 	mutex_init(&genpd->lock);
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 73e938b..917494f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -17,6 +17,12 @@
 #include <linux/notifier.h>
 #include <linux/cpuidle.h>
 
+/* PM domain state transition notifications */
+#define GPD_NOTIFY_POWER_ON_PREPARE	0x01
+#define GPD_NOTIFY_POST_POWER_ON	0x02
+#define GPD_NOTIFY_POWER_OFF_PREPARE	0x03
+#define GPD_NOTIFY_POST_POWER_OFF	0x04
+
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
 	GPD_STATE_WAIT_MASTER,	/* PM domain's master is being waited for */
@@ -49,6 +55,7 @@ struct generic_pm_domain {
 	struct list_head master_links;	/* Links with PM domain as a master */
 	struct list_head slave_links;	/* Links with PM domain as a slave */
 	struct list_head dev_list;	/* List of devices */
+	struct blocking_notifier_head notify_chain_head;
 	struct mutex lock;
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
@@ -107,6 +114,20 @@ struct generic_pm_domain_data {
 	bool need_restore;
 };
 
+struct gpd_notifier_block {
+	struct notifier_block nb;
+	/* The notification's user private data */
+	void *data;
+};
+
+static inline void *gpd_get_nb_data(struct notifier_block *nb)
+{
+	struct gpd_notifier_block *genpd_nb;
+
+	genpd_nb = container_of(nb, struct gpd_notifier_block, nb);
+	return genpd_nb->data;
+}
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS
 static inline struct generic_pm_domain_data *to_gpd_data(struct pm_domain_data *pdd)
 {
@@ -146,6 +167,15 @@ extern void pm_genpd_init(struct generic_pm_domain *genpd,
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_poweron(const char *domain_name);
 
+extern int pm_genpd_register_notifier(struct device *dev,
+				      struct gpd_notifier_block *gpd_nb);
+extern int pm_genpd_name_register_notifier(const char *domain_name,
+				   struct gpd_notifier_block *gpd_nb);
+extern void pm_genpd_unregister_notifier(struct device *dev,
+					struct gpd_notifier_block *gpd_nb);
+extern void pm_genpd_name_unregister_notifier(const char *domain_name,
+					struct gpd_notifier_block *gpd_nb);
+
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
 #else
@@ -219,6 +249,22 @@ static inline int pm_genpd_name_poweron(const char *domain_name)
 {
 	return -ENOSYS;
 }
+static inline int pm_genpd_register_notifier(struct device *dev,
+					struct gpd_notifier_block *genpd_nb)
+{
+	return -ENOSYS;
+}
+
+static int pm_genpd_name_register_notifier(const char *domain_name,
+				    struct gpd_notifier_block *genpd_nb)
+{
+	return -ENOSYS;
+}
+
+static inline void pm_genpd_unregister_notifier(struct device *dev,
+				 struct gpd_notifier_block *genpd_nb) {}
+static inline void pm_genpd_name_unregister_notifier(const char *domain_name,
+				 struct gpd_notifier_block *genpd_nb) {}
 #define simple_qos_governor NULL
 #define pm_domain_always_on_gov NULL
 #endif
-- 
1.7.9.5
