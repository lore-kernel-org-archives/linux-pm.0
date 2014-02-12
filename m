From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Is it ok for deferrable timer wakeup the idle cpu?
Date: Wed, 12 Feb 2014 16:06:29 +0100
Message-ID: <20140212150627.GB5496@localhost.localdomain>
References: <CALZhoSQZQcM0yKTw1=ZkYz3Z_3X2QxLk0vCw6gKXW55HSrVEdw@mail.gmail.com>
 <alpine.DEB.2.02.1401221459590.4260@ionos.tec.linutronix.de>
 <CALZhoSSSOZKwDok2ZHumeZAs0R88SC6bU2BaL54U3TU6jgoaZA@mail.gmail.com>
 <CAKohpomMZ0TAN2e6N76_g4ZRzxd5vZ1XfuZfxrP7GMxfTNiLVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:41139 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbaBLPGd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2014 10:06:33 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpomMZ0TAN2e6N76_g4ZRzxd5vZ1XfuZfxrP7GMxfTNiLVw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lei Wen <adrian.wenl@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Viresh,

On Thu, Jan 23, 2014 at 11:22:32AM +0530, Viresh Kumar wrote:
> 
> Hi Guys,
> 
> So the first question is why cpufreq needs it and is it really stupid?
> Yes, it is stupid but that's how its implemented since a long time. It does
> so to get data about the load on CPUs, so that freq can be scaled up/down.
> 
> Though there is a solution in discussion currently, which will take
> inputs from scheduler and so these background timers would go away.
> But we need to wait until that time.
> 
> Now, why do we need that for every cpu, while that for a single cpu might
> be enough? The answer is cpuidle here: What if the cpu responsible for
> running timer goes to sleep? Who will evaluate the load then? And if we
> make this timer run on one cpu in non-deferrable mode then that cpu
> would be waken up again and again from idle. So, it was decided to have
> a per-cpu deferrable timer. Though to improve efficiency, once it is fired
> on any cpu, timer for all other CPUs are rescheduled, so that they don't
> fire before 5ms (sampling time)..
> 
> I think below diff might get this fixed for you, though I am not sure if it
> breaks something else. Probably Thomas/Frederic can answer here.
> If this looks fine I will send it formally again:
> 
> diff --git a/kernel/timer.c b/kernel/timer.c
> index accfd24..3a2c7fa 100644
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -940,7 +940,8 @@ void add_timer_on(struct timer_list *timer, int cpu)
>          * makes sure that a CPU on the way to stop its tick can not
>          * evaluate the timer wheel.
>          */
> -       wake_up_nohz_cpu(cpu);
> +       if (!tbase_get_deferrable(timer->base))
> +               wake_up_nohz_cpu(cpu);

The change I'm applying is strongly inspired from the above. Can I use your Signed-off-by?

Thanks.

>         spin_unlock_irqrestore(&base->lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(add_timer_on);
