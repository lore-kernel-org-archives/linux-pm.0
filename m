From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/2] Rework disabling of interrupts
 during suspend-resume
Date: Sun, 22 Feb 2009 10:13:22 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902221007150.3111@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902221837.49396.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 22 Feb 2009, Rafael J. Wysocki wrote:
> 
> However, x86 currently doesn't set the IRQF_TIMER flag and I need to 
> make it do so before going further in this direction and changing the 
> PCI PM framework to take advantage of the $subject changes, for example. 

Actually, you don't.

The modern form of timer interrupt on x86 is the local apic timer, and it 
doesn't go through the io-apic at all, and is not even visible to the irq 
subsystem. So it stays enabled through this all.

But for old-style timer interrupts, something like the appended should 
do it.

Untested, of course, but it looks obvious enough.

		Linus

---
 arch/x86/kernel/time_64.c     |    2 +-
 arch/x86/kernel/vmiclock_32.c |    3 ++-
 arch/x86/mach-default/setup.c |    2 +-
 arch/x86/mach-voyager/setup.c |    2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/time_64.c b/arch/x86/kernel/time_64.c
index e6e695a..241ec39 100644
--- a/arch/x86/kernel/time_64.c
+++ b/arch/x86/kernel/time_64.c
@@ -115,7 +115,7 @@ unsigned long __init calibrate_cpu(void)
 
 static struct irqaction irq0 = {
 	.handler	= timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_IRQPOLL | IRQF_NOBALANCING,
+	.flags		= IRQF_DISABLED | IRQF_IRQPOLL | IRQF_NOBALANCING | IRQF_TIMER,
 	.mask		= CPU_MASK_NONE,
 	.name		= "timer"
 };
diff --git a/arch/x86/kernel/vmiclock_32.c b/arch/x86/kernel/vmiclock_32.c
index bde106c..7a29d5c 100644
--- a/arch/x86/kernel/vmiclock_32.c
+++ b/arch/x86/kernel/vmiclock_32.c
@@ -1,3 +1,4 @@
+
 /*
  * VMI paravirtual timer support routines.
  *
@@ -202,7 +203,7 @@ static irqreturn_t vmi_timer_interrupt(int irq, void *dev_id)
 static struct irqaction vmi_clock_action  = {
 	.name 		= "vmi-timer",
 	.handler 	= vmi_timer_interrupt,
-	.flags 		= IRQF_DISABLED | IRQF_NOBALANCING,
+	.flags 		= IRQF_DISABLED | IRQF_NOBALANCING, IRQF_TIMER,
 	.mask 		= CPU_MASK_ALL,
 };
 
diff --git a/arch/x86/mach-default/setup.c b/arch/x86/mach-default/setup.c
index a265a7c..d737542 100644
--- a/arch/x86/mach-default/setup.c
+++ b/arch/x86/mach-default/setup.c
@@ -96,7 +96,7 @@ void __init trap_init_hook(void)
 
 static struct irqaction irq0  = {
 	.handler = timer_interrupt,
-	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_IRQPOLL,
+	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_IRQPOLL, IRQF_TIMER,
 	.mask = CPU_MASK_NONE,
 	.name = "timer"
 };
diff --git a/arch/x86/mach-voyager/setup.c b/arch/x86/mach-voyager/setup.c
index d914a79..4de9e08 100644
--- a/arch/x86/mach-voyager/setup.c
+++ b/arch/x86/mach-voyager/setup.c
@@ -56,7 +56,7 @@ void __init trap_init_hook(void)
 
 static struct irqaction irq0 = {
 	.handler = timer_interrupt,
-	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_IRQPOLL,
+	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_IRQPOLL, IRQF_TIMER,
 	.mask = CPU_MASK_NONE,
 	.name = "timer"
 };
