From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] i2c: OMAP: fix static suspend vs. runtime suspend
Date: Thu, 27 Jan 2011 16:18:41 -0800
Message-ID: <1296173921-4832-1-git-send-email-khilman__15401.1748884388$1296174130$gmane$org@ti.com>
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
To: Ben Dooks <ben-linux@fluff.org>, Rajendra Nayak <rnayak@ti.com>, linux-i2c@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

When runtime PM is enabled, each OMAP i2c device is suspended after
each i2c xfer.  However, there are two cases when the static suspend
methods must be used to ensure the devices are suspended:

1) runtime PM is disabled, either at compile time or dynamically
    via /sys/devices/.../power/control.
2) an i2c client driver uses i2c during it's suspend callback, thus
   leaving the i2c driver active (NOTE: runtime suspend transitions are
   disabled during system suspend, so i2c activity during system
   suspend will runtime resume the device, but not runtime (re)suspend it.)

Since the actual work to suspend the device is handled by the
subsytem, call the bus methods to take care of it.

NOTE: This takes care of a known suspend problem on OMAP3 where the
TWL RTC driver does i2c xfers during its suspend path leaving the i2c
driver in an active state (since runtime suspend transistions are
disabled.)

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Ben, this is a regression in 2.6.38 so hopefully this can be queued
in the 2.6.38-rc cycle.  Thanks.

 drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b605ff3..0541df9 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1137,12 +1137,40 @@ omap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_SUSPEND
+static int omap_i2c_suspend(struct device *dev)
+{
+	if (!pm_runtime_suspended(dev))
+		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
+			dev->bus->pm->runtime_suspend(dev);
+
+	return 0;
+}
+
+static int omap_i2c_resume(struct device *dev)
+{
+	if (!pm_runtime_suspended(dev))
+		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
+			dev->bus->pm->runtime_resume(dev);
+
+	return 0;
+}
+
+static struct dev_pm_ops omap_i2c_pm_ops = {
+	.suspend = omap_i2c_suspend,
+	.resume = omap_i2c_resume,
+};
+#else
+#define omap_i2c_pm_ops NULL
+#endif
+
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
 	.remove		= omap_i2c_remove,
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
+		.pm     = &omap_i2c_pm_ops,
 	},
 };
 
-- 
1.7.3.5
