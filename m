From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: lockdep splat in CPU hotplug
Date: Tue, 21 Oct 2014 09:23:30 -0700
Message-ID: <20141021162330.GJ4977@linux.vnet.ibm.com>
References: <alpine.LNX.2.00.1410211255531.24255@pobox.suse.cz>
 <20141021151043.GA11800@redhat.com>
 <alpine.LNX.2.00.1410211717210.24255@pobox.suse.cz>
 <20141021160029.GH4977@linux.vnet.ibm.com>
 <alpine.LNX.2.00.1410211802500.24255@pobox.suse.cz>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1410211802500.24255@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dave Jones <davej@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 21, 2014 at 06:04:52PM +0200, Jiri Kosina wrote:
> On Tue, 21 Oct 2014, Paul E. McKenney wrote:
> 
> > > Looks like this indeed is something that lockdep *should* report (*), 
> > > although I would be suprised that stack unwinder would be so confused 
> > > by this -- there is no way for synchronize_sched_expedited() to be 
> > > inlined all the way to cpuidle_pause().
> > 
> > I think that if synchronize_sched_expedited() was in fact called, it
> > had already returned by the time we hit this problem.  But I must confess
> > that I am not seeing how cpuidle_uninstall_idle_handler() gets to
> > synchronize_rcu().
> 
> Umm, it directly calls it? :-)
> 
> 	void cpuidle_uninstall_idle_handler(void)
> 	{
> 		if (enabled_devices) {
> 			initialized = 0;
> 			wake_up_all_idle_cpus();
> 		}
> 
> 		/*
> 		 * Make sure external observers (such as the scheduler)
> 		 * are done looking at pointed idle states.
> 		 */
> 		synchronize_rcu();
> 	}

Ah, it would help if I did "git checkout linus/master" after updating,
wouldn't it now?

> > > (*) there are multiple places where cpu_hotplug.lock -> cpuidle_lock lock 
> > >     dependency is assumed. The patch that Dave pointed out adds 
> > >     cpuidle_lock -> cpu_hotplug.lock dependency.
> > > 
> > > Still not clear whether this is what's happening here ... anyway, adding 
> > > Paul to CC.
> > 
> > Hmmm...
> > 
> > Both cpuidle_pause() and cpuidle_pause_and_lock() acquire cpuidle_lock,
> > and are at the top of both stacks.  Which was the original confusion.  ;-)
> 
> Yup, they are, but lockdep is complaining about cpuidle_pause() acquiring 
> cpu_hotplug.lock ...

If it was attempting to acquire it via synchronize_sched_expedited(),
the attempt would fail and synchronize_sched_expedited() would fall
back to synchronize_sched()'s normal grace-period mechanism.  (Not to
synchronize_sched() itself, of course, as that would be infinite
recursion.)

So I believe that something else is going on here.

							Thanx, Paul
