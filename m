From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 03/16] PM / Domains: Support IRQ safe PM domains
Date: Fri, 26 Jun 2015 21:02:23 -0600
Message-ID: <1435374156-19214-4-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34874 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbbF0DCt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:02:49 -0400
Received: by pdbci14 with SMTP id ci14so84808980pdb.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:02:48 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Generic Power Domains currently support turning on/off only in process
context. This prevents the usage of PM domains for domains that could be
powered on/off in a context where IRQs are disabled. Many such domains
exist today and do not get powered off, when the IRQ safe devices in
that domain are powered off, because of this limitation.

However, not all domains can operate in IRQ safe contexts. Genpd
therefore, has to support both cases where the domain may or may not
operate in IRQ safe contexts. Configuring genpd to use an appropriate
lock for that domain, would allow domains that have IRQ safe devices to
runtime suspend and resume, in atomic context.

To achieve domain specific locking, set the domain's ->flag to
GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that genpd
should use a spinlock instead of a mutex for locking the domain. Locking
is abstracted through genpd_lock() and genpd_unlock() functions that use
the flag to determine the appropriate lock to be used for that domain.
Domains that have lower latency to suspend and resume and can operate
with IRQs disabled may now be able to save power, when the component
devices and sub-domains are idle at runtime.

The restriction this imposes on the domain hierarchy is that sub-domains
and all devices in the IRQ safe domain's hierarchy also have to be IRQ
safe, so that we dont try to lock a mutex, while holding a spinlock.
Non-IRQ safe domains may continue to have devices and sub-domains that
may or may not be IRQ safe.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
Changes in v2:
	- Modify commit text
	- Fix an issue with IRQ safe check
	- Rename genpd_lock_domain() and genpd_unlock_domain names
	- Inlined functions instead of macros
	- Rebase on top of V4 of Ulf's patch [1].

[1]. https://patches.linaro.org/50047/
---
 Documentation/power/devices.txt |  11 ++-
 drivers/base/power/domain.c     | 201 +++++++++++++++++++++++++++++++---------
 include/linux/pm_domain.h       |  11 ++-
 3 files changed, 178 insertions(+), 45 deletions(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index d172bce..67b74ae 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -600,7 +600,16 @@ individually.  Instead, a set of devices sharing a power resource can be put
 into a low-power state together at the same time by turning off the shared
 power resource.  Of course, they also need to be put into the full-power state
 together, by turning the shared power resource on.  A set of devices with this
-property is often referred to as a power domain.
+property is often referred to as a power domain. A power domain may also be
+nested inside another domain.
+
+Devices, by default, operate in process context and if a device can operate in
+IRQ safe context, has to be explicitly set as IRQ safe. PM domains by default,
+operate in process context but could have devices that are IRQ safe. Such PM
+domains cannot be powered on/off during runtime PM. On the other hand, an IRQ
+safe PM domain that can be powered on/off and suspend or resumed in an atomic
+context, may contain IRQ safe devices. Such domain may only contain only IRQ
+safe devices or IRQ safe sub-domains.
 
 Support for power domains is provided through the pm_domain field of struct
 device.  This field is a pointer to an object of type struct dev_pm_domain,
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e9b7cfb..42ffb8b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -50,6 +50,74 @@
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
+static inline int genpd_lock_noirq(struct generic_pm_domain *genpd,
+					unsigned int subclass)
+	__acquires(&genpd->slock)
+{
+	unsigned long flags;
+
+	if (unlikely(subclass > 0))
+		spin_lock_irqsave_nested(&genpd->slock, flags, subclass);
+	else
+		spin_lock_irqsave(&genpd->slock, flags);
+
+	genpd->lock_flags = flags;
+	return 0;
+}
+
+static inline void genpd_unlock_noirq(struct generic_pm_domain *genpd)
+	__releases(&genpd->slock)
+{
+	spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
+}
+
+static inline int genpd_lock_irq(struct generic_pm_domain *genpd,
+					unsigned int subclass)
+	__acquires(&genpd->mlock)
+{
+	if (unlikely(subclass > 0))
+		mutex_lock_nested(&genpd->mlock, subclass);
+	else
+		mutex_lock(&genpd->mlock);
+	return 0;
+}
+
+static inline int genpd_lock_interruptible_irq(struct generic_pm_domain *genpd)
+	__acquires(&genpd->mlock)
+{
+	return mutex_lock_interruptible(&genpd->mlock);
+}
+
+static inline void genpd_unlock_irq(struct generic_pm_domain *genpd)
+	__releases(&genpd->mlock)
+{
+	mutex_unlock(&genpd->mlock);
+}
+
+static inline int genpd_lock(struct generic_pm_domain *genpd)
+{
+	return genpd->irq_safe ? genpd_lock_noirq(genpd, 0)
+			: genpd_lock_irq(genpd, 0);
+}
+
+static inline int genpd_lock_nested(struct generic_pm_domain *genpd)
+{
+	return genpd->irq_safe ? genpd_lock_noirq(genpd, SINGLE_DEPTH_NESTING)
+			: genpd_lock_irq(genpd, SINGLE_DEPTH_NESTING);
+}
+
+static inline int genpd_lock_interruptible(struct generic_pm_domain *genpd)
+{
+	return genpd->irq_safe ? genpd_lock_noirq(genpd, 0)
+			: genpd_lock_interruptible_irq(genpd);
+}
+
+static inline void genpd_unlock(struct generic_pm_domain *genpd)
+{
+	return genpd->irq_safe ? genpd_unlock_noirq(genpd)
+			: genpd_unlock_irq(genpd);
+}
+
 static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
 {
 	struct generic_pm_domain *genpd = NULL, *gpd;
@@ -270,9 +338,9 @@ int pm_genpd_poweron(struct generic_pm_domain *genpd)
 {
 	int ret;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	ret = __pm_genpd_poweron(genpd);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	return ret;
 }
 
@@ -332,9 +400,9 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 		spin_unlock_irq(&dev->power.lock);
 
 		if (!IS_ERR(genpd)) {
-			mutex_lock(&genpd->lock);
+			genpd_lock(genpd);
 			genpd->max_off_time_changed = true;
-			mutex_unlock(&genpd->lock);
+			genpd_unlock(genpd);
 		}
 
 		dev = dev->parent;
@@ -391,7 +459,13 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		if (stat > PM_QOS_FLAGS_NONE)
 			return -EBUSY;
 
-		if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
+		/*
+		 * We do not want to power off the domain if the device is
+		 * not suspended or an IRQ safe device is part of this
+		 * non-IRQ safe domain.
+		 */
+		if (!pm_runtime_suspended(pdd->dev) ||
+			(pdd->dev->power.irq_safe && !genpd->irq_safe))
 			not_suspended++;
 	}
 
@@ -457,9 +531,9 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	pm_genpd_poweroff(genpd);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 }
 
 /**
@@ -497,17 +571,19 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	}
 
 	/*
-	 * If power.irq_safe is set, this routine will be run with interrupts
-	 * off, so it can't use mutexes.
+	 * If power.irq_safe is set, this routine may be run with
+	 * IRQ disabled, so suspend only if the power domain is
+	 * irq_safe.
 	 */
