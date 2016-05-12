From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 2/2] PM / Domains: Remove redundant wrapper functions for system PM
Date: Thu, 12 May 2016 16:11:25 +0200
Message-ID: <1463062285-3213-3-git-send-email-ulf.hansson@linaro.org>
References: <1463062285-3213-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34671 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbcELOLl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2016 10:11:41 -0400
Received: by mail-lf0-f46.google.com with SMTP id m64so72390366lfd.1
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2016 07:11:40 -0700 (PDT)
In-Reply-To: <1463062285-3213-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Alex Deucher <alexander.deucher@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, dri-devel@lists.freedesktop.org, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>

Due to the previous changes to genpd, which removed the suspend_power_off
flag, several of the system PM callbacks is no longer doing any additional
checks but only invoking a corresponding pm_generic_* helper function.

To clean up the code let's remove these wrapper functions as they have
become redundant. Instead assign the system PM callbacks directly to
the pm_generic_*() helper function.

While changing this, it became clear that some of the current system PM
callbacks in genpd, invokes the wrong callback at the driver level. For
example, genpd's ->restore() callback invokes pm_generic_resume(), while
it should be pm_generic_restore(). Let's fix this as well.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

Changes in v2:
        - Updated changelog.

---
 drivers/base/power/domain.c | 203 +++-----------------------------------------
 1 file changed, 12 insertions(+), 191 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a608f52..658eb1b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -768,48 +768,6 @@ static int pm_genpd_prepare(struct device *dev)
 }
 
 /**
- * pm_genpd_suspend - Suspend a device belonging to an I/O PM domain.
- * @dev: Device to suspend.
- *
- * Suspend a device under the assumption that its pm_domain field points to the
- * domain member of an object of type struct generic_pm_domain representing
- * a PM domain consisting of I/O devices.
- */
-static int pm_genpd_suspend(struct device *dev)
-{
-	struct generic_pm_domain *genpd;
-
-	dev_dbg(dev, "%s()\n", __func__);
-
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	return pm_generic_suspend(dev);
-}
-
-/**
- * pm_genpd_suspend_late - Late suspend of a device from an I/O PM domain.
- * @dev: Device to suspend.
- *
- * Carry out a late suspend of a device under the assumption that its
- * pm_domain field points to the domain member of an object of type
- * struct generic_pm_domain representing a PM domain consisting of I/O devices.
- */
-static int pm_genpd_suspend_late(struct device *dev)
-{
-	struct generic_pm_domain *genpd;
-
-	dev_dbg(dev, "%s()\n", __func__);
-
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	return pm_generic_suspend_late(dev);
-}
-
-/**
  * pm_genpd_suspend_noirq - Completion of suspend of device in an I/O PM domain.
  * @dev: Device to suspend.
  *
@@ -873,92 +831,6 @@ static int pm_genpd_resume_noirq(struct device *dev)
 }
 
 /**
- * pm_genpd_resume_early - Early resume of a device in an I/O PM domain.
- * @dev: Device to resume.
- *
- * Carry out an early resume of a device under the assumption that its
- * pm_domain field points to the domain member of an object of type
- * struct generic_pm_domain representing a power domain consisting of I/O
- * devices.
- */
-static int pm_genpd_resume_early(struct device *dev)
-{
-	struct generic_pm_domain *genpd;
-
-	dev_dbg(dev, "%s()\n", __func__);
-
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	return pm_generic_resume_early(dev);
-}
-
-/**
- * pm_genpd_resume - Resume of device in an I/O PM domain.
- * @dev: Device to resume.
- *
- * Resume a device under the assumption that its pm_domain field points to the
- * domain member of an object of type struct generic_pm_domain representing
- * a power domain consisting of I/O devices.
- */
-static int pm_genpd_resume(struct device *dev)
-{
-	struct generic_pm_domain *genpd;
-
-	dev_dbg(dev, "%s()\n", __func__);
-
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	return pm_generic_resume(dev);
-}
-
-/**
- * pm_genpd_freeze - Freezing a device in an I/O PM domain.
- * @dev: Device to freeze.
- *
- * Freeze a device under the assumption that its pm_domain field points to the
- * domain member of an object of type struct generic_pm_domain representing
- * a power domain consisting of I/O devices.
- */
-static int pm_genpd_freeze(struct device *dev)
-{
-	struct generic_pm_domain *genpd;
-
-	dev_dbg(dev, "%s()\n", __func__);
-
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	return pm_generic_freeze(dev);
-}
-
-/**
- * pm_genpd_freeze_late - Late freeze of a device in an I/O PM domain.
- * @dev: Device to freeze.
- *
- * Carry out a late freeze of a device under the assumption that its
- * pm_domain field points to the domain member of an object of type
- * struct generic_pm_domain representing a power domain consisting of I/O
- * devices.
- */
-static int pm_genpd_freeze_late(struct device *dev)
-{
-	struct generic_pm_domain *genpd;
-
-	dev_dbg(dev, "%s()\n", __func__);
-
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	return pm_generic_freeze_late(dev);
-}
-
-/**
  * pm_genpd_freeze_noirq - Completion of freezing a device in an I/O PM domain.
  * @dev: Device to freeze.
  *
@@ -1001,49 +873,6 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 }
 
 /**
- * pm_genpd_thaw_early - Early thaw of device in an I/O PM domain.
- * @dev: Device to thaw.
- *
- * Carry out an early thaw of a device under the assumption that its
- * pm_domain field points to the domain member of an object of type
- * struct generic_pm_domain representing a power domain consisting of I/O
- * devices.
- */
-static int pm_genpd_thaw_early(struct device *dev)
-{
-	struct generic_pm_domain *genpd;
-
-	dev_dbg(dev, "%s()\n", __func__);
-
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	return pm_generic_thaw_early(dev);
-}
-
-/**
- * pm_genpd_thaw - Thaw a device belonging to an I/O power domain.
- * @dev: Device to thaw.
- *
- * Thaw a device under the assumption that its pm_domain field points to the
- * domain member of an object of type struct generic_pm_domain representing
- * a power domain consisting of I/O devices.
- */
-static int pm_genpd_thaw(struct device *dev)
-{
-	struct generic_pm_domain *genpd;
-
-	dev_dbg(dev, "%s()\n", __func__);
-
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	return pm_generic_thaw(dev);
-}
-
-/**
  * pm_genpd_restore_noirq - Start of restore of device in an I/O PM domain.
  * @dev: Device to resume.
  *
@@ -1151,18 +980,10 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 #else /* !CONFIG_PM_SLEEP */
 
 #define pm_genpd_prepare		NULL
