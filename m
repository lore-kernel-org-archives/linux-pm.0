From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] cpuidle: delay enabling interrupts until all coupled
 CPUs leave idle
Date: Tue, 11 Mar 2014 09:41:36 +0000
Message-ID: <20140311094136.GP17457@pburton-linux.le.imgtec.org>
References: <1394103721-32616-1-git-send-email-paul.burton@imgtec.com>
 <6009429.TU4uH7j3ue@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.89.28.115]:47113 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbaCKJlj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Mar 2014 05:41:39 -0400
Content-Disposition: inline
In-Reply-To: <6009429.TU4uH7j3ue@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>

On Thu, Mar 06, 2014 at 01:55:06PM +0100, Rafael J. Wysocki wrote:
> On Thursday, March 06, 2014 11:02:01 AM Paul Burton wrote:
> > As described by a comment at the end of cpuidle_enter_state_coupled it
> > can be inefficient for coupled idle states to return with IRQs enabled
> > since they may proceed to service an interrupt instead of clearing the
> > coupled idle state. Until they have finished & cleared the idle state
> > all CPUs coupled with them will spin rather than being able to enter a
> > safe idle state.
> > 
> > Commits e1689795a784 "cpuidle: Add common time keeping and irq
> > enabling" and 554c06ba3ee2 "cpuidle: remove en_core_tk_irqen flag" led
> > to the cpuidle_enter_state enabling interrupts for all idle states,
> > including coupled ones, making this inefficiency unavoidable by drivers
> > & the local_irq_enable near the end of cpuidle_enter_state_coupled
> > redundant. This patch avoids enabling interrupts in cpuidle_enter_state
> > after a coupled state has been entered, allowing them to remain disabled
> > until all coupled CPUs have exited the idle state and
> > cpuidle_enter_state_coupled re-enables them.
> 
> This appears to be a regression.
> 
> Are there any bug reports related to it?  Alternatively, can you reproduce
> it and if so, then on what hardware?

I'm not aware of any bug reports related to this (though I haven't gone
looking). I can see the issue occur with (a further developed version
of) the MIPS CPS cpuidle driver I posted a while ago. I haven't measured
the impact on exit latency (which I suppose would be variable anyway
depending on the pending interrupt(s)) but have seen the issue with
interrupts processed whilst a coupled CPU spins. Given that there is
clearly an inconsistency between cpuidle_enter_state &
cpuidle_enter_state_coupled, and given that the latter documents the
issue & its intent with regards to IRQs pretty clearly, this would seem
to be the obvious fix.

Thanks,
    Paul

> 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  drivers/cpuidle/cpuidle.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index a55e68f..366e684 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -85,7 +85,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
> >  
> >  	time_end = ktime_get();
> >  
> > -	local_irq_enable();
> > +	if (!cpuidle_state_is_coupled(dev, drv, entered_state))
> > +		local_irq_enable();
> >  
> >  	diff = ktime_to_us(ktime_sub(time_end, time_start));
> >  	if (diff > INT_MAX)
> > 
> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
