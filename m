From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v2 01/12] PM / Domains: Abstract genpd locking
Date: Fri, 12 Feb 2016 13:50:27 -0700
Message-ID: <1455310238-8963-2-git-send-email-lina.iyer@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

Abstract genpd lock/unlock calls, in preparation for domain specific
locks added in the following patches.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
Changes since RFC v1 -
- split into two patches. This patch abstracts genpd locking
- uses function pointer, instead of runtime function determination

 drivers/base/power/domain.c | 109 ++++++++++++++++++++++++++++++------=
--------
 include/linux/pm_domain.h   |   5 +-
 2 files changed, 79 insertions(+), 35 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3ddd05d..8204615 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -40,6 +40,46 @@
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
=20
+struct genpd_lock_fns {
+	void (*lock)(struct generic_pm_domain *genpd);
+	void (*lock_nested)(struct generic_pm_domain *genpd, int depth);
+	int (*lock_interruptible)(struct generic_pm_domain *genpd);
+	void (*unlock)(struct generic_pm_domain *genpd);
+};
+
+static void genpd_lock_irq(struct generic_pm_domain *genpd)
+{
+	mutex_lock(&genpd->mlock);
+}
+
+static void genpd_lock_irq_nested(struct generic_pm_domain *genpd,
+					int depth)
+{
+	mutex_lock_nested(&genpd->mlock, depth);
+}
+
+static int genpd_lock_interruptible_irq(struct generic_pm_domain *genp=
d)
+{
+	return mutex_lock_interruptible(&genpd->mlock);
+}
+
+static void genpd_unlock_irq(struct generic_pm_domain *genpd)
+{
+	return mutex_unlock(&genpd->mlock);
+}
+
+static struct genpd_lock_fns irq_lock =3D {
+	.lock =3D genpd_lock_irq,
+	.lock_nested =3D genpd_lock_irq_nested,
+	.lock_interruptible =3D genpd_lock_interruptible_irq,
+	.unlock =3D genpd_unlock_irq,
+};
+
+#define genpd_lock(p)			p->lock_fns->lock(p)
+#define genpd_lock_nested(p, d)		p->lock_fns->lock_nested(p, d)
+#define genpd_lock_interruptible(p)	p->lock_fns->lock_interruptible(p)
+#define genpd_unlock(p)			p->lock_fns->unlock(p)
+
 /*
  * Get the generic PM domain for a particular struct device.
  * This validates the struct device pointer, the PM domain pointer,
@@ -202,9 +242,9 @@ static int genpd_poweron(struct generic_pm_domain *=
genpd, unsigned int depth)
=20
 		genpd_sd_counter_inc(master);
=20
-		mutex_lock_nested(&master->lock, depth + 1);
+		genpd_lock_nested(master, depth + 1);
 		ret =3D genpd_poweron(master, depth + 1);
-		mutex_unlock(&master->lock);
+		genpd_unlock(master);
=20
 		if (ret) {
 			genpd_sd_counter_dec(master);
@@ -268,9 +308,9 @@ static int genpd_dev_pm_qos_notifier(struct notifie=
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
@@ -367,9 +407,9 @@ static void genpd_power_off_work_fn(struct work_str=
uct *work)
=20
 	genpd =3D container_of(work, struct generic_pm_domain, power_off_work=
);
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	genpd_poweroff(genpd, true);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 }
=20
 /**
@@ -439,9 +479,9 @@ static int pm_genpd_runtime_suspend(struct device *=
dev)
 	if (dev->power.irq_safe)
 		return 0;
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	genpd_poweroff(genpd, false);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	return 0;
 }
@@ -476,9 +516,9 @@ static int pm_genpd_runtime_resume(struct device *d=
ev)
 		goto out;
 	}
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	ret =3D genpd_poweron(genpd, 0);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	if (ret)
 		return ret;
@@ -692,14 +732,14 @@ static int pm_genpd_prepare(struct device *dev)
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
@@ -717,12 +757,12 @@ static int pm_genpd_prepare(struct device *dev)
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
@@ -1080,13 +1120,13 @@ static void pm_genpd_complete(struct device *de=
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
@@ -1260,7 +1300,7 @@ int __pm_genpd_add_device(struct generic_pm_domai=
n *genpd, struct device *dev,
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	if (genpd->prepared_count > 0) {
 		ret =3D -EAGAIN;
@@ -1277,7 +1317,7 @@ int __pm_genpd_add_device(struct generic_pm_domai=
n *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
=20
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1310,7 +1350,7 @@ int pm_genpd_remove_device(struct generic_pm_doma=
in *genpd,
 	gpd_data =3D to_gpd_data(pdd);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	if (genpd->prepared_count > 0) {
 		ret =3D -EAGAIN;
@@ -1325,14 +1365,14 @@ int pm_genpd_remove_device(struct generic_pm_do=
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
@@ -1358,8 +1398,8 @@ int pm_genpd_add_subdomain(struct generic_pm_doma=
in *genpd,
 	if (!link)
 		return -ENOMEM;
=20
-	mutex_lock(&subdomain->lock);
-	mutex_lock_nested(&genpd->lock, SINGLE_DEPTH_NESTING);
+	genpd_lock(subdomain);
+	genpd_lock_nested(genpd, SINGLE_DEPTH_NESTING);
=20
 	if (genpd->status =3D=3D GPD_STATE_POWER_OFF
 	    &&  subdomain->status !=3D GPD_STATE_POWER_OFF) {
@@ -1382,8 +1422,8 @@ int pm_genpd_add_subdomain(struct generic_pm_doma=
in *genpd,
 		genpd_sd_counter_inc(genpd);
=20
  out:
-	mutex_unlock(&genpd->lock);
-	mutex_unlock(&subdomain->lock);
+	genpd_unlock(genpd);
+	genpd_unlock(subdomain);
 	if (ret)
 		kfree(link);
 	return ret;
@@ -1404,8 +1444,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_d=
omain *genpd,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
 		return -EINVAL;
=20
-	mutex_lock(&subdomain->lock);
-	mutex_lock_nested(&genpd->lock, SINGLE_DEPTH_NESTING);
+	genpd_lock(subdomain);
+	genpd_lock_nested(genpd, SINGLE_DEPTH_NESTING);
=20
 	if (!list_empty(&subdomain->slave_links) || subdomain->device_count) =
{
 		pr_warn("%s: unable to remove subdomain %s\n", genpd->name,
@@ -1429,8 +1469,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_d=
omain *genpd,
 	}
=20
 out:
-	mutex_unlock(&genpd->lock);
-	mutex_unlock(&subdomain->lock);
+	genpd_unlock(genpd);
+	genpd_unlock(subdomain);
=20
 	return ret;
 }
@@ -1595,7 +1635,8 @@ void pm_genpd_init(struct generic_pm_domain *genp=
d,
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
-	mutex_init(&genpd->lock);
+	mutex_init(&genpd->mlock);
+	genpd->lock_fns =3D &irq_lock;
 	genpd->gov =3D gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
@@ -1952,9 +1993,9 @@ int genpd_dev_pm_attach(struct device *dev)
 	dev->pm_domain->detach =3D genpd_dev_pm_detach;
 	dev->pm_domain->sync =3D genpd_dev_pm_sync;
=20
-	mutex_lock(&pd->lock);
+	genpd_lock(pd);
 	ret =3D genpd_poweron(pd, 0);
-	mutex_unlock(&pd->lock);
+	genpd_unlock(pd);
 out:
 	return ret ? -EPROBE_DEFER : 0;
 }
@@ -2011,7 +2052,7 @@ static int pm_genpd_summary_one(struct seq_file *=
s,
 	struct gpd_link *link;
 	int ret;
=20
-	ret =3D mutex_lock_interruptible(&genpd->lock);
+	ret =3D genpd_lock_interruptible(genpd);
 	if (ret)
 		return -ERESTARTSYS;
=20
@@ -2047,7 +2088,7 @@ static int pm_genpd_summary_one(struct seq_file *=
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
index 376d7fa..ec5523c 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -44,13 +44,14 @@ struct genpd_power_state {
 	u32 param;
 };
=20
+struct genpd_lock_fns;
+
 struct generic_pm_domain {
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list=
 */
 	struct list_head master_links;	/* Links with PM domain as a master */
 	struct list_head slave_links;	/* Links with PM domain as a slave */
 	struct list_head dev_list;	/* List of devices */
-	struct mutex lock;
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
 	const char *name;
@@ -74,6 +75,8 @@ struct generic_pm_domain {
 	struct genpd_power_state *states;
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
+	struct genpd_lock_fns *lock_fns;
+	struct mutex mlock;
=20
 };
=20
--=20
2.1.4
