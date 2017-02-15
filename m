From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: Regression in next with use printk_safe buffers in printk
Date: Wed, 15 Feb 2017 13:44:44 +0900
Message-ID: <20170215044444.GA1834@jagdpanzerIV.localdomain>
References: <20170213185956.GM3897@atomide.com>
 <20170214160140.GA401@tigerII.localdomain>
 <20170214161809.GQ6500@twins.programming.kicks-ass.net>
 <20170214165645.GB10321@tigerII.localdomain>
 <20170214170335.GS3897@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36155 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdBOEoZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2017 23:44:25 -0500
Content-Disposition: inline
In-Reply-To: <20170214170335.GS3897@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, John Stultz <john.stultz@linaro.org>

On (02/14/17 09:03), Tony Lindgren wrote:
[..]
> > Do not call printk() from tk_debug_account_sleep_time(), because
> > tk_debug_account_sleep_time() is called under tk_core seq lock.
> > It's not safe to call printk() under tk_core, because console_sem
> > invokes scheduled (via wake_up_process()->activate_task()), which,
> > in turn, can call timekeeping code again, for instance, via
> > get_time()->ktime_get(). This may result in infinite loop on
> > tk_core.
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> Thanks yeah this fixes the issue for me:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

thanks.

	-ss
