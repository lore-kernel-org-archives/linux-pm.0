From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 04/14] PM / Domains: Support IRQ safe PM domains
Date: Fri, 29 Jul 2016 15:56:15 -0600
Message-ID: <1469829385-11511-5-git-send-email-lina.iyer@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?q?Krzysztof=20Koz=C5=82owski?= <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

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

The restriction this imposes on the domain hierarchy is that non-IRQ
safe domains may not have IRQ-safe subdomains, but IRQ safe domains may
have IRQ safe and non-IRQ safe subdomains and devices.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[Ulf: Rebased and solved a conflict]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 107 ++++++++++++++++++++++++++++++++++++=
+++-----
 include/linux/pm_domain.h   |  10 ++++-
 2 files changed, 106 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 88b6f95..153f1c6 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -74,11 +74,61 @@ static const struct genpd_lock_fns genpd_mtx_fns  =3D=
 {
 	.unlock =3D genpd_unlock_mtx,
 };
=20
+static void genpd_lock_spin(struct generic_pm_domain *genpd)
+	__acquires(&genpd->slock)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&genpd->slock, flags);
+	genpd->lock_flags =3D flags;
+}
+
+static void genpd_lock_nested_spin(struct generic_pm_domain *genpd,
+					int depth)
+	__acquires(&genpd->slock)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave_nested(&genpd->slock, flags, depth);
+	genpd->lock_flags =3D flags;
+}
+
+static int genpd_lock_interruptible_spin(struct generic_pm_domain *gen=
pd)
+	__acquires(&genpd->slock)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&genpd->slock, flags);
+	genpd->lock_flags =3D flags;
+	return 0;
+}
+
+static void genpd_unlock_spin(struct generic_pm_domain *genpd)
+	__releases(&genpd->slock)
+{
+	spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
+}
+
+static const struct genpd_lock_fns genpd_spin_fns =3D {
+	.lock =3D genpd_lock_spin,
+	.lock_nested =3D genpd_lock_nested_spin,
+	.lock_interruptible =3D genpd_lock_interruptible_spin,
+	.unlock =3D genpd_unlock_spin,
+};
+
 #define genpd_lock(p)			p->lock_fns->lock(p)
 #define genpd_lock_nested(p, d)		p->lock_fns->lock_nested(p, d)
 #define genpd_lock_interruptible(p)	p->lock_fns->lock_interruptible(p)
 #define genpd_unlock(p)			p->lock_fns->unlock(p)
=20
+#define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
+
+static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
+		struct generic_pm_domain *genpd)
+{
+	return pm_runtime_is_irq_safe(dev) && !genpd_is_irq_safe(genpd);
+}
+
 /*
  * Get the generic PM domain for a particular struct device.
  * This validates the struct device pointer, the PM domain pointer,
@@ -343,7 +393,12 @@ static int genpd_poweroff(struct generic_pm_domain=
 *genpd, bool is_async)
 		if (stat > PM_QOS_FLAGS_NONE)
 			return -EBUSY;
=20
-		if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
+		/*
+		 * Do not allow PM domain to be powered off, when an IRQ safe
+		 * device is part of a non-IRQ safe domain.
+		 */
+		if (!pm_runtime_suspended(pdd->dev) ||
+			irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd))
 			not_suspended++;
 	}
=20
@@ -506,10 +561,10 @@ static int genpd_runtime_suspend(struct device *d=
ev)
 	}
=20
 	/*
-	 * If power.irq_safe is set, this routine will be run with interrupts
-	 * off, so it can't use mutexes.
+	 * If power.irq_safe is set, this routine may be run with
+	 * IRQs disabled, so suspend only if the PM domain also is irq_safe.
 	 */
-	if (dev->power.irq_safe)
+	if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
 		return 0;
=20
 	genpd_lock(genpd);
