From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Regression in next with use printk_safe buffers in printk
Date: Tue, 14 Feb 2017 17:18:09 +0100
Message-ID: <20170214161809.GQ6500@twins.programming.kicks-ass.net>
References: <20170213185956.GM3897@atomide.com>
 <20170214160140.GA401@tigerII.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47507 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754173AbdBNQSS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2017 11:18:18 -0500
Content-Disposition: inline
In-Reply-To: <20170214160140.GA401@tigerII.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Wed, Feb 15, 2017 at 01:01:40AM +0900, Sergey Senozhatsky wrote:
> 
> but I'm a bit confused by rt_b->rt_runtime_lock in this unsafe lock
> scenario (so it's not ABBA, but ABAD)
> 
> >   lock(hrtimer_bases.lock);
> >                                lock(&rt_b->rt_runtime_lock);
> >                                lock(hrtimer_bases.lock);
> >   lock(tk_core);
> >
> >
> > Chain exists of:
> >
> >	tk_core --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock
> 
> 
> I'm lacking some knowledge here, sorry. where does the tk_core --> &rt_b->rt_runtime_lock
> come from?

rt_b->rt_runtime_lock is one of the scheduler locks, since we do
printk() under tk_core, which does semaphore muck, which then includes
the entire scheduler chain of locks.
