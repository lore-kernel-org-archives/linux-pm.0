From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] cpuidle / menu: Return error code if there are no suitable states
Date: Tue, 29 Apr 2014 01:28:03 +0200
Message-ID: <2000825.kO1es8ShkW@vostro.rjw.lan>
References: <2471963.urOyfY8mOG@vostro.rjw.lan> <6832089.A5AOPipfbA@vostro.rjw.lan> <535E3818.2040905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <535E3818.2040905@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday, April 28, 2014 01:14:32 PM Daniel Lezcano wrote:
> On 04/27/2014 02:55 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If there is a PM QoS latency limit and all of the sufficiently shallow
> > C-states are disabled, the cpuidle menu governor returns 0 which on
> > some systems is CPUIDLE_DRIVER_STATE_START and shouldn't be returned
> > if that C-state has been disabled.
> >
> > Fix the issue by modifying the menu governor to return an error code
> > in such situations.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/cpuidle/governors/menu.c |    2 +-
> >   include/linux/cpuidle.h          |    2 ++
> >   2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > @@ -296,7 +296,7 @@ static int menu_select(struct cpuidle_dr
> >   		data->needs_update = 0;
> >   	}
> >
> > -	data->last_state_idx = 0;
> > +	data->last_state_idx = CPUIDLE_DRIVER_STATE_POLL;
> >
> >   	/* Special case when user has set very strict latency requirement */
> >   	if (unlikely(latency_req == 0))
> > Index: linux-pm/include/linux/cpuidle.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/cpuidle.h
> > +++ linux-pm/include/linux/cpuidle.h
> > @@ -217,8 +217,10 @@ static inline int cpuidle_register_gover
> >
> >   #ifdef CONFIG_ARCH_HAS_CPU_RELAX
> >   #define CPUIDLE_DRIVER_STATE_START	1
> > +#define CPUIDLE_DRIVER_STATE_POLL	0
> >   #else
> >   #define CPUIDLE_DRIVER_STATE_START	0
> > +#define CPUIDLE_DRIVER_STATE_POLL	(-ENXIO)
> >   #endif
> >
> >   #endif /* _LINUX_CPUIDLE_H */
> 
> Hi Rafael,
> 
> CPUIDLE_DRIVER_STATE_START is only for x86. It introduces some confusion 
> in the code.

I won't disagree with that.

> As only two drivers are concerned by it, wouldn't make 
> sense to add the poll state to those driver directly instead of having 
> the code hacked around ? (eg. insert the poll state in the common 
> cpuidle code).

Well, what about initializing data->last_state_idx to
(CPUIDLE_DRIVER_STATE_START - 1) in menu_select() instead of introducing the
new symbol for the time being and getting rid of CPUIDLE_DRIVER_STATE_START
separately?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
