From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Wed, 13 Jul 2016 16:00:04 +0900
Message-ID: <20160713070004.GB563@swordfish>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712093805.GA498@swordfish>
 <20160712125243.GA8597@pathway.suse.cz>
 <20160712131203.GN4695@ubuntu>
 <20160712171113.GD4695@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36733 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbcGMHAX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 03:00:23 -0400
Content-Disposition: inline
In-Reply-To: <20160712171113.GD4695@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Petr Mladek <pmladek@suse.com>, rjw@rjwysocki.net, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org

On (07/12/16 10:11), Viresh Kumar wrote:
> +extern bool printk_sync_suspended;
>  static int suspend_enter(suspend_state_t state, bool *wakeup)
>  {
>         char suspend_abort[MAX_SUSPEND_ABORT_LEN];
> @@ -218,6 +219,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>         }
>  
>         arch_suspend_disable_irqs();
> +       printk_sync_suspended = true;
>         BUG_ON(!irqs_disabled());
>  
>         error = syscore_suspend();
> @@ -237,6 +239,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>                 syscore_resume();
>         }
>  
> +       printk_sync_suspended = false;
>         arch_suspend_enable_irqs();
>         BUG_ON(irqs_disabled());
>  
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 46bb017ac2c9..187054074b96 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -293,6 +293,7 @@ static u32 log_buf_len = __LOG_BUF_LEN;
>  
>  /* Control whether printing to console must be synchronous. */
>  static bool __read_mostly printk_sync = false;
> +bool printk_sync_suspended = false;
>  /* Printing kthread for async printk */
>  static struct task_struct *printk_kthread;
>  /* When `true' printing thread has messages to print */
> @@ -300,7 +301,7 @@ static bool printk_kthread_need_flush_console;
>  
>  static inline bool can_printk_async(void)
>  {
> -       return !printk_sync && printk_kthread;
> +       return !printk_sync && !printk_sync_suspended && printk_kthread;
>  }
>  
>  /* Return log buffer address */
> 
> 
> i.e. I disabled async-printk after interrupts are disabled on the last
> running CPU (0) and enabled it again before enabling interrupts back.
> 
> This FIXES the hangs for me :)

ah, just saw this. OK, very close to what I sent in another thread, so I
guess it will work on your side.
let me know if it doesn't, I'll fold it into 0001 and re-spin the series.
thanks for your help!


I'll also drop the KERN_CONT patch for now. apparently it didn't work for
Petr.

	-ss
