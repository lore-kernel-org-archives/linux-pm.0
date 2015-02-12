From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/6] intel_idle: Add ->enter_freeze callbacks
Date: Thu, 12 Feb 2015 17:24:51 +0100
Message-ID: <25445086.IBiaGBbm1j@vostro.rjw.lan>
References: <8292243.ibkmfVtXac@vostro.rjw.lan> <2407992.WHaFxrNaoa@vostro.rjw.lan> <20150212132643.GY23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150212132643.GY23123@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, February 12, 2015 02:26:43 PM Peter Zijlstra wrote:
> On Wed, Feb 11, 2015 at 05:04:17AM +0100, Rafael J. Wysocki wrote:
> > @@ -131,28 +133,32 @@ static struct cpuidle_state nehalem_csta
> >  		.flags = MWAIT2flg(0x00),
> >  		.exit_latency = 3,
> >  		.target_residency = 6,
> > -		.enter = &intel_idle },
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> >  	{
> >  		.name = "C1E-NHM",
> >  		.desc = "MWAIT 0x01",
> >  		.flags = MWAIT2flg(0x01),
> >  		.exit_latency = 10,
> >  		.target_residency = 20,
> > -		.enter = &intel_idle },
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> >  	{
> >  		.name = "C3-NHM",
> >  		.desc = "MWAIT 0x10",
> >  		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
> >  		.exit_latency = 20,
> >  		.target_residency = 80,
> > -		.enter = &intel_idle },
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> >  	{
> >  		.name = "C6-NHM",
> >  		.desc = "MWAIT 0x20",
> >  		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> >  		.exit_latency = 200,
> >  		.target_residency = 800,
> > -		.enter = &intel_idle },
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> >  	{
> >  		.enter = NULL }
> >  };
> 
> Why bother with enter_freeze() for any but the deepest state (C6 in this
> case)?

User space may disable the deepest one (and any of them in general) via sysfs
and there's no good reason to ignore its choice in this particular case while
we're honoring it otherwise.

So the logic is basically "find the deepest one which isn't disabled" and
setting the pointers costs us nothing really.

> Also, should we ignore things like intel_idle.max_cstate for this
> selection?

No, we shouldn't.  The deeper ones may just not work then.