@@ -543,8 +598,11 @@ static int genpd_runtime_resume(struct device *dev=
)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	/* If power.irq_safe, the PM domain is never powered off. */
-	if (dev->power.irq_safe) {
+	/*
+	 * As we don't power off a non IRQ safe domain, which holds
+	 * an IRQ safe device, we don't need to restore power to it.
+	 */
+	if (irq_safe_dev_in_no_sleep_domain(dev, genpd)) {
 		timed =3D false;
 		goto out;
 	}
@@ -586,7 +644,8 @@ static int genpd_runtime_resume(struct device *dev)
 err_stop:
 	genpd_stop_dev(genpd, dev);
 err_poweroff:
-	if (!dev->power.irq_safe) {
+	if (!dev->power.irq_safe ||
+		(dev->power.irq_safe && genpd_is_irq_safe(genpd))) {
 		genpd_lock(genpd);
 		genpd_poweroff(genpd, 0);
 		genpd_unlock(genpd);
@@ -1117,6 +1176,11 @@ int __pm_genpd_add_device(struct generic_pm_doma=
in *genpd, struct device *dev,
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
=20
+	/* Check if we are adding an IRQ safe device to non-IRQ safe domain *=
/
+	if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
+		dev_warn_once(dev, "PM domain %s will not be powered off\n",
+				genpd->name);
+
 	genpd_lock(genpd);
=20
 	if (genpd->prepared_count > 0) {
@@ -1211,6 +1275,17 @@ int pm_genpd_add_subdomain(struct generic_pm_dom=
ain *genpd,
 	    || genpd =3D=3D subdomain)
 		return -EINVAL;
=20
+	/*
+	 * If the domain can be powered on/off in an IRQ safe
+	 * context, ensure that the subdomain can also be
+	 * powered on/off in that context.
+	 */
+	if (!genpd_is_irq_safe(genpd) && genpd_is_irq_safe(subdomain)) {
+		WARN("Parent %s of subdomain %s must be IRQ safe\n",
+				genpd->name, subdomain->name);
+		return -EINVAL;
+	}
+
 	link =3D kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
@@ -1375,6 +1450,17 @@ static int genpd_of_parse(struct generic_pm_doma=
in *genpd)
 	return pm_genpd_of_parse_power_states(genpd);
 }
=20
+static void genpd_lock_init(struct generic_pm_domain *genpd)
+{
+	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
+		spin_lock_init(&genpd->slock);
+		genpd->lock_fns =3D &genpd_spin_fns;
+	} else {
+		mutex_init(&genpd->mlock);
+		genpd->lock_fns =3D &genpd_mtx_fns;
+	}
+}
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1394,8 +1480,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd=
,
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
-	mutex_init(&genpd->mlock);
-	genpd->lock_fns =3D &genpd_mtx_fns;
+	genpd_lock_init(genpd);
 	genpd->gov =3D gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
@@ -1839,7 +1924,9 @@ static int pm_genpd_summary_one(struct seq_file *=
s,
 	}
=20
 	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
-		kobj_path =3D kobject_get_path(&pm_data->dev->kobj, GFP_KERNEL);
+		kobj_path =3D kobject_get_path(&pm_data->dev->kobj,
+				genpd_is_irq_safe(genpd) ?
+				GFP_ATOMIC : GFP_KERNEL);
 		if (kobj_path =3D=3D NULL)
 			continue;
=20
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 466d787..9964de7 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -15,9 +15,11 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/notifier.h>
+#include <linux/spinlock.h>
=20
 /* Defines used for the flags field in the struct generic_pm_domain */
 #define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
+#define GENPD_FLAG_IRQ_SAFE	(1U << 1) /* PM domain operates in atomic =
*/
=20
 #define GENPD_MAX_NUM_STATES	8 /* Number of possible low power states =
*/
=20
@@ -76,7 +78,13 @@ struct generic_pm_domain {
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
 	const struct genpd_lock_fns *lock_fns;
-	struct mutex mlock;
+	union {
+		struct mutex mlock;
+		struct {
+			spinlock_t slock;
+			unsigned long lock_flags;
+		};
+	};
=20
 };
=20
--=20
2.7.4
