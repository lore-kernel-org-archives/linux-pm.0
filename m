From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] cpuidle / sleep: fix timer stopping regression (was: drivers: cpuidle: minor suspend-to-idle fixes)
Date: Mon, 02 Mar 2015 15:50:26 +0100
Message-ID: <1882932.aLeaejbmMz@vostro.rjw.lan>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com> <20150302100823.GA23990@red-moon> <1809382.kscziWfTPN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1809382.kscziWfTPN@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Monday, March 02, 2015 02:13:05 PM Rafael J. Wysocki wrote:
> On Monday, March 02, 2015 10:08:23 AM Lorenzo Pieralisi wrote:
> > On Sat, Feb 28, 2015 at 11:58:21PM +0000, Rafael J. Wysocki wrote:
> > > On Saturday, February 28, 2015 11:54:23 AM Lorenzo Pieralisi wrote:
> 
> [cut]
> 
> > > Index: linux-pm/drivers/cpuidle/cpuidle.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> > > +++ linux-pm/drivers/cpuidle/cpuidle.c
> > > @@ -230,15 +230,39 @@ int cpuidle_select(struct cpuidle_driver
> > >   * @dev:   the cpuidle device
> > >   * @index: the index in the idle state table
> > >   *
> > > - * Returns the index in the idle state, < 0 in case of error.
> > > - * The error code depends on the backend driver
> > > + * Returns the index in the idle state, < 0 in case of error.  -EBUSY is
> > > + * returned to indicate that the target state was temporarily inaccessible.
> > > + * The other error codes depend on the backend driver.
> > >   */
> > >  int cpuidle_enter(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > >  		  int index)
> > >  {
> > > -	if (cpuidle_state_is_coupled(dev, drv, index))
> > > -		return cpuidle_enter_state_coupled(dev, drv, index);
> > > -	return cpuidle_enter_state(dev, drv, index);
> > > +	unsigned int broadcast;
> > > +	int ret;
> > > +
> > > +	broadcast = drv->states[index].flags & CPUIDLE_FLAG_TIMER_STOP;
> > > +
> > > +	/*
> > > +	 * Tell the time framework to switch to a broadcast timer
> > > +	 * because our local timer will be shutdown. If a local timer
> > > +	 * is used from another cpu as a broadcast timer, this call may
> > > +	 * fail if it is not available
> > > +	 */
> > > +	if (broadcast) {
> > > +		ret = clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
> > > +					 &dev->cpu);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	ret = cpuidle_state_is_coupled(dev, drv, index) ?
> > > +		cpuidle_enter_state_coupled(dev, drv, index) :
> > > +		cpuidle_enter_state(dev, drv, index);
> > > +
> > > +	if (broadcast)
> > > +		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> > > +
> > > +	return ret;
> > 
> > You have to check this return value in cpuidle_enter_freeze() too
> > otherwise we return to the idle thread on -EBUSY without
> > even executing arch_cpu_idle() and with IRQ disabled, code hits
> > the WARN_ON_ONCE line 180.
> 
> Right.
> 
> > There are multiple ways of fixing the issue, either you check the
> > cpuidle_enter_freeze() return value (you add one) to cpuidle_idle_call()
> > to make code consistent with the cpuidle_idle_call "normal" idle
> > behaviour or you add the return value check in cpuidle_enter_freeze(),
> > I am fine both ways.
> 
> Well, in both cases we'd end up with a function enabling interrupts on exit
> in some cases and not doing that in some other ones.  Not nice.
> 
> Below is an alternative to that (on top of the previous patches).  Can you
> test it please?

Actually, this one is still slightly incorrect, because we only should call
cpuidle_reflect() if we've called cpuidle_select() before.  Also it's better
to pass cpuidle_driver and cpuidle_device to all functions called by
cpuidle_idle_call().

Two patches will follow.  [1/2] is a cleanup re-arranging the code in
cpuidle_idle_call() to move the fallback path to the end of the function.
[2/2] is a replacement for the patch sent previously.

Please test.

Rafael
