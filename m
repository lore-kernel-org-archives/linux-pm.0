From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 06/17] rtc: ds1343: remove misuse of IRQF_NO_SUSPEND flag
Date: Mon, 21 Sep 2015 16:47:02 +0100
Message-ID: <1442850433-5903-7-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com
List-Id: linux-pm@vger.kernel.org

The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
be left enabled so as to allow them to work as expected during the
suspend-resume cycle, but doesn't guarantee that it will wake the system
from a suspended state, enable_irq_wake is recommended to be used for
the wakeup.

This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/rtc/rtc-ds1343.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 79a06dd3c185..615ce5c370eb 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -21,6 +21,7 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/pm.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
 
 #define DS1343_DRV_VERSION	"01.00"
@@ -663,15 +664,15 @@ static int ds1343_probe(struct spi_device *spi)
 
 	if (priv->irq >= 0) {
 		res = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
-						ds1343_thread,
-						IRQF_NO_SUSPEND | IRQF_ONESHOT,
+						ds1343_thread, IRQF_ONESHOT,
 						"ds1343", priv);
 		if (res) {
 			priv->irq = -1;
 			dev_err(&spi->dev,
 				"unable to request irq for rtc ds1343\n");
 		} else {
-			device_set_wakeup_capable(&spi->dev, 1);
+			device_init_wakeup(&spi->dev, true);
+			dev_pm_set_wake_irq(&spi->dev, spi->irq);
 		}
 	}
 
@@ -692,6 +693,8 @@ static int ds1343_remove(struct spi_device *spi)
 		priv->irqen &= ~RTC_AF;
 		mutex_unlock(&priv->mutex);
 
+		dev_pm_clear_wake_irq(&spi->dev);
+		device_init_wakeup(&spi->dev, false);
 		devm_free_irq(&spi->dev, spi->irq, priv);
 	}
 
-- 
1.9.1
