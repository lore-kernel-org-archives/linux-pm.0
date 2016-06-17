From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 08/10] PM core: Fix restoring devices with links during
	system PM transition
Date: Fri, 17 Jun 2016 08:26:58 +0200
Message-ID: <1466144820-6286-9-git-send-email-m.szyprowski@samsung.com>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1466144820-6286-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

When devices are being runtime resumed during the system PM transition to
suspend state, the link suppliers might be already resumed and
have runtime pm disabled. This is normal case. This patch adds special
support for such case. Simple call to pm_runtime_get_syncreturns error
when device has runtime PM disabled, what results in incorrect runtime PM
state during system wide PM transition.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/base/power/runtime.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 0ea00d442e0f..d00b079fad88 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -261,6 +261,26 @@ static int rpm_check_suspend_allowed(struct device *dev)
 }
 
 /**
+ * __pm_runtime_force_resume - force resume of the device
+ * @dev: Device to resume
+ *
+ * This function works like __pm_runtime_resume(dev, RPM_GET_PUT), but
+ * also handles devices with runtime PM disabled. This allows to properly
+ * control all devices during preparation for system PM transition.
+ */
+static int __pm_runtime_force_resume(struct device *dev)
+{
+	if (!dev->power.disable_depth)
+		return pm_runtime_get_sync(dev);
+
+	if (dev->power.runtime_status != RPM_ACTIVE ||
+	    atomic_inc_not_zero(&dev->power.usage_count) == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
  * __rpm_callback - Run a given runtime PM callback for a given device.
  * @cb: Runtime PM callback to run.
  * @dev: Device to run the callback for.
@@ -291,7 +311,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 				if ((link->flags & DEVICE_LINK_PM_RUNTIME)
 				    && link->status != DEVICE_LINK_SUPPLIER_UNBIND
 				    && !link->rpm_active) {
-					retval = pm_runtime_get_sync(link->supplier);
+					retval = __pm_runtime_force_resume(link->supplier);
 					if (retval < 0) {
 						pm_runtime_put_noidle(link->supplier);
 						goto fail;
-- 
1.9.1
