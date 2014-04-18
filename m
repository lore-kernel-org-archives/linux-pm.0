From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCHC 3/3] sched/fair: use the idle state info to choose
 the idlest cpu
Date: Fri, 18 Apr 2014 14:53:44 +0200
Message-ID: <20140418125344.GX11182@twins.programming.kicks-ass.net>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org>
 <1396009796-31598-4-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.11.1404012208110.1571@knanqh.ubzr>
 <534FDCDC.6000806@linaro.org>
 <alpine.LFD.2.11.1404171138470.980@knanqh.ubzr>
 <534FFBB3.8050601@linaro.org>
 <alpine.LFD.2.11.1404171207531.980@knanqh.ubzr>
 <20140418093845.GD11096@twins.programming.kicks-ass.net>
 <535116FC.5070700@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <535116FC.5070700@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-kernel@vger.kernel.org, mingo@elte.hu, rjw@rjwysocki.net, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 18, 2014 at 02:13:48PM +0200, Daniel Lezcano wrote:
> On 04/18/2014 11:38 AM, Peter Zijlstra wrote:
> >On Thu, Apr 17, 2014 at 12:21:28PM -0400, Nicolas Pitre wrote:
> >>CPU topology is needed to properly describe scheduling domains.  Whether
> >>we balance across domains or pack using as few domains as possible is a
> >>separate issue.  In other words, you shouldn't have to care in this
> >>patch series.
> >>
> >>And IMHO coupled C-state is a low-level mechanism that should remain
> >>private to cpuidle which the scheduler shouldn't be aware of.
> >
> >I'm confused.. why wouldn't you want to expose these?
> 
> The couple C-state is used as a mechanism for cpuidle to sync the cpus when
> entering a specific c-state. This mechanism is usually used to handle the
> cluster power down. It is only used for a two drivers (soon three) but it is
> not the only mechanism used for syncing the cpus. There are also the MCPM
> (tc2), the hand made sync when the hardware allows it (ux500), and an
> abstraction from the firmware (mwait), transparent to the kernel.
> 
> Taking into account the couple c-state only does not make sense because of
> the other mechanisms above. This is why it should stay inside the cpuidle
> framework.
> 
> The extension of the cpu topology will provide a generic way to describe and
> abstracting such dependencies.
> 
> Does it answer your question ?

I suppose so; its still a bit like we won't but we will :-)

So we _will_ actually expose coupled C states through the topology bits,
that's good.
