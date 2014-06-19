From: "Charles Garcia-Tobin" <charles.garcia-tobin@arm.com>
Subject: RE: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
Date: Thu, 19 Jun 2014 16:09:08 +0100
Message-ID: <000401cf8bd0$6e2e4be0$4a8ae3a0$@arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com> <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com> <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr> <20140613164954.GA16745@e102568-lin.cambridge.arm.com> <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr> <20140618173648.GB31573@e102568-lin.cambridge.arm.com> <53A1E818.6030400@ti.com> <000001cf8b90$d6a6f090$83f4d1b0$@arm.com> <53A2EEDF.4030403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:45020 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932663AbaFSPJh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jun 2014 11:09:37 -0400
In-Reply-To: <53A2EEDF.4030403@ti.com>
Content-Language: en-gb
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Santosh Shilimkar' <santosh.shilimkar@ti.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Rob Herring <robh+dt@kernel.org>, grant.likely@linaro.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>


Hi

Looks we are pretty much agreed on the number now.
In my e-mail though I was questioning what should be optional and what
shouldn't. The current proposal is that wakeup-latency-us is the optional
one, I was thinking that it's make more sense making entry/exit (given the
use is much more specific and yet to be proven) but frankly it is not great
shakes either way, so for me it's fine as it is. The only thing that I think
would be worth clarifying is that the text around wakeup-latency-us, to make
it clear when it makes sense to provide it. So I was thinking something
like:

        - wakeup-latency-us:
                Usage: Optional
                Value type: <prop-encoded-array>
                Definition: u32 value representing maximum delay between the
                            signalling of a wake-up event and the CPU being
                            able to execute normal code again. If omitted,
                            this is assumed to be equal to:
                                entry-latency-us + exit-latency-us
                            It is important to supply this value on systems 
                            where the duration of PREP phase is 
                            non-neglibigle. In such systems 
                            entry-latency-us + exit-latency-us 
                            will exceed wakeup-latency-us by this duration.

The other thing that may be worth adding is some graphs to help explain what
is meant by min-residency. Lorenzo feel free to take this or leave this. But
something like:

The energy consumption of a cpu when it enters a power state can be roughly
characterised by the following graph:

               |
               |
               |
           e   |
           n   |                                      /---
           e   |                               /------
           r   |                        /------
           g   |                  /-----
           y   |           /------
               |       ----
               |      /|
               |     / |
               |    /  |
               |   /   |
               |  /    |
               | /     |                          
               |/      |                          
          -----|-------+----------------------------------
              0|       1                      time


The graph starts with a steep slope and then a shallower one. The first part
denotes the energy costs incurred whilst entering and leaving the power
state. The shallower slope is essentially representing the power consumption
of the state. 
We are defining min-residency for a given state as the period of time after
which choosing that state become the most energy efficient option. A good
way to visualise this, is if we take the same graph above and compare some
states. Due to the limitations of ascii art we are only showing two made up
states C1, and C2:


          |
          |
          |
          |                                                  /-- C1
       e  |                                              /---      
       n  |                                         /----          
       e  |                                     /---               
       r  |                                /----     /----------- C2
       g  |                    /-------/-------------               
       y  |        ------------    /---|
          |       /           /----    |
          |      /        /---         |
          |     /    /----             |
          |    / /---                  |
          |   ---                      |
          |  /                         |
          | /                          |
          |/                           |                  time
       ---/----------------------------+------------------------
          |  better off with C1        | better off with C2
                                       |
                                   min-residency    
                                   for C2               



As you can see, having taken into account entry/exit costs there is period
were C1 is the better choice of state. This is mainly down to the fact that
entry/exit costs are low. However the lower power consumption of C2 means
that after a suitable time, C2 is the better choice. This interval of time
is what we want to call min-residency
                     
Cheers

