From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 16/17] pinctrl: single: remove misuse of IRQF_NO_SUSPEND flag
Date: Mon, 21 Sep 2015 16:47:12 +0100
Message-ID: <1442850433-5903-17-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
be left enabled so as to allow them to work as expected during the
suspend-resume cycle, but doesn't guarantee that it will wake the system
from a suspended state, enable_irq_wake is recommended to be used for
the wakeup.

This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
irq_set_irq_wake instead.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/pinctrl/pinctrl-single.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index ef04b962c3d5..a5d0f0e52de1 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1615,12 +1615,14 @@ static void pcs_irq_unmask(struct irq_data *d)
  */
 static int pcs_irq_set_wake(struct irq_data *d, unsigned int state)
 {
+	struct pcs_soc_data *pcs_soc = irq_data_get_irq_chip_data(d);
+
 	if (state)
 		pcs_irq_unmask(d);
 	else
 		pcs_irq_mask(d);
 
-	return 0;
+	return irq_set_irq_wake(pcs_soc->irq, state);
 }
 
 /**
@@ -1755,8 +1757,7 @@ static int pcs_irq_init_chained_handler(struct pcs_device *pcs,
 		int res;
 
 		res = request_irq(pcs_soc->irq, pcs_irq_handler,
-				  IRQF_SHARED | IRQF_NO_SUSPEND |
-				  IRQF_NO_THREAD,
+				  IRQF_SHARED | IRQF_NO_THREAD,
 				  name, pcs_soc);
 		if (res) {
 			pcs_soc->irq = -1;
-- 
1.9.1
