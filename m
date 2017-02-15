From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: Regression in next with use printk_safe buffers in printk
Date: Wed, 15 Feb 2017 13:49:07 +0900
Message-ID: <20170215044907.GB1834@jagdpanzerIV.localdomain>
References: <20170213185956.GM3897@atomide.com>
 <20170214160140.GA401@tigerII.localdomain>
 <20170214161809.GQ6500@twins.programming.kicks-ass.net>
 <20170214165645.GB10321@tigerII.localdomain>
 <20170214182956.GS6500@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36276 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdBOEsr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2017 23:48:47 -0500
Content-Disposition: inline
In-Reply-To: <20170214182956.GS6500@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tony Lindgren <tony@atomide.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, John Stultz <john.stultz@linaro.org>

On (02/14/17 19:29), Peter Zijlstra wrote:
> On Wed, Feb 15, 2017 at 01:56:45AM +0900, Sergey Senozhatsky wrote:
> > that crossed my mind, but I kinda assumed that we do printk() from
> > under tk_core using sched fair, and rt_runtime_lock is from sched rt.
> 
> That's all true; lockdep doesn't care :-) All it knows is that at some
> point those locks nest.

thanks.

I think I'll get more familiar with the lockdep splats in
coming months :) but it's good (well, so far) that now we
keep lockdep enabled in printk.

	-ss
