From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Date: Thu, 9 Aug 2018 09:39:47 +0100
Message-ID: <20180809083947.2ogkudkpg6d52roc@darkstar>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <d8a3d533-84df-bfc7-96ae-790141be4926@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d8a3d533-84df-bfc7-96ae-790141be4926@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 06-Aug 09:50, Randy Dunlap wrote:
> Hi,

Hi Randy,

> On 08/06/2018 09:39 AM, Patrick Bellasi wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 041f3a022122..1d45a6877d6f 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -583,6 +583,25 @@ config HAVE_UNSTABLE_SCHED_CLOCK
> >  config GENERIC_SCHED_CLOCK
> >  	bool
> >  
> > +menu "Scheduler features"
> > +
> > +config UCLAMP_TASK
> > +	bool "Enable utilization clamping for RT/FAIR tasks"
> > +	depends on CPU_FREQ_GOV_SCHEDUTIL
> > +	default false
> 
> 	default n
> but just omit the line completely since "n" is already the default.


Right, will update for next posting!
Is there a strict rule to omit this line when it's already the
default?
> 
> > +	help
> > +	  This feature enables the scheduler to track the clamped utilization
> > +	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
> > +
> > +	  When this option is enabled, the user can specify a min and max CPU
> > +          bandwidth which is allowed for a task.
> > +	  The max bandwidth allows to clamp the maximum frequency a task can
> > +	  use, while the min bandwidth allows to define a minimum frequency a
> > +          task will always use.
> 
> Please clean up the indentation above to use one tab + 2 spaces on all lines.

Sure, my bad I did not notice it... although I'm quite sure the patch
passed a checkpatch... will check better next time.

> > +
> > +	  If in doubt, say N.
> > +
> > +endmenu

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
