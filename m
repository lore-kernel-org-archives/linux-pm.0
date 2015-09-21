From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 11/17] pm: bf609: remove misuse of IRQF_NO_SUSPEND flag
Date: Mon, 21 Sep 2015 16:47:07 +0100
Message-ID: <1442850433-5903-12-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54051 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932180AbbIUPsY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Sep 2015 11:48:24 -0400
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net

The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
be left enabled so as to allow them to work as expected during the
suspend-resume cycle, but doesn't guarantee that it will wake the system
from a suspended state, enable_irq_wake is recommended to be used for
the wakeup.

This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
enable_irq_wake instead.

Cc: Steven Miao <realmz6@gmail.com>
Cc: adi-buildroot-devel@lists.sourceforge.net
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/blackfin/mach-bf609/pm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/blackfin/mach-bf609/pm.c b/arch/blackfin/mach-bf609/pm.c
index b1bfcf434d16..dab42d39b085 100644
--- a/arch/blackfin/mach-bf609/pm.c
+++ b/arch/blackfin/mach-bf609/pm.c
@@ -338,21 +338,22 @@ static int __init bf609_init_pm(void)
 				GPIO_PE12, error);
 	}
 
-	error = request_irq(irq, test_isr, IRQF_TRIGGER_RISING | IRQF_NO_SUSPEND
-				| IRQF_FORCE_RESUME, "gpiope12", NULL);
+	error = request_irq(irq, test_isr, IRQF_TRIGGER_RISING,
+			    "gpiope12", NULL);
 	if(error < 0)
 		printk(KERN_DEBUG "Unable to get irq\n");
+	enable_irq_wake(irq);
 #endif
 
-	error = request_irq(IRQ_CGU_EVT, dpm0_isr, IRQF_NO_SUSPEND |
-				IRQF_FORCE_RESUME, "cgu0 event", NULL);
+	error = request_irq(IRQ_CGU_EVT, dpm0_isr, 0, "cgu0 event", NULL);
 	if(error < 0)
 		printk(KERN_DEBUG "Unable to get irq\n");
+	enable_irq_wake(IRQ_CGU_EVT);
 
-	error = request_irq(IRQ_DPM, dpm0_isr, IRQF_NO_SUSPEND |
-				IRQF_FORCE_RESUME, "dpm0 event", NULL);
+	error = request_irq(IRQ_DPM, dpm0_isr, 0, "dpm0 event", NULL);
 	if (error < 0)
 		printk(KERN_DEBUG "Unable to get irq\n");
+	enable_irq_wake(IRQ_DPM);
 
 	bfin_cpu_pm = &bf609_cpu_pm;
 	return 0;
-- 
1.9.1

