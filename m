From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 2/7] PM / Domains: Support IRQ safe PM domains
Date: Thu,  3 Sep 2015 13:58:29 -0600
Message-ID: <1441310314-8857-3-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36657 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbICT6s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 15:58:48 -0400
Received: by pacwi10 with SMTP id wi10so208352pac.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2015 12:58:47 -0700 (PDT)
In-Reply-To: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Generic Power Domains currently support turning on/off only in process
context. This prevents the usage of PM domains for domains that could b=
e
powered on/off in a context where IRQs are disabled. Many such domains
exist today and do not get powered off, when the IRQ safe devices in
that domain are powered off, because of this limitation.

However, not all domains can operate in IRQ safe contexts. Genpd
therefore, has to support both cases where the domain may or may not
operate in IRQ safe contexts. Configuring genpd to use an appropriate
lock for that domain, would allow domains that have IRQ safe devices to
runtime suspend and resume, in atomic context.

To achieve domain specific locking, set the domain's ->flag to
GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that genp=
d
should use a spinlock instead of a mutex for locking the domain. Lockin=
g
is abstracted through genpd_lock() and genpd_unlock() functions that us=
e
the flag to determine the appropriate lock to be used for that domain.
Domains that have lower latency to suspend and resume and can operate
with IRQs disabled may now be able to save power, when the component
devices and sub-domains are idle at runtime.

The restriction this imposes on the domain hierarchy is that sub-domain=
s
and all devices in the IRQ safe domain's hierarchy also have to be IRQ
safe, so that we dont try to lock a mutex, while holding a spinlock.
Non-IRQ safe domains may continue to have devices and sub-domains that
may or may not be IRQ safe.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/power/devices.txt |  11 ++-
 drivers/base/power/domain.c     | 212 ++++++++++++++++++++++++++++++++=
