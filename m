From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 03/14] PM / Domains: Abstract genpd locking
Date: Fri, 29 Jul 2016 15:56:14 -0600
Message-ID: <1469829385-11511-4-git-send-email-lina.iyer@linaro.org>
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

Abstract genpd lock/unlock calls, in preparation for domain specific
locks added in the following patches.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[Ulf: Rebased as additional mutex_lock|unlock has been added]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 113 ++++++++++++++++++++++++++++++------=
--------
 include/linux/pm_domain.h   |   5 +-
 2 files changed, 81 insertions(+), 37 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d3f6f5a..88b6f95 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -39,6 +39,46 @@
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
+static void genpd_lock_mtx(struct generic_pm_domain *genpd)
+{
+	mutex_lock(&genpd->mlock);
+}
+
+static void genpd_lock_nested_mtx(struct generic_pm_domain *genpd,
+					int depth)
+{
+	mutex_lock_nested(&genpd->mlock, depth);
+}
+
+static int genpd_lock_interruptible_mtx(struct generic_pm_domain *genp=
d)
+{
+	return mutex_lock_interruptible(&genpd->mlock);
+}
+
+static void genpd_unlock_mtx(struct generic_pm_domain *genpd)
+{
+	return mutex_unlock(&genpd->mlock);
+}
+
+static const struct genpd_lock_fns genpd_mtx_fns  =3D {
+	.lock =3D genpd_lock_mtx,
+	.lock_nested =3D genpd_lock_nested_mtx,
+	.lock_interruptible =3D genpd_lock_interruptible_mtx,
+	.unlock =3D genpd_unlock_mtx,
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
@@ -200,9 +240,9 @@ static int genpd_poweron(struct generic_pm_domain *=
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
@@ -255,9 +295,9 @@ static int genpd_dev_pm_qos_notifier(struct notifie=
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
@@ -354,9 +394,9 @@ static void genpd_power_off_work_fn(struct work_str=
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
@@ -472,9 +512,9 @@ static int genpd_runtime_suspend(struct device *dev=
)
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
@@ -509,9 +549,9 @@ static int genpd_runtime_resume(struct device *dev)
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
@@ -547,9 +587,9 @@ err_stop:
 	genpd_stop_dev(genpd, dev);
 err_poweroff:
 	if (!dev->power.irq_safe) {
-		mutex_lock(&genpd->lock);
+		genpd_lock(genpd);
 		genpd_poweroff(genpd, 0);
-		mutex_unlock(&genpd->lock);
+		genpd_unlock(genpd);
 	}
=20
 	return ret;
@@ -732,20 +772,20 @@ static int pm_genpd_prepare(struct device *dev)
 	if (resume_needed(dev, genpd))
 		pm_runtime_resume(dev);
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	if (genpd->prepared_count++ =3D=3D 0)
 		genpd->suspended_count =3D 0;
=20
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	ret =3D pm_generic_prepare(dev);
 	if (ret) {
-		mutex_lock(&genpd->lock);
+		genpd_lock(genpd);
=20
 		genpd->prepared_count--;
=20
-		mutex_unlock(&genpd->lock);
+		genpd_unlock(genpd);
 	}
=20
 	return ret;
@@ -936,13 +976,13 @@ static void pm_genpd_complete(struct device *dev)
=20
 	pm_generic_complete(dev);
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	genpd->prepared_count--;
 	if (!genpd->prepared_count)
 		genpd_queue_power_off_work(genpd);
=20
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 }
=20
 /**
@@ -1077,7 +1117,7 @@ int __pm_genpd_add_device(struct generic_pm_domai=
n *genpd, struct device *dev,
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	if (genpd->prepared_count > 0) {
 		ret =3D -EAGAIN;
@@ -1094,7 +1134,7 @@ int __pm_genpd_add_device(struct generic_pm_domai=
n *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
=20
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
=20
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1127,7 +1167,7 @@ int pm_genpd_remove_device(struct generic_pm_doma=
in *genpd,
 	gpd_data =3D to_gpd_data(pdd);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
=20
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
=20
 	if (genpd->prepared_count > 0) {
 		ret =3D -EAGAIN;
@@ -1142,14 +1182,14 @@ int pm_genpd_remove_device(struct generic_pm_do=
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
@@ -1175,8 +1215,8 @@ int pm_genpd_add_subdomain(struct generic_pm_doma=
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
@@ -1199,8 +1239,8 @@ int pm_genpd_add_subdomain(struct generic_pm_doma=
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
@@ -1221,8 +1261,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_d=
omain *genpd,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
 		return -EINVAL;
=20
-	mutex_lock(&subdomain->lock);
-	mutex_lock_nested(&genpd->lock, SINGLE_DEPTH_NESTING);
+	genpd_lock(subdomain);
+	genpd_lock_nested(genpd, SINGLE_DEPTH_NESTING);
=20
 	if (!list_empty(&subdomain->master_links) || subdomain->device_count)=
 {
 		pr_warn("%s: unable to remove subdomain %s\n", genpd->name,
@@ -1246,8 +1286,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_d=
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
@@ -1354,7 +1394,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd=
,
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
-	mutex_init(&genpd->lock);
+	mutex_init(&genpd->mlock);
+	genpd->lock_fns =3D &genpd_mtx_fns;
 	genpd->gov =3D gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
@@ -1712,9 +1753,9 @@ int genpd_dev_pm_attach(struct device *dev)
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
@@ -1772,7 +1813,7 @@ static int pm_genpd_summary_one(struct seq_file *=
s,
 	char state[16];
 	int ret;
=20
-	ret =3D mutex_lock_interruptible(&genpd->lock);
+	ret =3D genpd_lock_interruptible(genpd);
 	if (ret)
 		return -ERESTARTSYS;
=20
@@ -1809,7 +1850,7 @@ static int pm_genpd_summary_one(struct seq_file *=
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
index 3ad5914..466d787 100644
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
 	struct device_node *of_node;	/* Device node of the PM domain */
@@ -74,6 +75,8 @@ struct generic_pm_domain {
 	struct genpd_power_state states[GENPD_MAX_NUM_STATES];
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
+	const struct genpd_lock_fns *lock_fns;
+	struct mutex mlock;
=20
 };
=20
--=20
2.7.4
