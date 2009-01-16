From: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] irq: provide debug_poll_all_shared_irqs() method
	under	CONFIG_DEBUG_SHIRQ
Date: Fri, 16 Jan 2009 17:51:23 +0100
Message-ID: <20090116165123.GB27495__33262.4733135619$1232124953$gmane$org@elte.hu>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0901160733260.29252@localhost.localdomain>
	<200901161727.05026.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200901161727.05026.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, john stultz <johnstul@us.ibm.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > I did suggest that we could also add some test-infrastructure like the 
> > DEBUG_SHIRQ thing we already have, which sends an interrupt 
> > immediately on resume after interrupts have been enabled. That will 
> > likely uncover a _lot_ of problems, and it's almost certainly worth 
> > doing regardless.
> 
> For the record, I put that onto my todo list, which unfortunately is 
> quite long at the moment (and getting longer).

as i mentioned it in the private thread to Linus, kernel/irq/spurious.c's 
misrouted_irq(-1) function function is precisely what we want to call at 
resume time.

See the patch below, it factors this functionality out and provides a 
debug_poll_shared_irqs() function that you can call from the resume path. 

In the !DEBUG_SHIRQ case it will do nothing, in the DEBUG_SHIRQ case it 
will iterate through all registered IRQs (which are capable of handling 
shared irq lines) and call them (if they are not disabled explicitly).

The sooner we start seeing these kinds of problems the better - delaying 
debug patches to after feature work is never a good idea - delaying 
feature changes works much better ;-)

	Ingo

------------------>
>From 74296a8ed6aa3c5bf672808ada690de7ba323ecc Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 16 Jan 2009 17:43:50 +0100
Subject: [PATCH] irq: provide debug_poll_all_shared_irqs() method under CONFIG_DEBUG_SHIRQ

Provide a shared interrupt debug facility under CONFIG_DEBUG_SHIRQ:
it uses the existing irqpoll facilities to iterate through all
registered interrupt handlers and call those which can handle shared
IRQ lines.

This can be handy for suspend/resume debugging: if we call this function
early during resume we can trigger crashes in those drivers which have
incorrect assumptions about when exactly their ISRs will be called
during suspend/resume.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/interrupt.h |    6 ++++++
 kernel/irq/spurious.c     |   14 +++++++++++++-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 9127f6b..468e3a2 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -462,6 +462,12 @@ static inline void init_irq_proc(void)
 }
 #endif
 
+#if defined(CONFIG_GENERIC_HARDIRQS) && defined(CONFIG_DEBUG_SHIRQ)
+extern void debug_poll_all_shared_irqs(void);
+#else
+static inline void debug_poll_all_shared_irqs(void) { }
+#endif
+
 int show_interrupts(struct seq_file *p, void *v);
 
 struct irq_desc;
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index dd364c1..4d56829 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -104,7 +104,7 @@ static int misrouted_irq(int irq)
 	return ok;
 }
 
-static void poll_spurious_irqs(unsigned long dummy)
+static void poll_all_shared_irqs(void)
 {
 	struct irq_desc *desc;
 	int i;
@@ -123,11 +123,23 @@ static void poll_spurious_irqs(unsigned long dummy)
 
 		try_one_irq(i, desc);
 	}
+}
+
+static void poll_spurious_irqs(unsigned long dummy)
+{
+	poll_all_shared_irqs();
 
 	mod_timer(&poll_spurious_irq_timer,
 		  jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
 }
 
+#ifdef CONFIG_DEBUG_SHIRQ
+void debug_poll_all_shared_irqs(void)
+{
+	poll_all_shared_irqs();
+}
+#endif
+
 /*
  * If 99,900 of the previous 100,000 interrupts have not been handled
  * then assume that the IRQ is stuck in some manner. Drop a diagnostic