--------
 include/linux/pm_domain.h       |  11 ++-
 3 files changed, 189 insertions(+), 45 deletions(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devi=
ces.txt
index 8ba6625..bde6141 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -607,7 +607,16 @@ individually.  Instead, a set of devices sharing a=
 power resource can be put
 into a low-power state together at the same time by turning off the sh=
ared
 power resource.  Of course, they also need to be put into the full-pow=
er state
 together, by turning the shared power resource on.  A set of devices w=
ith this
-property is often referred to as a power domain.
+property is often referred to as a power domain. A power domain may al=
so be
+nested inside another power domain.
+
+Devices, by default, operate in process context and if a device can op=
erate in
+IRQ safe context, has to be explicitly set as IRQ safe. Power domains =
by
+default, operate in process context but could have devices that are IR=
Q safe.
+Such power domains cannot be powered on/off during runtime PM. On the =
other
+hand, an IRQ safe PM domain that can be powered on/off and suspended o=
r resumed
+in an atomic context, may contain IRQ safe devices. Such domains may o=
nly
+contain IRQ safe devices or IRQ safe sub-domains.
=20
 Support for power domains is provided through the pm_domain field of s=
truct
 device.  This field is a pointer to an object of type struct dev_pm_do=
main,
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ef8d19f..9849338 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -53,6 +53,80 @@
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
=20
+static inline int genpd_lock_nosleep(struct generic_pm_domain *genpd,
+					unsigned int subclass)
+	__acquires(&genpd->slock)
+{
+	unsigned long flags;
+
+	if (subclass > 0)
+		spin_lock_irqsave_nested(&genpd->slock, flags, subclass);
+	else
+		spin_lock_irqsave(&genpd->slock, flags);
+
+	genpd->lock_flags =3D flags;
+	return 0;
+}
+
+static inline void genpd_unlock_nosleep(struct generic_pm_domain *genp=
d)
+	__releases(&genpd->slock)
+{
+	spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
+}
+
+static inline int genpd_lock_irq(struct generic_pm_domain *genpd,
+					unsigned int subclass)
+	__acquires(&genpd->mlock)
+{
+	if (subclass > 0)
+		mutex_lock_nested(&genpd->mlock, subclass);
+	else
+		mutex_lock(&genpd->mlock);
+	return 0;
+}
+
+static inline int genpd_lock_interruptible_irq(struct generic_pm_domai=
n *genpd)
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
+	return genpd->irq_safe ? genpd_lock_nosleep(genpd, 0)
+			: genpd_lock_irq(genpd, 0);
+}
+
+static inline int genpd_lock_nested(struct generic_pm_domain *genpd)
+{
+	return genpd->irq_safe ? genpd_lock_nosleep(genpd, SINGLE_DEPTH_NESTI=
NG)
+			: genpd_lock_irq(genpd, SINGLE_DEPTH_NESTING);
+}
+
+static inline int genpd_lock_interruptible(struct generic_pm_domain *g=
enpd)
+{
+	return genpd->irq_safe ? genpd_lock_nosleep(genpd, 0)
+			: genpd_lock_interruptible_irq(genpd);
+}
+
+static inline void genpd_unlock(struct generic_pm_domain *genpd)
+{
+	return genpd->irq_safe ? genpd_unlock_nosleep(genpd)
+			: genpd_unlock_irq(genpd);
+}
+
+static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
+		struct generic_pm_domain *genpd)
+{
+	return dev->power.irq_safe && !genpd->irq_safe;
+}
+
 static struct generic_pm_domain *pm_genpd_lookup_name(const char *doma=
in_name)
 {
 	struct generic_pm_domain *genpd =3D NULL, *gpd;
@@ -273,9 +347,9 @@ int pm_genpd_poweron(struct generic_pm_domain *genp=
d)
 {
 	int ret;
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	ret =3D __pm_genpd_poweron(genpd);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	return ret;
 }
=20
@@ -335,9 +409,9 @@ static int genpd_dev_pm_qos_notifier(struct notifie=
r_block *nb,
 		spin_unlock_irq(&dev->power.lock);
=20
 		if (!IS_ERR(genpd)) {
-			mutex_lock(&genpd->lock);
+			genpd_lock(genpd);
 			genpd->max_off_time_changed =3D true;
-			mutex_unlock(&genpd->lock);
+			genpd_unlock(genpd);
 		}
=20
 		dev =3D dev->parent;
@@ -394,8 +468,17 @@ static int pm_genpd_poweroff(struct generic_pm_dom=
ain *genpd)
 		if (stat > PM_QOS_FLAGS_NONE)
 			return -EBUSY;
=20
-		if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
+		/*
+		 * We do not want to power off the domain if the device is
+		 * not suspended or an IRQ safe device is part of this
+		 * non-IRQ safe domain.
+		 */
+		if (!pm_runtime_suspended(pdd->dev) ||
+			irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd))
 			not_suspended++;
+		WARN_ONCE(irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd),
+				"PM domain %s will not be powered off\n",
+				genpd->name);
 	}
=20
 	if (not_suspended > genpd->in_progress)
@@ -460,9 +543,9 @@ static void genpd_power_off_work_fn(struct work_str=
uct *work)
=20
 	genpd =3D container_of(work, struct generic_pm_domain, power_off_work=
);
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	pm_genpd_poweroff(genpd);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 }
=20
 /**
@@ -500,17 +583,21 @@ static int pm_genpd_runtime_suspend(struct device=
 *dev)
 	}
=20
 	/*
-	 * If power.irq_safe is set, this routine will be run with interrupts
-	 * off, so it can't use mutexes.
+	 * If power.irq_safe is set, this routine may be run with
+	 * IRQ disabled, so suspend only if the power domain is
+	 * irq_safe.
 	 */
-	if (dev->power.irq_safe)
+	WARN_ONCE(irq_safe_dev_in_no_sleep_domain(dev, genpd),
+			"genpd %s will not be powered off\n", genpd->name);
+	if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
 		return 0;
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
+
 	genpd->in_progress++;
 	pm_genpd_poweroff(genpd);
 	genpd->in_progress--;
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	return 0;
 }
