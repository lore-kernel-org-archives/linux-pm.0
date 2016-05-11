From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 1/2] PM / Domains: Allow genpd to power on during the system PM phase
Date: Wed, 11 May 2016 10:00:09 +0200
Message-ID: <1462953610-20824-2-git-send-email-ulf.hansson@linaro.org>
References: <1462953610-20824-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34228 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbcEKIAk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2016 04:00:40 -0400
Received: by mail-lf0-f44.google.com with SMTP id m64so40521722lfd.1
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2016 01:00:39 -0700 (PDT)
In-Reply-To: <1462953610-20824-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Alex Deucher <alexander.deucher@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, dri-devel@lists.freedesktop.org, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>

If the PM domain is powered off when the first device in the domain sta=
rts
its system PM prepare phase, genpd prevents any further attempts to pow=
er
on the PM domain during the system PM phase. This constraint affects no=
t
only the current device which is being prepared, but all devices within
the same PM domain.

This behaviour needs to be changed, as a subsystem/driver for a device =
in
the same PM domain may still need to be able to serve requests in the
system PM phase. Accordingly, it may need to runtime resume its device =
and
thus also request the corresponding PM domain to be powered on.

To deal with these scenarios, let's make the device operational in the
system PM prepare phase by runtime resuming it, no matter if the PM dom=
ain
is powered on or off. Changing this also enables us to remove genpd's
suspend_power_off flag, as it's being used to track this condition.
Additionally, we must allow the PM domain to be powered on via runtime =
PM
during the system PM phase.

This change also requires a fix in the AMD ACP (Audio CoProcessor) drm
driver. It registers a genpd to model the ACP as a PM domain, but
unfortunately it's also abuses genpd's "internal" suspend_power_off fla=
g
to deal with a corner case at system PM resume.

More precisely, the so called SMU block powers on the ACP at system PM
resume, unconditionally if it's being used or not. This may lead to tha=
t
genpd's internal status of the power state, may not correctly reflect t=
he
power state of the HW after a system PM resume.

Because of changing the behaviour of genpd, by runtime resuming devices=
 in
the prepare phase, the AMD ACP drm driver no longer have to deal with t=
his
corner case. So let's just drop the related code in this driver.

Cc: David Airlie <airlied@linux.ie>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Updated changelog.
	- Added a fix in the AMD ACP (Audio CoProcessor) drm driver, which
	registers a genpd. The fix removes the usage of genpd's internal
	suspend_power_off flag as it's not needed after this change. Because o=
f
	this change I am also requesting an ack from the drm driver maintainer=
=2E

---
 drivers/base/power/domain.c             | 84 ++++++++++++-------------=
--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 23 ---------
 include/linux/pm_domain.h               |  1 -
 3 files changed, 31 insertions(+), 77 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index de23b64..a608f52 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -187,8 +187,7 @@ static int genpd_poweron(struct generic_pm_domain *=
genpd, unsigned int depth)
 	struct gpd_link *link;
 	int ret =3D 0;
=20
-	if (genpd->status =3D=3D GPD_STATE_ACTIVE
-	    || (genpd->prepared_count > 0 && genpd->suspend_power_off))
+	if (genpd->status =3D=3D GPD_STATE_ACTIVE)
 		return 0;
=20
 	/*
@@ -735,21 +734,22 @@ static int pm_genpd_prepare(struct device *dev)
=20
 	mutex_lock(&genpd->lock);
=20
-	if (genpd->prepared_count++ =3D=3D 0) {
+	if (genpd->prepared_count++ =3D=3D 0)
 		genpd->suspended_count =3D 0;
-		genpd->suspend_power_off =3D genpd->status =3D=3D GPD_STATE_POWER_OF=
=46;
-	}
=20
 	mutex_unlock(&genpd->lock);
=20
-	if (genpd->suspend_power_off)
-		return 0;
-
 	/*
-	 * The PM domain must be in the GPD_STATE_ACTIVE state at this point,
-	 * so genpd_poweron() will return immediately, but if the device
-	 * is suspended (e.g. it's been stopped by genpd_stop_dev()), we need
-	 * to make it operational.
+	 * Even if the PM domain is powered off at this point, we can't expec=
t
+	 * it to remain in that state during the entire system PM suspend
+	 * phase. Any subsystem/driver for a device in the PM domain, may sti=
ll
+	 * need to serve a request which may require the device to be runtime
+	 * resumed and its PM domain to be powered.
+	 *
+	 * As we are disabling runtime PM at this point, we are preventing th=
e
+	 * subsystem/driver to decide themselves. For that reason, we need to
+	 * make sure the device is operational as it may be required in some
+	 * cases.
 	 */
 	pm_runtime_resume(dev);
 	__pm_runtime_disable(dev, false);
