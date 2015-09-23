From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [RFC 0/3] sched/idle: run-time support for setting idle polling
Date: Wed, 23 Sep 2015 09:21:15 -0400
Message-ID: <20150923092115.1b29448e@redhat.com>
References: <1442954062-28578-1-git-send-email-lcapitulino@redhat.com>
	<1593595.NpzC8TsdGC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1593595.NpzC8TsdGC@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, rafael.j.wysocki@intel.com, mingo@kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 23 Sep 2015 03:17:59 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Tuesday, September 22, 2015 04:34:19 PM Luiz Capitulino wrote:
> > Hi,
> 
> Hi,
> 
> Please always CC patches related to power management to linux-pm@vger.kernel.org.
> 
> Also CCing Len Brown who's the maintainer of the intel_idle driver and Peter Z.
> 
> > Some archs allow the system administrator to set the
> > idle thread behavior to spin instead of entering
> > sleep states. The x86 arch, for example, has a idle=
> > command-line parameter for this purpose.
> > 
> > However, the command-line parameter has two problems:
> > 
> >  1. You have to reboot if you change your mind
> >  2. This setting affects all system cores
> > 
> > The second point is relevant for systems where cores
> > are partitioned into bookkeeping and low-latency cores.
> > Usually, it's OK for bookkeeping cores to enter deeper
> > sleep states. It's only the low-latency cores that should
> > poll when entering idle.
> 
> This looks like a use case for PM QoS to me rather.  You'd need to make it
> work per-CPU rather than globally, but that really is about asking for
> minimum latency.

Yes, wake up latency. But that feature is already there, I'm just making
it a run-time tunable.

> > This series adds the following file:
> > 
> >  /sys/devices/system/cpu/cpu_idle
> > 
> > This file outputs and stores a cpumask of the cores
> > which will have idle polling behavior.
> 
> I don't like this interface at all.
> 
> You have a cpuidle directory per core already, so what's the reason to add an
> extra mask file really? 

If there's consensus that this is the right thing to do, I'd do it.

However, idle polling behavior is a idle thread parameter which is a
core kernel component not tied to drivers. In this case, it would
make more sense to add a idle_thread dir to sysfs so that future
idle thread parameters can be added there.

> > This implementation seems to work fine on x86, however
> > it's RFC because of the following points (for which
> > feedback is greatly appreciated):
> > 
> >  o I believe this implementation should work for all archs,
> >    but I can't confirm it as my machines and experience is
> >    limited to x86
> > 
> >  o Some x86 cpufreq drivers explicitly check if idle=poll
> >    was passed. Does anyone know if this is an optmization
> >    or is there actually a conflict between idle=poll and
> >    driver operation?
> 
> idle=poll is used as a workaround for platform defects on some systems IIRC.

Oh, makes sense.

> 
> >  o This series maintains cpu_idle_poll_ctrl() semantics
> >    which led to a more complex implementation. That is, today
> >    cpu_idle_poll_ctrl() increments or decrements a counter.
> >    A lot of arch code seems to count on this semantic, where
> >    cpu_idle_poll_ctrl(enable or false) calls have to match to
> >    enable or disable idle polling
> > 
> > Luiz Capitulino (3):
> >   sched/idle: cpu_idle_poll(): drop unused return code
> >   sched/idle: make cpu_idle_force_poll per-cpu
> >   sched/idle: run-time support for setting idle polling
> > 
> >  drivers/base/cpu.c  | 44 ++++++++++++++++++++++++
> >  include/linux/cpu.h |  2 ++
> >  kernel/sched/idle.c | 96 +++++++++++++++++++++++++++++++++++++++++++++--------
> >  3 files changed, 129 insertions(+), 13 deletions(-)
> 
> Thanks,
> Rafael
> 
