From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] cris: Update comments for generic idle conversion
Date: Fri, 23 May 2014 10:54:23 +0200
Message-ID: <1400835265-21956-3-git-send-email-geert+renesas@glider.be>
References: <1400835265-21956-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400835265-21956-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com
List-Id: linux-pm@vger.kernel.org

As of commit 8dc7c5ecd8d0f739728d844ee794c4fae169f9c2 ("cris: Use generic
idle loop"), cris no longer provides cpu_idle().

  - On cris-v10, etrax_gpio_wake_up_check() is called from
    default_idle() instead of cpu_idle(),
  - On cris-v32, etrax_gpio_wake_up_check() is not called from
    default_idle(), so remove this (copy-and-paste?) part.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: linux-cris-kernel@axis.com
---
 arch/cris/arch-v10/drivers/gpio.c         | 4 ++--
 arch/cris/arch-v32/drivers/mach-fs/gpio.c | 6 +-----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/cris/arch-v10/drivers/gpio.c b/arch/cris/arch-v10/drivers/gpio.c
index f4374bae4fb4..64285e0d3481 100644
--- a/arch/cris/arch-v10/drivers/gpio.c
+++ b/arch/cris/arch-v10/drivers/gpio.c
@@ -833,8 +833,8 @@ static int __init gpio_init(void)
 	printk(KERN_INFO "ETRAX 100LX GPIO driver v2.5, (c) 2001-2008 "
 		"Axis Communications AB\n");
 	/* We call etrax_gpio_wake_up_check() from timer interrupt and
-	 * from cpu_idle() in kernel/process.c
-	 * The check in cpu_idle() reduces latency from ~15 ms to ~6 ms
+	 * from default_idle() in kernel/process.c
+	 * The check in default_idle() reduces latency from ~15 ms to ~6 ms
 	 * in some tests.
 	 */
 	res = request_irq(TIMER0_IRQ_NBR, gpio_poll_timer_interrupt,
diff --git a/arch/cris/arch-v32/drivers/mach-fs/gpio.c b/arch/cris/arch-v32/drivers/mach-fs/gpio.c
index 9e54273af0ca..009f4ee1bd09 100644
--- a/arch/cris/arch-v32/drivers/mach-fs/gpio.c
+++ b/arch/cris/arch-v32/drivers/mach-fs/gpio.c
@@ -958,11 +958,7 @@ gpio_init(void)
 
 	printk(KERN_INFO "ETRAX FS GPIO driver v2.5, (c) 2003-2007 "
 		"Axis Communications AB\n");
-	/* We call etrax_gpio_wake_up_check() from timer interrupt and
-	 * from cpu_idle() in kernel/process.c
-	 * The check in cpu_idle() reduces latency from ~15 ms to ~6 ms
-	 * in some tests.
-	 */
+	/* We call etrax_gpio_wake_up_check() from timer interrupt */
 	if (request_irq(TIMER0_INTR_VECT, gpio_poll_timer_interrupt,
 			IRQF_SHARED, "gpio poll", &alarmlist))
 		printk(KERN_ERR "timer0 irq for gpio\n");
-- 
1.9.1
