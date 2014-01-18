From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH REGRESSION FIX] x86 idle: restore mwait_idle()
Date: Sat, 18 Jan 2014 10:33:53 +0100
Message-ID: <1390037633.5676.3.camel@marge.simpson.net>
References: <1ae2a8af42281d6b9888ac8c76bab7bd2f431d44.1389763084.git.len.brown@intel.com>
	 <345254a551eb5a6a866e048d7ab570fd2193aca4.1389763084.git.len.brown@intel.com>
	 <52D8567A.8090308@mit.edu> <1389932442.5449.4.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1389932442.5449.4.camel@marge.simpson.net>
Sender: stable-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Ian Malone <ibmalone@gmail.com>, Josh Boyer <jwboyer@redhat.com>, stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2014-01-17 at 05:20 +0100, Mike Galbraith wrote:

> taskset 0xc pipe-test 1
> 
> 3.8.13     3.397977 usecs/loop -- avg 3.400336 588.2 KHz
> master+    4.798547 usecs/loop -- avg 4.791692 417.4 KHz

Bah, those are apple/grape, these are apple/apple.

idle: kill unnecessary mwait_idle() resched IPIs

Set/clear polling instead.

Q6600, pipe-test scheduling cross core:
3.8.13                   487.2 KHz    1.000
3.13.0-master            415.5 KHz     .852
3.13.0-master+           415.2 KHz     .852     + restore mwait_idle
3.13.0-master++          488.5 KHz    1.002     + restore mwait_idle + IPI fix

Signed-off-by: Mike Galbraith <bitbucket@online.de>
---
 arch/x86/kernel/process.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -427,18 +427,18 @@ static int prefer_mwait_c1_over_halt(con
 
 static void mwait_idle(void)
 {
-	if (!need_resched()) {
+	if (!current_set_polling_and_test()) {
 		if (this_cpu_has(X86_FEATURE_CLFLUSH_MONITOR))
 			clflush((void *)&current_thread_info()->flags);
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		smp_mb();
 		if (!need_resched())
 			__sti_mwait(0, 0);
 		else
 			local_irq_enable();
 	} else
 		local_irq_enable();
+	__current_clr_polling();
 }
 
 void select_idle_routine(const struct cpuinfo_x86 *c)
