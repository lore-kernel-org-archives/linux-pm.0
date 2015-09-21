From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 01/17] rtc: pl031: remove misuse of IRQF_NO_SUSPEND flag
Date: Mon, 21 Sep 2015 16:46:57 +0100
Message-ID: <1442850433-5903-2-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com
List-Id: linux-pm@vger.kernel.org

The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
be left enabled so as to allow them to work as expected during the
suspend-resume cycle, but doesn't guarantee that it will wake the system
from a suspended state, enable_irq_wake is recommended to be used for
the wakeup.

This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/rtc/rtc-pl031.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 41dcb7ddb906..e1687e19c59f 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/bcd.h>
 #include <linux/delay.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
 
 /*
@@ -305,6 +306,8 @@ static int pl031_remove(struct amba_device *adev)
 {
 	struct pl031_local *ldata = dev_get_drvdata(&adev->dev);
 
+	dev_pm_clear_wake_irq(&adev->dev);
+	device_init_wakeup(&adev->dev, false);
 	free_irq(adev->irq[0], ldata);
 	rtc_device_unregister(ldata->rtc);
 	iounmap(ldata->base);
@@ -370,7 +373,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 		}
 	}
 
-	device_init_wakeup(&adev->dev, 1);
+	device_init_wakeup(&adev->dev, true);
 	ldata->rtc = rtc_device_register("pl031", &adev->dev, ops,
 					THIS_MODULE);
 	if (IS_ERR(ldata->rtc)) {
@@ -383,7 +386,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 		ret = -EIO;
 		goto out_no_irq;
 	}
-
+	dev_pm_set_wake_irq(&adev->dev, adev->irq[0]);
 	return 0;
 
 out_no_irq:
@@ -408,7 +411,6 @@ static struct pl031_vendor_data arm_pl031 = {
 		.set_alarm = pl031_set_alarm,
 		.alarm_irq_enable = pl031_alarm_irq_enable,
 	},
-	.irqflags = IRQF_NO_SUSPEND,
 };
 
 /* The First ST derivative */
@@ -422,7 +424,6 @@ static struct pl031_vendor_data stv1_pl031 = {
 	},
 	.clockwatch = true,
 	.st_weekday = true,
-	.irqflags = IRQF_NO_SUSPEND,
 };
 
 /* And the second ST derivative */
@@ -439,8 +440,10 @@ static struct pl031_vendor_data stv2_pl031 = {
 	/*
 	 * This variant shares the IRQ with another block and must not
 	 * suspend that IRQ line.
+	 * TODO check if it shares with IRQF_NO_SUSPEND user, else we can
+	 * remove IRQF_COND_SUSPEND
 	 */
-	.irqflags = IRQF_SHARED | IRQF_NO_SUSPEND,
+	.irqflags = IRQF_SHARED | IRQF_COND_SUSPEND,
 };
 
 static struct amba_id pl031_ids[] = {
-- 
1.9.1
