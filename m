From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -v1] MIPS: add IRQF_TIMER flag for Timer
	Interrupts
Date: Fri,  9 Oct 2009 23:50:50 +0800
Message-ID: <1255103450-12537-1-git-send-email-wuzhangjin__32859.6924701289$1255103545$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-mips <linux-mips@linux-mips.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org, yuasa@linux-mips.org
List-Id: linux-pm@vger.kernel.org

This patch add IRQF_TIMER flag for all Timer interrupts in linux-MIPS,
which will help to not disable the Timer IRQ when suspending to ensure
resuming normally(d6c585a4342a2ff627a29f9aea77c5ed4cd76023) and not
thread them when enabled PREEMPT_RT.

NOTE: Perhaps there are also some board-specific Timer interrupts
missing here!

(This -v1 version Incorporated the feedback from Atsushi Nemoto
 <anemo@mba.ocn.ne.jp>.)

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/jazz/irq.c                |    2 +-
 arch/mips/kernel/cevt-bcm1480.c     |    2 +-
 arch/mips/kernel/cevt-ds1287.c      |    2 +-
 arch/mips/kernel/cevt-gt641xx.c     |    2 +-
 arch/mips/kernel/cevt-r4k.c         |    2 +-
 arch/mips/kernel/cevt-sb1250.c      |    2 +-
 arch/mips/kernel/cevt-txx9.c        |    2 +-
 arch/mips/kernel/i8253.c            |    2 +-
 arch/mips/nxp/pnx8550/common/int.c  |    2 +-
 arch/mips/nxp/pnx8550/common/time.c |    4 ++--
 arch/mips/sgi-ip27/ip27-timer.c     |    2 +-
 arch/mips/sni/time.c                |    2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index 7fd170d..7bd32d0 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -134,7 +134,7 @@ static irqreturn_t r4030_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction r4030_timer_irqaction = {
 	.handler	= r4030_timer_interrupt,
-	.flags		= IRQF_DISABLED,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.name		= "R4030 timer",
 };
 
diff --git a/arch/mips/kernel/cevt-bcm1480.c b/arch/mips/kernel/cevt-bcm1480.c
index e02f79b..bfea327 100644
--- a/arch/mips/kernel/cevt-bcm1480.c
+++ b/arch/mips/kernel/cevt-bcm1480.c
@@ -144,7 +144,7 @@ void __cpuinit sb1480_clockevent_init(void)
 	bcm1480_unmask_irq(cpu, irq);
 
 	action->handler	= sibyte_counter_handler;
-	action->flags	= IRQF_DISABLED | IRQF_PERCPU;
+	action->flags	= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER;
 	action->name	= name;
 	action->dev_id	= cd;
 
diff --git a/arch/mips/kernel/cevt-ds1287.c b/arch/mips/kernel/cevt-ds1287.c
index 6996da4..00a4da2 100644
--- a/arch/mips/kernel/cevt-ds1287.c
+++ b/arch/mips/kernel/cevt-ds1287.c
@@ -107,7 +107,7 @@ static irqreturn_t ds1287_interrupt(int irq, void *dev_id)
 
 static struct irqaction ds1287_irqaction = {
 	.handler	= ds1287_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "ds1287",
 };
 
diff --git a/arch/mips/kernel/cevt-gt641xx.c b/arch/mips/kernel/cevt-gt641xx.c
index 92351e0..f5d265e 100644
--- a/arch/mips/kernel/cevt-gt641xx.c
+++ b/arch/mips/kernel/cevt-gt641xx.c
@@ -113,7 +113,7 @@ static irqreturn_t gt641xx_timer0_interrupt(int irq, void *dev_id)
 
 static struct irqaction gt641xx_timer0_irqaction = {
 	.handler	= gt641xx_timer0_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "gt641xx_timer0",
 };
 
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 2652362..b469ad0 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -83,7 +83,7 @@ out:
 
 struct irqaction c0_compare_irqaction = {
 	.handler = c0_compare_interrupt,
-	.flags = IRQF_DISABLED | IRQF_PERCPU,
+	.flags = IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name = "timer",
 };
 
