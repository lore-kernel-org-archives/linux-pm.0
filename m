From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] i2c: Factor out runtime suspend checks from PM
	operations
Date: Thu, 30 Dec 2010 12:40:13 +0000
Message-ID: <1293712813-4090-1-git-send-email-broonie__21636.0473343686$1293712888$gmane$org@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Delvare <khali@linux-fr.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

When devices use dev_pm_ops the I2C API is implementing standard functionality
for integration with runtime PM and for checking for the presence of a per
device op. The PM core provides pm_generic_ functions implementing this
behaviour - use them to reduce coupling with future PM updates.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/i2c/i2c-core.c |   68 ++++++++++++++---------------------------------
 1 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 6b4cc56..6793c51 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -196,88 +196,60 @@ static int i2c_device_pm_suspend(struct device *dev)
 {
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
-	if (pm) {
-		if (pm_runtime_suspended(dev))
-			return 0;
-		else
-			return pm->suspend ? pm->suspend(dev) : 0;
-	}
-
-	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
+	if (pm)
+		return pm_generic_suspend(dev);
+	else
+		return i2c_legacy_suspend(dev, PMSG_SUSPEND);
 }
 
 static int i2c_device_pm_resume(struct device *dev)
 {
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-	int ret;
 
 	if (pm)
-		ret = pm->resume ? pm->resume(dev) : 0;
+		return pm_generic_resume(dev);
 	else
-		ret = i2c_legacy_resume(dev);
-
-	return ret;
+		return i2c_legacy_resume(dev);
 }
 
 static int i2c_device_pm_freeze(struct device *dev)
 {
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
-	if (pm) {
-		if (pm_runtime_suspended(dev))
-			return 0;
-		else
-			return pm->freeze ? pm->freeze(dev) : 0;
-	}
-
-	return i2c_legacy_suspend(dev, PMSG_FREEZE);
+	if (pm)
+		return pm_generic_freeze(dev);
+	else
+		return i2c_legacy_suspend(dev, PMSG_FREEZE);
 }
 
 static int i2c_device_pm_thaw(struct device *dev)
 {
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
-	if (pm) {
-		if (pm_runtime_suspended(dev))
-			return 0;
-		else
-			return pm->thaw ? pm->thaw(dev) : 0;
-	}
-
-	return i2c_legacy_resume(dev);
+	if (pm)
+		return pm_generic_thaw(dev);
+	else
+		return i2c_legacy_resume(dev);
 }
 
 static int i2c_device_pm_poweroff(struct device *dev)
 {
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
-	if (pm) {
-		if (pm_runtime_suspended(dev))
-			return 0;
-		else
-			return pm->poweroff ? pm->poweroff(dev) : 0;
-	}
-
-	return i2c_legacy_suspend(dev, PMSG_HIBERNATE);
+	if (pm)
+		return pm_generic_poweroff(dev);
+	else
+		return i2c_legacy_suspend(dev, PMSG_HIBERNATE);
 }
 
 static int i2c_device_pm_restore(struct device *dev)
 {
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-	int ret;
 
 	if (pm)
-		ret = pm->restore ? pm->restore(dev) : 0;
+		return pm_generic_restore(dev);
 	else
-		ret = i2c_legacy_resume(dev);
-
-	if (!ret) {
-		pm_runtime_disable(dev);
-		pm_runtime_set_active(dev);
-		pm_runtime_enable(dev);
-	}
-
-	return ret;
+		return i2c_legacy_resume(dev);
 }
 #else /* !CONFIG_PM_SLEEP */
 #define i2c_device_pm_suspend	NULL
-- 
1.7.2.3
