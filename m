From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3] cpuidle: Handle tick_broadcast_enter() failure gracefully
Date: Sat, 09 May 2015 20:46:20 +0200
Message-ID: <4263013.jBGApPfu4h@vostro.rjw.lan>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com> <8680371.ymYIEaFYPT@vostro.rjw.lan> <554D9FDC.6090608@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50836 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750994AbbEISVS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 May 2015 14:21:18 -0400
In-Reply-To: <554D9FDC.6090608@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: peterz@infradead.org, tglx@linutronix.de, rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org, rlippert@google.com, linux-pm@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com, linuxppc-dev@lists.ozlabs.org

On Saturday, May 09, 2015 11:19:16 AM Preeti U Murthy wrote:
> Hi Rafael,
> 
> On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:
> >> +/*
> >> + * find_tick_valid_state - select a state where tick does not stop
> >> + * @dev: cpuidle device for this cpu
> >> + * @drv: cpuidle driver for this cpu
> >> + */
> >> +static int find_tick_valid_state(struct cpuidle_device *dev,
> >> +				struct cpuidle_driver *drv)
> >> +{
> >> +	int i, ret = -1;
> >> +
> >> +	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
> >> +		struct cpuidle_state *s = &drv->states[i];
> >> +		struct cpuidle_state_usage *su = &dev->states_usage[i];
> >> +
> >> +		/*
> >> +		 * We do not explicitly check for latency requirement
> >> +		 * since it is safe to assume that only shallower idle
> >> +		 * states will have the CPUIDLE_FLAG_TIMER_STOP bit
> >> +		 * cleared and they will invariably meet the latency
> >> +		 * requirement.
> >> +		 */
> >> +		if (s->disabled || su->disable ||
> >> +			(s->flags & CPUIDLE_FLAG_TIMER_STOP))
> >> +			continue;
> >> +
> >> +		ret = i;
> >> +	}
> >> +	return ret;
> >> +}
> >> +
> >>  /**
> >>   * cpuidle_enter_state - enter the state and update stats
> >>   * @dev: cpuidle device for this cpu
> >> @@ -168,10 +199,17 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
> >>  	 * CPU as a broadcast timer, this call may fail if it is not available.
> >>  	 */
> >>  	if (broadcast && tick_broadcast_enter()) {
> >> -		default_idle_call();
> >> -		return -EBUSY;
> >> +		index = find_tick_valid_state(dev, drv);
> > 
> > Well, the new state needs to be deeper than the old one or you may violate the
> > governor's choice and this doesn't guarantee that.
> 
> The comment above in find_tick_valid_state() explains why we are bound
> to choose a shallow idle state. I think its safe to assume that any
> state deeper than this one, would have the CPUIDLE_FLAG_TIMER_STOP flag
> set and hence would be skipped.
> 
> Your patch relies on the assumption that the idle states are arranged in
> the increasing order of exit_latency/in the order of shallow to deep.
> This is not guaranteed, is it?

No, it isn't, which is a good point.  There's no reason to rely on that
assumption, so appended is an updated version of the patch using a latency
limit instead of an index limit.

> 
> > 
> > Also I don't quite see a reason to duplicate the find_deepest_state() functionality
> > here.
> 
> Agreed. We could club them like in your patch.
> 
> > 
> >> +		if (index < 0) {
> >> +			default_idle_call();
> >> +			return -EBUSY;
> >> +		}
> >> +		target_state = &drv->states[index];
> >>  	}
> >>  
> >> +	/* Take note of the planned idle state. */
> >> +	idle_set_state(smp_processor_id(), target_state);
> > 
> > And I wouldn't do this either.
> > 
> > The behavior here is pretty much as though the driver demoted the state chosen
> > by the governor and we don't call idle_set_state() again in those cases.
> 
> Why is this wrong?

Because it is inconsistent, but let me reply to this in a separate message.

Anyway, it is a different problem and should be addressed by a separate
patch IMO.


