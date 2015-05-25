From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/8] core: platform: wakeup the parent before trying any driver operations
Date: Mon, 25 May 2015 19:09:27 +0300
Message-ID: <1432570172-86963-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

If the parent is still suspended when a driver probe,
remove or shutdown is attempted, the result may be a
failure.

For example, if the parent is a PCI MFD device that has been
suspended when we try to probe our device, any register
reads will return 0xffffffff.

To fix the problem, making sure the parent is always awake
before using driver probe, remove or shutdown.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/platform.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index ebf034b..59fcda5 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -518,9 +518,15 @@ static int platform_drv_probe(struct device *_dev)
 
 	ret = dev_pm_domain_attach(_dev, true);
 	if (ret != -EPROBE_DEFER) {
+		if (_dev->parent != &platform_bus)
+			pm_runtime_get_sync(_dev->parent);
+
 		ret = drv->probe(dev);
 		if (ret)
 			dev_pm_domain_detach(_dev, true);
+
+		if (_dev->parent != &platform_bus)
+			pm_runtime_put(_dev->parent);
 	}
 
 	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
@@ -542,9 +548,15 @@ static int platform_drv_remove(struct device *_dev)
 	struct platform_device *dev = to_platform_device(_dev);
 	int ret;
 
+	if (_dev->parent != &platform_bus)
+		pm_runtime_get_sync(_dev->parent);
+
 	ret = drv->remove(dev);
-	dev_pm_domain_detach(_dev, true);
 
+	if (_dev->parent != &platform_bus)
+		pm_runtime_put(_dev->parent);
+
+	dev_pm_domain_detach(_dev, true);
 	return ret;
 }
 
@@ -553,7 +565,14 @@ static void platform_drv_shutdown(struct device *_dev)
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
 
+	if (_dev->parent != &platform_bus)
+		pm_runtime_get_sync(_dev->parent);
+
 	drv->shutdown(dev);
+
+	if (_dev->parent != &platform_bus)
+		pm_runtime_put(_dev->parent);
+
 	dev_pm_domain_detach(_dev, true);
 }
 
-- 
2.1.4
