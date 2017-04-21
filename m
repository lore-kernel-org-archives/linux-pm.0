From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [patch V2 03/10] timers: Rework idle logic
Date: Fri, 21 Apr 2017 16:43:59 +0200
Message-ID: <20170421144358.GC2586@lerouge>
References: <20170418111102.490432548@linutronix.de>
 <20170418111400.589271247@linutronix.de>
 <20170419065039.nhmi5vrhydqy5ftw@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170419065039.nhmi5vrhydqy5ftw@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 19, 2017 at 08:50:39AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 18, 2017 at 01:11:05PM +0200, Thomas Gleixner wrote:
> > Storing next event and determining whether the base is idle can be done in
> > __next_timer_interrupt(). 
> > 
> > Preparatory patch for new call sites which need this information as well.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/time/timer.c |   43 ++++++++++++++++++++++++-------------------
> >  1 file changed, 24 insertions(+), 19 deletions(-)
> > 
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -1358,8 +1358,11 @@ static int next_pending_bucket(struct ti
> >  /*
> >   * Search the first expiring timer in the various clock levels. Caller must
> >   * hold base->lock.
> > + *
> > + * Stores the next expiry time in base. The return value indicates whether
> > + * the base is empty or not.
> >   */
> > -static unsigned long __next_timer_interrupt(struct timer_base *base)
> > +static bool __next_timer_interrupt(struct timer_base *base)
> 
> Can't say I'm a fan of this.. I sort of see where this is going, but the
> fact remains that __next_timer_interrupt(), as a function, makes me
> expect a return value of time/timer quantity.

Maybe we can just do a rename like fetch_next_timer_interrupt() or
update_next_timer_interrupt()?
