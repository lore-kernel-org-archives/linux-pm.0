From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 07/17] input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
Date: Mon, 21 Sep 2015 16:47:03 +0100
Message-ID: <1442850433-5903-8-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

The driver handles wakeup irq correctly using irq_set_irq_wake. There's
no need to use IRQF_NO_SUSPEND while registering the interrupt.

This patch removes the use of IRQF_NO_SUSPEND flag.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mfd/qcom_rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 6afc9fabd94c..207a3bd68559 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -550,7 +550,7 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev,
 			       irq_ack,
 			       qcom_rpm_ack_interrupt,
-			       IRQF_TRIGGER_RISING | IRQF_NO_SUSPEND,
+			       IRQF_TRIGGER_RISING,
 			       "qcom_rpm_ack",
 			       rpm);
 	if (ret) {
-- 
1.9.1
