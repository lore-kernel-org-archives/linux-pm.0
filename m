From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v6 05/14] sched/topology: Reference the Energy Model of
 CPUs when available
Date: Thu, 30 Aug 2018 13:50:31 +0100
Message-ID: <20180830125031.GV2960@e110439-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-6-quentin.perret@arm.com>
 <20180829162238.GQ2960@e110439-lin>
 <20180829165603.astg32z3ep2qldfu@queper01-lin>
 <20180830100019.GT2960@e110439-lin>
 <20180830104718.lvkkhyi3dtwkfjr7@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180830104718.lvkkhyi3dtwkfjr7@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 30-Aug 11:47, Quentin Perret wrote:
> On Thursday 30 Aug 2018 at 11:00:20 (+0100), Patrick Bellasi wrote:
> > Dunno... but, in any case, probably we don't care about using EAS until
> > the boot complete, isn't it?
> 
> So, as of now, EAS will typically start soon after CPUFreq. I don't see a
> point in starting before, and I'm not sure if starting it later is
> really what we want either ... It probably makes sense to start the
> DVFS-related features (CPUFreq, EAS, ...) together.
> 
> > Just to better understand, what is the most common activation path we expect ?
> > 
> >   1. system boot
> >   2. CPUs online
> >   3. CPUFreq initialization
> >   4. EM registered
> >   X. ???
> 
> X is sort of arch dependent (like the EM registration actually). For
> arm/arm64, the arch topology driver (see drivers/base/arch_topology.c)
> will rebuild the sched_domains once the capacities of CPU are
> discovered. In previous versions, I had a patch that did that explicitly:
> 
> https://lore.kernel.org/lkml/20180724122521.22109-14-quentin.perret@arm.com/
> 
> However, I dropped this patch for v6 because I rebased the series on top
> of Morten's automatic flag detection patches, which happen to already do
> that for me. More precisely, Morten's patches will rebuild the sched
> domains if the SD_ASYM_CPUCAPACITY flag needs to be set somewhere in the
> hierarchy. EAS depends on this flag anyway, so I guess it's fine to rely
> on this rebuild to start EAS at the same time.
> 
> I have been wondering for a while if such a 'loose' way of starting EAS
> was alright or not. My conclusion was that it should be OK for now,
> because that should suit all the users I can see in the short/medium
> term. An alternative could be to introduce something like a notifier in
> the EM framework in order to let other subsystems know that the EM is
> complete or something along those lines. And then we could register a
> callback on this notifier to rebuild the sched_domains. But that's added
> complexity, which isn't really needed (yet). If that needs to be done to
> accomodate the needs of new users/archs, we can still implement that
> later :-)
> 
> >   N. partition_sched_domains
> >         build_perf_domains
> > 
> > IOW, who do we expect to call build_perf_domains for the first time ?
> 
> On arm/arm64, when the arch_topology driver calls rebuild_sched_domains.

Great, I missed that point, which you actually call out in the cover
letter. Thanks also for the more comprehensive explanation above!

> Thanks !
> Quentin

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
