From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 09/17] MIPS: ttyFDC: replace IRQF_NO_SUSPEND with IRQF_COND_SUSPEND
Date: Mon, 21 Sep 2015 16:47:05 +0100
Message-ID: <1442850433-5903-10-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-pm@vger.kernel.org

Since the FD interrupt handler can discern spurious IRQs and it is
shared with timer interrupt, use IRQF_COND_SUSPEND instead of
IRQF_NO_SUSPEND.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tty/mips_ejtag_fdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index a8c8cfd52a23..5a6d0b5cd18b 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -977,7 +977,7 @@ static int mips_ejtag_fdc_tty_probe(struct mips_cdmm_device *dev)
 	/* Try requesting the IRQ */
 	if (priv->irq >= 0) {
 		/*
-		 * IRQF_SHARED, IRQF_NO_SUSPEND: The FDC IRQ may be shared with
+		 * IRQF_SHARED, IRQF_COND_SUSPEND: The FDC IRQ may be shared with
 		 * other local interrupts such as the timer which sets
 		 * IRQF_TIMER (including IRQF_NO_SUSPEND).
 		 *
@@ -987,7 +987,7 @@ static int mips_ejtag_fdc_tty_probe(struct mips_cdmm_device *dev)
 		 */
 		ret = devm_request_irq(priv->dev, priv->irq, mips_ejtag_fdc_isr,
 				       IRQF_PERCPU | IRQF_SHARED |
-				       IRQF_NO_THREAD | IRQF_NO_SUSPEND,
+				       IRQF_NO_THREAD | IRQF_COND_SUSPEND,
 				       priv->fdc_name, priv);
 		if (ret)
 			priv->irq = -1;
-- 
1.9.1
