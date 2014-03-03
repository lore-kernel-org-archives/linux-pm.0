From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v2 02/11] drivercore: Bind/unbind power domain on probe/remove
Date: Mon,  3 Mar 2014 17:02:07 +0100
Message-ID: <1393862536-9842-3-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Len Brown <len.brown@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Pavel Machek <pavel@ucw.cz>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Kumar
List-Id: linux-pm@vger.kernel.org

On a number of platforms, devices are part of controllable power
domains, which need to be enabled before such devices can be accessed
and may be powered down when the device is idle to save some power.
This means that on systems that support power domain control using
generic power domains subsystem, it is necessary to add device to its
power domain before binding a driver to it and remove it from its power
domain after its driver is unbound to make sure that an unused device
does not affect power domain state.

Since this is not limited to particular busses and specific
archs/platforms, it is more convenient to do the above directly in
driver core, just as done with pinctrl default configuration. This patch
adds necessary code to really_probe() and __device_release_driver() to
achieve this and maintain consistent stack-like ordering of operations
happening when binding and unbinding a driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/base/dd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0605176..78e5b36 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -23,6 +23,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/async.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
 
@@ -273,6 +274,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 
 	dev->driver = drv;
 
+	/* If using genpd, bind power domain now before probing */
+	ret = genpd_bind_domain(dev);
+	if (ret)
+		goto probe_failed;
+
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
 	if (ret)
@@ -303,6 +309,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 probe_failed:
 	devres_release_all(dev);
 	driver_sysfs_remove(dev);
+	genpd_unbind_domain(dev);
 	dev->driver = NULL;
 	dev_set_drvdata(dev, NULL);
 
@@ -513,7 +520,7 @@ static void __device_release_driver(struct device *dev)
 			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 						     BUS_NOTIFY_UNBOUND_DRIVER,
 						     dev);
-
+		genpd_unbind_domain(dev);
 	}
 }
 
-- 
1.9.0
