From: Don Zickus <dzickus@redhat.com>
Subject: Re: suspend regression in 4.1-rc1
Date: Mon, 18 May 2015 10:26:07 -0400
Message-ID: <20150518142607.GL184517@redhat.com>
References: <20150517185041.GA5897@dhcp22.suse.cz>
 <CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
 <20150518073046.GO17717@twins.programming.kicks-ass.net>
 <20150518090336.GA6393@dhcp22.suse.cz>
 <20150518093150.GC21418@twins.programming.kicks-ass.net>
 <309071648.615900.1431946606778.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49217 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbbERO07 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 May 2015 10:26:59 -0400
Content-Disposition: inline
In-Reply-To: <309071648.615900.1431946606778.JavaMail.zimbra@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulrich Obergfell <uobergfe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, May 18, 2015 at 06:56:46AM -0400, Ulrich Obergfell wrote:
> 
> > There further appears to be a distinct lack of serialization between
> > setting and using watchdog_enabled, so perhaps we should wrap the
> > {en,dis}able_all() things in watchdog_proc_mutex.
> 
> As I understand it, the {en,dis}able_all() functions are only called early
> at kernel startup, so I do not see how they could be racing with watchdog
> code that is executed in the context of write() system calls to parameters
> in /proc/sys/kernel. Please see also my earlier reply to Michal for further
> details: http://marc.info/?l=linux-pm&m=143194387208250&w=2
> 
> Do we really need synchronization here?

As Peter said we have to focus on doing things correctly and not based on
what is currently.

During s2ram, I believe all the threads get parked and then unparked during
resume.  I am wondering if the race happens there, threads get unparked and
stomp on each other when watchdog_nmi_enable_all() is called.  (or vice
versa on the way down).  I think during boot the cpu bring up is slow enough
that the race doesn't happen, but s2ram is alot quicker.  My guess.

Cheers,
Don

> 
> > This patch fixes a s2r failure reported by Michal; which I cannot
> > readily explain. But this does make the code internally consistent
> > again.
> >
> > Reported-and-tested-by: Michal Hocko <mhocko@suse.cz>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/watchdog.c |   20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index 2316f50..506edcc5 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -41,6 +41,8 @@
> >  #define NMI_WATCHDOG_ENABLED      (1 << NMI_WATCHDOG_ENABLED_BIT)
> >  #define SOFT_WATCHDOG_ENABLED     (1 << SOFT_WATCHDOG_ENABLED_BIT)
> > 
> > +static DEFINE_MUTEX(watchdog_proc_mutex);
> > +
> >  #ifdef CONFIG_HARDLOCKUP_DETECTOR
> >  static unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
> >  #else
> > @@ -608,26 +610,36 @@ void watchdog_nmi_enable_all(void)
> >  {
> >          int cpu;
> > 
> > -        if (!watchdog_user_enabled)
> > -                return;
> > +        mutex_lock(&watchdog_proc_mutex);
> > +
> > +        if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
> > +                goto unlock;
> > 
> >          get_online_cpus();
> >          for_each_online_cpu(cpu)
> >                  watchdog_nmi_enable(cpu);
> >          put_online_cpus();
> > +
> > +unlock:
> > +        mutex_lock(&watchdog_proc_mutex);
> >  }
> > 
> >  void watchdog_nmi_disable_all(void)
> >  {
> >          int cpu;
> > 
> > +        mutex_lock(&watchdog_proc_mutex);
> > +
> >          if (!watchdog_running)
> > -                return;
> > +                goto unlock;
> > 
> >          get_online_cpus();
> >          for_each_online_cpu(cpu)
> >                  watchdog_nmi_disable(cpu);
> >          put_online_cpus();
> > +
> > +unlock:
> > +        mutex_unlock(&watchdog_proc_mutex);
> >  }
> >  #else
> >  static int watchdog_nmi_enable(unsigned int cpu) { return 0; }
> > @@ -744,8 +756,6 @@ static int proc_watchdog_update(void)
> > 
> >  }
> > 
> > -static DEFINE_MUTEX(watchdog_proc_mutex);
> > -
> >  /*
> >   * common function for watchdog, nmi_watchdog and soft_watchdog parameter
> >   *
