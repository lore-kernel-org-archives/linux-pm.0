From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] timers: Fix timer inaccuracy
Date: Thu, 10 Nov 2016 11:07:51 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1611101039540.3501@nanos>
References: <1478684203-11966-1-git-send-email-joonwoop@codeaurora.org> <alpine.DEB.2.20.1611091045040.3501@nanos> <53b2d275-23f2-9ee2-7bde-e441659cf885@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60936 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752771AbcKJKKb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 05:10:31 -0500
In-Reply-To: <53b2d275-23f2-9ee2-7bde-e441659cf885@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joonwoo Park <joonwoop@codeaurora.org>
Cc: John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <fweisbec@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 9 Nov 2016, Joonwoo Park wrote:
> On 11/09/2016 01:56 AM, Thomas Gleixner wrote:
> > That's simply wrong. We guarantee that the timer sleeps for at least a
> > jiffy. So in case of the first wheel we _must_ increment by one simply
> > because the next jiffie might be immanent and not doing so would expire the
> > timer early.
> > 
> > The wheel is not meant to be accurate at all and I really don't want an
> > extra conditional in that path just to make it accurate for some expiry
> > values. That's a completely pointless exercise.
> 
> I understand it's not meant to provide much of accuracy and also don't really
> care about accuracy of sporadic timer aim and fire.
> What I'm worried about is case that relies on periodic timer with relatively
> short interval.
> If you see bus scaling driver function devfreq_monitor() in
> drivers/devfreq/devfreq.c, it polls hardware every configured interval by
> using deferrable delayed work.  I'm not quite familiar with bus scaling so
> cc'ing linux-pm.

So you are not familiar with that and therefor use it as an argument for a
potential problem. Pretty scientific approach.

You already mentioned the keyword: DEFERRABLE, which is designed to be
inaccurate.
 
> My guess is that ever since we have timer refactoring, above driver is polling
> every configured jiffy + 1 most of time.

Sure, guess work is the right approach here.

> When CONFIG_HZ_100=y and the interval is 1, polling will be happening every
> 20ms rather than configured 10ms which is 100% later than ideal.

The wheel guarantees that the timer sleeps at least 1 jiffie and this can
only be done by adding one jiffie simply because:

CPU 0	   	CPU 1
		mod_timer(jiffies + 1)
timer irq
jiffies++	queue_timer
		timer_irq
		expire timer

So this timer expired exactly a few micro seconds after arming and therefor
violates the guarantee of firing not before the specified interval.

So depending on when you arm the timer the expiry is going to be:

   1 jiffie <= expiry <= 2 jiffies

If you disable high resolution timers then your user space program using
nanosleep will have exactly the same behaviour.

And this is the only sane behaviour you can expect from timers: To not
expire early.

Every user must cope with late expiry anyway as there is no guarantee that
the task is scheduled right away. Neither is there a guarantee that the
softirq (it might be deferred to ksoftirqd) invokes the callback on time.

The timer wheel is optimized for enqueue/dequeue speed and implicit
batching. Making it artificial accurate for one particular case is just
adding pointless overhead and aside of that it's going to violate the valid
assumption that a 1 jiffie sleep is going to sleep at least 1 jiffie.

> If that kind of drivers want to run periodic polling at similar level of
> accuracy like pre v4.8, each drivers have to switch to hrtimer but there are
> problems apart from the fact there is no nicely written deferred processing
> mechanism like workqueue with hrtimer -
> 1) there is no deferrable hrtimer.
> 2) hrtimer has more overhead more than low res timer, especially hrtimer will
> fire interrupt for individual timer lists which will cause power impact.

Deferrable timers shouldn't have been invented in the first place and yes,
they are not going to happen on hrtimers, quite the contrary, I'm working
on eliminating them completely.
 
> It also makes sense to me that queued timer especially with long delay is
> tolerable to inaccuracy especially when most of them got canceled prior to its
> expiry time.
> But by drivers which use timer as polling mechanism which never cancel it,
> IMHO this behaviour change could be a regression.

When you can come up with a real regression caused by the rework and not
just some handwaving theories then we can revisit that, but until then it's
going to stay as is.

Thanks,

	tglx
