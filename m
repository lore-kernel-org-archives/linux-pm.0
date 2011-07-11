From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 3/4] OMAP: PM: omap_device: add API to disable
	idle on suspend
Date: Mon, 11 Jul 2011 16:29:28 -0700
Message-ID: <1310426969-30306-4-git-send-email-khilman__10394.835464149$1310427047$gmane$org@ti.com>
References: <1310426969-30306-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1310426969-30306-1-git-send-email-khilman@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

By default, omap_devices will be automatically idled on suspend
(and re-enabled on resume.)  Using this new API, device init code
can disable this feature if desired.

NOTE: any driver/device that has been runtime PM converted should
      not be using this API.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    5 +++++
 arch/arm/plat-omap/omap_device.c              |    6 ++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index bc36d05..ee405b36 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -46,6 +46,7 @@ extern struct device omap_device_parent;
 
 /* omap_device.flags values */
 #define OMAP_DEVICE_SUSPENDED BIT(0)
+#define OMAP_DEVICE_NO_IDLE_ON_SUSPEND BIT(1)
 
 /**
  * struct omap_device - omap_device wrapper for platform_devices
@@ -121,6 +122,10 @@ int omap_device_enable_hwmods(struct omap_device *od);
 int omap_device_disable_clocks(struct omap_device *od);
 int omap_device_enable_clocks(struct omap_device *od);
 
+static inline void omap_device_disable_idle_on_suspend(struct omap_device *od)
+{
+	od->flags |= OMAP_DEVICE_NO_IDLE_ON_SUSPEND;
+}
 
 /*
  * Entries should be kept in latency order ascending
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index b93cfdc..2526fa3 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -573,6 +573,9 @@ static int _od_suspend_noirq(struct device *dev)
 	struct omap_device *od = to_omap_device(pdev);
 	int ret;
 
+	if (od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND)
+		return pm_generic_suspend_noirq(dev);
+
 	ret = pm_generic_suspend_noirq(dev);
 
 	if (!ret && !pm_runtime_status_suspended(dev)) {
@@ -590,6 +593,9 @@ static int _od_resume_noirq(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_device *od = to_omap_device(pdev);
 
+	if (od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND)
+		return pm_generic_resume_noirq(dev);
+
 	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
 	    !pm_runtime_status_suspended(dev)) {
 		od->flags &= ~OMAP_DEVICE_SUSPENDED;
-- 
1.7.6
