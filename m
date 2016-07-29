From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Fri, 29 Jul 2016 13:42:01 -0700
Message-ID: <20160729204201.GA4605@ubuntu>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
 <20160713054507.GA563@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34050 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbcG2UmF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2016 16:42:05 -0400
Received: by mail-pa0-f45.google.com with SMTP id fi15so34219370pac.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Jul 2016 13:42:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160713054507.GA563@swordfish>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, rjw@rjwysocki.net, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>

On 13-07-16, 14:45, Sergey Senozhatsky wrote:
> something like below, perhaps. will this work for you?
> 
> ---
>  kernel/printk/printk.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index bbb4180..786690e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -288,6 +288,11 @@ static u32 log_buf_len = __LOG_BUF_LEN;
>  
>  /* Control whether printing to console must be synchronous. */
>  static bool __read_mostly printk_sync = true;
> +/*
> + * Force sync printk mode during suspend/kexec, regardless whether
> + * console_suspend_enabled permits console suspend.
> + */
> +static bool __read_mostly force_printk_sync;
>  /* Printing kthread for async printk */
>  static struct task_struct *printk_kthread;
>  /* When `true' printing thread has messages to print */
> @@ -295,7 +300,7 @@ static bool printk_kthread_need_flush_console;
>  
>  static inline bool can_printk_async(void)
>  {
> -	return !printk_sync && printk_kthread;
> +	return !printk_sync && printk_kthread && !force_printk_sync;
>  }
>  
>  /* Return log buffer address */
> @@ -2027,6 +2032,7 @@ static bool suppress_message_printing(int level) { return false; }
>  
>  /* Still needs to be defined for users */
>  DEFINE_PER_CPU(printk_func_t, printk_func);
> +static bool __read_mostly force_printk_sync;
>  
>  #endif /* CONFIG_PRINTK */
>  
> @@ -2163,6 +2169,8 @@ MODULE_PARM_DESC(console_suspend, "suspend console during suspend"
>   */
>  void suspend_console(void)
>  {
> +	force_printk_sync = true;
> +
>  	if (!console_suspend_enabled)
>  		return;
>  	printk("Suspending console(s) (use no_console_suspend to debug)\n");
> @@ -2173,6 +2181,8 @@ void suspend_console(void)
>  
>  void resume_console(void)
>  {
> +	force_printk_sync = false;
> +
>  	if (!console_suspend_enabled)
>  		return;
>  	down_console_sem();

I haven't seen any issues with it yet and it works just fine. Please feel free
to add below for the entire series including this hunk.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