-	if (dev->power.irq_safe)
+	if (dev->power.irq_safe && !genpd->irq_safe)
 		return 0;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
+
 	genpd->in_progress++;
 	pm_genpd_poweroff(genpd);
 	genpd->in_progress--;
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	return 0;
 }
@@ -532,15 +608,18 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	/* If power.irq_safe, the PM domain is never powered off. */
-	if (dev->power.irq_safe) {
+	/*
+	 * As we dont power off a non IRQ safe domain, which holds a
+	 * an IRQ safe device, we dont need to restore power to it.
+	 */
+	if (dev->power.irq_safe && !genpd->irq_safe) {
 		timed = false;
 		goto out;
 	}
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	ret = __pm_genpd_poweron(genpd);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	if (ret)
 		return ret;
@@ -740,14 +819,14 @@ static int pm_genpd_prepare(struct device *dev)
 	if (resume_needed(dev, genpd))
 		pm_runtime_resume(dev);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (genpd->prepared_count++ == 0) {
 		genpd->suspended_count = 0;
 		genpd->suspend_power_off = genpd->status == GPD_STATE_POWER_OFF;
 	}
 
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	if (genpd->suspend_power_off) {
 		pm_runtime_put_noidle(dev);
@@ -765,12 +844,12 @@ static int pm_genpd_prepare(struct device *dev)
 
 	ret = pm_generic_prepare(dev);
 	if (ret) {
-		mutex_lock(&genpd->lock);
+		genpd_lock(genpd);
 
 		if (--genpd->prepared_count == 0)
 			genpd->suspend_power_off = false;
 
-		mutex_unlock(&genpd->lock);
+		genpd_unlock(genpd);
 		pm_runtime_enable(dev);
 	}
 
@@ -1127,13 +1206,13 @@ static void pm_genpd_complete(struct device *dev)
 	if (IS_ERR(genpd))
 		return;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	run_complete = !genpd->suspend_power_off;
 	if (--genpd->prepared_count == 0)
 		genpd->suspend_power_off = false;
 
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	if (run_complete) {
 		pm_generic_complete(dev);
@@ -1277,11 +1356,18 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
+	/* Devices in an IRQ safe PM domain have to be IRQ safe too */
+	if (genpd->irq_safe && !dev->power.irq_safe) {
+		dev_err(dev,
+			"Devices in an IRQ safe domain have to be IRQ safe.\n");
+		return -EINVAL;
+	}
+
 	gpd_data = genpd_alloc_dev_data(dev, genpd, td);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (genpd->prepared_count > 0) {
 		ret = -EAGAIN;
@@ -1298,7 +1384,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1342,7 +1428,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	gpd_data = to_gpd_data(pdd);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (genpd->prepared_count > 0) {
 		ret = -EAGAIN;
@@ -1357,14 +1443,14 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	list_del_init(&pdd->list_node);
 
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
 
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
 
 	return ret;
@@ -1385,12 +1471,23 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 	    || genpd == subdomain)
 		return -EINVAL;
 
+	/*
+	 * If the domain can be powered on/off in an IRQ safe
+	 * context, ensure that the subdomain can also be
+	 * powered on/off in that context.
+	 */
+	if (genpd->irq_safe && !subdomain->irq_safe) {
+		WARN("Incompatible sub-domain %s of IRQ safe domain %s\n",
+				subdomain->name, genpd->name);
+		return -EINVAL;
+	}
+
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
 
-	mutex_lock(&genpd->lock);
-	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
+	genpd_lock(genpd);
+	genpd_lock_nested(subdomain);
 
 	if (genpd->status == GPD_STATE_POWER_OFF
 	    &&  subdomain->status != GPD_STATE_POWER_OFF) {
@@ -1413,8 +1510,8 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 		genpd_sd_counter_inc(genpd);
 
  out:
-	mutex_unlock(&subdomain->lock);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(subdomain);
+	genpd_unlock(genpd);
 
 	return ret;
 }
@@ -1462,13 +1559,13 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
 		return -EINVAL;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	list_for_each_entry(link, &genpd->master_links, master_node) {
 		if (link->slave != subdomain)
 			continue;
 
-		mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
+		genpd_lock_nested(subdomain);
 
 		list_del(&link->master_node);
 		list_del(&link->slave_node);
@@ -1476,13 +1573,13 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 		if (subdomain->status != GPD_STATE_POWER_OFF)
 			genpd_sd_counter_dec(genpd);
 
-		mutex_unlock(&subdomain->lock);
+		genpd_unlock(subdomain);
 
 		ret = 0;
 		break;
 	}
 
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	return ret;
 }
@@ -1506,11 +1603,17 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 	if (IS_ERR_OR_NULL(genpd) || state < 0)
 		return -EINVAL;
 
+	if (genpd->irq_safe) {
+		WARN("Domain %s is IRQ safe, cannot attach to cpuidle\n",
+				genpd->name);
+		return -EINVAL;
+	}
+
 	cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
 	if (!cpuidle_data)
 		return -ENOMEM;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (genpd->cpuidle_data) {
 		ret = -EEXIST;
@@ -1537,7 +1640,7 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 	genpd_recalc_cpu_exit_latency(genpd);
 
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	return ret;
 
  err:
@@ -1574,7 +1677,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 	if (IS_ERR_OR_NULL(genpd))
 		return -EINVAL;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	cpuidle_data = genpd->cpuidle_data;
 	if (!cpuidle_data) {
@@ -1592,7 +1695,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 	kfree(cpuidle_data);
 
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	return ret;
 }
 
@@ -1653,6 +1756,17 @@ static int pm_genpd_default_restore_state(struct device *dev)
 	return cb ? cb(dev) : 0;
 }
 
+static void genpd_lock_init(struct generic_pm_domain *genpd)
+{
+	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
+		spin_lock_init(&genpd->slock);
+		genpd->irq_safe = true;
+	} else {
+		mutex_init(&genpd->mlock);
+		genpd->irq_safe = false;
+	}
+}
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1668,7 +1782,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
-	mutex_init(&genpd->lock);
+	genpd_lock_init(genpd);
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	genpd->in_progress = 0;
@@ -2053,7 +2167,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 	struct gpd_link *link;
 	int ret;
 
-	ret = mutex_lock_interruptible(&genpd->lock);
+	ret = genpd_lock_interruptible(genpd);
 	if (ret)
 		return -ERESTARTSYS;
 
@@ -2073,7 +2187,8 @@ static int pm_genpd_summary_one(struct seq_file *s,
 	}
 
 	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
-		kobj_path = kobject_get_path(&pm_data->dev->kobj, GFP_KERNEL);
+		kobj_path = kobject_get_path(&pm_data->dev->kobj,
+				genpd->irq_safe ? GFP_ATOMIC : GFP_KERNEL);
 		if (kobj_path == NULL)
 			continue;
 
@@ -2084,7 +2199,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 
 	seq_puts(s, "\n");
 exit:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	return 0;
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b2725e6..dc7cb53 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -16,9 +16,11 @@
 #include <linux/of.h>
 #include <linux/notifier.h>
 #include <linux/cpuidle.h>
+#include <linux/spinlock.h>
 
 /* Defines used for the flags field in the struct generic_pm_domain */
 #define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
+#define GENPD_FLAG_IRQ_SAFE	(1U << 1) /* PM domain operates in atomic */
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
@@ -49,7 +51,6 @@ struct generic_pm_domain {
 	struct list_head master_links;	/* Links with PM domain as a master */
 	struct list_head slave_links;	/* Links with PM domain as a slave */
 	struct list_head dev_list;	/* List of devices */
-	struct mutex lock;
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
 	const char *name;
@@ -74,6 +75,14 @@ struct generic_pm_domain {
 	void (*detach_dev)(struct generic_pm_domain *domain,
 			   struct device *dev);
 	unsigned int flags;		/* Bit field of configs for genpd */
+	bool irq_safe;
+	union {
+		struct mutex mlock;
+		struct {
+			spinlock_t slock;
+			unsigned long lock_flags;
+		};
+	};
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
-- 
2.1.4