-#define pm_genpd_suspend		NULL
-#define pm_genpd_suspend_late		NULL
 #define pm_genpd_suspend_noirq		NULL
-#define pm_genpd_resume_early		NULL
 #define pm_genpd_resume_noirq		NULL
-#define pm_genpd_resume			NULL
-#define pm_genpd_freeze			NULL
-#define pm_genpd_freeze_late		NULL
 #define pm_genpd_freeze_noirq		NULL
-#define pm_genpd_thaw_early		NULL
 #define pm_genpd_thaw_noirq		NULL
-#define pm_genpd_thaw			NULL
 #define pm_genpd_restore_noirq		NULL
 #define pm_genpd_complete		NULL
 
@@ -1454,24 +1275,24 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = genpd_runtime_resume;
 	genpd->domain.ops.prepare = pm_genpd_prepare;
-	genpd->domain.ops.suspend = pm_genpd_suspend;
-	genpd->domain.ops.suspend_late = pm_genpd_suspend_late;
+	genpd->domain.ops.suspend = pm_generic_suspend;
+	genpd->domain.ops.suspend_late = pm_generic_suspend_late;
 	genpd->domain.ops.suspend_noirq = pm_genpd_suspend_noirq;
 	genpd->domain.ops.resume_noirq = pm_genpd_resume_noirq;
-	genpd->domain.ops.resume_early = pm_genpd_resume_early;
-	genpd->domain.ops.resume = pm_genpd_resume;
-	genpd->domain.ops.freeze = pm_genpd_freeze;
-	genpd->domain.ops.freeze_late = pm_genpd_freeze_late;
+	genpd->domain.ops.resume_early = pm_generic_resume_early;
+	genpd->domain.ops.resume = pm_generic_resume;
+	genpd->domain.ops.freeze = pm_generic_freeze;
+	genpd->domain.ops.freeze_late = pm_generic_freeze_late;
 	genpd->domain.ops.freeze_noirq = pm_genpd_freeze_noirq;
 	genpd->domain.ops.thaw_noirq = pm_genpd_thaw_noirq;
-	genpd->domain.ops.thaw_early = pm_genpd_thaw_early;
-	genpd->domain.ops.thaw = pm_genpd_thaw;
-	genpd->domain.ops.poweroff = pm_genpd_suspend;
-	genpd->domain.ops.poweroff_late = pm_genpd_suspend_late;
+	genpd->domain.ops.thaw_early = pm_generic_thaw_early;
+	genpd->domain.ops.thaw = pm_generic_thaw;
+	genpd->domain.ops.poweroff = pm_generic_poweroff;
+	genpd->domain.ops.poweroff_late = pm_generic_poweroff_late;
 	genpd->domain.ops.poweroff_noirq = pm_genpd_suspend_noirq;
 	genpd->domain.ops.restore_noirq = pm_genpd_restore_noirq;
-	genpd->domain.ops.restore_early = pm_genpd_resume_early;
-	genpd->domain.ops.restore = pm_genpd_resume;
+	genpd->domain.ops.restore_early = pm_generic_restore_early;
+	genpd->domain.ops.restore = pm_generic_restore;
 	genpd->domain.ops.complete = pm_genpd_complete;
 
 	if (genpd->flags & GENPD_FLAG_PM_CLK) {
-- 
1.9.1

