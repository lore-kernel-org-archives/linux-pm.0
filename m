From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] drm / exynos / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Wed, 03 Dec 2014 02:53:44 +0100
Message-ID: <19437813.I83iiGloeA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: Jingoo Han <jg1.han@samsung.com>, Inki Dae <inki.dae@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@linux.ie>, Kukjin Kim <kgene.kim@samsung.com>, dri-devel@lists.freedesktop.org, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
depending on CONFIG_PM_RUNTIME may now be changed to depend on
CONFIG_PM.

Replace CONFIG_PM_RUNTIME with CONFIG_PM in 4 files under
gpu/drm/exynos/.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
PM_SLEEP is selected) which is only in linux-next at the moment (via the
linux-pm tree).

Please let me know if it is OK to take this one into linux-pm.

---
 drivers/gpu/drm/exynos/exynos_drm_fimc.c    |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c     |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c     |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/gpu/drm/exynos/exynos_drm_fimc.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ linux-pm/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -1817,7 +1817,7 @@ static int fimc_resume(struct device *de
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int fimc_runtime_suspend(struct device *dev)
 {
 	struct fimc_context *ctx = get_fimc_context(dev);
Index: linux-pm/drivers/gpu/drm/exynos/exynos_drm_gsc.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ linux-pm/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1764,7 +1764,7 @@ static int gsc_resume(struct device *dev
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int gsc_runtime_suspend(struct device *dev)
 {
 	struct gsc_context *ctx = get_gsc_context(dev);
Index: linux-pm/drivers/gpu/drm/exynos/exynos_drm_rotator.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ linux-pm/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -822,7 +822,7 @@ static int rotator_resume(struct device
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int rotator_runtime_suspend(struct device *dev)
 {
 	struct rot_context *rot = dev_get_drvdata(dev);
Index: linux-pm/drivers/gpu/drm/exynos/exynos_drm_g2d.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ linux-pm/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1540,7 +1540,7 @@ static int g2d_resume(struct device *dev
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int g2d_runtime_suspend(struct device *dev)
 {
 	struct g2d_data *g2d = dev_get_drvdata(dev);
