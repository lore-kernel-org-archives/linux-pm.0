From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v2 02/12] PM / Domains: Support IRQ safe PM domains
Date: Fri, 12 Feb 2016 13:50:28 -0700
Message-ID: <1455310238-8963-3-git-send-email-lina.iyer@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32874 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbcBLUvT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 15:51:19 -0500
Received: by mail-pf0-f177.google.com with SMTP id q63so52947187pfb.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2016 12:51:18 -0800 (PST)
In-Reply-To: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>

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
have IRQ safe and non-IRQ safe domains and devices.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
Changes since RFC v1 -
- split off to into its own patch
- Removed restriction that IRQ-safe domains can only have IRQ safe pare=
nts

 Documentation/power/devices.txt |  11 +++-
 drivers/base/power/domain.c     | 112 ++++++++++++++++++++++++++++++++=
++++----
 include/linux/pm_domain.h       |  11 +++-
 3 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devi=
ces.txt
index 8ba6625..c06f0b6 100644
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
+hand, an IRQ safe PM domains that have IRQ safe devices may be powered=
 off
+when all the devices are in idle. An IRQ safe domain may only be attac=
hed as a
+subdomain to another IRQ safe domain.
=20
 Support for power domains is provided through the pm_domain field of s=
truct
 device.  This field is a pointer to an object of type struct dev_pm_do=
main,
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8204615..3c4f675 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -75,11 +75,59 @@ static struct genpd_lock_fns irq_lock =3D {
 	.unlock =3D genpd_unlock_irq,
 };
=20
+static void genpd_lock_nosleep(struct generic_pm_domain *genpd)
+	__acquires(&genpd->slock)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&genpd->slock, flags);
+	genpd->lock_flags =3D flags;
+}
+
+static void genpd_lock_nosleep_nested(struct generic_pm_domain *genpd,
+					int depth)
+	__acquires(&genpd->slock)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave_nested(&genpd->slock, flags, depth);
+	genpd->lock_flags =3D flags;
+}
+
+static int genpd_lock_nosleep_interruptible(struct generic_pm_domain *=
genpd)
+	__acquires(&genpd->slock)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&genpd->slock, flags);
+	genpd->lock_flags =3D flags;
+	return 0;
+}
+
+static void genpd_unlock_nosleep(struct generic_pm_domain *genpd)
+	__releases(&genpd->slock)
+{
+	spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
+}
+
+static struct genpd_lock_fns no_sleep_lock =3D {
+	.lock =3D genpd_lock_nosleep,
+	.lock_nested =3D genpd_lock_nosleep_nested,
+	.lock_interruptible =3D genpd_lock_nosleep_interruptible,
+	.unlock =3D genpd_unlock_nosleep,
+};
+
 #define genpd_lock(p)			p->lock_fns->lock(p)
 #define genpd_lock_nested(p, d)		p->lock_fns->lock_nested(p, d)
 #define genpd_lock_interruptible(p)	p->lock_fns->lock_interruptible(p)
 #define genpd_unlock(p)			p->lock_fns->unlock(p)
=20
+static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
+		struct generic_pm_domain *genpd)
+{
+	return dev->power.irq_safe && !genpd->irq_safe;
+}
+
 /*
  * Get the generic PM domain for a particular struct device.
  * This validates the struct device pointer, the PM domain pointer,
@@ -356,8 +404,17 @@ static int genpd_poweroff(struct generic_pm_domain=
 *genpd, bool is_async)
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
 	if (not_suspended > 1 || (not_suspended =3D=3D 1 && is_async))
@@ -473,10 +530,13 @@ static int pm_genpd_runtime_suspend(struct device=
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
 	genpd_lock(genpd);
@@ -510,8 +570,11 @@ static int pm_genpd_runtime_resume(struct device *=
dev)
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
@@ -1296,6 +1359,13 @@ int __pm_genpd_add_device(struct generic_pm_doma=
in *genpd, struct device *dev,
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
@@ -1394,6 +1464,17 @@ int pm_genpd_add_subdomain(struct generic_pm_dom=
ain *genpd,
 	    || genpd =3D=3D subdomain)
 		return -EINVAL;
=20
+	/*
+	 * If the domain can be powered on/off in an IRQ safe
+	 * context, ensure that the subdomain can also be
+	 * powered on/off in that context.
+	 */
+	if (!genpd->irq_safe && subdomain->irq_safe) {
+		WARN("Parent %s of subdomain %s must be IRQ-safe\n",
+				genpd->name, subdomain->name);
+		return -EINVAL;
+	}
+
 	link =3D kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
@@ -1610,6 +1691,19 @@ static int of_genpd_device_parse_states(struct d=
evice_node *np,
 	return 0;
 }
=20
+static void genpd_lock_init(struct generic_pm_domain *genpd)
+{
+	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
+		spin_lock_init(&genpd->slock);
+		genpd->irq_safe =3D true;
+		genpd->lock_fns =3D &no_sleep_lock;
+	} else {
+		mutex_init(&genpd->mlock);
+		genpd->irq_safe =3D false;
+		genpd->lock_fns =3D &irq_lock;
+	}
+}
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1635,8 +1729,7 @@ void pm_genpd_init(struct generic_pm_domain *genp=
d,
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
-	mutex_init(&genpd->mlock);
-	genpd->lock_fns =3D &irq_lock;
+	genpd_lock_init(genpd);
 	genpd->gov =3D gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
@@ -2077,7 +2170,8 @@ static int pm_genpd_summary_one(struct seq_file *=
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
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ec5523c..3f245d5 100644
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
 enum gpd_status {
 	GPD_STATE_ACTIVE =3D 0,	/* PM domain is active */
@@ -76,7 +78,14 @@ struct generic_pm_domain {
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
 	struct genpd_lock_fns *lock_fns;
-	struct mutex mlock;
+	bool irq_safe;
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
2.1.4

