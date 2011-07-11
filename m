From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 2/4] OMAP: PM: omap_device: add system PM methods
	for PM domain handling
Date: Mon, 11 Jul 2011 16:29:27 -0700
Message-ID: <1310426969-30306-3-git-send-email-khilman__38764.1878951856$1310427042$gmane$org@ti.com>
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

In the omap_device PM domain callbacks, use omap_device idle/enable to
automatically manage device idle states during system suspend/resume.

If an omap_device has not already been runtime suspended, the
->suspend_noirq() method of the PM domain will use omap_device_idle()
to idle the HW after calling the driver's ->runtime_suspend()
callback.  Similarily, upon resume, if the device was suspended during
->suspend_noirq(), the ->resume_noirq() method of the PM domain will
use omap_device_enable() to enable the HW and then call the driver's
->runtime_resume() callback.

If a device has already been runtime suspended, the noirq methods of
the PM domain leave the device runtime suspended by default.

However, if a driver needs to runtime resume a device during suspend
(for example, to change its wakeup settings), it may do so using
pm_runtime_get* in it's ->suspend() callback.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    4 +++
 arch/arm/plat-omap/omap_device.c              |   36 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index e4c349f..bc36d05 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -44,6 +44,9 @@ extern struct device omap_device_parent;
 #define OMAP_DEVICE_STATE_IDLE		2
 #define OMAP_DEVICE_STATE_SHUTDOWN	3
 
+/* omap_device.flags values */
+#define OMAP_DEVICE_SUSPENDED BIT(0)
+
 /**
  * struct omap_device - omap_device wrapper for platform_devices
  * @pdev: platform_device
@@ -73,6 +76,7 @@ struct omap_device {
 	s8				pm_lat_level;
 	u8				hwmods_cnt;
 	u8				_state;
+	u8                              flags;
 };
 
 /* Device driver interface (call via platform_data fn ptrs) */
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index f7d2ff7..b93cfdc 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -566,11 +566,47 @@ static int _od_runtime_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_SUSPEND
+static int _od_suspend_noirq(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od = to_omap_device(pdev);
+	int ret;
+
+	ret = pm_generic_suspend_noirq(dev);
+
+	if (!ret && !pm_runtime_status_suspended(dev)) {
+		if (pm_generic_runtime_suspend(dev) == 0) {
+			omap_device_idle(pdev);
+			od->flags |= OMAP_DEVICE_SUSPENDED;
+		}
+	}
+
+	return ret;
+}
+
+static int _od_resume_noirq(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od = to_omap_device(pdev);
+
+	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
+	    !pm_runtime_status_suspended(dev)) {
+		od->flags &= ~OMAP_DEVICE_SUSPENDED;
+		omap_device_enable(pdev);
+		pm_generic_runtime_resume(dev);
+	}
+
+	return pm_generic_resume_noirq(dev);
+}
+#endif
+
 static struct dev_pm_domain omap_device_pm_domain = {
 	.ops = {
 		SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
 				   _od_runtime_idle)
 		USE_PLATFORM_PM_SLEEP_OPS
+		SET_SYSTEM_SLEEP_PM_OPS(_od_suspend_noirq, _od_resume_noirq)
 	}
 };
 
-- 
1.7.6
