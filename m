From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 01/12] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Date: Wed, 18 Jul 2018 10:02:26 -0700
Message-ID: <20180718170226.GA21148@joelaf.mtv.corp.google.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-2-patrick.bellasi@arm.com>
 <20180717175025.GA150378@joelaf.mtv.corp.google.com>
 <20180718084218.GI32302@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180718084218.GI32302@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 18, 2018 at 09:42:18AM +0100, Patrick Bellasi wrote:
> On 17-Jul 10:50, Joel Fernandes wrote:
> > On Mon, Jul 16, 2018 at 09:28:55AM +0100, Patrick Bellasi wrote:
> 
> [...]
> 
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index 041f3a022122..1d45a6877d6f 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -583,6 +583,25 @@ config HAVE_UNSTABLE_SCHED_CLOCK
> > >  config GENERIC_SCHED_CLOCK
> > >  	bool
> > >  
> > > +menu "Scheduler features"
> > > +
> > > +config UCLAMP_TASK
> > > +	bool "Enable utilization clamping for RT/FAIR tasks"
> > > +	depends on CPU_FREQ_GOV_SCHEDUTIL
> > 
> > Does it make sense to depend on this? One could turn off schedutil and then
> > uclamp can't be used for any other purpose (big.LITTLE task placement etc)?
> 
> You right, utilization clamping is _going_ to target tasks placement.
> But, the support currently posted in this series is just for OPP
> biasing. Thus, it would not make sense to enabled it when schedutil
> is not available.
> 
> My idea was to keep this dependency while we finalize these bits.
> Once we move on to the tasks placement biasing, we will remove this
> dependency too.
> 
> Does that makes sense?

Yes, that's fine with me.