@@ -535,15 +622,18 @@ static int pm_genpd_runtime_resume(struct device =
*dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	/* If power.irq_safe, the PM domain is never powered off. */
-	if (dev->power.irq_safe) {
+	/*
+	 * As we dont power off a non IRQ safe domain, which holds
+	 * an IRQ safe device, we dont need to restore power to it.
+	 */
+	if (dev->power.irq_safe && !genpd->irq_safe) {
 		timed =3D false;
 		goto out;
 	}
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	ret =3D __pm_genpd_poweron(genpd);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	if (ret)
 		return ret;
@@ -743,14 +833,14 @@ static int pm_genpd_prepare(struct device *dev)
 	if (resume_needed(dev, genpd))
 		pm_runtime_resume(dev);
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	if (genpd->prepared_count++ =3D=3D 0) {
 		genpd->suspended_count =3D 0;
 		genpd->suspend_power_off =3D genpd->status =3D=3D GPD_STATE_POWER_OF=
=46;
 	}
=20
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	if (genpd->suspend_power_off) {
 		pm_runtime_put_noidle(dev);
@@ -768,12 +858,12 @@ static int pm_genpd_prepare(struct device *dev)
=20
 	ret =3D pm_generic_prepare(dev);
 	if (ret) {
-		mutex_lock(&genpd->lock);
+		genpd_lock(genpd);
=20
 		if (--genpd->prepared_count =3D=3D 0)
 			genpd->suspend_power_off =3D false;
=20
-		mutex_unlock(&genpd->lock);
+		genpd_unlock(genpd);
 		pm_runtime_enable(dev);
 	}
=20
@@ -1130,13 +1220,13 @@ static void pm_genpd_complete(struct device *de=
v)
 	if (IS_ERR(genpd))
 		return;
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	run_complete =3D !genpd->suspend_power_off;
 	if (--genpd->prepared_count =3D=3D 0)
 		genpd->suspend_power_off =3D false;
=20
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	if (run_complete) {
 		pm_generic_complete(dev);
@@ -1280,11 +1370,18 @@ int __pm_genpd_add_device(struct generic_pm_dom=
ain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
=20
+	if (genpd->irq_safe && !dev->power.irq_safe) {
+		dev_err(dev,
+			"PM Domain %s is IRQ safe; device has to IRQ safe.\n",
+			genpd->name);
+		return -EINVAL;
+	}
+
 	gpd_data =3D genpd_alloc_dev_data(dev, genpd, td);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	if (genpd->prepared_count > 0) {
 		ret =3D -EAGAIN;
@@ -1301,7 +1398,7 @@ int __pm_genpd_add_device(struct generic_pm_domai=
n *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
=20
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1345,7 +1442,7 @@ int pm_genpd_remove_device(struct generic_pm_doma=
in *genpd,
 	gpd_data =3D to_gpd_data(pdd);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	if (genpd->prepared_count > 0) {
 		ret =3D -EAGAIN;
@@ -1360,14 +1457,14 @@ int pm_genpd_remove_device(struct generic_pm_do=
main *genpd,
=20
 	list_del_init(&pdd->list_node);
=20
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	genpd_free_dev_data(dev, gpd_data);
=20
 	return 0;
=20
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
=20
 	return ret;
@@ -1388,12 +1485,23 @@ int pm_genpd_add_subdomain(struct generic_pm_do=
main *genpd,
 	    || genpd =3D=3D subdomain)
 		return -EINVAL;
=20
+	/*
+	 * If the domain can be powered on/off in an IRQ safe
+	 * context, ensure that the subdomain can also be
+	 * powered on/off in that context.
+	 */
+	if (genpd->irq_safe && !subdomain->irq_safe) {
+		WARN("Sub-domain (%s) in an IRQ-safe domain (%s) has to be IRQ safe\=
n",
+				subdomain->name, genpd->name);
+		return -EINVAL;
+	}
+
 	link =3D kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
=20
-	mutex_lock(&genpd->lock);
-	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
+	genpd_lock(genpd);
+	genpd_lock_nested(subdomain);
=20
 	if (genpd->status =3D=3D GPD_STATE_POWER_OFF
 	    &&  subdomain->status !=3D GPD_STATE_POWER_OFF) {
@@ -1416,8 +1524,8 @@ int pm_genpd_add_subdomain(struct generic_pm_doma=
in *genpd,
 		genpd_sd_counter_inc(genpd);
=20
  out:
-	mutex_unlock(&subdomain->lock);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(subdomain);
+	genpd_unlock(genpd);
 	if (ret)
 		kfree(link);
 	return ret;
@@ -1466,13 +1574,13 @@ int pm_genpd_remove_subdomain(struct generic_pm=
_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
 		return -EINVAL;
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	list_for_each_entry(link, &genpd->master_links, master_node) {
 		if (link->slave !=3D subdomain)
 			continue;
=20
-		mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
+		genpd_lock_nested(subdomain);
=20
 		list_del(&link->master_node);
 		list_del(&link->slave_node);
@@ -1480,13 +1588,13 @@ int pm_genpd_remove_subdomain(struct generic_pm=
_domain *genpd,
 		if (subdomain->status !=3D GPD_STATE_POWER_OFF)
 			genpd_sd_counter_dec(genpd);
=20
-		mutex_unlock(&subdomain->lock);
+		genpd_unlock(subdomain);
=20
 		ret =3D 0;
 		break;
 	}
=20
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	return ret;
 }
@@ -1510,11 +1618,17 @@ int pm_genpd_attach_cpuidle(struct generic_pm_d=
omain *genpd, int state)
 	if (IS_ERR_OR_NULL(genpd) || state < 0)
 		return -EINVAL;
=20
+	if (genpd->irq_safe) {
+		WARN("Domain %s is IRQ safe, cannot attach to cpuidle\n",
+				genpd->name);
+		return -EINVAL;
+	}
+
 	cpuidle_data =3D kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
 	if (!cpuidle_data)
 		return -ENOMEM;
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	if (genpd->cpuidle_data) {
 		ret =3D -EEXIST;
@@ -1541,7 +1655,7 @@ int pm_genpd_attach_cpuidle(struct generic_pm_dom=
ain *genpd, int state)
 	genpd_recalc_cpu_exit_latency(genpd);
=20
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	return ret;
=20
  err:
@@ -1578,7 +1692,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_dom=
ain *genpd)
 	if (IS_ERR_OR_NULL(genpd))
 		return -EINVAL;
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	cpuidle_data =3D genpd->cpuidle_data;
 	if (!cpuidle_data) {
@@ -1596,7 +1710,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_dom=
ain *genpd)
 	kfree(cpuidle_data);
=20
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	return ret;
 }
=20
@@ -1657,6 +1771,17 @@ static int pm_genpd_default_restore_state(struct=
 device *dev)
 	return cb ? cb(dev) : 0;
 }
=20
+static void genpd_lock_init(struct generic_pm_domain *genpd)
+{
+	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
+		spin_lock_init(&genpd->slock);
+		genpd->irq_safe =3D true;
+	} else {
+		mutex_init(&genpd->mlock);
+		genpd->irq_safe =3D false;
+	}
+}
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1672,7 +1797,7 @@ void pm_genpd_init(struct generic_pm_domain *genp=
d,
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
-	mutex_init(&genpd->lock);
+	genpd_lock_init(genpd);
 	genpd->gov =3D gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	genpd->in_progress =3D 0;
@@ -2067,7 +2192,7 @@ static int pm_genpd_summary_one(struct seq_file *=
s,
 	struct gpd_link *link;
 	int ret;
=20
-	ret =3D mutex_lock_interruptible(&genpd->lock);
+	ret =3D genpd_lock_interruptible(genpd);
 	if (ret)
 		return -ERESTARTSYS;
=20
@@ -2087,7 +2212,8 @@ static int pm_genpd_summary_one(struct seq_file *=
s,
 	}
=20
 	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
-		kobj_path =3D kobject_get_path(&pm_data->dev->kobj, GFP_KERNEL);
+		kobj_path =3D kobject_get_path(&pm_data->dev->kobj,
+				genpd->irq_safe ? GFP_ATOMIC : GFP_KERNEL);
 		if (kobj_path =3D=3D NULL)
 			continue;
=20
@@ -2098,7 +2224,7 @@ static int pm_genpd_summary_one(struct seq_file *=
s,
=20
 	seq_puts(s, "\n");
 exit:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
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
=20
 /* Defines used for the flags field in the struct generic_pm_domain */
 #define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
+#define GENPD_FLAG_IRQ_SAFE	(1U << 1) /* PM domain operates in atomic =
*/
=20
 enum gpd_status {
 	GPD_STATE_ACTIVE =3D 0,	/* PM domain is active */
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
=20
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_doma=
in *pd)
--=20
2.1.4