Charles

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: 19 June 2014 15:09
> To: Charles Garcia-Tobin; Lorenzo Pieralisi; Nicolas Pitre
> Cc: linux-arm-kernel@lists.infradead.org; linux-pm@vger.kernel.org;
> devicetree@vger.kernel.org; Mark Rutland; Sudeep Holla; Catalin
> Marinas; Rob Herring; grant.likely@linaro.org; Peter De Schrijver;
> Daniel Lezcano; Amit Kucheria; Vincent Guittot; Antti Miettinen;
> Stephen Boyd; Kevin Hilman; Sebastian Capella; Tomasz Figa; Mark Brown;
> Paul Walmsley; Chander Kashyap
> Subject: Re: [PATCH v4 1/6] Documentation: arm: define DT idle states
> bindings
> 
> Charles,
> 
> On Thursday 19 June 2014 03:33 AM, Charles Garcia-Tobin wrote:
> >
> >
> >> -----Original Message-----
> >> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> >> Sent: 18 June 2014 20:27
> >> To: Lorenzo Pieralisi; Nicolas Pitre
> 
> [..]
> 
> >>> +===========================================
> >>> +3 - state node
> >>> +===========================================
> >>> +
> >>> +A state node represents an idle state description and must be
> >> defined as
> >>> +follows:
> >>> +
> >>> +- state node
> >>> +
> >>> +	Description: must be child of the idle-states node
> >>> +
> >>> +	The state node name shall follow standard device tree naming
> >>> +	rules ([5], 2.2.1 "Node names"), in particular state nodes which
> >>> +	are siblings within a single common parent must be given a unique
> >> name.
> >>> +
> >>> +	The idle state entered by executing the wfi instruction
> >> (idle_standby
> >>> +	SBSA,[3][4]) is considered standard on all ARM platforms and
> >> therefore
> >>> +	must not be listed.
> >>> +
> >>> +	To correctly specify idle states timing and energy related
> >> properties,
> >>> +	the following definitions identify the different execution phases
> >>> +	a CPU goes through to enter and exit idle states and the implied
> >>> +	energy metrics:
> >>> +
> >>> +
> >> 	..__[EXEC]__|__[PREP]__|__[ENTRY]__|__[IDLE]__|__[EXIT]__|__[EXEC]
> >> __..
> >>> +		    |          |           |          |          |
> >>> +
> >>> +		    |<------ entry ------->|
> >>> +		    |       latency        |
> >>> +						      |<- exit ->|
> >>> +						      |  latency |
> >>> +		    |<-------- min-residency -------->|
> >>> +			       |<-------  wakeup-latency ------->|
> >>> +
> >> I don't know the wakeup latency makes much sense and also correct.
> >> Hardware wakeup latency is actually exit latency. Is it for failed
> >> or abort-able ilde case ? We are adding this as a new parameter
> >> at least from idle states perspective. I think we should just
> >> avoid it.
> >>
> >
> > Hi Santosh,
> >
> > To me wake up latency makes up a lot of sense. It is not always the
> same as
> > exit latency, it will depend on your system, and just how smart it
> is. In
> > some cases the [ENTRY] period may not be negligible in which case
> exit
> > latency will be less than the wake up latency.
> > In addition, it will generally always be shorter than entry+exit
> which is
> > the default value if omitted, this assumes the PREP time is not
> abortable,
> > but this is the safer assumption to make.
> > Wake up latency is really the number that folk have in their head for
> what
> > you'd stick into the pm_qos to veto entry into states when you are
> latency
> > constrained.
> > The one thing that really is an optimisation here is having a
> separate exit
> > latency, which is being proposed for use in core selection for the
> > scheduler.
> > So if anything was going to be made optional pending new scheduler
> patches
> > should that not be entry/exit latency?
> >
> PM QOS angle Nico pointed out and its clear. The wakeup latency as such
> is a
> worst case wakeup latency from QOS perspective so considering the
> aborted idle
> case it makes sense to have conservative number which includes entry +
> exit.
> 
> If you look at current idle governors, only exit latency and target
> residency
> is being used. No matter how we represent it, as long idle governor or
> idle
> C-state selection logic gets that information, things should be fine.
> So
> from that view your point of entry/exit optional makes sense
> considering
> wakeup latency can convey that information indirectly.
> 
> Regards,
> Santosh


