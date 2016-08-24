From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/2] cpufreq / sched: Pass flags to
 cpufreq_update_util()
Date: Wed, 24 Aug 2016 06:53:59 +0200
Message-ID: <20160824045359.GB8407@kozik-book>
References: <6346523.ZooER3FGDH@vostro.rjw.lan>
 <25822023.SGCZQcEZuy@vostro.rjw.lan>
 <20160820154049.GA6344@kozik-book>
 <92003780.FE55FOzMhP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <92003780.FE55FOzMhP@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 22, 2016 at 07:30:36PM +0200, Rafael J. Wysocki wrote:
> On Saturday, August 20, 2016 05:40:49 PM Krzysztof Kozlowski wrote:
> > On Sat, Aug 20, 2016 at 03:08:01AM +0200, Rafael J. Wysocki wrote:
> > > On Friday, August 19, 2016 03:26:21 PM Krzysztof Kozlowski wrote:
> > > > On Fri, Aug 12, 2016 at 2:04 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > It is useful to know the reason why cpufreq_update_util() has just
> > > > > been called and that can be passed as flags to cpufreq_update_util()
> > > > > and to the ->func() callback in struct update_util_data.  However,
> > > > > doing that in addition to passing the util and max arguments they
> > > > > already take would be clumsy, so avoid it.
> > > > >
> > > > > Instead, use the observation that the schedutil governor is part
> > > > > of the scheduler proper, so it can access scheduler data directly.
> > > > > This allows the util and max arguments of cpufreq_update_util()
> > > > > and the ->func() callback in struct update_util_data to be replaced
> > > > > with a flags one, but schedutil has to be modified to follow.
> > > > >
> > > > > Thus make the schedutil governor obtain the CFS utilization
> > > > > information from the scheduler and use the "RT" and "DL" flags
> > > > > instead of the special utilization value of ULONG_MAX to track
> > > > > updates from the RT and DL sched classes.  Make it non-modular
> > > > > too to avoid having to export scheduler variables to modules at
> > > > > large.
> > > > >
> > > > > Next, update all of the other users of cpufreq_update_util()
> > > > > and the ->func() callback in struct update_util_data accordingly.
> > > > >
> > > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >
> > > > > v1 -> v2: Do not check cpu_of(rq) against smp_processor_id() in
> > > > >           cfs_rq_util_change().
> > > > >
> > > > > ---
> > > > >  drivers/cpufreq/Kconfig            |    5 --
> > > > >  drivers/cpufreq/cpufreq_governor.c |    2 -
> > > > >  drivers/cpufreq/intel_pstate.c     |    2 -
> > > > >  include/linux/sched.h              |   12 ++++--
> > > > >  kernel/sched/cpufreq.c             |    2 -
> > > > >  kernel/sched/cpufreq_schedutil.c   |   67 ++++++++++++++++++++-----------------
> > > > >  kernel/sched/deadline.c            |    4 +-
> > > > >  kernel/sched/fair.c                |   10 +----
> > > > >  kernel/sched/rt.c                  |    4 +-
> > > > >  kernel/sched/sched.h               |   31 +++++------------
> > > > >  10 files changed, 66 insertions(+), 73 deletions(-)
> > > > 
> > > > (...)
> > > > 
> > > > > --- linux-pm.orig/drivers/cpufreq/Kconfig
> > > > > +++ linux-pm/drivers/cpufreq/Kconfig
> > > > > @@ -194,7 +194,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
> > > > >           If in doubt, say N.
> > > > >
> > > > >  config CPU_FREQ_GOV_SCHEDUTIL
> > > > > -       tristate "'schedutil' cpufreq policy governor"
> > > > > +       bool "'schedutil' cpufreq policy governor"
> > > > 
> > > > If you change such symbols please remember to update also all the
> > > > defconfigs. Without the update they start to show errors.
> > > 
> > > Are there defconfigs that use this particular one?
> > 
> > Yes, ARM/multi_v7 and exynos were using this as module. Javier sent a
> > patch for that and should be switched to builtin in upcoming next [1].
> > 
> > If you would like to base on top of that, let me know, so I would
> > prepare a tag.
> 
> I wouldn't like to rebase, but I can pull that branch depending on how
> much more material there is on it.

Not much, I put only the fix m->y on a separate branch. Anyway if you
need it, here it is:


The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-schedutil-4.9

for you to fetch changes up to 08023fb9cec03ee2992df51fa728c3f14a1ba0ea:

  ARM: multi_v7_defconfig: Don't attempt to enable schedutil governor as module (2016-08-19 17:50:13 +0200)

----------------------------------------------------------------
The schedutil cpufreq governor will be switched from tristate to bool. Fix
defconfigs.

----------------------------------------------------------------
Javier Martinez Canillas (2):
      ARM: exynos_defconfig: Don't attempt to enable schedutil governor as module
      ARM: multi_v7_defconfig: Don't attempt to enable schedutil governor as module

 arch/arm/configs/exynos_defconfig   | 2 +-
 arch/arm/configs/multi_v7_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
