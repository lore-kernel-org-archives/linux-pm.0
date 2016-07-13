From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Wed, 13 Jul 2016 16:18:58 -0700
Message-ID: <20160713231858.GG4695@ubuntu>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
 <20160713054507.GA563@swordfish>
 <20160713153910.GY4695@ubuntu>
 <CAJZ5v0ifOMb=wCvCRoGb2AHTfGLc0z10_fPUYVMP3pH_kWtr4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32937 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbcGMXTG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 19:19:06 -0400
Received: by mail-pa0-f54.google.com with SMTP id ks6so22014057pab.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2016 16:19:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ifOMb=wCvCRoGb2AHTfGLc0z10_fPUYVMP3pH_kWtr4A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Alex Elder <alex.elder@linaro.org>, johan@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Linux PM <linux-pm@vger.kernel.org>, Petr Mladek <pmladek@suse.com>

On 14-07-16, 01:08, Rafael J. Wysocki wrote:
> On Wed, Jul 13, 2016 at 5:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Maybe not, as this can still lead to the original bug we were all
> > chasing. This may hog some other CPU if we are doing excessive
> > printing in suspend :(
> 
> How can it hog that CPU, exactly?

Not *that* CPU, but any of the CPUs. Because we are moving back to
synchronous printing, any CPU which is doing a lot of printing, may
end up spending all its time in the print-loop (as the original
problem we had).

> > suspend_console() is called quite early, so for example in my case we
> > do lots of printing during suspend (not from the suspend thread, but
> > an IRQ handled by the USB subsystem, which removes a bus with help of
> > some other thread probably).
> 
> Why doing a lot of printing from an IRQ is not regarded as a bug?

We aren't doing it in Interrupt Context or with interrupts disabled,
but perhaps in the kthread managed by usb hub core.

But, I am not only talking about my platform's printing issues, but
the idea behind the patches that Sergey and Jan are working on. If we
move back to synchronous printing before starting to suspend the
devices, we may have the same problem again that we were trying to
solve.

> Are all of those messages printed actually useful?

Hmm, maybe not. But that's not the point I was trying to raise, as I
earlier mentioned :)

We have a problem with asynchronous printing after disabling
interrupts on the last running CPU, and we are trying to disable that
from suspend_console(), because we already have a function to call
this from.

> > That is why my Hacky patch tried to do it after devices are removed
> > and irqs are disabled, but before syscore users are suspended (and
> > timekeeping is one of them). And so it fixes it for me completely.
> >
> > IOW, we should switch back to synchronous printing after disabling
> > interrupts on the last running CPU.
> >
> > And I of course agree with Rafael that we would need something similar
> > in Hibernation code path as well, if we choose to fix it my way.
> 
> Well, the patch proposed by Sergey is sufficient to fix the deadlock
> issue and it is not clear that anything more needs to be done.
> 
> My suggestion, then, would be to use this patch to start with and see
> if things really go worse then.

Sure, I am just saying that theoretically, we can still have the CPU
hog problem that we all started with :)

-- 
viresh
