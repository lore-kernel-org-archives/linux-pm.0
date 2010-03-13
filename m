From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] i2c: Use generic subsystem-level power
	management callbacks
Date: Sat, 13 Mar 2010 22:04:30 +0100
Message-ID: <201003132204.30905.rjw__19524.1314745092$1268514151$gmane$org@sisk.pl>
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
To: Jean Delvare <khali@linux-fr.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There are three issues with the i2c's power management callbacks at
the moment.  First, they don't include any hibernate callbacks,
although they should at least include the .restore() callback
(there's no guarantee that the driver will be in memory before
loading the image kernel and we must restore the pre-hibernation
state of the device).  Second, the "legacy" callbacks are not going
to be invoked by the PM core since the bus type's pm object is not
NULL.  Finally, the system power transition (ie. suspend/resume)
callbacks don't check if the device hasn't been already suspended
at run time, in which case they should skip suspending it and
handle it in a special way during resume.  Also, it looks like the
i2c bus type itself doesn't need any power management handling beyond
that provided by the generic subsystem-level PM callbacks.

For these reasons, remove the power management callbacks defined by
the i2c bus type and make it use the generic subsystem-level power
management callbacks.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
Jean,

I know I said I wanted to implement the generic callbacks later, but they
were implemented in the meantime anyway, so I think we can use them now.

Please note that the "legacy" callbacks removed by this patch are already
effectively dead, because they are not going to be called by the PM core
anyway.  I'm not sure if this is what we want, though, so please let me know
in case it's not.

Thanks,
Rafael
---
 drivers/i2c/i2c-core.c |  113 -------------------------------------------------
 1 file changed, 1 insertion(+), 112 deletions(-)

Index: linux-2.6/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.orig/drivers/i2c/i2c-core.c
+++ linux-2.6/drivers/i2c/i2c-core.c
@@ -156,107 +156,6 @@ static void i2c_device_shutdown(struct d
 		driver->shutdown(client);
 }
 
-#ifdef CONFIG_SUSPEND
-static int i2c_device_pm_suspend(struct device *dev)
-{
-	const struct dev_pm_ops *pm;
-
-	if (!dev->driver)
-		return 0;
-	pm = dev->driver->pm;
-	if (!pm || !pm->suspend)
-		return 0;
-	return pm->suspend(dev);
-}
-
-static int i2c_device_pm_resume(struct device *dev)
-{
-	const struct dev_pm_ops *pm;
-
-	if (!dev->driver)
-		return 0;
-	pm = dev->driver->pm;
-	if (!pm || !pm->resume)
-		return 0;
-	return pm->resume(dev);
-}
-#else
-#define i2c_device_pm_suspend	NULL
-#define i2c_device_pm_resume	NULL
-#endif
-
-#ifdef CONFIG_PM_RUNTIME
-static int i2c_device_runtime_suspend(struct device *dev)
-{
-	const struct dev_pm_ops *pm;
-
-	if (!dev->driver)
-		return 0;
-	pm = dev->driver->pm;
-	if (!pm || !pm->runtime_suspend)
-		return 0;
-	return pm->runtime_suspend(dev);
-}
-
-static int i2c_device_runtime_resume(struct device *dev)
-{
-	const struct dev_pm_ops *pm;
-
-	if (!dev->driver)
-		return 0;
-	pm = dev->driver->pm;
-	if (!pm || !pm->runtime_resume)
-		return 0;
-	return pm->runtime_resume(dev);
-}
-
-static int i2c_device_runtime_idle(struct device *dev)
-{
-	const struct dev_pm_ops *pm = NULL;
-	int ret;
-
-	if (dev->driver)
-		pm = dev->driver->pm;
-	if (pm && pm->runtime_idle) {
-		ret = pm->runtime_idle(dev);
-		if (ret)
-			return ret;
-	}
-
-	return pm_runtime_suspend(dev);
-}
-#else
-#define i2c_device_runtime_suspend	NULL
-#define i2c_device_runtime_resume	NULL
-#define i2c_device_runtime_idle		NULL
-#endif
-
-static int i2c_device_suspend(struct device *dev, pm_message_t mesg)
-{
-	struct i2c_client *client = i2c_verify_client(dev);
-	struct i2c_driver *driver;
-
-	if (!client || !dev->driver)
-		return 0;
-	driver = to_i2c_driver(dev->driver);
-	if (!driver->suspend)
-		return 0;
-	return driver->suspend(client, mesg);
-}
-
-static int i2c_device_resume(struct device *dev)
-{
-	struct i2c_client *client = i2c_verify_client(dev);
-	struct i2c_driver *driver;
-
-	if (!client || !dev->driver)
-		return 0;
-	driver = to_i2c_driver(dev->driver);
-	if (!driver->resume)
-		return 0;
-	return driver->resume(client);
-}
-
 static void i2c_client_dev_release(struct device *dev)
 {
 	kfree(to_i2c_client(dev));
@@ -295,23 +194,13 @@ static const struct attribute_group *i2c
 	NULL
 };
 
-static const struct dev_pm_ops i2c_device_pm_ops = {
-	.suspend = i2c_device_pm_suspend,
-	.resume = i2c_device_pm_resume,
-	.runtime_suspend = i2c_device_runtime_suspend,
-	.runtime_resume = i2c_device_runtime_resume,
-	.runtime_idle = i2c_device_runtime_idle,
-};
-
 struct bus_type i2c_bus_type = {
 	.name		= "i2c",
 	.match		= i2c_device_match,
 	.probe		= i2c_device_probe,
 	.remove		= i2c_device_remove,
 	.shutdown	= i2c_device_shutdown,
-	.suspend	= i2c_device_suspend,
-	.resume		= i2c_device_resume,
-	.pm		= &i2c_device_pm_ops,
+	.pm		= GENERIC_SUBSYS_PM_OPS,
 };
 EXPORT_SYMBOL_GPL(i2c_bus_type);
 
