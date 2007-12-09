From: Ingo Molnar <mingo@elte.hu>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Sun, 9 Dec 2007 09:06:19 +0100
Message-ID: <20071209080619.GA682__2894.29447516358$1197187697$gmane$org@elte.hu>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
	<47595A0A.5000502@gmail.com> <20071207151150.GB24254@elte.hu>
	<20071207175134.GA18916@elte.hu> <475A5188.6070809@gmail.com>
	<20071208083939.GD30997@elte.hu> <475A629C.7010408@gmail.com>
	<20071208152447.GA30270@elte.hu> <475AD7D0.8040905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <475AD7D0.8040905@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Jiri Slaby <jirislaby@gmail.com> wrote:

> On 12/08/2007 04:24 PM, Ingo Molnar wrote:
> > i'm wondering why it had no effect now - the new code is in essence a 
> > NOP over what we had.
> 
> Maybe a dumb question. Why those changes in process_32.c in the patch 
> and not in process_64.c?

not a dumb question at all - i forgot about it. Find the updated patch 
below.

( sidenote: this shows the x86 unification concept in action. You
  noticed the missing _64.c probably because you saw a _32.c file 
  modified in the patch and the rule is that if we modify a _32.c file 
  then the matching _64.c file needs to be updated too. If this had been
  an old-style pre-unification arch/i386/kernel/process.c file you'd not
  have been able to tell this from just looking at the patch file - and
  we'd possibly have missed to include a fix on the 64-bit side. With
  the unification of files we are realizing it how many times this
  happened in the past (and went unnoticed). )

	Ingo

--------------------->
Subject: x86: idle wakeup event in the HLT loop
From: Ingo Molnar <mingo@elte.hu>

do a proper idle-wakeup event on HLT as well - some CPUs stop the TSC
in HLT too, not just when going through the ACPI methods.

(the ACPI idle code already does this.)

[ update the 64-bit side too, as noticed by Jiri Slaby. ]

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/process_32.c |   15 ++++++++++++---
 arch/x86/kernel/process_64.c |   13 ++++++++++---
 2 files changed, 22 insertions(+), 6 deletions(-)

Index: linux-x86.q/arch/x86/kernel/process_32.c
===================================================================
--- linux-x86.q.orig/arch/x86/kernel/process_32.c
+++ linux-x86.q/arch/x86/kernel/process_32.c
@@ -113,10 +113,19 @@ void default_idle(void)
 		smp_mb();
 
 		local_irq_disable();
-		if (!need_resched())
+		if (!need_resched()) {
+			ktime_t t0, t1;
+			u64 t0n, t1n;
+
+			t0 = ktime_get();
+			t0n = ktime_to_ns(t0);
 			safe_halt();	/* enables interrupts racelessly */
-		else
-			local_irq_enable();
+			local_irq_disable();
+			t1 = ktime_get();
+			t1n = ktime_to_ns(t1);
+			sched_clock_idle_wakeup_event(t1n - t0n);
+		}
+		local_irq_enable();
 		current_thread_info()->status |= TS_POLLING;
 	} else {
 		/* loop is done by the caller */
Index: linux-x86.q/arch/x86/kernel/process_64.c
===================================================================
--- linux-x86.q.orig/arch/x86/kernel/process_64.c
+++ linux-x86.q/arch/x86/kernel/process_64.c
@@ -116,9 +116,16 @@ static void default_idle(void)
 	smp_mb();
 	local_irq_disable();
 	if (!need_resched()) {
-		/* Enables interrupts one instruction before HLT.
-		   x86 special cases this so there is no race. */
-		safe_halt();
+		ktime_t t0, t1;
+		u64 t0n, t1n;
+
+		t0 = ktime_get();
+		t0n = ktime_to_ns(t0);
+		safe_halt();	/* enables interrupts racelessly */
+		local_irq_disable();
+		t1 = ktime_get();
+		t1n = ktime_to_ns(t1);
+		sched_clock_idle_wakeup_event(t1n - t0n);
 	} else
 		local_irq_enable();
 	current_thread_info()->status |= TS_POLLING;
