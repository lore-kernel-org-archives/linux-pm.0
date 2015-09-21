From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 05/17] platform: x86: remove misuse of IRQF_NO_SUSPEND flag
Date: Mon, 21 Sep 2015 16:47:01 +0100
Message-ID: <1442850433-5903-6-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
be left enabled so as to allow them to work as expected during the
suspend-resume cycle, but doesn't guarantee that it will wake the system
from a suspended state, enable_irq_wake is recommended to be used for
the wakeup.

This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.

Cc: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/platform/x86/intel_mid_powerbtn.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_mid_powerbtn.c b/drivers/platform/x86/intel_mid_powerbtn.c
index 22606d6b2af3..1fc0de870ff8 100644
--- a/drivers/platform/x86/intel_mid_powerbtn.c
+++ b/drivers/platform/x86/intel_mid_powerbtn.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/mfd/intel_msic.h>
+#include <linux/pm_wakeirq.h>
 
 #define DRIVER_NAME "msic_power_btn"
 
@@ -76,14 +77,17 @@ static int mfld_pb_probe(struct platform_device *pdev)
 
 	input_set_capability(input, EV_KEY, KEY_POWER);
 
-	error = request_threaded_irq(irq, NULL, mfld_pb_isr, IRQF_NO_SUSPEND,
-			DRIVER_NAME, input);
+	error = request_threaded_irq(irq, NULL, mfld_pb_isr, 0,
+				     DRIVER_NAME, input);
 	if (error) {
 		dev_err(&pdev->dev, "Unable to request irq %d for mfld power"
 				"button\n", irq);
 		goto err_free_input;
 	}
 
+	device_init_wakeup(&pdev->dev, true);
+	dev_pm_set_wake_irq(&pdev->dev, irq);
+
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&pdev->dev, "Unable to register input dev, error "
@@ -124,6 +128,8 @@ static int mfld_pb_remove(struct platform_device *pdev)
 	struct input_dev *input = platform_get_drvdata(pdev);
 	int irq = platform_get_irq(pdev, 0);
 
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
 	free_irq(irq, input);
 	input_unregister_device(input);
 
-- 
1.9.1
