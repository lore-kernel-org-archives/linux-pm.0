From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Tue, 12 Jul 2016 10:11:13 -0700
Message-ID: <20160712171113.GD4695@ubuntu>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712093805.GA498@swordfish>
 <20160712125243.GA8597@pathway.suse.cz>
 <20160712131203.GN4695@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33337 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbcGLRLP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2016 13:11:15 -0400
Received: by mail-pa0-f45.google.com with SMTP id ks6so8453480pab.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2016 10:11:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160712131203.GN4695@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, rjw@rjwysocki.net
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org

On 12-07-16, 06:12, Viresh Kumar wrote:

> Yeah, so I tried debugging this more and I am able to get printing
> done to just before arch_suspend_disable_irqs() in suspend.c and then
> it stops because of the async nature.
> 
> I get to this point for both successful suspend/resume (where system
> resumes back successfully) and in the bad case (where the system just
> hangs/crashes).
> 
> FWIW, I also tried commenting out following in suspend_enter():
> 
>         error = suspend_ops->enter(state);
> 
> so that the system doesn't go into suspend at all, and just resume
> back immediately (similar to TEST_CORE) and I saw the hang/crash then
> as well one of the times.

So I tried it cleanly without any local hacks using:

echo core > /sys/power/pm_test

and I still see the problem, so whatever happens, happens before
putting the system into complete suspend.

FWIW, I also tried this hacky thing:

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index bc71478fac26..045ebc88fe08 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -170,6 +170,7 @@ void __attribute__ ((weak)) arch_suspend_enable_irqs(void)
  *
  * This function should be called after devices have been suspended.
  */
+extern bool printk_sync_suspended;
 static int suspend_enter(suspend_state_t state, bool *wakeup)
 {
        char suspend_abort[MAX_SUSPEND_ABORT_LEN];
@@ -218,6 +219,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
        }
 
        arch_suspend_disable_irqs();
+       printk_sync_suspended = true;
        BUG_ON(!irqs_disabled());
 
        error = syscore_suspend();
@@ -237,6 +239,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
                syscore_resume();
        }
 
+       printk_sync_suspended = false;
        arch_suspend_enable_irqs();
        BUG_ON(irqs_disabled());
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 46bb017ac2c9..187054074b96 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -293,6 +293,7 @@ static u32 log_buf_len = __LOG_BUF_LEN;
 
 /* Control whether printing to console must be synchronous. */
 static bool __read_mostly printk_sync = false;
+bool printk_sync_suspended = false;
 /* Printing kthread for async printk */
 static struct task_struct *printk_kthread;
 /* When `true' printing thread has messages to print */
@@ -300,7 +301,7 @@ static bool printk_kthread_need_flush_console;
 
 static inline bool can_printk_async(void)
 {
-       return !printk_sync && printk_kthread;
+       return !printk_sync && !printk_sync_suspended && printk_kthread;
 }
 
 /* Return log buffer address */


i.e. I disabled async-printk after interrupts are disabled on the last
running CPU (0) and enabled it again before enabling interrupts back.

This FIXES the hangs for me :)


I don't think its a crash but some sort of deadlock in async printk
thread because of the state it was left in before we offlined all
other CPUs and disabled interrupts on the local one.

-- 
viresh
