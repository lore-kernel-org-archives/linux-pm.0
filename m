From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH v2] pnp: convert pnp driver bus legacy pm_ops to dev_pm_ops
Date: Fri, 26 Jul 2013 15:07:26 -0600
Message-ID: <1374872846-29606-1-git-send-email-shuah.kh@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael.j.wysocki@intel.com, bhelgaas@google.com, fengguang.wu@intel.com
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

Convert drivers/pnp/driver.c bus legacy pm_ops to dev_pm_ops using
existing suspend and resume routines. Added freeze interface to
handle PM_EVENT_FREEZE correctly with dev_pm_ops. pm_op() looks for
freeze interface when the event is PM_EVENT_FREEZE.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
Changes since v1: Fixed the following warning found in kbuild test robot
drivers/pnp/driver.c:223:25: sparse: symbol 'pnp_bus_dev_pm_ops' was not declared. Should it be static?

 drivers/pnp/driver.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index c3f9e89..a39ee38 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -154,7 +154,7 @@ static int pnp_bus_match(struct device *dev, struct device_driver *drv)
 	return 1;
 }
 
-static int pnp_bus_suspend(struct device *dev, pm_message_t state)
+static int __pnp_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct pnp_dev *pnp_dev = to_pnp_dev(dev);
 	struct pnp_driver *pnp_drv = pnp_dev->driver;
@@ -187,6 +187,16 @@ static int pnp_bus_suspend(struct device *dev, pm_message_t state)
 	return 0;
 }
 
+static int pnp_bus_suspend(struct device *dev)
+{
+	return __pnp_bus_suspend(dev, PMSG_SUSPEND);
+}
+
+static int pnp_bus_freeze(struct device *dev)
+{
+	return __pnp_bus_suspend(dev, PMSG_FREEZE);
+}
+
 static int pnp_bus_resume(struct device *dev)
 {
 	struct pnp_dev *pnp_dev = to_pnp_dev(dev);
@@ -223,14 +233,19 @@ static int pnp_bus_resume(struct device *dev)
 	return 0;
 }
 
+static const struct dev_pm_ops pnp_bus_dev_pm_ops = {
+	.suspend = pnp_bus_suspend,
+	.freeze = pnp_bus_freeze,
+	.resume = pnp_bus_resume,
+};
+
 struct bus_type pnp_bus_type = {
 	.name    = "pnp",
 	.match   = pnp_bus_match,
 	.probe   = pnp_device_probe,
 	.remove  = pnp_device_remove,
 	.shutdown = pnp_device_shutdown,
-	.suspend = pnp_bus_suspend,
-	.resume  = pnp_bus_resume,
+	.pm	 = &pnp_bus_dev_pm_ops,
 	.dev_attrs = pnp_interface_attrs,
 };
 
-- 
1.7.10.4
