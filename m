From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Regression in next with use printk_safe buffers in printk
Date: Tue, 14 Feb 2017 19:29:56 +0100
Message-ID: <20170214182956.GS6500@twins.programming.kicks-ass.net>
References: <20170213185956.GM3897@atomide.com>
 <20170214160140.GA401@tigerII.localdomain>
 <20170214161809.GQ6500@twins.programming.kicks-ass.net>
 <20170214165645.GB10321@tigerII.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:40203 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbdBNSaJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2017 13:30:09 -0500
Content-Disposition: inline
In-Reply-To: <20170214165645.GB10321@tigerII.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, John Stultz <john.stultz@linaro.org>

On Wed, Feb 15, 2017 at 01:56:45AM +0900, Sergey Senozhatsky wrote:
> that crossed my mind, but I kinda assumed that we do printk() from
> under tk_core using sched fair, and rt_runtime_lock is from sched rt.

That's all true; lockdep doesn't care :-) All it knows is that at some
point those locks nest.