diff --git a/arch/mips/kernel/cevt-sb1250.c b/arch/mips/kernel/cevt-sb1250.c
index ac5903d..da78eea 100644
--- a/arch/mips/kernel/cevt-sb1250.c
+++ b/arch/mips/kernel/cevt-sb1250.c
@@ -143,7 +143,7 @@ void __cpuinit sb1250_clockevent_init(void)
 	sb1250_unmask_irq(cpu, irq);
 
 	action->handler	= sibyte_counter_handler;
-	action->flags	= IRQF_DISABLED | IRQF_PERCPU;
+	action->flags	= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER;
 	action->name	= name;
 	action->dev_id	= cd;
 
diff --git a/arch/mips/kernel/cevt-txx9.c b/arch/mips/kernel/cevt-txx9.c
index 0037f21..218ee6b 100644
--- a/arch/mips/kernel/cevt-txx9.c
+++ b/arch/mips/kernel/cevt-txx9.c
@@ -146,7 +146,7 @@ static irqreturn_t txx9tmr_interrupt(int irq, void *dev_id)
 
 static struct irqaction txx9tmr_irq = {
 	.handler	= txx9tmr_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "txx9tmr",
 	.dev_id		= &txx9_clock_event_device,
 };
diff --git a/arch/mips/kernel/i8253.c b/arch/mips/kernel/i8253.c
index f7d8d5d..ed5c441 100644
--- a/arch/mips/kernel/i8253.c
+++ b/arch/mips/kernel/i8253.c
@@ -98,7 +98,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction irq0  = {
 	.handler = timer_interrupt,
-	.flags = IRQF_DISABLED | IRQF_NOBALANCING,
+	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TIMER,
 	.name = "timer"
 };
 
diff --git a/arch/mips/nxp/pnx8550/common/int.c b/arch/mips/nxp/pnx8550/common/int.c
index f080f11..7aca7d5 100644
--- a/arch/mips/nxp/pnx8550/common/int.c
+++ b/arch/mips/nxp/pnx8550/common/int.c
@@ -172,7 +172,7 @@ static struct irqaction gic_action = {
 
 static struct irqaction timer_action = {
 	.handler =	no_action,
-	.flags =	IRQF_DISABLED,
+	.flags =	IRQF_DISABLED | IRQF_TIMER,
 	.name =		"Timer",
 };
 
diff --git a/arch/mips/nxp/pnx8550/common/time.c b/arch/mips/nxp/pnx8550/common/time.c
index 18b1927..8836c62 100644
--- a/arch/mips/nxp/pnx8550/common/time.c
+++ b/arch/mips/nxp/pnx8550/common/time.c
@@ -59,7 +59,7 @@ static irqreturn_t pnx8xxx_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction pnx8xxx_timer_irq = {
 	.handler	= pnx8xxx_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "pnx8xxx_timer",
 };
 
@@ -72,7 +72,7 @@ static irqreturn_t monotonic_interrupt(int irq, void *dev_id)
 
 static struct irqaction monotonic_irqaction = {
 	.handler = monotonic_interrupt,
-	.flags = IRQF_DISABLED,
+	.flags = IRQF_DISABLED | IRQF_TIMER,
 	.name = "Monotonic timer",
 };
 
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 6d0e59f..d6802d6 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -105,7 +105,7 @@ static irqreturn_t hub_rt_counter_handler(int irq, void *dev_id)
 
 struct irqaction hub_rt_irqaction = {
 	.handler	= hub_rt_counter_handler,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "hub-rt",
 };
 
diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index 62df6a5..f3b60e6 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -67,7 +67,7 @@ static irqreturn_t a20r_interrupt(int irq, void *dev_id)
 
 static struct irqaction a20r_irqaction = {
 	.handler	= a20r_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
 	.name		= "a20r-timer",
 };
 
-- 
1.6.2.1