@@ -758,8 +758,7 @@ static int pm_genpd_prepare(struct device *dev)
 	if (ret) {
 		mutex_lock(&genpd->lock);
=20
-		if (--genpd->prepared_count =3D=3D 0)
-			genpd->suspend_power_off =3D false;
+		genpd->prepared_count--;
=20
 		mutex_unlock(&genpd->lock);
 		pm_runtime_enable(dev);
@@ -786,7 +785,7 @@ static int pm_genpd_suspend(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	return genpd->suspend_power_off ? 0 : pm_generic_suspend(dev);
+	return pm_generic_suspend(dev);
 }
=20
 /**
@@ -807,7 +806,7 @@ static int pm_genpd_suspend_late(struct device *dev=
)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	return genpd->suspend_power_off ? 0 : pm_generic_suspend_late(dev);
+	return pm_generic_suspend_late(dev);
 }
=20
 /**
@@ -827,8 +826,7 @@ static int pm_genpd_suspend_noirq(struct device *de=
v)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	if (genpd->suspend_power_off
-	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)=
))
+	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
 		return 0;
=20
 	genpd_stop_dev(genpd, dev);
@@ -860,8 +858,7 @@ static int pm_genpd_resume_noirq(struct device *dev=
)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	if (genpd->suspend_power_off
-	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)=
))
+	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
 		return 0;
=20
 	/*
@@ -894,7 +891,7 @@ static int pm_genpd_resume_early(struct device *dev=
)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	return genpd->suspend_power_off ? 0 : pm_generic_resume_early(dev);
+	return pm_generic_resume_early(dev);
 }
=20
 /**
@@ -915,7 +912,7 @@ static int pm_genpd_resume(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	return genpd->suspend_power_off ? 0 : pm_generic_resume(dev);
+	return pm_generic_resume(dev);
 }
=20
 /**
@@ -936,7 +933,7 @@ static int pm_genpd_freeze(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	return genpd->suspend_power_off ? 0 : pm_generic_freeze(dev);
+	return pm_generic_freeze(dev);
 }
=20
 /**
@@ -958,7 +955,7 @@ static int pm_genpd_freeze_late(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	return genpd->suspend_power_off ? 0 : pm_generic_freeze_late(dev);
+	return pm_generic_freeze_late(dev);
 }
=20
 /**
@@ -980,7 +977,7 @@ static int pm_genpd_freeze_noirq(struct device *dev=
)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	return genpd->suspend_power_off ? 0 : genpd_stop_dev(genpd, dev);
+	return genpd_stop_dev(genpd, dev);
 }
=20
 /**
@@ -1000,8 +997,7 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	return genpd->suspend_power_off ?
-		0 : genpd_start_dev(genpd, dev);
+	return genpd_start_dev(genpd, dev);
 }
=20
 /**
@@ -1023,7 +1019,7 @@ static int pm_genpd_thaw_early(struct device *dev=
)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	return genpd->suspend_power_off ? 0 : pm_generic_thaw_early(dev);
+	return pm_generic_thaw_early(dev);
 }
=20
 /**
@@ -1044,7 +1040,7 @@ static int pm_genpd_thaw(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	return genpd->suspend_power_off ? 0 : pm_generic_thaw(dev);
+	return pm_generic_thaw(dev);
 }
=20
 /**
@@ -1072,26 +1068,13 @@ static int pm_genpd_restore_noirq(struct device=
 *dev)
 	 * At this point suspended_count =3D=3D 0 means we are being run for =
the
 	 * first time for the given domain in the present cycle.
 	 */
-	if (genpd->suspended_count++ =3D=3D 0) {
+	if (genpd->suspended_count++ =3D=3D 0)
 		/*
 		 * The boot kernel might put the domain into arbitrary state,
 		 * so make it appear as powered off to pm_genpd_sync_poweron(),
 		 * so that it tries to power it on in case it was really off.
 		 */
 		genpd->status =3D GPD_STATE_POWER_OFF;
-		if (genpd->suspend_power_off) {
-			/*
-			 * If the domain was off before the hibernation, make
-			 * sure it will be off going forward.
-			 */
-			genpd_power_off(genpd, true);
-
-			return 0;
-		}
-	}
-
-	if (genpd->suspend_power_off)
-		return 0;
=20
 	pm_genpd_sync_poweron(genpd, true);
=20
@@ -1110,7 +1093,6 @@ static int pm_genpd_restore_noirq(struct device *=
dev)
 static void pm_genpd_complete(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	bool run_complete;
=20
 	dev_dbg(dev, "%s()\n", __func__);
=20
@@ -1120,18 +1102,14 @@ static void pm_genpd_complete(struct device *de=
v)
=20
 	mutex_lock(&genpd->lock);
=20
-	run_complete =3D !genpd->suspend_power_off;
-	if (--genpd->prepared_count =3D=3D 0)
-		genpd->suspend_power_off =3D false;
+	genpd->prepared_count--;
=20
 	mutex_unlock(&genpd->lock);
=20
-	if (run_complete) {
-		pm_generic_complete(dev);
-		pm_runtime_set_active(dev);
-		pm_runtime_enable(dev);
-		pm_request_idle(dev);
-	}
+	pm_generic_complete(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_request_idle(dev);
 }
=20
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_acp.c
index b7b583c..a905f1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -421,29 +421,6 @@ static int acp_suspend(void *handle)
=20
 static int acp_resume(void *handle)
 {
-	int i, ret;
-	struct acp_pm_domain *apd;
-	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
-
-	/* return early if no ACP */
-	if (!adev->acp.acp_genpd)
-		return 0;
-
-	/* SMU block will power on ACP irrespective of ACP runtime status.
-	 * Power off explicitly based on genpd ACP runtime status so that ACP
-	 * hw and ACP-genpd status are in sync.
-	 * 'suspend_power_off' represents "Power status before system suspend=
"
-	*/
-	if (adev->acp.acp_genpd->gpd.suspend_power_off =3D=3D true) {
-		apd =3D container_of(&adev->acp.acp_genpd->gpd,
-					struct acp_pm_domain, gpd);
-
-		for (i =3D 4; i >=3D 0 ; i--) {
-			ret =3D acp_suspend_tile(apd->cgs_dev, ACP_TILE_P1 + i);
-			if (ret)
-				pr_err("ACP tile %d tile suspend failed\n", i);
-		}
-	}
 	return 0;
 }
=20
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 39285c7..dd5b044 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -57,7 +57,6 @@ struct generic_pm_domain {
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices *=
/
-	bool suspend_power_off;	/* Power status before system suspend */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct gpd_dev_ops dev_ops;
--=20
1.9.1

