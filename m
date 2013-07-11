From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH] pnp: convert pnp driver bus legacy pm_ops to dev_pm_ops
Date: Thu, 11 Jul 2013 17:33:38 -0600
Message-ID: <1373585618-3741-1-git-send-email-shuah.kh@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:50693
	"EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754983Ab3GKXdq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2013 19:33:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, shuahkhan@gmail.com

Convert drivers/pnp/driver.c bus legacy pm_ops to dev_pm_ops using
existing suspend and resume routines. Added freeze interface to
handle PM_EVENT_FREEZE correctly with dev_pm_ops. pm_op() looks for
freeze interface when the event is PM_EVENT_FREEZE.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/pnp/driver.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index c3f9e89..0c89dfa 100644
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
 
+const struct dev_pm_ops pnp_bus_dev_pm_ops = {
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

