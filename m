From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 07/17][UPDATE] mfd: qcom_rpm: Drop use of IRQF_NO_SUSPEND flag
Date: Fri, 25 Sep 2015 13:39:13 +0100
Message-ID: <1443184753-6803-1-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-8-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41885 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754412AbbIYMjW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 25 Sep 2015 08:39:22 -0400
In-Reply-To: <1442850433-5903-8-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Samuel Ortiz <sameo@linux.intel.com>

The driver handles wakeup irq correctly using irq_set_irq_wake. There's
no need to use IRQF_NO_SUSPEND while registering the interrupt.

This patch removes the use of IRQF_NO_SUSPEND flag.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mfd/qcom_rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Updated version with the $subject fixed and Lee's ACK.

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

